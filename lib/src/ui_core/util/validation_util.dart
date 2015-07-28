part of w_ui_platform.ui_core;

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

    _warningsStreamController.add(message);

    if (WARNINGS_ENABLED) {
      if (THROW_ON_WARNING) {
        throw new ValidationWarning(message);
      }

      window.console.warn('VALIDATION WARNING: ${message}');
    }

    return true;
  }

  static final StreamController<String> _warningsStreamController = new StreamController.broadcast(sync: true);

  /// A stream of the input to the [warn] method.
  ///
  /// Useful for verifying warnings in unit tests.
  static Stream<String> get warnings => _warningsStreamController.stream;
}

class ValidationWarning extends Error {
  /** Message describing the problem. */
  final message;

  ValidationWarning([this.message]);
}
