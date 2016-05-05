library ui_core.validation_util;

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

/// Validates whether the current page detects touch support via the 'touch'/'no-touch' classes on the <html> element.
/// Asserts that touch support detection is enabled, plus prints an error message if detection is not enabled so that
/// in unchecked mode an error will still be produced.
///
/// This detection is necessary for proper CSS behavior for checkboxes, radios, and switches.
void validateTouchSupportDetection() {
  var htmlClasses = document.documentElement.classes;
  var detectsTouchSupport = htmlClasses.contains('touch') || htmlClasses.contains('no-touch');

  if (! detectsTouchSupport) {
    assert(
        detectsTouchSupport &&
        'Detection of touch support with addition of the "touch"/"no-touch" CSS classes is not enabled. '
        'This detection is necessary for proper CSS behavior for checkboxes, radios, and switches.\n'
        'See: https://github.com/Workiva/web-skin/search?l=scss&q=no-touch\n\n'
        'Make sure to include Modernizr, or some other library that adds the "touch"/"no-touch" CSS classes to the <html> element.\n'
        'To use the copy in Web Skin, add `'
        '<script src="packages/web_skin/dist/js/core/modernizr/modernizr-custom.js"></script>'
        '` at the end of this page\'s <head> tag.\n' is String
    );

    window.console.error(
        'Detection of touch support with addition of the "touch"/"no-touch" CSS classes is not enabled. '
        'This detection is necessary for proper CSS behavior for checkboxes, radios, and switches.\n'
        'See: https://github.com/Workiva/web-skin/search?l=scss&q=no-touch\n\n'
        'Make sure to include Modernizr, or some other library that adds the "touch"/"no-touch" CSS classes to the <html> element.\n'
        'To use the copy in Web Skin, add `'
        '<script src="packages/web_skin/dist/js/core/modernizr/modernizr-custom.js"></script>'
        '` at the end of this page\'s <head> tag.\n'
    );
  }
}
