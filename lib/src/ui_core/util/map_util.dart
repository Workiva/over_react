part of w_ui_platform.ui_core;

/// Make a copy of a map, optionally omitting certain keys.
Map copyMap(Map sourceMap, [Iterable keysToOmit]) {
  Map newMap = new Map.from(sourceMap);
  if (keysToOmit != null) {
    keysToOmit.forEach((key) => newMap.remove(key));
  }
  return newMap;
}
