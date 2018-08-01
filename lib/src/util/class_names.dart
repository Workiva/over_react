// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Utilities for manipulating and generating CSS class names.
library over_react.class_names;

import 'dart:collection';

import 'package:over_react/over_react.dart' show
    // Must import these consts because they are used in the transformed code.
    PropsMeta, PropDescriptor, ConsumedProps, // ignore: unused_shown_name
    UiComponent, UiProps;
import 'package:over_react/src/component_declaration/annotations.dart';

/// Typed getters/setters for props related to CSS class manipulation.
///
/// Universally available on all OverReact components via [UiProps].
@PropsMixin(keyNamespace: '')
abstract class CssClassPropsMixin {
  // ignore: undefined_identifier, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForCssClassPropsMixin;

  Map get props;

  /// String of space-delimited CSS classes to be added to the resultant DOM.
  ///
  /// All over_react components merge any added classes with this prop and the [classNameBlacklist] prop (see
  /// [UiComponent.forwardingClassNameBuilder]).
  String className;

  /// String of space-delimited CSS classes to be blacklisted from being added to the resultant DOM.
  ///
  /// All over_react components merge any added classes with this prop and the [className] prop (see
  /// [UiComponent.forwardingClassNameBuilder]).
  String classNameBlacklist;
}

/// A `MapView` with typed getters/setters for all CSS-class-related props.
class CssClassPropsMapView extends MapView with CssClassPropsMixin {
  /// Create a new instance backed by the specified map.
  CssClassPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  ///
  /// In this case, it's the current [MapView] object.
  @override
  Map get props => this;
}

/// A [StringBuffer]-backed CSS class builder optimized for adding classNames,
/// with support for blacklisting CSS classes.
class ClassNameBuilder {
  StringBuffer _classNamesBuffer = new StringBuffer();
  StringBuffer _blacklistBuffer;

  /// Creates a new, empty `ClassNameBuilder` instance.
  ///
  /// > Related: [UiComponent.forwardingClassNameBuilder]
  ClassNameBuilder();

  /// Creates a new `ClassNameBuilder` with the [CssClassPropsMixin.className] values and
  /// excludes the [CssClassPropsMixin.classNameBlacklist] values if specified within the
  /// provided [props] Map.
  ///
  /// This method gracefully handles null [props], as well as unspecified/null prop values.
  ClassNameBuilder.fromProps(Map props) {
    addFromProps(props);
  }

  /// Creates a new `ClassNameBuilder` with [_classNamesBuffer] and [_blacklistBuffer] merged from [a] and [b].
  ///   
  ///     ClassNameBuilder a = new ClassNameBuilder()
  ///       ..add('a');
  /// 
  ///     ClassNameBuilder b = new ClassNameBuilder()
  ///       ..add('b');
  ///     
  ///     ClassNameBuilder builder = new ClassNameBuilder.merged(a,b);
  /// 
  ///     print(builder.toClassName()); // 'a b'
  ClassNameBuilder.merged(ClassNameBuilder a, ClassNameBuilder b) {
    merge(a);
    merge(b);
  }

  /// Adds the [CssClassPropsMixin.className] and excludes the [CssClassPropsMixin.classNameBlacklist] values
  /// if specified within the provided [props] Map.
  ///
  /// This method gracefully handles null [props], as well as unspecified/null prop values.
  ///
  /// > This method, along with [toProps], are useful for merging sets of className/blacklist props.
  void addFromProps(Map props) {
    if (props == null) {
      return;
    }

    var cssClassProps = new CssClassPropsMapView(props);

    this
      ..add(cssClassProps.className)
      ..blacklist(cssClassProps.classNameBlacklist);
  }

