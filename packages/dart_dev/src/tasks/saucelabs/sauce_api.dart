/// Methods for starting Sauce Connect and running tests in Sauce Labs via
/// [SauceUnitTestDriver].
library dart_dev.src.tasks.saucelabs.sauce_api;

import 'dart:async';

import 'package:dart_dev/util.dart';

import 'sauce_unit_test_driver.dart';

const String sauceApiUrl = 'https://saucelabs.com/rest/v1/';

/// Starts a Sauce Connect (`sc` command) process, optionally with a `tunnelIdentifier` and returns
/// a Future that completes with the Process when the tunnel is ready to be used.
///
/// Logs live output to the console via [reporter].
Future<TaskProcess> startSauceConnection(String username, String accessKey,
    {String tunnelIdentifier}) async {
  var args = ['--user', username, '--api-key', accessKey];

  if (tunnelIdentifier != null) {
    args.addAll(['--tunnel-identifier', tunnelIdentifier]);
  }

  var process = new TaskProcess('sc', args);

  var stdout = process.stdout.asBroadcastStream();

  reporter.logGroup('Starting Sauce Connect tunnel',
      outputStream: stdout, errorStream: process.stderr);

  await for (String line in stdout) {
    if (line.contains('Sauce Connect is up, you may start your tests.')) {
      return process;
    }
  }

  throw new Exception('Sauce Connection failed.');
}

/// Kicks off a set of runs for the test at [testUrl] on the specified [platforms], and returns a
/// Future that completes with the corresponding drivers once all tests have been started.
///
/// Uses the [SauceUnitTestDriver] to run the tests as opposed to the [JS unit test REST API][js-unit-api].
///
/// Optional [options] are also allowed (see <https://wiki.saucelabs.com/display/DOCS/Test+Configuration+Options>).
///
/// [js-unit-api]: https://wiki.saucelabs.com/display/DOCS/JavaScript+Unit+Testing+Methods#JavaScriptUnitTestingMethods-StartJSUnitTests
Future<List<SauceUnitTestDriver>> startSauceTests(String testName,
    String testUrl, List platforms, String username, String accessKey,
    {Map options: const {}}) async {
  List<Future<SauceUnitTestDriver>> driversFutures =
      platforms.map((platform) async {
    var testRunName = '$platform - $testName';
    var testDriver = new SauceUnitTestDriver(
        testRunName, testUrl, platform, username, accessKey, options);

    try {
      await testDriver.start();
    } catch (e) {
      reporter.log('Failure starting $testDriver.\n$e');
    }

    return testDriver;
  }).toList(); // Iterate immediately so that the each runner doesn't have to wait for the previous.

  return Future.wait(driversFutures);
}

/// Returns a Future that completes with the JS test results once all [testDrivers] have finished running.
///
/// Results are of the format returned by <https://wiki.saucelabs.com/display/DOCS/JavaScript+Unit+Testing+Methods#JavaScriptUnitTestingMethods-GetJSUnitTestStatus>.
Future<Map> waitForTestsToComplete(
    List<SauceUnitTestDriver> testDrivers) async {
  List<Future<Map>> jsTestsFutures = testDrivers.map((testDriver) async {
    Map result = null;
    try {
      result = await testDriver.results;
    } catch (e) {
      reporter.log('Failure fetching results from $testDriver.\n$e');
    }

    reporter.log('- Finished: $testDriver');

    return {
      'name': testDriver.testRunName,
      'url': testDriver.jobUrl,
      'id': testDriver.jobId,
      'job_id': null,
      'platform': testDriver.platform.toJson(),
      'result': result,
      'status': testDriver.status,
    };
  }).toList(); // Iterate immediately so that the each runner doesn't have to wait for the previous.

  List<Map> jsTests = await Future.wait(jsTestsFutures);

  return {'completed': true, 'js tests': jsTests};
}
