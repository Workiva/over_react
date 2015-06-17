part of w_ui_platform.ui_core;

class ValidationUtil {

  static bool WARNINGS_ENABLED = true;
  static bool THROW_ON_WARNING = false;
  static int WARNING_COUNT = 0;

  static bool warn(String message) {
    WARNING_COUNT += 1;

    if (!WARNINGS_ENABLED) {
      return true;
    }

    if (THROW_ON_WARNING) {
      throw new ValidationWarning(message);
    }

    print('VALIDATION WARNING: ${message}');
    return true;
  }

}

class ValidationError extends Error {
  /** Message describing the problem. */
  final message;

  ValidationError([this.message]);
}

class ValidationWarning extends Error {
  /** Message describing the problem. */
  final message;

  ValidationWarning([this.message]);
}