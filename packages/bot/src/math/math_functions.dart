part of bot.math;

// TODO: bad to pollute top-level NS like this?
// Another library? Hmm...

bool isValidNumber(num value) {
  return value != null && !value.isInfinite && !value.isNaN;
}

/**
 * Performs linear interpolation between values a and b. Returns the value
 * between a and b proportional to x (when x is between 0 and 1. When x is
 * outside this range, the return value is a linear extrapolation).
 */
num lerp(num a, num b, num x) {
  requireArgument(isValidNumber(a), 'a');
  requireArgument(isValidNumber(b), 'b');
  requireArgument(isValidNumber(x), 'x');
  return a + x * (b - a);
}

math.Random get rnd {
  if (_botHelperRandom == null) {
    _botHelperRandom = new math.Random();
  }
  return _botHelperRandom;
}

math.Random _botHelperRandom;
