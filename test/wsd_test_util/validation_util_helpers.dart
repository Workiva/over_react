// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
