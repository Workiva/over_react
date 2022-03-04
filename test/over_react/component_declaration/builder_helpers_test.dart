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

// ignore_for_file: deprecated_member_use_from_same_package
library over_react.builder_generation.helpers_test;

import 'package:over_react/src/component_declaration/builder_helpers.dart';
import 'package:test/test.dart';

final Matcher throwsUngeneratedError          = throwsA(isA<UngeneratedError>());
final Matcher throwsIllegalInstantiationError = throwsA(isA<IllegalInstantiationError>());

main() {
  group('transformation generation helpers:', () {
    void testStubbedMapMembers(Map Function() mapFactory) {
      group('Map members:', () {
        Map map;

        setUp(() {
          map = mapFactory();
        });

        test('operator[]',    () {expect(() => map[null],                    throwsUngeneratedError);});
        test('operator[]=',   () {expect(() => map[null] = null,             throwsUngeneratedError);});
        test('addAll',        () {expect(() => map.addAll({}),               throwsUngeneratedError);});
        test('clear',         () {expect(() => map.clear(),                  throwsUngeneratedError);});
        test('containsKey',   () {expect(() => map.containsKey(null),        throwsUngeneratedError);});
        test('containsValue', () {expect(() => map.containsValue(null),      throwsUngeneratedError);});
        test('forEach',       () {expect(() => map.forEach((key, value) {}), throwsUngeneratedError);});

        test('isEmpty',       () {expect(() => map.isEmpty,                  throwsUngeneratedError);});
        test('isNotEmpty',    () {expect(() => map.isNotEmpty,               throwsUngeneratedError);});
        test('keys',          () {expect(() => map.keys,                     throwsUngeneratedError);});
        test('length',        () {expect(() => map.length,                   throwsUngeneratedError);});

        test('putIfAbsent',   () {expect(() => map.putIfAbsent(null, () {}), throwsUngeneratedError);});
        test('remove',        () {expect(() => map.remove(null),             throwsUngeneratedError);});
        test('values',        () {expect(() => map.values,                   throwsUngeneratedError);});
      });
    }

    group('UiProps', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => UngeneratedUiProps(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiProps unimplemented;

        setUp(() {
          unimplemented = UnimplementedUiProps();
        });

        test('props',            () {expect(() => unimplemented.props,            throwsUngeneratedError);});
        test('propKeyNamespace', () {expect(() => unimplemented.propKeyNamespace, throwsUngeneratedError);});
        test('a map method',     () {expect(() => unimplemented.keys,             throwsUngeneratedError);});
        test('staticMeta',      () {expect(() => unimplemented.staticMeta,       throwsUngeneratedError);});

        testStubbedMapMembers(() => UnimplementedUiProps());
      });
    });

    group('UiComponent', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => UngeneratedUiComponent(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiComponent unimplemented;

        setUp(() {
          unimplemented = UnimplementedUiComponent();
        });

        test('\$defaultConsumedProps', () {expect(() => unimplemented.$defaultConsumedProps, throwsUngeneratedError);});
        test('typedPropsFactory',      () {expect(() => unimplemented.typedPropsFactory({}), throwsUngeneratedError);});
      });
    });

    group('UiState', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => UngeneratedUiState(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiState unimplemented;

        setUp(() {
          unimplemented = UnimplementedUiState();
        });

        test('typedPropsFactory', () {expect(() => unimplemented.state, throwsUngeneratedError);});

        test('a map method',      () {expect(() => unimplemented.keys,  throwsUngeneratedError);});

        testStubbedMapMembers(() => UnimplementedUiState());
      });
    });

    group('UiStatefulComponent', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => UngeneratedUiStatefulComponent(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiStatefulComponent unimplemented;

        setUp(() {
          unimplemented = UnimplementedUiStatefulComponent();
        });

        test('\$defaultConsumedProps', () {expect(() => unimplemented.$defaultConsumedProps, throwsUngeneratedError);});
        test('typedPropsFactory',      () {expect(() => unimplemented.typedPropsFactory({}), throwsUngeneratedError);});
        test('typedStateFactory',      () {expect(() => unimplemented.typedStateFactory({}), throwsUngeneratedError);});
      });
    });

    group('consumedProps getter proxies \$defaultConsumedProps', () {
      test('in UiComponent', () {
        var component = TestConsumedPropKeysUiComponent();
        expect(component.consumedProps, equals([const ConsumedProps([], ['prop1', 'prop2'])]));
      });

      test('in UiStatefulComponent', () {
        var component = TestConsumedPropKeysUiStatefulComponent();
        expect(component.consumedProps, equals([const ConsumedProps([], ['prop1', 'prop2'])]));
      });
    });
  });
}


class UngeneratedUiProps extends UiProps {}

@Component()
class UngeneratedUiComponent extends UiComponent {
  @override
  render() {}
}

class UngeneratedUiState extends UiState {}

@Component()
class UngeneratedUiStatefulComponent extends UiStatefulComponent {
  @override
  render() {}
}


class UnimplementedUiProps extends UiProps {
  @override
  bool get $isClassGenerated => true;
}

@Component()
class UnimplementedUiComponent extends UiComponent {
  @override
  bool get $isClassGenerated => true;

  @override
  render() {}
}

class UnimplementedUiState extends UiState {
  @override
  bool get $isClassGenerated => true;
}

@Component()
class UnimplementedUiStatefulComponent extends UiStatefulComponent {
  @override
  bool get $isClassGenerated => true;

  @override
  render() {}
}

@Component()
class TestConsumedPropKeysUiComponent extends UiComponent {
  @override
  bool get $isClassGenerated => true;

  @override
  get $defaultConsumedProps => [const ConsumedProps([], ['prop1', 'prop2'])];

  @override
  render() {}
}

@Component()
class TestConsumedPropKeysUiStatefulComponent extends UiStatefulComponent {
  @override
  bool get $isClassGenerated => true;

  @override
  get $defaultConsumedProps => [const ConsumedProps([], ['prop1', 'prop2'])];

  @override
  render() {}
}
