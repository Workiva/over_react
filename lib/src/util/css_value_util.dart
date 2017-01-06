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

library over_react.css_value_util;

import 'package:quiver/core.dart';

/// A CSS length value, with a number and unit component, for use in CSS properties such as `width`, `top`, `padding`, etc.
class CssValue implements Comparable<CssValue> {
  /// The number component of this CSS value.
  ///
  /// E.g., 1 for '1px'
  final num number;

  /// The unit component of this CSS value.
  ///
  /// E.g., 'px' for '1px'
  final String unit;

  /// Creates a new [CssValue]. If no [unit] is specified, `'px'` is used instead.
  const CssValue(this.number, [this.unit = 'px']);

  /// Parse [source] and return its [CssValue] representation.
  ///
  /// Accepts a number optionally followed by a CSS length unit. If no unit is present, `'px'` is used as the unit instead.
  ///
  /// If `source` is not a valid CSS value, the [onError] callback is called with [source] and an error object, and its return value is used instead. If no `onError` is provided, `null` is returned.
  ///
  /// Examples of accepted values:
  ///
  ///     '2px'
  ///     '10'
  ///     20
  ///     '1.25em'
  ///     '-15%'
  factory CssValue.parse(dynamic source, {CssValue onError(value, error)}) {
    num number;
    String unit;

    var error;

    if (source == null) {
      error = new ArgumentError.notNull('value');
    } else if (source is num) {
      number = source;
      unit = 'px';
    } else {
      var unitMatch = new RegExp(r'(?:rem|em|ex|vh|vw|vmin|vmax|%|px|cm|mm|in|pt|pc|ch)?$').firstMatch(source.toString());
        unit = unitMatch.group(0);
      if (unit == '') {
        unit = 'px';
      }

      number = double.parse(unitMatch.input.substring(0, unitMatch.start), (_) {
        error = new ArgumentError.value(source, 'value', 'Invalid number/unit for CSS value');
      });
    }

    if (number != null && !number.isFinite) {
      // Rule out -Infinity, Infinity, and NaN.
      error = new ArgumentError.value(number, 'value', 'Number portion of CSS value ($source) must be finite');
    }

    var result;
    if (error != null) {
      if (onError == null) {
        result = null;
      } else {
        result = onError(source, error);
      }
    } else {
      result = new CssValue(number, unit);
    }

    return result;
  }

  /// Throws an error if this value's [unit] does not match that of [other].
  ///
  /// Used internally to prevent calculations between incompatible units.
  void _checkMatchingUnits(CssValue other) {
    if (unit != other.unit) {
      throw new ArgumentError('Cannot compare CSS unit values of units $unit and ${other.unit}');
    }
  }

  /// Returns the remainder of dividing this value's [number] by [other].
  CssValue operator %(num other) => new CssValue(number % other, unit);

  /// Returns the result of multiplying this value's [number] by [other].
  CssValue operator *(num other) => new CssValue(number * other, unit);

  /// Returns the result of dividing this value's [number] by [other].
  CssValue operator /(num other) => new CssValue(number / other, unit);

  /// Returns a new [CssValue] with the sum of the [number]s of this value and [other].
  ///
  /// Throws an error if the [unit] of this value and [other] do not match.
  CssValue operator +(CssValue other) {
    _checkMatchingUnits(other);
    return new CssValue(number + other.number, unit);
  }

  /// Returns a new [CssValue] with the difference between the [number]s of this value and [other].
  ///
  /// Throws an error if the [unit] of this value and [other] do not match.
  CssValue operator -(CssValue other) {
    _checkMatchingUnits(other);
    return new CssValue(number - other.number, unit);
  }

  /// Returns whether this value's [number] is less than that of [other].
  ///
  /// Throws an error if the [unit] of this value and [other] do not match.
  bool operator <(CssValue other) {
    _checkMatchingUnits(other);
    return number < other.number;
  }

  /// Returns whether this value's [number] is less than or equal to that of [other].
  ///
  /// Throws an error if the [unit] of this value and [other] do not match.
  bool operator <=(CssValue other) {
    _checkMatchingUnits(other);
    return number <= other.number;
  }

  /// Returns whether this value's [number] and [unit] are equal to that of [other].
  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is CssValue && number == other.number && unit == other.unit);
  }

  @override
  int get hashCode => hash2(this.number, this.unit);

  /// Returns whether this value's [number] is greater than that of [other].
  ///
  /// Throws an error if the [unit] of this value and [other] do not match.
  bool operator >(CssValue other) {
    _checkMatchingUnits(other);
    return number > other.number;
  }

  /// Returns whether this value's [number] is greater than or equal to that of [other].
  ///
  /// Throws an error if the [unit] of this value and [other] do not match.
  bool operator >=(CssValue other) {
    _checkMatchingUnits(other);
    return number >= other.number;
  }

  /// Returns a new [CssValue] with this value's [unit] and the negation of this value's [number].
  CssValue operator -() {
    return new CssValue(-number, unit);
  }

  /// Returns the result of comparing this value's [number] to that of [other].
  ///
  /// Throws an error if the [unit] of this value and [other] do not match.
  @override
  int compareTo(CssValue other) {
    _checkMatchingUnits(other);
    return number.compareTo(other.number);
  }

  /// Returns the String representation of this value, which can be used as CSS style values.
  ///
  /// If [number] is 0, then the [unit] is omitted.
  @override
  String toString() {
    if (number == 0) return '0';

    if (number == number.truncate()) return '${number.toStringAsFixed(0)}$unit';

    return '$number$unit';
  }
}
