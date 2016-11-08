import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:browser_detect/browser_detect.dart';
import 'package:fluri/fluri.dart';
import 'package:rate_limit/rate_limit.dart';

const String testsPassedMessage = 'All tests passed';
final RegExp testsFinishedPattern =
    new RegExp(r'All tests passed|Some tests failed');

/// Uses an iframe to run the test at the url specified by the `test_url` query parameter,
/// and then exposes the test results at `window.global_test_results` for Sauce Labs to consume.
///
/// (See more info on [`global_test_results`](https://wiki.saucelabs.com/display/DOCS/Reporting+JavaScript+Unit+Test+Results+to+Sauce+Labs+Using+a+Custom+Framework]).)
///
/// This runner also provides a basic UI that displays the current platform, the path to the test,
/// the test's status, and live test logs.
main() async {
  final String testUrl =
      Uri.parse(window.location.toString()).queryParameters['test_url'];
  if (testUrl == null) {
    throw new ArgumentError(
        'Must specify test to run via the `test_url` query string.');
  }

  var friendlyTestName = testUrl
      .replaceFirst(new RegExp(r'\.sauce_browser_test\.html$'), '')
      .replaceFirst(new RegExp(r'^/'), '');

  // Display test status for convenience.
  displayTestTitle(
      '$friendlyTestName - ${getTestPlatform(friendlyName: true)} - ');
  displayTestStatus('Running tests...');

  initLogScrolling();

  // Run the tests

  Stopwatch timer = new Stopwatch();

  timer.start();
  var testLogs =
      await runTests(testUrl, getTestPlatform(), onLog: displayTestLog);
  timer.stop();

  // Parse the logs to get the status output lines.
  var statuses = <Status>[];
  testLogs.forEach((line) {
    var status = new Status.fromLog(line);
    if (status != null) {
      statuses.add(status);
    } else {
      statuses.last.otherLogs.add(line);
    }
  });

  // Loop through the status lines to collect a list of all tests
  // and determine which ones passed/failed.

  var tests = <Map>[];

  Status lastStatus = Status.initial;
  for (var status in statuses.reversed) {
    if (testsFinishedPattern.hasMatch(status.testDescription)) {
      lastStatus = status;
      continue;
    }

    bool passed = lastStatus.passCount - status.passCount == 1;
    bool failed = lastStatus.failCount - status.failCount == 1;

    // Ignore non-test logs that don't change the status (e.g., setUpAll)
    if (!passed && !failed) {
      lastStatus = status;
      continue;
    }

    if (passed) {
      tests.insert(0, {
        'name': status.testDescription,
        'result': true,
      });
    } else {
      // The output displays status lines for failing tests twice:
      //   1. Once with the status before the test
      //   2. Once with the status after the test
      // We want #2, since that one contains all of the error messages.
      var test = {
        'name': lastStatus.testDescription,
        'result': false,
      };

      var message = lastStatus.otherLogs.join('\n');
      if (!message.isEmpty) {
        test['message'] = message;
      }

      tests.insert(0, test);
    }

    lastStatus = status;
  }

  int passedCount = statuses.last.passCount;
  int failedCount = statuses.last.failCount;

  final globalTestResults = {
    'passed': passedCount,
    'failed': failedCount,
    'total': passedCount + failedCount,
    'duration': timer.elapsed.inMilliseconds,
    'tests': tests,
  };

  context['global_test_results_untruncated'] =
      new JsObject.jsify(globalTestResults);
  context['global_test_results_summary'] =
      'Failing tests:\n' + tests.map((test) => '- ${test['name']}').join('\n');
  window.console.debug('If you\'re debugging failing tests, check out '
      '`global_test_results_untruncated` and `global_test_results_summary`.');

  if (isAboveMaxResultSize(globalTestResults)) {
    // Only report failing tests
    tests.removeWhere((test) => test['result'] == false);

    if (isAboveMaxResultSize(globalTestResults)) {
      tests.forEach((test) => test.remove('message'));

      tests.first['message'] = 'TRUNCATED\n\n'
          'Test result messages are too long to display in Sauce Labs.\n\n'
          'See the captured HTML for full test output.';

      if (isAboveMaxResultSize(globalTestResults)) {
        tests
          ..clear()
          ..add({
            'name': 'TRUNCATED',
            'message': 'Test results are too long to display in Sauce Labs.\n\n'
                'See the captured HTML for full test output.',
          });
      }
    }
  }

  // Expose results at `window.global_test_results` so Sauce Labs can read them.
  context['global_test_results'] = new JsObject.jsify(globalTestResults);

  // Also display results in the page for convenience.
  displayTestStatus(
      'Tests finished: $passedCount passed, $failedCount failed.');
}