  /// Adds all of the CSS classes represented by a space-delimited list of [className]s
  /// if [shouldAdd] is `true`.
  ///
  /// Does not check for / remove duplicate CSS classes.
  ///
  /// Is a noop if [shouldAdd] is `false`, [className] is `null` or [className] is an empty string.
  ///
  /// __[shouldAdd] makes conditional CSS classes a breeze:__
  ///
  ///     @override
  ///     render() {
  ///       var classes = forwardingClassNameBuilder()
  ///         ..add('foo')
  ///         ..add('foo--is-active', state.isActive)
  ///         ..add('foo--is-disabled', state.isDisabled);
  ///
  ///       return (Dom.div()
  ///         ..addProps(copyUnconsumedDomProps())
  ///         ..className = classes.toClassName()
  ///       )(props.children);
  ///     }
  ///
  /// > Related: [blacklist]
  void add(String className, [bool shouldAdd = true]) {
    if (!shouldAdd || className == null || className == '') {
      return;
    }

    if (_classNamesBuffer.isNotEmpty) {
      _classNamesBuffer.write(' ');
    }
    _classNamesBuffer.write(className);
  }

  /// Blacklists all of the CSS classes represented by a space-delimited list of [className]s
  /// if [shouldBlacklist] is `true`.
  ///
  /// Classes added to the blacklist will not appear in the result of [toClassName].
  ///
  /// Is a noop if [shouldBlacklist] is `false`, [className] is `null` or [className] is an empty string.
  ///
  /// > Related: [add]
  void blacklist(String className, [bool shouldBlacklist = true]) {
    if (!shouldBlacklist || className == null || className == '') {
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



  /// Merges the classes and blacklists from [other] into this builder.
  void merge(ClassNameBuilder other) {
    if (_blacklistBuffer == null) {
      _blacklistBuffer = new StringBuffer();
    } else {
      if (_blacklistBuffer.isNotEmpty) {
        _blacklistBuffer.write(' ');
      }
    }
    _blacklistBuffer.write(other._blacklistBuffer);

    if (_classNamesBuffer.isNotEmpty) {
      _classNamesBuffer.write(' ');
    }
    _classNamesBuffer.write(other._classNamesBuffer);
  }

  /// Returns a String representation of the built className, which includes any added classes,
  /// and none of the blacklisted classes.
  ///
  /// Does not check for / remove duplicate CSS classes.
  ///
  /// __Necessary to convert a `ClassNameBuilder` instance into a valid [CssClassPropsMixin.className] value:__
  ///
  ///     @override
  ///     render() {
  ///       var classes = forwardingClassNameBuilder()
  ///         ..add('foo')
  ///         ..add('foo--is-active', state.isActive)
  ///         ..add('foo--is-disabled', state.isDisabled);
  ///
  ///       return (Dom.div()
  ///         ..addProps(copyUnconsumedDomProps())
  ///         ..className = classes.toClassName()
  ///       )(props.children);
  ///     }
  ///
  /// > Related: [toClassNameBlacklist]
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
  ///
  /// Does not check for / remove duplicate CSS classes.
  ///
  /// __Useful for blacklist forwarding:__
  ///
  ///     @override
  ///     render() {
  ///       var classes = forwardingClassNameBuilder()
  ///         ..blacklist('some-class-found-in-the-forwarding-builder', state.becauseReasons);
  ///
  ///       return (NestedComponent()
  ///         ..addProps(copyUnconsumedProps())
  ///         ..className = classes.toClassName()
  ///         ..classNameBlacklist = classes.toClassNameBlacklist()
  ///       )(props.children);
  ///     }
  ///
  /// > Related: [toClassName]
  String toClassNameBlacklist() {
    return _blacklistBuffer == null || _blacklistBuffer.isEmpty
        ? null
        : _blacklistBuffer.toString();
  }

  /// Returns a Map with the [CssClassPropsMixin.className] and [CssClassPropsMixin.classNameBlacklist] props
  /// populated from the return values of [toClassName] and [toClassNameBlacklist], respectively.
  ///
  /// > This method, along with [addFromProps], is useful for merging sets of className/blacklist props.
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

/// Returns a List of space-delimited tokens efficiently split from the specified [string].
///
/// Useful for splitting CSS className strings into class tokens, or `data-test-id` values into individual test IDs.
///
/// Handles leading and trailing spaces, as well as token separated by multiple spaces.
///
/// __Example:__
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
