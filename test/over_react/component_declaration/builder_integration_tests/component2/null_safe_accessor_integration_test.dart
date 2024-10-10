// Copyright 2023 Workiva Inc.
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

// ignore_for_file: unnecessary_question_mark
@TestOn('browser')
library over_react.test.component2.null_safe_accessor_integration_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';
import 'package:react_testing_library/react_testing_library.dart' as rtl;

part 'null_safe_accessor_integration_test.over_react.g.dart';

void main() {
  group('null-safe props:', () {
    group('properly reads and writes specified props of different nullabilities and requiredness:',
        () {
      void testPropWriteAndRead<T>({
        required T Function(NullSafeTestProps props) readProp,
        required void Function(NullSafeTestProps props, T value) writeProp,
        required T testValue,
      }) {
        final props = NullSafeTest();

        expect(() => writeProp(props, testValue), returnsNormally,
            reason: 'should assign the prop without error');
        expect(props, {props.getPropKey(readProp): testValue},
            reason: 'assigning the prop should write to the map');

        late final T readResult;
        expect(() => readResult = readProp(props), returnsNormally,
            reason: 'should read the prop without error');
        expect(readResult, testValue, reason: 'should read the test value from the map');
      }

      group('required late', () {
        test('non-nullable', () {
          testPropWriteAndRead<String>(
            readProp: (p) => p.requiredNonNullable,
            writeProp: (p, value) => p.requiredNonNullable = value,
            testValue: 'test value',
          );
        });
        test('non-nullable typedef', () {
          testPropWriteAndRead<NonNullableTypedef>(
            readProp: (p) => p.requiredNonNullableTypedef,
            writeProp: (p, value) => p.requiredNonNullableTypedef = value,
            testValue: 'test value',
          );
        });
        test('nullable', () {
          testPropWriteAndRead<String?>(
            readProp: (p) => p.requiredNullable,
            writeProp: (p, value) => p.requiredNullable = value,
            testValue: 'test value',
          );
        });
        test('nullable typedef, without ? syntax', () {
          testPropWriteAndRead<NullableTypedef>(
            readProp: (p) => p.requiredNullableTypedefWithoutQuestion,
            writeProp: (p, value) => p.requiredNullableTypedefWithoutQuestion = value,
            testValue: 'test value',
          );
        });
        test('dynamic', () {
          testPropWriteAndRead<NullableTypedef>(
            readProp: (p) => p.requiredDynamic,
            writeProp: (p, value) => p.requiredDynamic = value,
            testValue: 'test value',
          );
        });
      });

      group('optional', () {
        test('nullable', () {
          testPropWriteAndRead<String?>(
            readProp: (p) => p.nullable,
            writeProp: (p, value) => p.nullable = value,
            testValue: 'test value',
          );
        });
        test('nullable dynamic', () {
          testPropWriteAndRead<dynamic>(
            readProp: (p) => p.nullableDynamic,
            writeProp: (p, value) => p.nullableDynamic = value,
            testValue: 'test value',
          );
        });
        test('nullable typedef, without ? syntax', () {
          testPropWriteAndRead<NullableTypedef>(
            readProp: (p) => p.nullableTypedefWithoutQuestion,
            writeProp: (p, value) => p.nullableTypedefWithoutQuestion = value,
            testValue: 'test value',
          );
        });
      });
    });

    group('results in expected behavior when reading props that are not specified:', () {
      void expectReadPropThrows<T extends Object>(T Function(NullSafeTestProps props) readProp) {
        // We probably don't need to be this specific, but it is nice to verify that
        // we're getting a null error and not some other unexpected error.
        //
        // Since this error message is implemented by the Dart SDK, is different in different compilers,
        // (DDC: Expected a value of type '$T', but got one of type 'Null')
        // (dart2js: type 'JSNull' is not a subtype of type '$T')
        // and may change across SDK versions, let's simulate the expected error instead of hard-coding it.
        late String expectedErrorMessage;
        try {
          (null as dynamic) as T;
        } catch (e) {
          expectedErrorMessage = e.toString();
        }
        expect(expectedErrorMessage, contains('Null'), reason: 'test setup check');

        final props = NullSafeTest();
        expect(() => readProp(props),
            throwsA(isA<TypeError>().havingToStringValue(expectedErrorMessage)));
      }

      void expectReadPropReturnsNull<T>(T Function(NullSafeTestProps props) readProp) {
        final props = NullSafeTest();
        expect(() => readProp(props), returnsNormally);
        expect(readProp(props), isNull);
      }

      group('required props:', () {
        group('throws when reading non-nullable props:', () {
          test('non-nullable', () {
            expectReadPropThrows((props) => props.requiredNonNullable);
          });
          test('non-nullable typedef', () {
            expectReadPropThrows((props) => props.requiredNonNullableTypedef);
          });
        });

        group('does not throw and just returns null when reading nullable props:', () {
          test('nullable', () {
            expectReadPropReturnsNull((props) => props.requiredNullable);
          });
          test('nullable typedef, without ? syntax', () {
            expectReadPropReturnsNull((props) => props.requiredNullableTypedefWithoutQuestion);
          });
          test('dynamic', () {
            expectReadPropReturnsNull((props) => props.requiredDynamic);
          });
        });
      });

      group('optional props: returns null:', () {
        test('nullable', () {
          expectReadPropReturnsNull((props) => props.nullable);
        });
        test('nullable dynamic', () {
          expectReadPropReturnsNull((props) => props.nullableDynamic);
        });
        test('nullable typedef, without ? syntax', () {
          expectReadPropReturnsNull((props) => props.nullableTypedefWithoutQuestion);
        });
      });
    });

    test('late props work with @Accessor annotation', () {
      final props = NullSafeTest()..requiredWithAccessorAndCustomKey = 'test value';
      expect(props, {'NullSafeTestProps.customKey': 'test value'});
    });

    test('late props are considered required in props metadata', () {
      final props = NullSafeTest();
      expect(
          NullSafeTestProps.meta.fields.where((f) => f.isRequired).map((f) => f.key).toList(),
          unorderedEquals([
            props.getPropKey((p) => p.requiredNonNullable),
            props.getPropKey((p) => p.requiredNonNullableTypedef),
            props.getPropKey((p) => p.requiredNullable),
            props.getPropKey((p) => p.requiredNullableTypedefWithoutQuestion),
            props.getPropKey((p) => p.requiredDynamic),
            props.getPropKey((p) => p.requiredWithAccessorAndCustomKey),
          ]));
    });
  });

  group('null-safe state:', () {
    late NullSafeTestState Function(Map map) typedStateFactory;

    setUpAll(() {
      final ref = createRef<NullSafeTestComponent>();
      rtl.render((NullSafeTest()
        ..ref = ref
        ..requiredNonNullable = ''
        ..requiredNonNullableTypedef = ''
        ..requiredNullable = ''
        ..requiredNullableTypedefWithoutQuestion = ''
        ..requiredDynamic = ''
        ..requiredWithAccessorAndCustomKey = ''
      )());
      typedStateFactory = ref.current!.typedStateFactory;
    });

    group('properly reads and writes specified state of different nullabilities and requiredness:',
        () {
      void testStateWriteAndRead<T>({
        required T Function(NullSafeTestState state) readState,
        required void Function(NullSafeTestState state, T value) writeState,
        required T testValue,
      }) {
        final state = typedStateFactory({});

        expect(() => writeState(state, testValue), returnsNormally,
            reason: 'should assign the state without error');
        final stateKey = getPropKey(readState, typedStateFactory);
        expect(state, {stateKey: testValue}, reason: 'assigning the state should write to the map');

        late final T readResult;
        expect(() => readResult = readState(state), returnsNormally,
            reason: 'should read the state without error');
        expect(readResult, testValue, reason: 'should read the test value from the map');
      }

      group('required late', () {
        test('non-nullable', () {
          testStateWriteAndRead<String>(
            readState: (p) => p.requiredNonNullable,
            writeState: (p, value) => p.requiredNonNullable = value,
            testValue: 'test value',
          );
        });
        test('non-nullable typedef', () {
          testStateWriteAndRead<NonNullableTypedef>(
            readState: (p) => p.requiredNonNullableTypedef,
            writeState: (p, value) => p.requiredNonNullableTypedef = value,
            testValue: 'test value',
          );
        });
        test('nullable', () {
          testStateWriteAndRead<String?>(
            readState: (p) => p.requiredNullable,
            writeState: (p, value) => p.requiredNullable = value,
            testValue: 'test value',
          );
        });
        test('nullable typedef, without ? syntax', () {
          testStateWriteAndRead<NullableTypedef>(
            readState: (p) => p.requiredNullableTypedefWithoutQuestion,
            writeState: (p, value) => p.requiredNullableTypedefWithoutQuestion = value,
            testValue: 'test value',
          );
        });
        test('dynamic', () {
          testStateWriteAndRead<NullableTypedef>(
            readState: (p) => p.requiredDynamic,
            writeState: (p, value) => p.requiredDynamic = value,
            testValue: 'test value',
          );
        });
      });

      group('optional', () {
        test('nullable', () {
          testStateWriteAndRead<String?>(
            readState: (p) => p.nullable,
            writeState: (p, value) => p.nullable = value,
            testValue: 'test value',
          );
        });
        test('nullable dynamic', () {
          testStateWriteAndRead<dynamic>(
            readState: (p) => p.nullableDynamic,
            writeState: (p, value) => p.nullableDynamic = value,
            testValue: 'test value',
          );
        });
        test('nullable typedef, without ? syntax', () {
          testStateWriteAndRead<NullableTypedef>(
            readState: (p) => p.nullableTypedefWithoutQuestion,
            writeState: (p, value) => p.nullableTypedefWithoutQuestion = value,
            testValue: 'test value',
          );
        });
      });
    });

    group('results in expected behavior when reading state that are not specified:', () {
      void expectReadStateThrows<T extends Object>(T Function(NullSafeTestState state) readState) {
        // We probably don't need to be this specific, but it is nice to verify that
        // we're getting a null error and not some other unexpected error.
        //
        // Since this error message is implemented by the Dart SDK, is different in different compilers,
        // (DDC: Expected a value of type '$T', but got one of type 'Null')
        // (dart2js: type 'JSNull' is not a subtype of type '$T')
        // and may change across SDK versions, let's simulate the expected error instead of hard-coding it.
        late String expectedErrorMessage;
        try {
          (null as dynamic) as T;
        } catch (e) {
          expectedErrorMessage = e.toString();
        }
        expect(expectedErrorMessage, contains('Null'), reason: 'test setup check');

        final state = typedStateFactory({});
        expect(() => readState(state),
            throwsA(isA<TypeError>().havingToStringValue(expectedErrorMessage)));
      }

      void expectReadStateReturnsNull<T>(T Function(NullSafeTestState state) readState) {
        final state = typedStateFactory({});
        expect(() => readState(state), returnsNormally);
        expect(readState(state), isNull);
      }

      group('required state:', () {
        group('throws when reading non-nullable state:', () {
          test('non-nullable', () {
            expectReadStateThrows((state) => state.requiredNonNullable);
          });
          test('non-nullable typedef', () {
            expectReadStateThrows((state) => state.requiredNonNullableTypedef);
          });
        });

        group('does not throw and just returns null when reading nullable state:', () {
          test('nullable', () {
            expectReadStateReturnsNull((state) => state.requiredNullable);
          });
          test('nullable typedef, without ? syntax', () {
            expectReadStateReturnsNull((state) => state.requiredNullableTypedefWithoutQuestion);
          });
          test('dynamic', () {
            expectReadStateReturnsNull((state) => state.requiredDynamic);
          });
        });
      });

      group('optional state: returns null:', () {
        test('nullable', () {
          expectReadStateReturnsNull((state) => state.nullable);
        });
        test('nullable dynamic', () {
          expectReadStateReturnsNull((state) => state.nullableDynamic);
        });
        test('nullable typedef, without ? syntax', () {
          expectReadStateReturnsNull((state) => state.nullableTypedefWithoutQuestion);
        });
      });
    });
  });
}