/// By default ([friendlyName]: false), returns the `test` package [platform selector](https://github.com/dart-lang/test#platform-selectors)
/// corresponding to the current browser.
///
/// If [friendlyName] is true, then a human-readable version will be returned instead.
String getTestPlatform({bool friendlyName: false}) {
  if (window.navigator.dartEnabled) {
    return friendlyName ? 'Dartium' : 'dartium';
  }
  if (browser.isChrome) {
    return friendlyName ? 'Chrome' : 'chrome';
  }
  if (browser.isFirefox) {
    return friendlyName ? 'Firefox' : 'firefox';
  }
  if (browser.isSafari) {
    return friendlyName ? 'Safari' : 'safari';
  }
  if (browser.isIe) {
    return friendlyName ? 'Internet Explorer' : 'ie';
  }

  throw new Exception(
      'Unable to detect browser test platform. User agent: ${window.navigator.userAgent}');
}

/// Returns whether the JSON-serialized version of [globalTestResults] exceeds the maximum
/// size allowed by Sauce Labs.
///
/// When this size is exceeded, Sauce Labs fails to properly report test results, so this method
/// can be used to check results and perform truncation when necessary to keep Sauce Labs happy.
bool isAboveMaxResultSize(Map globalTestResults) {
  const int maxResultsSize = 15000; // Actually somewhere >16100, <16500
  final int testResultsSize = JSON.encode(globalTestResults).length;

  return testResultsSize > maxResultsSize;
}

// ------------------------------------------------
// Test running and log parsing
// ------------------------------------------------

/// A data structure representing the status of a test at a given point in time, parsed from a test log.
class Status {
  /// The current "clock" time of this status.
  final String clock;

  /// The number of tests currently passing.
  final int passCount;

  /// The number of tests currently failing.
  final int failCount;

  /// The name/description of the current test.
  final String testDescription;

  /// Any other logs associated with this status (e.g., error messages, stack traces).
  ///
  /// To be filled in after instantiation by subsequent log processing.
  final List otherLogs = [];

  Status._({this.clock, this.passCount, this.failCount, this.testDescription});

  /// Returns a status object parsed from [line], or null if it does not represent a status log.
  factory Status.fromLog(String line) {
    line = stripAnsiColors(line);
    var match = new RegExp(r'^(\d\d(?::\d\d)+) \+(\d+)(?: \-(\d+))?: ')
        .firstMatch(line);

    if (match == null) {
      // If the regex didn't match anything, then the specified line doesn't correspond
      // to a status log.
      return null;
    }

    return new Status._(
        clock: match[1],
        passCount: int.parse(match[2]),
        failCount: match[3] == null ? 0 : int.parse(match[3]),
        testDescription: match.input.substring(match.end));
  }

  /// An empty, initial log for utility purposes.
  static final Status initial = new Status._(
      clock: '00:00', passCount: 0, failCount: 0, testDescription: null);
}

