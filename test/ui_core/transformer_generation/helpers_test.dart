library ui_core.transformer_generation.helpers_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

const Matcher throwsAnUngeneratedError = const Throws(const isInstanceOf<UngeneratedError>());
const Matcher throwsAnIllegalInstantiationError = const Throws(const isInstanceOf<IllegalInstantiationError>());

main() {
  group('transformation generation helpers:', () {
    void testStubbedMapMembers(Map mapFactory()) {
      group('Map members:', () {
        Map map;

        setUp(() {
          map = mapFactory();
        });

        test('operator[]',    () {expect(() => map[null],                    throwsAnUngeneratedError);});
        test('operator[]=',   () {expect(() => map[null] = null,             throwsAnUngeneratedError);});
        test('addAll',        () {expect(() => map.addAll({}),               throwsAnUngeneratedError);});
        test('clear',         () {expect(() => map.clear(),                  throwsAnUngeneratedError);});
        test('containsKey',   () {expect(() => map.containsKey(null),        throwsAnUngeneratedError);});
        test('containsValue', () {expect(() => map.containsValue(null),      throwsAnUngeneratedError);});
        test('forEach',       () {expect(() => map.forEach((key, value) {}), throwsAnUngeneratedError);});

        test('isEmpty',       () {expect(() => map.isEmpty,                  throwsAnUngeneratedError);});
        test('isNotEmpty',    () {expect(() => map.isNotEmpty,               throwsAnUngeneratedError);});
        test('keys',          () {expect(() => map.keys,                     throwsAnUngeneratedError);});
        test('length',        () {expect(() => map.length,                   throwsAnUngeneratedError);});

        test('putIfAbsent',   () {expect(() => map.putIfAbsent(null, () {}), throwsAnUngeneratedError);});
        test('remove',        () {expect(() => map.remove(null),             throwsAnUngeneratedError);});
        test('values',        () {expect(() => map.values,                   throwsAnUngeneratedError);});
      });
    }

    group('UiProps', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => new UngeneratedUiProps(), throwsAnIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiProps unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiProps();
        });

        test('props',            () {expect(() => unimplemented.props,            throwsAnUngeneratedError);});
        test('componentFactory', () {expect(() => unimplemented.componentFactory, throwsAnUngeneratedError);});
        test('propKeyNamespace', () {expect(() => unimplemented.propKeyNamespace, throwsAnUngeneratedError);});

        testStubbedMapMembers(() => new UnimplementedUiProps());
      });
    });

    group('UiComponent', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => new UngeneratedUiComponent(), throwsAnIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiComponent unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiComponent();
        });

        test('typedPropsFactory', () {expect(() => unimplemented.typedPropsFactory({}), throwsAnUngeneratedError);});
      });
    });

    group('UiState', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => new UngeneratedUiState(), throwsAnIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiState unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiState();
        });

        test('typedPropsFactory', () {expect(() => unimplemented.state, throwsAnUngeneratedError);});

        testStubbedMapMembers(() => new UnimplementedUiState());
      });
    });

    group('UiStatefulComponent', () {
      test('cannot be instantiated directly if not generated', () {
        expect(() => new UngeneratedUiStatefulComponent(), throwsAnIllegalInstantiationError);
      });

      group('throws errors when stubbed members are called that have not been generated:', () {
        UiStatefulComponent unimplemented;

        setUp(() {
          unimplemented = new UnimplementedUiStatefulComponent();
        });

        test('typedPropsFactory', () {expect(() => unimplemented.typedPropsFactory({}), throwsAnUngeneratedError);});
        test('typedStateFactory', () {expect(() => unimplemented.typedStateFactory({}), throwsAnUngeneratedError);});
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
        test('isEmpty', () {expect(() => stub.isEmpty,             throwsAnUngeneratedError);});
        test('forEach', () {expect(() => stub.forEach((value) {}), throwsAnUngeneratedError);});
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
  bool get $generated => true;
}

class UnimplementedUiComponent extends UiComponent {
  @override
  bool get $generated => true;

  render() {}
}

class UnimplementedUiState extends UiState {
  @override
  bool get $generated => true;
}

class UnimplementedUiStatefulComponent extends UiStatefulComponent {
  @override
  bool get $generated => true;

  render() {}
}
