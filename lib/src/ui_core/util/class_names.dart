/// Utilities for manipulating and generating CSS class names.
part of web_skin_dart.ui_core;

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
      ..add(props[CssClassProps.Z_$KEY__CLASS_NAME])
      ..blacklist(props[CssClassProps.Z_$KEY__CLASS_NAME_BLACKLIST]);
  }

  /// Adds a className string. May be a single CSS class 'token', or multiple space-delimited classes,
  /// IF [should] is true, otherwise, does nothing (convenience for helping to inline addition conditionals).
  ///
  /// There is no checking for duplicate CSS classes.
  void add(String className, [bool should = true]) {
    if (!should || className == null || className == '') {
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
    if (!should || className == null || className == '') {
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

  /// Returns a String representation of only the blacklisted classes.
  /// Useful for blacklist forwarding.
  ///
  /// Duplicate classes will be added.
  String toClassNameBlacklist() {
    return _blacklistBuffer == null || _blacklistBuffer.isEmpty
      ? null
      : _blacklistBuffer.toString();
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