/// Runs the test at [testUrl] in this page's iframe, and returns a Future that completes
/// with all of the test's logs once the test finishes.
///
/// [platform] should be a valid `test` package [platform selector](https://github.com/dart-lang/test#platform-selectors)
/// corresponding to the current platform these tests are being run on.
///
/// Also calls the optional [onLog] whenever the test logs something.
Future<List<String>> runTests(String testUrl, String platform,
    {onLog(String log)}) {
  var completer = new Completer<List<String>>();

  // Listen to logs

  Stream<String> testConsoleLogs = window.onMessage
      .map((event) => event.data.toString())
      .asBroadcastStream();

  if (onLog != null) {
    testConsoleLogs.listen(onLog);
  }

  var allLogs = <String>[];
  var allLogsListener = testConsoleLogs.listen(allLogs.add);

  testConsoleLogs.firstWhere((log) => log.contains(testsFinishedPattern)).then(
      (_) {
    if (!completer.isCompleted) {
      allLogsListener.cancel();
      completer.complete(allLogs);
    }
  }, onError: completer.completeError);

  // Handle timeouts

  // The maximum allowed time for initial load of the test page.
  const loadTimeoutDuration = const Duration(minutes: 5);
  // The maximum allowed time between test logs.
  const testTimeoutDuration = const Duration(minutes: 1);

  testConsoleLogs.first.timeout(loadTimeoutDuration, onTimeout: () {
    if (!completer.isCompleted) {
      allLogsListener.cancel();
      completer.completeError(new TimeoutException(
          'Timed out waiting for tests to load', loadTimeoutDuration));
    }
  });

  testConsoleLogs
      .skip(1)
      .transform(new Debouncer(testTimeoutDuration))
      .first
      .then((_) {
    if (!completer.isCompleted) {
      allLogsListener.cancel();
      completer.completeError(new TimeoutException(
          'Timed out waiting for test to run', testTimeoutDuration));
    }
  });

  // Load the tests

  var augmentedTestUrl = new Fluri(testUrl)
    ..setQueryParam('platform', platform);

  var iframe = new IFrameElement()..src = augmentedTestUrl.toString();

  querySelector('#iframe_container').append(iframe);

  return completer.future;
}

// ------------------------------------------------
// Runner output for test logs and current status
// ------------------------------------------------

bool scrollLogsToBottom;

/// Initialize log scrolling behavior.
///
/// Logs automatically scroll to the bottom as printed, stopping when you start scrolling up.
///
/// Automatic scrolling can be resumed by scrolling back to the bottom.
void initLogScrolling() {
  scrollLogsToBottom = true;

  var logContainer = querySelector('#log_container');

  logContainer.onMouseWheel.listen((e) {
    const snapThreshold = 10;
    bool nearBottom = (logContainer.scrollHeight - logContainer.clientHeight) -
            logContainer.scrollTop <
        snapThreshold;

    if (e.deltaY >= 0 && nearBottom) {
      scrollLogsToBottom = true;
    } else {
      scrollLogsToBottom = false;
    }
  });
}

final logs = querySelector('#logs');
void displayTestLog(String log) {
  logs.appendHtml(ansiHtml(log) + '\n');

  if (scrollLogsToBottom) {
    logs.scrollIntoView(ScrollAlignment.BOTTOM);
  }
}

void displayTestTitle(String title) {
  querySelector('#test_title').text = title;
}

void displayTestStatus(String status) {
  querySelector('#test_status').text = status;
}

// ------------------------------------------------
// ANSI color processing
// ------------------------------------------------

/// Returns [ansiText] with ANSI color codes stripped out.
String stripAnsiColors(String ansiText) {
  var colorCodePattern = new RegExp(r'\x1b\[(\d+)m');
  return ansiText.replaceAll(colorCodePattern, '');
}

/// Returns HTML generated from [ansiText], with ANSI color codes converted into
/// spans with color-specific classes.
String ansiHtml(String ansiText) {
  const Map ansiCodesToClasses = const {
    '0': null,
    '30': 'ansi-black',
    '31': 'ansi-red',
    '32': 'ansi-green',
    '33': 'ansi-yellow',
    '34': 'ansi-blue',
    '35': 'ansi-magenta',
    '36': 'ansi-cyan',
    '37': 'ansi-white',
  };

  var colorCodePattern = new RegExp(r'\x1b\[(\d+)m');

  var currentColor = null;
  var pieces = [];

  ansiText.splitMapJoin(colorCodePattern, onMatch: (codeMatch) {
    var code = codeMatch[1];

    if (ansiCodesToClasses.containsKey(code)) {
      currentColor = ansiCodesToClasses[code];
    }
  }, onNonMatch: (String textMatch) {
    var contents = const HtmlEscape(HtmlEscapeMode.ELEMENT).convert(textMatch);
    if (currentColor != null) {
      pieces.add('<span class="$currentColor">$contents</span>');
    } else {
      pieces.add(contents);
    }
  });

  return pieces.join('');
}
