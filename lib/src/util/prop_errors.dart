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

library over_react.prop_errors;

import 'package:over_react/over_react.dart';

/// Errors thrown due to a value within [UiComponent.props] being set incorrectly.
class PropError extends Error {
  static const String defaultPrefix = 'PropError: ';
  static const String requiredPrefix = 'RequiredPropError: ';
  static const String invalidPrefix = 'InvalidPropValueError: ';
  static const String combinationPrefix = 'InvalidPropCombinationError: ';

  final String _messagePrefix;
  dynamic invalidValue;
  final String propName;
  final String prop2Name;
  String message;

  /// Create a new [PropError], with the given [propName] and optional [message].
  PropError(this.propName, [this.message = ''])
    : invalidValue = null,
      prop2Name = null,
      _messagePrefix = defaultPrefix;

  /// Create a new [PropError] that signifies the given [propName] is required to be set.
  ///
  /// > See: [requiredProp] annotation
  PropError.required(this.propName, [this.message = ''])
    : invalidValue = null,
      prop2Name = null,
      _messagePrefix = requiredPrefix;

  /// Create a new [PropError] that signifies the given [propName] is set to an [invalidValue].
  PropError.value(this.invalidValue, this.propName, [this.message = ''])
    : prop2Name = null,
      _messagePrefix = invalidPrefix;

  /// Create a new [PropError] that signifies the [propName] and [prop2Name] are in conflict.
  PropError.combination(this.propName, this.prop2Name, [this.message = ''])
    : invalidValue = null,
      _messagePrefix = combinationPrefix;

  @override
  String toString() {
    String explanation;

    if (_messagePrefix == requiredPrefix) {
      explanation = 'Prop $propName is required. ';
    } else if (_messagePrefix == invalidPrefix) {
      explanation = 'Prop $propName set to $invalidValue. ';
    } else if (_messagePrefix == combinationPrefix) {
      explanation = 'Prop $propName and prop $prop2Name are set to incompatible values. ';
    } else {
      explanation = 'Prop $propName. ';
    }

    return '$_messagePrefix$explanation$message'.trim();
  }
}
