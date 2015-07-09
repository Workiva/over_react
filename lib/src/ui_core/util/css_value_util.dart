part of w_ui_platform.ui_core;

class CssValue implements Comparable {
  final num number;
  final String unit;

  const CssValue(this.number, [this.unit = 'px']);

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

  void _checkMatchingUnits(CssValue other) {
    if (unit != other.unit) {
      throw new ArgumentError('Cannot compare CSS unit values of units $unit and ${other.unit}');
    }
  }

  CssValue operator %(num other) => new CssValue(number % other, unit);
  CssValue operator *(num other) => new CssValue(number * other, unit);
  CssValue operator +(num other) => new CssValue(number + other, unit);
  CssValue operator -(num other) => new CssValue(number - other, unit);
  CssValue operator /(num other) => new CssValue(number / other, unit);

  bool operator <(CssValue other) {
    _checkMatchingUnits(other);
    return number < other.number;
  }

  bool operator <=(CssValue other) {
    _checkMatchingUnits(other);
    return number <= other.number;
  }

  bool operator ==(dynamic other) {
    return identical(this, other) || (other is CssValue && number == other.number && unit == other.unit);
  }

  bool operator >(CssValue other) {
    _checkMatchingUnits(other);
    return number > other.number;
  }

  bool operator >=(CssValue other) {
    _checkMatchingUnits(other);
    return number >= other.number;
  }

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
