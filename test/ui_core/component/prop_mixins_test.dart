library prop_mixins_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

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

  group('AriaProps', () {
      test('cannot set / read values that are not its prop map', () {
        var instance = new AriaPropMixinsTest({});
        expect(() {instance['notThere'];}, throws);
      });

      for (var propKey in AriaProps.Z_$propKeys) {
        test('prop: $propKey can have its value set / read', () {
          var instance = new AriaPropMixinsTest({});
          testProp(new Symbol(propKey.replaceFirst('aria-', '')), propKey, instance, null);
        });
      }
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

class AriaPropMixinsTest extends MapView with AriaProps {
  AriaPropMixinsTest(Map map) : super (map);

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
