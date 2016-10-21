library dart_dev.src.tasks.saucelabs.api;

import 'dart:io';

final env = Platform.environment;

String commandOutput(String cmd, [List args = const []]) =>
    (Process.runSync(cmd, args).stdout as String).trim();

/// Returns options for the Sauce Labs build, supplied by environment variables and Git.
///
/// The commit SHA is also always included in the custom data field.
Map getSauceBuildOptions(String buildName) {
  List<String> tags = <String>[];
  Map customData = {};

  final String commit = commandOutput('git', ['rev-parse', 'HEAD']);

  customData['commit'] = commit;

  final maxDuration = testDuration(const Duration(minutes: 15));

  // Additional saucelabs options
  // See https://wiki.saucelabs.com/display/DOCS/Test+Configuration+Options
  return {
    'build': buildName,
    'tags': tags,
    'public': 'team',
    'customData': customData,

    // Override default max duration of 180 seconds for JS tests.
    'maxDuration': maxDuration,
    // Specify via spinal-case as well to ensure Sauce Labs doesn't override it.
    'max-duration': maxDuration,

    // Capture HTML snapshots of the test page.
    // Useful for viewing the full logs when they get truncated.
    //
    // PROTIP: you can't always access these snapshots in the Sauce Labs web UI, but you CAN
    // take a screenshot URL and replace `screenshot.png` with `source.html` to get its
    // corresponding HTML capture.
    //
    // Example:
    //     https://assets.saucelabs.com/jobs/{job_id}/0005screenshot.png
    //     https://assets.saucelabs.com/jobs/{job_id}/0005source.html
    'captureHtml': true,
    // Disable video recording since it can makes tests run much slower.
    // Video of these tests aren't useful anyway, especially since we have screenshots and HTML.
    'recordVideo': false,
  };
}

String generateTunnelIdentifier() {
  return 'manual_${commandOutput('whoami')}';
}

int testDuration(Duration duration) {
  // The maximum test duration allowed by Sauce Labs, in seconds.
  const maxAllowedSeconds = 10800;

  var seconds = duration.inSeconds;
  if (seconds > maxAllowedSeconds) {
    throw new Exception(
        'Test duration must be at most $maxAllowedSeconds seconds.');
  }

  return seconds;
}
