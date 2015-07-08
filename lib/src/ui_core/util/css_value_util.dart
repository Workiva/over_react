part of w_ui_platform.ui_core;

/// Determines if a value will produce a valid CSS style for offset / size properties.
bool isValueCssNumericValue(dynamic value) {
  if (value is num) {
    return true;
  }

  if (value is! String) {
    return false;
  }

  // value is a String, but can it can be interpreted as a numerical value?
  String stripped = stripCssUnit(value);

  return double.parse(stripped, (source) => null) != null ? true : false;
}

/// Strip the units off of the given value.  Returns a unit-less String.
/// If no CSS unit is found within the given value, it will simply return the value.
String stripCssUnit(String value) {
  var matcher = new RegExp(r'(\d)(?:em|ex|rem|vh|vw|vmin|vmax|%|px|cm|mm|in|pt|pc|ch)$');
  return value.replaceAllMapped(matcher, (Match m) => m.group(1));
}
