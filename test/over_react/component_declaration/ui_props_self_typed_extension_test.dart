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
library over_react.component_declaration.ui_props_self_extension_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

part 'ui_props_self_typed_extension_test.over_react.g.dart';

main() {
  group('extensions in UiPropsSelfTypedExtension', () {
    group('getPropKey', () {
      group('returns the prop key', () {
        test('for optional props', () {
          final expectedPropKey = (Test()..optionalProp = '').keys.single;
          final props = Test();
          expect(props.getPropKey((p) => p.optionalProp), expectedPropKey);
        });

        // Test this explicitly to make sure it doesn't throw.
        test('for required props', () {
          final expectedPropKey = (Test()..requiredProp = '').keys.single;
          final props = Test();
          expect(props.getPropKey((p) => p.requiredProp), expectedPropKey);
        });

        test('for keys accessed directly', () {
          const testKey = 'data-test-key';
          final props = Test();
          expect(props.getPropKey((p) => p[testKey]), testKey);
        });
      });

      test('throws if no prop is read within the callback', () {
        final props = Test();
        expect(() => props.getPropKey((p) {}), throwsStateError);
      });
    });

    group('containsProp returns whether a prop is specified', () {
      void sharedTest<T>({
        required T Function(TestProps props) readProp,
        required void Function(TestProps props, T value) writeProp,
        required T testValue,
      }) {
        final unspecified = Test();
        expect(unspecified.containsProp(readProp), isFalse);

        final specified = Test();
        writeProp(specified, testValue);
        expect(specified.containsProp(readProp), isTrue);
      }

      group('for optional props', () {
        test('with non-null values', () {
          sharedTest<String?>(
            readProp: (p) => p.optionalProp,
            writeProp: (p, value) => p.optionalProp = value,
            testValue: 'test value',
          );
        });

        test('with null values', () {
          sharedTest<String?>(
            readProp: (p) => p.optionalProp,
            writeProp: (p, value) => p.optionalProp = value,
            testValue: null,
          );
        });
      });

      group('for required non-nullable props', () {
        test('with non-null values', () {
          sharedTest<String>(
            readProp: (p) => p.requiredProp,
            writeProp: (p, value) => p.requiredProp = value,
            testValue: 'test value',
          );
        });

        test('with null values (even though this should be possible when using typed setters)', () {
          readProp(TestProps p) => p.requiredProp;
          final propKey = Test().getPropKey(readProp);
          sharedTest<String?>(
            readProp: readProp,
            writeProp: (p, value) => p[propKey] = value,
            testValue: null,
          );
        });
      });

      group('for required nullable props', () {
        test('with non-null values', () {
          sharedTest<String?>(
            readProp: (p) => p.requiredNullableProp,
            writeProp: (p, value) => p.requiredNullableProp = value,
            testValue: 'test value',
          );
        });

        test('with null values', () {
          sharedTest<String?>(
            readProp: (p) => p.requiredNullableProp,
            writeProp: (p, value) => p.requiredNullableProp = value,
            testValue: null,
          );
        });
      });
    });

    group('getRequiredProp', () {
      group('returns a prop if it is specified', () {
        void sharedTest<T>({
          required T Function(TestProps props) readProp,
          required void Function(TestProps props, T value) writeProp,
          required T testValue,
        }) {
          final specified = Test();
          writeProp(specified, testValue);
          expect(
              specified.getRequiredProp(readProp,
                  orElse: () => fail('orElse should not be called for this test')),
              testValue);
        }

        group('for optional props', () {
          test('with non-null values', () {
            sharedTest<String?>(
              readProp: (p) => p.optionalProp,
              writeProp: (p, value) => p.optionalProp = value,
              testValue: 'test value',
            );
          });

          test('with null values', () {
            sharedTest<String?>(
              readProp: (p) => p.optionalProp,
              writeProp: (p, value) => p.optionalProp = value,
              testValue: null,
            );
          });
        });

        group('for required non-nullable props', () {
          test('with non-null values', () {
            sharedTest<String>(
              readProp: (p) => p.requiredProp,
              writeProp: (p, value) => p.requiredProp = value,
              testValue: 'test value',
            );
          });

          group('with null values (even though this should be possible when using typed setters),',
              () {
            void sharedThrowsTest({required bool expectHelpfulError}) {
              final errorMatcher = expectHelpfulError
                  ? isA<AssertionError>().havingToStringValue(
                      contains('Expected value to be non-nullable type `String`,'
                          ' but got `null` due to props map containing explicit `null` value'))
                  : isA<TypeError>();

              readProp(TestProps p) => p.requiredProp;
              final propKey = Test().getPropKey(readProp);
              final specified = Test();
              specified[propKey] = null;
              expect(() => specified.getRequiredProp(readProp, orElse: () => 'or else value'),
                  throwsA(errorMatcher));
            }

            test('throws a helpful error when asserts are enabled', () {
              sharedThrowsTest(expectHelpfulError: true);
            }, tags: 'ddc');

            test('throws', () {
              sharedThrowsTest(expectHelpfulError: false);
            }, tags: 'no-ddc');
          });
        });

        group('for required nullable props', () {
          test('with non-null values', () {
            sharedTest<String?>(
              readProp: (p) => p.requiredNullableProp,
              writeProp: (p, value) => p.requiredNullableProp = value,
              testValue: 'test value',
            );
          });

          test('with null values', () {
            sharedTest<String?>(
              readProp: (p) => p.requiredNullableProp,
              writeProp: (p, value) => p.requiredNullableProp = value,
              testValue: null,
            );
          });
        });
      });

      group('returns orElse otherwise', () {
        void sharedTest<T>({
          required T Function(TestProps props) readProp,
          required T orElseValue,
        }) {
          final notSpecified = Test();
          expect(notSpecified.getRequiredProp(readProp, orElse: () => orElseValue), orElseValue);
        }

        test('for optional props', () {
          sharedTest<String?>(
            readProp: (p) => p.optionalProp,
            orElseValue: 'or else value',
          );
        });

        test('for required non-nullable props', () {
          sharedTest<String>(
            readProp: (p) => p.requiredProp,
            orElseValue: 'or else value',
          );
        });

        test('for required nullable props', () {
          sharedTest<String?>(
            readProp: (p) => p.requiredNullableProp,
            orElseValue: 'or else value',
          );
        });
      });
    });
  });
}

UiFactory<TestProps> Test = castUiFactory(_$Test);

mixin TestProps on UiProps {
  late String requiredProp;
  late String? requiredNullableProp;
  String? optionalProp;
}

extension on TypeMatcher<Object> {
  Matcher havingToStringValue(dynamic matcher) =>
      having((o) => o.toString(), 'toString() value', matcher);
}
