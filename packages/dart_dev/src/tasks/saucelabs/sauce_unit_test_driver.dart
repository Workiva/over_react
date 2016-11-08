/// A library with a class that can be used to run JS unit tests on Sauce Labs via WebDriver.
library dart_dev.src.tasks.saucelabs.sauce_unit_test_driver;

import 'dart:async';
import 'dart:io';

import 'package:dart_dev/util.dart';
import 'package:webdriver/io.dart'
    show By, Capabilities, WebDriver, createDriver;

import './platforms.dart';
import 'sauce_runner.dart';

/// A class that uses WebDriver to run JS unit tests directly, as opposed to via the [JS unit test REST API][js-unit-api],
/// which isn't well documented, has poor error reporting, and has a tendency to intermittently fail.
///
/// This functions the same way as the JS test API:
/// - The WebDriver loads the specified URL.
/// - The WebDriver polls `window.global_test_results` on the page until it's non-null.
/// - The results of that polling are reported via the [results].
///
/// [js-unit-api]: https://wiki.saucelabs.com/display/DOCS/JavaScript+Unit+Testing+Methods#JavaScriptUnitTestingMethods-StartJSUnitTests
class SauceUnitTestDriver {
  /// The name of this test run, to be displayed on the Sauce Labs job.
  final String testRunName;

  /// The url that will run these tests when loaded.
  final String testUrl;

  /// The Sauce Labs username used to authenticate the WebDriver.
  final String username;

  /// The Sauce Labs access key used to authenticate the WebDriver.
  final String accessKey;

  /// The platform to run these tests on in Sauce Labs.
  final SaucePlatform platform;

  /// Additional options passed to Sauce Labs / Selenium.
  ///
  /// See <https://wiki.saucelabs.com/display/DOCS/Test+Configuration+Options> for available Sauce Labs options.
  final Map desiredCapabilities;

  /// The WebDriver instance used to run these tests.
  ///
  /// Not initialized until [start] is called.
  WebDriver _driver;

  /// The current status of this test.
  ///
  /// Either `'pending'`, `'running'`, `'completed'`, or `'test error'`.
  String _status = 'pending';

  /// The completer used to complete the [results] future when test results are available.
  Completer<Map> _resultsCompleter = new Completer<Map>();

  /// Runs [action] in its own zone and completes as soon as either:
  ///
  /// * the future returned by [action] completes.
  /// * an uncaught asynchronous error occurs in the zone.
  static Future _runAndHandleUncaughtErrors(Future action()) {
    var completer = new Completer();

    runZoned(() {
      action().then((value) {
        if (!completer.isCompleted) {
          completer.complete(value);
        }
      });
    }, onError: (error) {
      if (!completer.isCompleted) {
        completer.completeError(error);
      }
    });

    return completer.future;
  }

  /// Starts polling once every second for results, and returns a future that completes when they're available.
  ///
  /// Results should be exposed at either:
  /// - `window.global_test_results` (same as what the Sauce JS Unit API looks for)
  /// - `window.global_test_results_untruncated` (takes precedence if it's available; useful for exposing test results
  ///     that are too big for the Sauce JS Unit API to handle).
  Future _pollForResults() async {
    const Duration resultsPollInterval = const Duration(seconds: 1);

    var results = null;
    while (results == null) {
      await new Future.delayed(resultsPollInterval);

      /// Wrap with _runAndHandleUncaughtErrors so that uncaught async errors caused
      /// by failed WebDriver calls don't cause the script to exit.
      results = await _runAndHandleUncaughtErrors(() => _driver.execute(
          'return window.global_test_results_untruncated || window.global_test_results;',
          []));
    }

    return results;
  }

  /// Listeners for process signals (e.g., CTRL+C) that quit the WebDriver before the process shuts down.
  final List<StreamSubscription> _processSignalListeners = [];

