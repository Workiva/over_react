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

@TestOn('browser')
library over_react.test.null_safe_accessor_integration_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

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
        test('nullable dynamic with extraneous ? syntax', () {
          testPropWriteAndRead<dynamic>(
            readProp: (p) => p.nullableDynamicWithQuestion,
            writeProp: (p, value) => p.nullableDynamicWithQuestion = value,
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
        test('nullable dynamic with extraneous ? syntax', () {
          expectReadPropReturnsNull((props) => props.nullableDynamicWithQuestion);
        });
        test('nullable typedef, without ? syntax', () {
          expectReadPropReturnsNull((props) => props.nullableTypedefWithoutQuestion);
        });
      });
    });
  });
}

typedef NullableTypedef = Object?;
typedef NonNullableTypedef = Object;

UiFactory<NullSafeTestProps> NullSafeTest = uiFunction((props) {}, _$NullSafeTestConfig);

mixin NullSafeTestProps on UiProps {
  late String requiredNonNullable;
  late NonNullableTypedef requiredNonNullableTypedef;
  late String? requiredNullable;
  late NullableTypedef requiredNullableTypedefWithoutQuestion;
  late dynamic requiredDynamic;

  String? nullable;
  dynamic nullableDynamic;

  // ignore: unnecessary_question_mark
  dynamic? nullableDynamicWithQuestion;
  NullableTypedef nullableTypedefWithoutQuestion;
}

extension on TypeMatcher<Object> {
  Matcher havingToStringValue(dynamic matcher) =>
      having((o) => o.toString(), 'toString() value', matcher);
}
