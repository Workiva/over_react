/// A library for running Dart unit tests on Sauce Labs from start to finish,
/// with automatic (and optional) management of the Pub server and Sauce Connect tunnel.
library dart_dev.src.tasks.saucelabs.sauce_runner;

import 'dart:async';
import 'dart:convert';

import 'package:dart_dev/src/tasks/serve/api.dart';
import 'package:dart_dev/util.dart';
import 'package:http/http.dart';

import 'sauce_unit_test_driver.dart';
import 'platforms.dart';
import 'sauce_api.dart';

export 'platforms.dart';

const String iframeRunnerPath = 'sauce_iframe_runner/sauce_iframe_runner.html';

/// Runs the specified [tests] in Sauce Labs the specified [platforms], and returns a Future
/// that completes with the test resuls after they've finished running.
///
/// Additional [options] can be used to start the test (see <https://wiki.saucelabs.com/display/DOCS/Test+Configuration+Options>).
///
/// If [pubServePort] is `0`, a Pub server will automatically be started in order to serve the tests.
/// Otherwise, it will be assumed that a Pub server is already running on the specified port.
///
/// If [autoSauceConnect] is `true`, then a Sauce Connect tunnel will be automatically started,
/// with the optional [tunnelIdentifier], if specified.
/// If `false`, it will be assumed that Sauce Connect is already running (with [tunnelIdentifier], if specified).
Future<Map> run(List<SauceTest> tests, List<SaucePlatform> platforms,
    String sauceUserName, String sauceAccessKey,
    {Map options: const {},
    int pubServePort: 0,
    bool autoSauceConnect: true,
    String tunnelIdentifier}) async {
  PubServeTask pubServeTask;
  PubServeInfo serveInfo;
  TaskProcess sauceConnect;
  List<SauceTestHarness> testHarnesses;

  try {
    if (pubServePort == 0) {
      reporter.log('Starting pub server...');
      // Start `pub serve` on the `test` directory utilizing force-poll to better monitor
      // in use files during the testing process
      pubServeTask = startPubServe(additionalArgs: ['test', '--force-poll']);
      serveInfo = await logPubServeUntilFirstInfo(pubServeTask);
      reporter.log('');
    } else {
      // Use the specified port of the already-running instance.
      serveInfo = new PubServeInfo('test', pubServePort);
    }

    var pubServerBaseUrl = 'http://localhost:${serveInfo.port}/';

    reporter.log('Fetching test harness HTML files and their metadata...');
    testHarnesses = await getTestHarnesses(tests, pubServerBaseUrl);

    reporter.log('');
    reporter.log('Precompiling Dart test files...');
    var allDartFiles =
        testHarnesses.expand((SauceTestHarness test) => test.dartScripts);
    await Future.wait(allDartFiles.map((String dartScript) async {
      reporter.log('- Precompiling $dartScript');
      await get('$pubServerBaseUrl$dartScript.js');
    }));

    if (autoSauceConnect) {
      sauceConnect = await startSauceConnection(sauceUserName, sauceAccessKey,
          tunnelIdentifier: tunnelIdentifier);
    }

    reporter.log('');
    reporter.log('Starting tests...');
    List<SauceUnitTestDriver> allTestDrivers = <SauceUnitTestDriver>[];
    await Future.forEach(testHarnesses, (SauceTestHarness harness) async {
      var name = harness.test.name;

      var mergedOptions = {}
        ..addAll(options)
        ..addAll({
          'name': name,
        });

      if (tunnelIdentifier != null) {
        mergedOptions['tunnelIdentifier'] = tunnelIdentifier;
      }

      var testDrivers = await startSauceTests(name, harness.iframeRunnerUrl,
          platforms, sauceUserName, sauceAccessKey,
          options: mergedOptions);
      allTestDrivers.addAll(testDrivers);
    });

    reporter.log('');
    reporter.log(
        'Waiting for tests to complete... (See https://saucelabs.com/tests for overall status.)');

    final Map results = await waitForTestsToComplete(allTestDrivers);

    reporter.log('');
    reporter.log('Test Results:');

    final List<Map> jsTests = results['js tests'];

    // Log summary of results to console for convenience.
    jsTests.forEach((test) {
      var name = test['name'];
      var url = test['url'];

      if (test['status'] == 'test error') {
        reporter.log('- $name: test error');
      } else {
        var resultMessage;

        var result = test['result'];
        if (result == null) {
          resultMessage = 'completed';
        } else if (result is Map) {
          int passed = result['passed'];
          int failed = result['failed'];
          resultMessage = "$passed passed, $failed failed.";
        }

        reporter.log('- $name: $resultMessage ($url)');
      }
    });

    return results;
  } finally {
    reporter.log('');
    reporter.log('Cleaning up...');

    if (pubServeTask != null) {
      reporter.log('- Shutting down Pub server...');
      pubServeTask.stop();
      // Wait for the task to finish to flush its output.
      await pubServeTask.done;
    }

    if (sauceConnect != null) {
      reporter.log('- Shutting down Sauce Connect...');
      sauceConnect.kill();
      await sauceConnect.exitCode;
    }
  }
}

