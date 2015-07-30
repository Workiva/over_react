library prop_mixins_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';

import 'prop_utils.dart';

import 'dart:collection' show MapView;

main() {
  group('ReactProps', () {
    testKeys(ReactProps.Z_$propKeys, (() => new ReactPropMixinsTest({})));
  });

  group('CssClassProps', () {
    testKeys(CssClassProps.Z_$propKeys, (() => new CssClassPropMixinsTest({})));
  });

  group('DomProps', () {
    testKeys(DomProps.Z_$propKeys, (() => new DomPropMixinsTest({})));
  });

  group('UbiquitousProps', () {
    testKeys(UbiquitousDomProps.Z_$propKeys, (() => new UbiquitousPropMixinsTest({})));
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

class UbiquitousPropMixinsTest extends MapView with UbiquitousDomProps {
  UbiquitousPropMixinsTest(Map map) : super (map);

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
