/// Utilities for making assertions around [Rectangle] instances.
library rectangle_utils;

import 'dart:math';

import 'package:test/test.dart';

num horizontalCenter(Rectangle rectangle) => (rectangle.left + rectangle.right) / 2;

num verticalCenter(Rectangle rectangle) => (rectangle.top + rectangle.bottom) / 2;

Matcher isHorizontallyCenteredWith(Rectangle other) => predicate(
    (actual) => actual is Rectangle && _isCloseTo(horizontalCenter(actual), horizontalCenter(other)),
    'is horizontally centered with [other] ($other)'
);

Matcher isVerticallyCenteredWith(Rectangle other) => predicate(
    (actual) => actual is Rectangle && _isCloseTo(verticalCenter(actual), verticalCenter(other)),
    'is vertically centered with [other] ($other)'
);

bool _isCloseTo(num a, num b, [num tolerance = .01]) {
  if (tolerance.isNaN || tolerance.isNegative) {
    throw new ArgumentError.value(tolerance, 'tolerance', 'must be a valid number >= 0');
  }

  return (a - b).abs() <= tolerance;
}

/// Similar to [closeTo], but works with [Rectangle]s.
Matcher closeToRectangle(Rectangle other, [num tolerance = .01]) {
  return predicate((actual) {
      return actual is Rectangle &&
        _isCloseTo(actual.left,   other.left,   tolerance) &&
        _isCloseTo(actual.top,    other.top,    tolerance) &&
        _isCloseTo(actual.bottom, other.bottom, tolerance) &&
        _isCloseTo(actual.right,  other.right,  tolerance);
    },
    'is within $tolerance of the dimensions of [other] ($other)'
  );
}
