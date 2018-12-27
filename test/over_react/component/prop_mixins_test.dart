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

library prop_mixins_test;

import 'dart:collection' show MapView;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../test_util/prop_utils.dart';

main() {
  group('ReactProps', () {
    testInvalidKey((() => new ReactPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          new ReactPropMixinsTest({})
            ..ref = null
            ..key = null,
          {'ref': null, 'key': null});
    });

    group('prop: key can have its value set to', () {
      test('an int and be read as a String', () {
        var reactPropsMap = new ReactPropMixinsTest({})
          ..key = 1;

        expect(reactPropsMap.key, equals('1'));
      });

      test('a String and be read as a String', () {
        var reactPropsMap = new ReactPropMixinsTest({})
          ..key = '1';

        expect(reactPropsMap.key, equals('1'));
      });

      test('null and be read as a null', () {
        var reactPropsMap = new ReactPropMixinsTest({})
          ..key = null;

        expect(reactPropsMap.key, isNull);
      });
    });
  });

  group('CssClassProps', () {
    testInvalidKey((() => new CssClassPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(new CssClassPropMixinsTest({})..className = null..classNameBlacklist = null, {'className': null, 'classNameBlacklist': null});
    });
  });

  group('DomPropsMixin', () {
    testInvalidKey((() => new DomPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          new DomPropMixinsTest({})
            ..style = null
            ..id = null,
          {'style': null, 'id': null});
    });
  });

  group('SvgPropsMixin', () {
    testInvalidKey((() => new SvgPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          new SvgPropMixinsTest({})
            ..clipPath = null
            ..cx= null,
          {'clipPath': null, 'cx': null});
    });
  });

  group('UbiquitousProps', () {
    testInvalidKey((() => new UbiquitousPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          new UbiquitousPropMixinsTest({})
            ..tabIndex = null
            ..id = null,
          {'tabIndex': null, 'id': null});
    });

    group('has a getter that provides a typed view of', () {
      test('aria props', () {
        var instance = new UbiquitousPropMixinsTest({})
          ..aria.labelledby = 'foo';

        expect(instance, equals(ariaProps()..labelledby = 'foo'), reason: 'should set the prop properly');
        expect(instance.aria.labelledby, 'foo', reason: 'should be able to read the prop in addition to setting it');
        expect(instance.aria, same(instance.aria), reason: 'should cache the backing typed MapView');
      });

      test('DOM props', () {
        var instance = new UbiquitousPropMixinsTest({})
          ..dom.target = 'foo';

        expect(instance, equals(domProps()..target = 'foo'), reason: 'should set the prop properly');
        expect(instance.dom.target, 'foo', reason: 'should be able to read the prop in addition to setting it');
        expect(instance.dom, same(instance.dom), reason: 'should cache the backing typed MapView');
      });
    });
  });

  group('AriaProps', () {
    testInvalidKey(() => new AriaPropMixinsTest({}));

    test('uses unnamespaced keys with \'aria-\' prefix', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          new AriaPropMixinsTest({})
            ..activedescendant = null
            ..atomic = null,
          {'aria-activedescendant': null, 'aria-atomic': null});
    });
  });
}

class DomPropMixinsTest extends MapView with 
    DomPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $DomPropsMixin {
  /// Create a new instance backed by the specified map.
  DomPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw new ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class SvgPropMixinsTest extends MapView with 
    SvgPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $SvgPropsMixin {
  /// Create a new instance backed by the specified map.
  SvgPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw new ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class ReactPropMixinsTest extends MapView with 
    ReactPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $ReactPropsMixin {
  /// Create a new instance backed by the specified map.
  ReactPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw new ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class CssClassPropMixinsTest extends MapView with 
    CssClassPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $CssClassPropsMixin {
  /// Create a new instance backed by the specified map.
  CssClassPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw new ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class UbiquitousPropMixinsTest extends MapView with 
    UbiquitousDomPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $UbiquitousDomPropsMixin {
  UbiquitousPropMixinsTest(Map map) : super (map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw new ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class AriaPropMixinsTest extends MapView with 
    AriaPropsMixin,
    // ignore: mixin_of_non_class, undefined_class
    $AriaPropsMixin {
  AriaPropMixinsTest(Map map) : super (map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw new ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}
