/// Utilities for manipulating and generating CSS class names.
part of w_ui_platform.ui_core;

/// Converts a map of className->bool entries to a className, similar to React.addons.classSet.
/// See <http://facebook.github.io/react/docs/class-name-manipulation.html>.
@deprecated
String classNameFromMap(Map<String, bool> classMap) {
  return classMap.keys.where((key) => classMap[key]).join(' ');
}

/// Merges className definitions of different formats together.
/// Accepts single classes, className strings, and Map<String, bool> class maps.
@deprecated
Map<String, bool> mergeClassDefinitions(Iterable<dynamic> classes) {
  Map<String, bool> mergedClassMap = {};
  classes.forEach((dynamic classDefinition) {
    if (classDefinition is String) {
      String className = (classDefinition as String).trim();
      if (className.isNotEmpty) {
        className.split(' ').forEach((singleClass) => mergedClassMap[singleClass] = true);
      }
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
@deprecated
String classNames(dynamic classDefinition, [dynamic classDefinition2, dynamic classDefinition3, dynamic classDefinition4, dynamic classDefinition5]) {
  return classNameFromMap(mergeClassDefinitions([classDefinition, classDefinition2, classDefinition3, classDefinition4, classDefinition5]));
}

/// StringBuffer-backed className builder optimized for adding classNames, with support for blacklisting CSS classes.
class ClassNameBuilder {
  StringBuffer _classNamesBuffer = new StringBuffer();
  StringBuffer _blacklistBuffer = null;

  /// Creates a new, empty ClassNameBuilder.
  ClassNameBuilder();

  /// Creates a new ClassNameBuilder with className and blacklist values added from [CssClassProps.className] and
  /// [CssClassProps.classNameBlackList], if they are specified.
  ClassNameBuilder.fromProps(Map props) {
    this
      ..add(props[CssClassPropsKey.CLASS_NAME])
      ..blacklist(props[CssClassPropsKey.CLASS_NAME_BLACKLIST]);
  }

  /// Adds a className string. May be a single CSS class 'token', or multiple space-delimited classes,
  /// IF [should] is true, otherwise, does nothing (convenience for helping to inline addition conditionals).
  ///
  /// There is no checking for duplicate CSS classes.
  void add(String className, [bool should = true]) {
    if (!should || className == null) {
      return;
    }

    if (_classNamesBuffer.isNotEmpty) {
      _classNamesBuffer.write(' ');
    }
    _classNamesBuffer.write(className);
  }

  /// Adds all of the CSS classes represented by [className] (a space-delimited list) to the blacklist,
  /// IF [should] is true, otherwise, does nothing (convenience for helping to inline blacklisting conditionals).
  ///
  /// Classes added to the blacklist will not appear in the result of [toClassName].
  void blacklist(String className, [bool should = true]) {
    if (!should || className == null) {
      return;
    }

    if (_blacklistBuffer == null) {
      _blacklistBuffer = new StringBuffer();
    } else {
      if (_blacklistBuffer.isNotEmpty) {
        _blacklistBuffer.write(' ');
      }
    }
    _blacklistBuffer.write(className);
  }

  /// Returns a String representation of the built className, which includes any added classes, and none of the blacklisted classes.
  ///
  /// Duplicate classes will be added.
  String toClassName() {
    String className = _classNamesBuffer.toString();

    if (_blacklistBuffer != null && _blacklistBuffer.isNotEmpty) {
      List blacklistedClasses = splitClassName(_blacklistBuffer.toString());

      className = splitClassName(className)
        .where((String cssClass) => !blacklistedClasses.contains(cssClass))
        .join(' ');
    }

    return className;
  }

  @override
  String toString() {
    return '${runtimeType} _classNamesBuffer: ${_classNamesBuffer}, _blacklistBuffer: ${_blacklistBuffer}, toClassName(): ${toClassName()}';
  }
}


/// Returns a List of CSS class token Strings efficiently split from the specified [className].
List<String> splitClassName(String className) {
  const int SPACE = 32; // ' '.codeUnits.first;

  List<String> classNames = [];
  int start = 0;

  while (start != className.length) {
    while (className.codeUnitAt(start) == SPACE) {
      start++;
      if (start == className.length) {
        return classNames;
      }
    }

    int end = start;
    while (className.codeUnitAt(end) != SPACE) {
      end++;
      if (end == className.length) {
        classNames.add(className.substring(start, end));
        return classNames;
      }
    }

    classNames.add(className.substring(start, end));

    start = end;
  }

  return classNames;
}
