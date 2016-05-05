/// Utilities for manipulating and generating CSS class names.
part of web_skin_dart.ui_core;

/// StringBuffer-backed className builder optimized for adding classNames, with support for blacklisting CSS classes.
class ClassNameBuilder {
  StringBuffer _classNamesBuffer = new StringBuffer();
  StringBuffer _blacklistBuffer;

  /// Creates a new, empty ClassNameBuilder.
  ClassNameBuilder();

  /// Creates a new ClassNameBuilder with className and blacklist values added from [CssClassProps.className] and
  /// [CssClassProps.classNameBlackList], if they are specified.
  ///
  /// This method gracefully handles null [props], as well as unspecified/null prop values.
  ClassNameBuilder.fromProps(Map props) {
    addFromProps(props);
  }

  /// Adds the className and blacklist values from a [props] Map, using the
  /// [CssClassProps.className] and [CssClassProps.classNameBlackList] values.
  ///
  /// This method gracefully handles null [props], as well as unspecified/null prop values.
  ///
  /// This method, along with [toProps], is useful for merging sets of className/blacklist props.
  void addFromProps(Map props) {
    if (props == null) {
      return;
    }

    var cssClassProps = new CssClassPropsMapView(props);

    this
      ..add(cssClassProps.className)
      ..blacklist(cssClassProps.classNameBlacklist);
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
      List blacklistedClasses = splitSpaceDelimitedString(_blacklistBuffer.toString());

      className = splitSpaceDelimitedString(className)
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

  /// Returns a Map with the [CssClassProps.className] and [CssClassProps.classNameBlackList] props
  /// populated from the return values of [toClassName] and [toClassNameBlacklist], respectively.
  ///
  /// This method, along with [addFromProps], is useful for merging sets of className/blacklist props.
  Map toProps() {
    return new CssClassPropsMapView({})
      ..className = toClassName()
      ..classNameBlacklist = toClassNameBlacklist();
  }

  @override
  String toString() {
    return '$runtimeType _classNamesBuffer: $_classNamesBuffer, _blacklistBuffer: $_blacklistBuffer, toClassName(): ${toClassName()}';
  }
}

/// Returns a List of space-delimited tokens efficiently split from the specified string.
///
/// Useful for splitting CSS class name strings into class tokens, or `data-test-id` values into individual test IDs.
///
/// Handles leading and trailing spaces, as well as token separated by multiple spaces.
///
/// Example:
///
///     splitSpaceDelimitedString('   foo bar     baz') // ['foo', 'bar', 'baz']
List<String> splitSpaceDelimitedString(String string) {
  const int SPACE = 32; // ' '.codeUnits.first;

  List<String> strings = [];
  int start = 0;

  while (start != string.length) {
    while (string.codeUnitAt(start) == SPACE) {
      start++;
      if (start == string.length) {
        return strings;
      }
    }

    int end = start;
    while (string.codeUnitAt(end) != SPACE) {
      end++;
      if (end == string.length) {
        strings.add(string.substring(start, end));
        return strings;
      }
    }

    strings.add(string.substring(start, end));

    start = end;
  }

  return strings;
}
