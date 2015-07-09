part of w_ui_platform.ui_core;

class CssValue implements Comparable {
  final num number;
  final String unit;

  const CssValue(this.number, [this.unit = 'px']);

  factory CssValue.parse(dynamic value, {CssValue onError(dynamic value)}) {
    try {
      double number;
      String unit;
      if (value is num) {
        number = value.toDouble();
        unit = 'px';
      } else {
        var match = new RegExp(r'(.*\d)(em|ex|rem|vh|vw|vmin|vmax|%|px|cm|mm|in|pt|pc|ch)?$').firstMatch(value.toString());
        if (match == null) {
          throw 'Invalid CSS value: $value';
        }

        number = double.parse(match.group(1));
        unit = match.group(2);

        if (unit == null) {
          unit = 'px';
        }
      }

      return new CssValue(number, unit);
    } catch(e) {
      if (onError == null) {
        assert(ValidationUtil.warn(e));
        return null;
      } else {
        return onError(value);
      }
    }
  }

  void checkMatchingUnits(CssValue other) {
    if (unit != other.unit) {
      throw 'Cannot compare CSS unit values of units $unit and ${other.unit}';
    }
  }

  CssValue operator %(num other) => new CssValue(number % other, unit);
  CssValue operator *(num other) => new CssValue(number * other, unit);
  CssValue operator +(num other) => new CssValue(number + other, unit);
  CssValue operator -(num other) => new CssValue(number - other, unit);
  CssValue operator /(num other) => new CssValue(number / other, unit);

  bool operator <(CssValue other) {
    checkMatchingUnits(other);
    return number < other.number;
  }

  bool operator <=(CssValue other) {
    checkMatchingUnits(other);
    return number <= other.number;
  }

  bool operator ==(dynamic other) {
    return identical(this, other) || (other is CssValue && number == other.number && unit == other.unit);
  }

  bool operator >(CssValue other) {
    checkMatchingUnits(other);
    return number > other.number;
  }

  bool operator >=(CssValue other) {
    checkMatchingUnits(other);
    return number >= other.number;
  }

  CssValue operator -() {
    return new CssValue(-number, unit);
  }

  @override
  int compareTo(other) {
    checkMatchingUnits(other);
    return number.compareTo(other);
  }

  @override
  String toString() => number == 0 ? '0' : '$number${unit}';
}
