library test_util.validation_util_helpers;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

List<String> _validationWarnings;
void _recordValidationWarning(String warningMessage) {
  _validationWarnings.add(warningMessage);
}

/// Starts recording validation warnings for use with [verifyValidationWarning] and [rejectValidationWarning].
void startRecordingValidationWarnings() {
  _validationWarnings = [];
  ValidationUtil.onWarning = _recordValidationWarning;
}

/// Stops recording validation warnings.
void stopRecordingValidationWarnings() {
  _validationWarnings = null;
  if (ValidationUtil.onWarning == _recordValidationWarning) {
    ValidationUtil.onWarning = null;
  }
}

/// Returns the list of recorded validation warnings.
List<String> getValidationWarnings() => _validationWarnings.toList();

/// Clears the list of recorded validation warnings used by
/// [getValidationWarnings], [verifyValidationWarning], and [rejectValidationWarning].
void clearValidationWarnings() {
  _validationWarnings.clear();
}

/// Verify that no validation warning matching [warningMatcher] were logged.
///
/// Make sure to call [startRecordingValidationWarnings] before any code that might log errors.
void rejectValidationWarning(dynamic warningMatcher) {
  expect(_validationWarnings, everyElement(isNot(warningMatcher)),
    reason: 'Expected no recorded warnings to match: $warningMatcher'
  );
}

/// Verify that a validation warning matching [warningMatcher] was logged.
///
/// Make sure to call [startRecordingValidationWarnings] before any code that might log errors.
void verifyValidationWarning(dynamic warningMatcher) {
  expect(_validationWarnings, anyElement(warningMatcher),
    reason: 'Expected some recorded warning to match: $warningMatcher'
  );
}
