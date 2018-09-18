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

library over_react.validation_util;

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react.dart' as react;

typedef void ValidationUtilWarningCallback(String message);

/// Utility for logging validation errors or warnings.
class ValidationUtil {

  static bool WARNINGS_ENABLED = true;
  static bool THROW_ON_WARNING = false;
  static int WARNING_COUNT = 0;

  /// Use this to log warnings to the console in dev mode only.
  ///
  /// Code that produces the warnings will not be included when you compile in production mode.
  ///
  ///     assert(ValidationUtil.warn('Some warning message'));
  ///
  /// Optionally, a component or element can be passed as [data]
  /// to provide additional information in the console.
  ///
  ///     assert(ValidationUtil.warn('Some warning message', component));
  ///
  /// Assert that your component emits a warning using
  /// the validation test utilities available within
  /// `package:over_react_test/over_react_test.dart` like so:
  ///
  ///     group('emits a warning to the console', () {
  ///       setUp(startRecordingValidationWarnings);
  ///
  ///       tearDown(stopRecordingValidationWarnings);
  ///
  ///       test('when <describe something that should trigger a warning>', () {
  ///         // Do something that should trigger a warning
  ///
  ///         verifyValidationWarning(/* some Matcher or String */);
  ///       });
  ///
  ///       test('unless <describe something that should NOT trigger a warning>', () {
  ///         // Do something that should NOT trigger a warning
  ///
  ///         rejectValidationWarning(/* some Matcher or String */);
  ///       });
  ///     },
  ///         // Be sure to not run these tests in JS browsers
  ///         // like Chrome, Firefox, etc. since  the OverReact
  ///         // ValidationUtil.warn() method will only produce a
  ///         // console warning when compiled in "dev" mode.
  ///         testOn: '!js'
  ///     );
  static bool warn(String message, [dynamic data]) {
    WARNING_COUNT += 1;

    if (onWarning != null) {
      onWarning(message);
    }

    if (WARNINGS_ENABLED) {
      if (THROW_ON_WARNING) {
        throw new ValidationWarning(message);
      }

      window.console.warn('VALIDATION WARNING: $message');

      if (data != null) {
          window.console.groupCollapsed('(Warning info)');
          window.console.log(data);

          if (isValidElement(data)) {
            window.console.log('props: ${prettyPrintMap(getProps(data))}');
          } else if (data is react.Component) {
            window.console.log('props: ${data.props}');
          }

          window.console.groupEnd();
      }
    }

    return true;
  }

  /// Callback for when warnings are logged.
  ///
  /// Useful for verifying warnings in unit tests.
  ///
  /// > See: [startRecordingValidationWarnings]
  static ValidationUtilWarningCallback onWarning;
}

class ValidationWarning extends Error {
  /// Message describing the problem.
  final message;

  ValidationWarning([this.message]);
}
