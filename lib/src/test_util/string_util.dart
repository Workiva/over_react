library test_util.string_util;

/// Utility function to convert `SCREAMING_SNAKE` strings into `spinal-case` equivalents.
String screamingSnakeToSpinal(String str) {
  var newStr = str.replaceAll('_', '-');
      newStr = newStr.toLowerCase();

  return newStr;
}
