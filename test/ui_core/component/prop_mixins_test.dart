library prop_mixins_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';

import 'prop_utils.dart';
import 'dart:mirrors';

import 'dart:collection' show MapView;

main() {
  // Testing for ReactProps within prop_mixins.dart
  group('ReactProps', () {
    List keys = [
      'children',
      'key',
      'ref'
    ];

    testKeys(keys, (() => new ReactPropMixinsTest({})));
  });

  // Testing for CssClassProps within prop_mixins.dart
  group('CssClassProps', () {
    List keys = [
      'className',
      'classNameBlacklist'
    ];

    testKeys(keys, (() => new CssClassPropMixinsTest({})));
  });

  // Testing for DomProps within prop_mixins.dart
  group('DomProps', () {
    List keys = [
      'style',
      'id',
      'className',
      'tabIndex',
      'disabled',
      'onClick',
      'onChange',
      'htmlFor',
      'type',
      'checked',
      'href',
      'target',
      'role',
      'scope'
    ];

    testKeys(keys, (() => new DomPropMixinsTest({})));
  });
}

class DomPropMixinsTest extends MapView with DomProps {
  /// Create a new instance backed by the specified map.
  DomPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw 'Map does not contain this key: $key';
    }
    return super[key];
  }
}

class ReactPropMixinsTest extends MapView with ReactProps {
  /// Create a new instance backed by the specified map.
  ReactPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw 'Map does not contain this key: $key';
    }
    return super[key];
  }
}

class CssClassPropMixinsTest extends MapView with CssClassProps {
  /// Create a new instance backed by the specified map.
  CssClassPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw 'Map does not contain this key: $key';
    }
    return super[key];
  }
}
