/// Utilities for manipulating and generating CSS class names.
part of w_ui_platform.ui_core;

/// Converts a map of className->bool entries to a className, similar to React.addons.classSet.
/// See <http://facebook.github.io/react/docs/class-name-manipulation.html>.
String classNameFromMap(Map<String, bool> classMap) {
  return classMap.keys.where((key) => classMap[key]).join(' ');
}

Map<String, bool> mapFromClassName(String className, [Map<String, bool> classMap]) {
  if (classMap == null) {
    classMap = {};
  }
  if (className != null) {
    className = className.trim();
    if (className.isNotEmpty) {
      className.split(' ').forEach((singleClass) => classMap[singleClass] = true);
    }
  }
  return classMap;
}

/// Merges className definitions of different formats together.
/// Accepts single classes, className strings, and Map<String, bool> class maps.
Map<String, bool> mergeClassDefinitions(Iterable<dynamic> classes) {
  Map<String, bool> mergedClassMap = {};
  classes.forEach((dynamic classDefinition) {
    if (classDefinition is String) {
      mapFromClassName(classDefinition, mergedClassMap);
    } else if (classDefinition is Map) {
      mergedClassMap.addAll(classDefinition);
    }
  });
  return mergedClassMap;
}

/// Merges the specified className definitions and returns a className string.
/// For the sake of convenience, 1-6 definitions can be specified, as single classes, className strings, and Map<String, bool> class maps.
/// Similar to <https://github.com/JedWatson/classnames>.
/// See [classNameFromMap], [mergeClassDefinitions].
String classNames(dynamic classDefinition, [dynamic classDefinition2, dynamic classDefinition3, dynamic classDefinition4, dynamic classDefinition5]) {
  return classNameFromMap(mergeClassDefinitions([classDefinition, classDefinition2, classDefinition3, classDefinition4, classDefinition5]));
}
