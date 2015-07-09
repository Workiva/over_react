part of w_ui_platform.ui_core;

/// Class for handling CSS values
class CssValue implements Comparable {
  final num number;
  final String unit;

  /// Constructor
  const CssValue(this.number, [this.unit = 'px']);

  /// Parse a value into a CssValue.
  /// If the value provided is not a valid [CssValue] the 'onError' function will
  /// be called.
  /// If no 'onError' function was specified then null will be returned.
  factory CssValue.parse(dynamic value, {CssValue onError(value, error)}) {
    num number;
    String unit;

    var error = null;

    if (value == null) {
      error = new ArgumentError.notNull('value');
    } else if (value is num) {
      number = value;
      unit = 'px';
    } else {
      var unitMatch = new RegExp(r'(?:rem|em|ex|vh|vw|vmin|vmax|%|px|cm|mm|in|pt|pc|ch)?$').firstMatch(value.toString());
      try {
        number = double.parse(unitMatch.input.substring(0, unitMatch.start));
        unit = unitMatch.group(0);
        if (unit == '') {
          unit = 'px';
        }
      } catch(e) {
        error = new ArgumentError.value(value, 'value', 'Invalid number/unit for CSS value');
      }
    }

    if (number != null && !number.isFinite) {
      // Rule out -Infinity, Infinity, and NaN.
      error = new ArgumentError.value(number, 'value', 'Number portion of CSS value ($value) must be finite');
    }

    var result;
    if (error != null) {
      if (onError == null) {
        result = null;
      } else {
        result = onError(value, error);
      }
    } else {
      result = new CssValue(number, unit);
    }

    return result;
  }

  /// Internal function to check that units match
  void _checkMatchingUnits(CssValue other) {
    if (unit != other.unit) {
      throw new ArgumentError('Cannot compare CSS unit values of units $unit and ${other.unit}');
    }
  }

  /// Get the remainder [CssValue] divided by a number.
  CssValue operator %(num other) => new CssValue(number % other, unit);

  /// Multiply the [CssValue] by a number.
  CssValue operator *(num other) => new CssValue(number * other, unit);

  /// Divide the [CssValue] by a number.
  CssValue operator /(num other) => new CssValue(number / other, unit);

  /// Add two [CssValue] objects.
  CssValue operator +(CssValue other) {
    _checkMatchingUnits(other);
    return new CssValue(number + other.number, unit);
  }

  /// Subtract two [CssValue] objects.
  /// If the units of the two [CssValue] object doesn't match an ArgumentError will be thrown.
  CssValue operator -(CssValue other) {
    _checkMatchingUnits(other);
    return new CssValue(number - other.number, unit);
  }

  /// Check if this [CssValue] is less than the provided [CssValue].
  /// If the units of the two [CssValue] object doesn't match an ArgumentError will be thrown.
  bool operator <(CssValue other) {
    _checkMatchingUnits(other);
    return number < other.number;
  }

  /// Check if this [CssValue] is less than or equal to the provided [CssValue].
  /// If the units of the two [CssValue] object doesn't match an ArgumentError will be thrown.
  bool operator <=(CssValue other) {
    _checkMatchingUnits(other);
    return number <= other.number;
  }

  /// Check if this [CssValue] is equal to the provided [CssValue].
  /// Compares both the value and the units.
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is CssValue && number == other.number && unit == other.unit);
  }

  /// Check if this [CssValue] is less than or equal to the provided [CssValue].
  /// If the units of the two [CssValue] object doesn't match an ArgumentError will be thrown.
  bool operator >(CssValue other) {
    _checkMatchingUnits(other);
    return number > other.number;
  }

  /// Check if this [CssValue] is less than or equal to the provided [CssValue].
  /// If the units of the two [CssValue] object doesn't match an ArgumentError will be thrown.
  bool operator >=(CssValue other) {
    _checkMatchingUnits(other);
    return number >= other.number;
  }

  /// Negate this [CssValue].
  CssValue operator -() {
    return new CssValue(-number, unit);
  }

  @override
  int compareTo(other) {
    _checkMatchingUnits(other);
    return number.compareTo(other);
  }

  @override
  String toString() => number == 0 ? '0' : '$number${unit}';
}
