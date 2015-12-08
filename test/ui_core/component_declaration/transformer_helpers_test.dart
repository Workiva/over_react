library ui_core.transformer_generation.helpers_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/component_declaration/transformer_helpers.dart';

const Matcher throwsUngeneratedError          = const Throws(const isInstanceOf<UngeneratedError>());
const Matcher throwsIllegalInstantiationError = const Throws(const isInstanceOf<IllegalInstantiationError>());

main() {
  group('transformation generation helpers:', () {
    void testStubbedMapMembers(Map mapFactory()) {
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
        expect(() => new UngeneratedUiProps(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiProps unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiProps();
        });

        test('props',            () {expect(() => unimplemented.props,            throwsUngeneratedError);});
        test('componentFactory', () {expect(() => unimplemented.componentFactory, throwsUngeneratedError);});
        test('propKeyNamespace', () {expect(() => unimplemented.propKeyNamespace, throwsUngeneratedError);});

        test('a map method',     () {expect(() => unimplemented.keys,             throwsUngeneratedError);});

        testStubbedMapMembers(() => new UnimplementedUiProps());
      });
    });

    group('UiComponent', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => new UngeneratedUiComponent(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiComponent unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiComponent();
        });

        test('\$defaultConsumedPropKeys', () {expect(() => unimplemented.$defaultConsumedPropKeys, throwsUngeneratedError);});
        test('typedPropsFactory',         () {expect(() => unimplemented.typedPropsFactory({}),    throwsUngeneratedError);});
      });
    });

    group('UiState', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => new UngeneratedUiState(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiState unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiState();
        });

        test('typedPropsFactory', () {expect(() => unimplemented.state, throwsUngeneratedError);});

        test('a map method',      () {expect(() => unimplemented.keys,  throwsUngeneratedError);});

        testStubbedMapMembers(() => new UnimplementedUiState());
      });
    });

    group('UiStatefulComponent', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => new UngeneratedUiStatefulComponent(), throwsIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiStatefulComponent unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiStatefulComponent();
        });

        test('\$defaultConsumedPropKeys', () {expect(() => unimplemented.$defaultConsumedPropKeys, throwsUngeneratedError);});
        test('typedPropsFactory',         () {expect(() => unimplemented.typedPropsFactory({}),    throwsUngeneratedError);});
        test('typedStateFactory',         () {expect(() => unimplemented.typedStateFactory({}),    throwsUngeneratedError);});
      });
    });

    group('consumedPropKeys getter proxies \$defaultConsumedPropKeys', () {
      test('in UiComponent', () {
        var component = new TestConsumedPropKeysUiComponent();
        expect(component.consumedPropKeys, equals([['prop1', 'prop2']]));
      });

      test('in UiStatefulComponent', () {
        var component = new TestConsumedPropKeysUiStatefulComponent();
        expect(component.consumedPropKeys, equals([['prop1', 'prop2']]));
      });
    });

    group('\$PropKeys (ungenerated)', () {
      setUpAll(() {
        expect(() => const $PropKeys(#dummySymbol), isNot(throwsNoSuchMethodError),
            reason: 'Instanitating a const \$PropKeys should not have thrown an error. '
                    'Ensure that the web_skin_dart transformer is NOT running for this test file.'
        );
      });

      $PropKeys stub;

      setUp(() {
         stub = const $PropKeys(#dummySymbol);
      });

      test('implements List', () {
        expect(stub, const isInstanceOf<List<String>>());
      });

      group('throws errors when List members are invoked:', () {
        test('isEmpty', () {expect(() => stub.isEmpty,             throwsUngeneratedError);});
        test('forEach', () {expect(() => stub.forEach((value) {}), throwsUngeneratedError);});
      });
    });
  });
}


class UngeneratedUiProps extends UiProps {}

class UngeneratedUiComponent extends UiComponent {
  render() {}
}

class UngeneratedUiState extends UiState {}

class UngeneratedUiStatefulComponent extends UiStatefulComponent {
  render() {}
}


class UnimplementedUiProps extends UiProps {
  @override
  bool get $isClassGenerated => true;
}

class UnimplementedUiComponent extends UiComponent {
  @override
  bool get $isClassGenerated => true;

  render() {}
}

class UnimplementedUiState extends UiState {
  @override
  bool get $isClassGenerated => true;
}

class UnimplementedUiStatefulComponent extends UiStatefulComponent {
  @override
  bool get $isClassGenerated => true;

  render() {}
}

class TestConsumedPropKeysUiComponent extends UiComponent {
  @override
  bool get $isClassGenerated => true;

  @override
  get $defaultConsumedPropKeys => [['prop1', 'prop2']];

  render() {}
}

class TestConsumedPropKeysUiStatefulComponent extends UiStatefulComponent {
  @override
  bool get $isClassGenerated => true;

  @override
  get $defaultConsumedPropKeys => [['prop1', 'prop2']];

  render() {}
}