  /// Quits the WebDriver, closing any open browser and terminating its session.
  ///
  /// Used for disposing of the WebDriver after tests are done running, but will also end any ongoing test run.
  Future _quitDriver() async {
    _processSignalListeners.forEach((listener) => listener.cancel());
    _processSignalListeners.clear();

    try {
      /// Wrap with _runAndHandleUncaughtErrors so that uncaught async errors caused
      /// by failed WebDriver calls don't cause the script to exit.
      await _runAndHandleUncaughtErrors(
          () => _driver?.quit(closeSession: true));
    } catch (error) {
      // The driver fails to quit if Sauce Labs has timed out the session,
      // so just catch the error here and print it.
      print('Error quitting driver: $error');
    }

    // Ensure that the Future returned by `results` always completes.
    if (!_resultsCompleter.isCompleted) {
      _resultsCompleter.complete(null);
    }
  }

  SauceUnitTestDriver(
      String this.testRunName,
      String this.testUrl,
      SaucePlatform this.platform,
      String this.username,
      String this.accessKey,
      Map this.desiredCapabilities);

  /// Starts running these tests and returns a future that completes when the test URL has been fully loaded.
  Future start() async {
    try {
      var capabilities = new Map.from(desiredCapabilities)
        ..[Capabilities.supportsJavascript] = true
        ..addAll(platform.asCapabilities());

      /// Wrap with _runAndHandleUncaughtErrors so that uncaught async errors caused
      /// by failed WebDriver calls don't cause the script to exit.
      _driver = await _runAndHandleUncaughtErrors(() => createDriver(
          uri: Uri.parse(
              'http://$username:$accessKey@ondemand.saucelabs.com/wd/hub/'),
          desired: capabilities));

      reporter.log('- Loading: $this');

      // Quit the web driver when this process is interrupted.
      _processSignalListeners
        ..add(
            ProcessSignal.SIGTERM.watch().take(1).listen((_) => _quitDriver()))
        ..add(
            ProcessSignal.SIGINT.watch().take(1).listen((_) => _quitDriver()));

      // If the browser window is not active, focus events won't be dispatched in Firefox as expected.
      //
      // So, before running any tests, we'll ensure the browser window is active by clicking on the page with WebDriver.
      //
      // 1. Load `about:blank` to ensure that clicking on the page does nothing.
      // 2. Move the cursor over a valid element so that the WebDriver doesn't break itself trying to click on nothing.
      // 3. Click.
      await _driver.get('about:blank'); // [1]
      await _driver.mouse.moveTo(
          element: await _driver.findElement(const By.tagName('body'))); // [2]
      await _driver.mouse.click(); // [3]

      await _driver.get(testUrl);

      _status = 'running';
    } catch (_) {
      _status = 'test error';
      _quitDriver();
      rethrow;
    }

    // Kick off asynchronous results polling and complete _resultsCompleter
    // when results are available or an error occurs.
    _pollForResults().then((results) {
      _status = 'completed';
      _resultsCompleter.complete(results);
    }).catchError((error, [stackTrace]) {
      _status = 'test error';
      _resultsCompleter.completeError(error, stackTrace);
    }).whenComplete(_quitDriver);
  }

  /// The current status of this test run.
  ///
  /// Either `'pending'`, `'running'`, `'completed'`, or `'test error'`.
  String get status => _status;

  /// A future that completes with the results of this test run.
  ///
  /// If the test stops running due to an error or otherwise, the future will complete with `null`.
  Future<Map> get results => _resultsCompleter.future;

  /// The Sauce Labs job id of this test run.
  ///
  /// Will be `null` until [start] is called.
  String get jobId => _driver?.id;

  /// The URL to the Sauce Labs job for this test run.
  ///
  /// Will be `null` until [start] is called.
  String get jobUrl =>
      jobId == null ? null : 'https://saucelabs.com/tests/$jobId';

  /// Returns a String representation of this driver, containing [testRunName] and [jobUrl].
  @override
  String toString() => '$testRunName ($jobUrl)';
}
