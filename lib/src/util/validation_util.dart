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
  /// Optionally, an element can be passed as the second parameter
  /// to help devs locate the offending DOM node in the inspector.
  ///
  ///     assert(ValidationUtil.warn('Some warning message', element));
  ///
  /// The message will be printed out to the console.
  static bool warn(String message, [dynamic element]) {
    WARNING_COUNT += 1;

    if (onWarning != null) {
      onWarning(message);
    }

    if (WARNINGS_ENABLED) {
      if (THROW_ON_WARNING) {
        throw new ValidationWarning(message);
      }

      window.console.warn('VALIDATION WARNING: $message');

      if (element != null) {
          window.console.warn(findDomNode(element));
      }
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