/// Returns a Future that completes with a list of SauceTestHarness instances corresponding to
/// [tests], with iframe runner URLS based on [pubServerBaseUrl].
Future<List<SauceTestHarness>> getTestHarnesses(
    List<SauceTest> tests, String pubServerBaseUrl) {
  return Future.wait(tests.map((SauceTest test) async {
    final testPath = test.path;

    reporter.log('- ${test.name} - $testPath');

    if (!testPath.toLowerCase().endsWith('.html')) {
      throw new Exception('Test must be an HTML file: $testPath');
    }

    var harnessPath = '$testPath.sauce_browser_test.html';
    var harnessAbsolutePath = '/$harnessPath';
    var dartScripts = JSON.decode((await get(
            '$pubServerBaseUrl$testPath.dart_file_list.json',
            headers: {'Accept': 'application/json'}))
        .body);

    return new SauceTestHarness(
        test: test,
        iframeRunnerUrl:
            '$pubServerBaseUrl$iframeRunnerPath?test_url=${Uri.encodeQueryComponent(harnessAbsolutePath)}',
        dartScripts: dartScripts);
  }));
}

/// Returns a Future that completes when [pubServeTask] emits its first [PubServeInfo] (which means
/// that it's ready to serve a directory).
///
/// Until the Future completes, all `pub serve` output will logged live, and all subsequent
/// output will be buffered until the `pub serve` process terminates.
Future<PubServeInfo> logPubServeUntilFirstInfo(
    PubServeTask pubServeTask) async {
  var startupLogFinished = new Completer();
  reporter.logGroup(pubServeTask.command,
      outputStream:
          pubServeTask.stdOut.transform(until(startupLogFinished.future)),
      errorStream:
          pubServeTask.stdErr.transform(until(startupLogFinished.future)));

  var serveInfo = await pubServeTask.serveInfos.first;

  startupLogFinished.complete();

  pubServeTask.stdOut.join('\n').then((stdOut) {
    if (stdOut.isNotEmpty) {
      reporter.logGroup('`${pubServeTask.command}` (buffered stdout)',
          output: stdOut);
    }
  });

  pubServeTask.stdErr.join('\n').then((stdErr) {
    if (stdErr.isNotEmpty) {
      reporter.logGroup('`${pubServeTask.command}` (buffered stderr)',
          error: stdErr);
    }
  });

  return serveInfo;
}

/// A named Dart unit test to be run on Sauce Labs.
class SauceTest {
  /// The name of the test, to be displayed in the Sauce Labs.
  final String name;

  /// The URL path to this test's HTML runner file when served via Pub from the `test` directory.
  final String path;

  const SauceTest(this.name, this.path);
}

/// Information on a Dart test harness generated from a Dart unit test.
class SauceTestHarness {
  /// The test that associated with this harness info.
  final SauceTest test;

  /// The paths of the Dart scripts referenced via `<link rel="x-dart-test" ...>` tags
  /// in this test's HTML.
  final List<String> dartScripts;

  /// The url which, when opened, will run this test using the Sauce Labs iframe runner.
  final String iframeRunnerUrl;

  const SauceTestHarness({this.test, this.iframeRunnerUrl, this.dartScripts});
}
