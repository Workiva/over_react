// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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

@TestOn('browser')
library prop_mixins_test;

import 'dart:collection' show MapView;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../test_util/prop_utils.dart';

main() {
  group('ReactProps', () {
    testInvalidKey((() => ReactPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          ReactPropMixinsTest({})
            ..ref = null
            ..key = null,
          {'ref': null, 'key': null});
    });

    group('prop: key can have its value set to', () {
      test('an int and be read as a String', () {
        var reactPropsMap = ReactPropMixinsTest({})
          ..key = 1;

        expect(reactPropsMap.key, equals('1'));
      });

      test('a String and be read as a String', () {
        var reactPropsMap = ReactPropMixinsTest({})
          ..key = '1';

        expect(reactPropsMap.key, equals('1'));
      });

      test('null and be read as a null', () {
        var reactPropsMap = ReactPropMixinsTest({})
          ..key = null;

        expect(reactPropsMap.key, isNull);
      });
    });
  });

  group('CssClassProps', () {
    testInvalidKey((() => CssClassPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(CssClassPropMixinsTest({})..className = null..classNameBlacklist = null, {'className': null, 'classNameBlacklist': null});
    });
  });

  group('DomPropsMixin', () {
    testInvalidKey((() => DomPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          DomPropMixinsTest({})
            ..style = null
            ..id = null,
          {'style': null, 'id': null});
    });
  });

  group('SvgPropsMixin', () {
    testInvalidKey((() => SvgPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          SvgPropMixinsTest({})
            ..clipPath = null
            ..cx= null,
          {'clipPath': null, 'cx': null});
    });
  });

  group('UbiquitousProps', () {
    testInvalidKey((() => UbiquitousPropMixinsTest({})));
    test('uses unnamespaced keys', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          UbiquitousPropMixinsTest({})
            ..tabIndex = null
            ..id = null,
          {'tabIndex': null, 'id': null});
    });

    group('has a getter that provides a typed view of', () {
      test('aria props', () {
        var instance = UbiquitousPropMixinsTest({})
          ..aria.labelledby = 'foo';

        expect(instance, equals(ariaProps()..labelledby = 'foo'), reason: 'should set the prop properly');
        expect(instance.aria.labelledby, 'foo', reason: 'should be able to read the prop in addition to setting it');
        expect(instance.aria, same(instance.aria), reason: 'should cache the backing typed MapView');
      });

      test('DOM props', () {
        var instance = UbiquitousPropMixinsTest({})
          ..dom.target = 'foo';

        expect(instance, equals(domProps()..target = 'foo'), reason: 'should set the prop properly');
        expect(instance.dom.target, 'foo', reason: 'should be able to read the prop in addition to setting it');
        expect(instance.dom, same(instance.dom), reason: 'should cache the backing typed MapView');
      });
    });
  });

  group('AriaProps', () {
    testInvalidKey(() => AriaPropMixinsTest({}));

    test('uses unnamespaced keys with \'aria-\' prefix', () {
      // Test two keys to reduce the possibility that the key we picked might have a custom @Accessor annotation on it
      expect(
          AriaPropMixinsTest({})
            ..activedescendant = null
            ..atomic = null,
          {'aria-activedescendant': null, 'aria-atomic': null});
    });
  });
}

class DomPropMixinsTest extends MapView with
    DomPropsMixin {
  /// Create a new instance backed by the specified map.
  DomPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class SvgPropMixinsTest extends MapView with
    SvgPropsMixin {
  /// Create a new instance backed by the specified map.
  SvgPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class ReactPropMixinsTest extends MapView with
    ReactPropsMixin {
  /// Create a new instance backed by the specified map.
  ReactPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class CssClassPropMixinsTest extends MapView with
    CssClassPropsMixin {
  /// Create a new instance backed by the specified map.
  CssClassPropMixinsTest(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class UbiquitousPropMixinsTest extends MapView with
    UbiquitousDomPropsMixin {
  UbiquitousPropMixinsTest(Map map) : super (map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}

class AriaPropMixinsTest extends MapView with
    AriaPropsMixin {
  AriaPropMixinsTest(Map map) : super (map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;

  @override
  operator [](key) {
    if (!this.containsKey(key)) {
      throw ArgumentError('Map does not contain this key: $key');
    }
    return super[key];
  }
}