typedef NullableTypedef = Object?;
typedef NonNullableTypedef = Object;

@Factory()
UiFactory<NullSafeTestProps> NullSafeTest =
    _$NullSafeTest; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$NullSafeTestProps extends UiProps {
  late String requiredNonNullable;
  late NonNullableTypedef requiredNonNullableTypedef;
  late String? requiredNullable;
  late NullableTypedef requiredNullableTypedefWithoutQuestion;
  late dynamic requiredDynamic;
  @Accessor(key: 'customKey')
  late String requiredWithAccessorAndCustomKey;

  String? nullable;
  dynamic nullableDynamic;

  NullableTypedef nullableTypedefWithoutQuestion;
}

@State()
class _$NullSafeTestState extends UiState {
  late String requiredNonNullable;
  late NonNullableTypedef requiredNonNullableTypedef;
  late String? requiredNullable;
  late NullableTypedef requiredNullableTypedefWithoutQuestion;
  late dynamic requiredDynamic;

  String? nullable;
  dynamic nullableDynamic;

  NullableTypedef nullableTypedefWithoutQuestion;
}

@Component2()
class NullSafeTestComponent extends UiStatefulComponent2<NullSafeTestProps, NullSafeTestState> {
  @override
  render() => null;
}

extension on TypeMatcher<Object> {
  Matcher havingToStringValue(dynamic matcher) =>
      having((o) => o.toString(), 'toString() value', matcher);
}
