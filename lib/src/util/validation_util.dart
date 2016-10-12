library over_react.validation_util;

import 'dart:html';

typedef void ValidationUtilWarningCallback(String message);

/// Utility for logging validation errors or warning.
class ValidationUtil {

  static bool WARNINGS_ENABLED = true;
  static bool THROW_ON_WARNING = false;
  static int WARNING_COUNT = 0;

  /// Use this to log warnings to the console in dev mode only.
  /// This is to be used in assert calls for dev help only so that it gets
  /// compiled out for production.
  ///     assert(ValidationUtil.warn('Some warning message'));
  ///
  /// The message will get print out to the console.
  static bool warn(String message) {
    WARNING_COUNT += 1;

    if (onWarning != null) {
      onWarning(message);
    }

    if (WARNINGS_ENABLED) {
      if (THROW_ON_WARNING) {
        throw new ValidationWarning(message);
      }

      window.console.warn('VALIDATION WARNING: $message');
    }

    return true;
  }

  /// Callback for when warnings are logged.
  ///
  /// Useful for verifying warnings in unit tests.
  static ValidationUtilWarningCallback onWarning;
}

class ValidationWarning extends Error {
  /// Message describing the problem.
  final message;

  ValidationWarning([this.message]);
}
