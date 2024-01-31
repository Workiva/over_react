// Copyright 2024 Workiva Inc.
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

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/get_all_props.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/required_props.dart';
import 'package:test/test.dart';

import '../../../util/shared_analysis_context.dart';
import 'shared_util.dart';

void main() {
  group('required props utilities -', () {
    group('PropRequiredness enum', () {
      test('has correct isRequiredness for each value', () {
        // Instead of manually testing each value, use a switch statement,
        // which will statically enforce there are cases for each value,
        // ensuring that we aren't missing tests for any value.
        for (final value in PropRequiredness.values) {
          switch (value) {
            case PropRequiredness.late:
              expect(value.isRequired, isTrue);
              break;
            case PropRequiredness.annotation:
              expect(value.isRequired, isTrue);
              break;
            case PropRequiredness.ignoredViaDefault:
              expect(value.isRequired, isFalse);
              break;
            case PropRequiredness.ignoredByConsumingClass:
              expect(value.isRequired, isFalse);
              break;
            case PropRequiredness.none:
              expect(value.isRequired, isFalse);
              break;
          }
        }
      });

      group('maxRequiredness works as expected for all permutations', () {
        const expectedMostToLeastRequired = [
          PropRequiredness.late,
          PropRequiredness.annotation,
          PropRequiredness.ignoredViaDefault,
          PropRequiredness.ignoredByConsumingClass,
          PropRequiredness.none,
        ];

        setUpAll(() {
          expect(PropRequiredness.values.map(expectedMostToLeastRequired.indexOf), everyElement(isNot(-1)),
              reason: 'test setup check; all values should be present in expectedMostToLeastRequired');
        });

        test('(hard-coded test to ensure order isn\'t accidentally flipped', () {
          expect(maxRequiredness(PropRequiredness.late, PropRequiredness.none), PropRequiredness.late);
        });

        for (final value1 in PropRequiredness.values) {
          for (final value2 in PropRequiredness.values) {
            test('maxRequiredness(${value1.name}, ${value2.name})', () {
              final index1 = expectedMostToLeastRequired.indexOf(value1);
              final index2 = expectedMostToLeastRequired.indexOf(value2);
              // Separate expects so it's clear in failure stacks which case we're dealing with.
              if (index1 == index2) {
                expect(value1, value2, reason: 'test setup check; should be the same value');
                expect(maxRequiredness(value1, value2), value1,
                    reason: 'should return the same value passed in for both arguments');
              } else if (index1 < index2) {
                expect(maxRequiredness(value1, value2), value1,
                    reason: '$value1 comes before $value2 in expectedMostToLeastRequired');
              } else {
                expect(maxRequiredness(value1, value2), value2,
                    reason: '$value1 comes after $value2 in expectedMostToLeastRequired');
              }
            });
          }
        }
      });
    });

    group('resolved AST utilities -', () {
      final sharedContext = SharedAnalysisContext.overReact;

      late ResolvedUnitResult result;

      setUpAll(() async {
        await sharedContext.warmUpAnalysis();
        result = await setUpResult(sharedContext);
      });

      group('isRequiredPropValidationDisabled', () {
        FieldElement getPropField(String propsName, String propName) {
          final propsElement = getInterfaceElement(result, propsName);
          return getAllProps(propsElement).singleWhere((f) => f.name == propName);
        }

        group('returns true for prop fields annotated with @disableRequiredPropValidation', () {
          test('declared in a props class', () {
            final propField = getPropField('DisableRequiredPropValidationProps', 'lateRequiredWithValidationDisabled');
            expect(isRequiredPropValidationDisabled(propField), isTrue);
          });

          test('inherited from another props class', () {
            final propField =
                getPropField('ExtendsDisableRequiredPropValidationProps', 'lateRequiredWithValidationDisabled');
            expect(isRequiredPropValidationDisabled(propField), isTrue);
          });
        });

        test('returns false for props not annotated with @disableRequiredPropValidation', () {
          final propField = getPropField('DisableRequiredPropValidationProps', 'lateRequired');
          expect(isRequiredPropValidationDisabled(propField), isFalse);
        });
      });

      group('getDisableValidationForClassDefaultProps', () {
        group('returns the value set in the @Props() annotation', () {
          test('true', () {
            final propsElement = getInterfaceElement(result, 'GetDisableValidationForClassDefaultProps_TrueProps');
            expect(getDisableValidationForClassDefaultProps(propsElement), isTrue);
          });

          test('false', () {
            final propsElement = getInterfaceElement(result, 'GetDisableValidationForClassDefaultProps_FalseProps');
            expect(getDisableValidationForClassDefaultProps(propsElement), isFalse);
          });
        });

        group('returns the default value (true) when', () {
          test('the @Props annotation does not have disableValidationForClassDefaultProps argument', () {
            final propsElement =
                getInterfaceElement(result, 'GetDisableValidationForClassDefaultProps_UnspecifiedProps');
            expect(getDisableValidationForClassDefaultProps(propsElement), isTrue);
          });

          test('there is no @Props annotation present', () {
            final propsElement =
                getInterfaceElement(result, 'GetDisableValidationForClassDefaultProps_WithoutAnnotationProps');
            expect(getDisableValidationForClassDefaultProps(propsElement), isTrue);
          });
        });
      });

      group('getIgnoredRequiredPropNames', () {
        test('returns the set of props specified in the @Props() annotation', () {
          final propsElement = getInterfaceElement(result, 'IgnoreRequiredPropsAnnotationTest_WithIgnoresProps');
          expect(getIgnoredRequiredPropNames(propsElement), unorderedEquals(<String>{'foo', 'bar'}));
        });

        test('returns null when @Props annotation does not have disableRequiredPropValidation argument', () {
          final propsElement = getInterfaceElement(result, 'IgnoreRequiredPropsAnnotationTest_WithoutIgnoresProps');
          expect(getIgnoredRequiredPropNames(propsElement), isNull);
        });

        test('returns null when no @Props annotation is present', () {
          final propsElement = getInterfaceElement(result, 'IgnoreRequiredPropsAnnotationTest_WithoutAnnotationProps');
          expect(getIgnoredRequiredPropNames(propsElement), isNull);
        });
      });

      group('getAllRequiredProps', () {
        void verifyRequiredProps(RequiredPropInfo info, {required Map<String, PropRequiredness> expected}) {
          expect(info.propRequirednessByName, expected);

          final expectedRequiredPropNames =
              expected.entries.where((e) => e.value.isRequired).map((e) => e.key).toList();
          expect(info.requiredFieldsByName, {
            for (final name in expectedRequiredPropNames) name: isA<FieldElement>().havingName(name),
          });
          expect(info.requiredPropNames, unorderedEquals(expectedRequiredPropNames));
        }

        group('returns an empty list for UiProps', () {
          test('(the one from builder_helpers.dart)', () {
            final builderHelpersUiProps = getImportedInterfaceElement(result, 'UiProps');
            verifyRequiredProps(getAllRequiredProps(builderHelpersUiProps), expected: {});
          });

          test('(the one from component_base.dart)', () {
            final builderHelpersUiProps = getImportedInterfaceElement(result, 'UiProps');
            final componentBaseUiProps =
                builderHelpersUiProps.allSupertypes.map((type) => type.element).singleWhere((e) => e.name == 'UiProps');
            expect(componentBaseUiProps, isNot(builderHelpersUiProps), reason: 'test setup check');
            verifyRequiredProps(getAllRequiredProps(componentBaseUiProps), expected: {});
          });
        });

        test('returns an empty result for a type that is not a props class', () {
          final notAPropsClass = getInterfaceElement(result, 'NotAPropsClass');
          verifyRequiredProps(getAllRequiredProps(notAPropsClass), expected: {});
        });

        group('returns required props for', () {
          group('a v2 boilerplate', () {
            test('concrete props class', () {
              final propsElement = getInterfaceElement(result, 'V2Props');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v2_lateRequiredProp': PropRequiredness.late,
                'v2_optionalProp': PropRequiredness.none,
                'v2_annotationRequiredProp': PropRequiredness.annotation,
              });
            });

            test('props mixin', () {
              final propsElement = getInterfaceElement(result, 'V2PropsMixin');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v2_lateRequiredProp_inMixin': PropRequiredness.late,
                'v2_optionalProp_inMixin': PropRequiredness.none,
                'v2_annotationRequiredProp_inMixin': PropRequiredness.annotation,
              });
            });
          });

          group('a v3 boilerplate', () {
            test('concrete props class', () {
              final propsElement = getInterfaceElement(result, 'V3Props');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v3_lateRequiredProp': PropRequiredness.late,
                'v3_optionalProp': PropRequiredness.none,
                'v3_annotationRequiredProp': PropRequiredness.annotation,
              });
            });

            test('props mixin', () {
              final propsElement = getInterfaceElement(result, 'V3PropsMixin');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v3_lateRequiredProp_inMixin': PropRequiredness.late,
                'v3_optionalProp_inMixin': PropRequiredness.none,
                'v3_annotationRequiredProp_inMixin': PropRequiredness.annotation,
              });
            });
          });

          group('a v4 boilerplate', () {
            // These props technically come from the mixin (since in V4 props can only be declared in mixins),
            // so these test cases are slightly redundant with the extension test in the group below.
            //
            // However, there are things like `PropRequiredness.ignoredViaDefault` behavior we want to make sure
            // we test here.
            group('props element associated with a component:', () {
              test('concrete props class', () {
                final propsElement = getInterfaceElement(result, 'V4ConcreteProps');
                verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                  'v4_lateRequiredProp': PropRequiredness.late,
                  'v4_optionalProp': PropRequiredness.none,
                  'v4_annotationRequiredProp': PropRequiredness.annotation,
                });
              });

              test('props mixin (shorthand syntax)', () {
                final propsElement = getInterfaceElement(result, 'V4ShorthandProps');
                verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                  'v4_lateRequiredProp': PropRequiredness.late,
                  'v4_optionalProp': PropRequiredness.none,
                  'v4_annotationRequiredProp': PropRequiredness.annotation,
                });
              });
            });

            test('props mixin', () {
              final propsElement = getInterfaceElement(result, 'V4PropsMixin');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v4_lateRequiredProp': PropRequiredness.late,
                'v4_optionalProp': PropRequiredness.none,
                'v4_annotationRequiredProp': PropRequiredness.annotation,
              });
            });
          });

          test('DomProps', () {
            final propsElement = getImportedInterfaceElement(result, 'DomProps');
            final info = getAllRequiredProps(propsElement);
            expect(info.requiredPropNames, isEmpty);
            expect(info.propRequirednessByName, containsPair('disabled', PropRequiredness.none));
          });

          group('props classes that extend from other props classes, including props from supertypes', () {
            test('a v2 concrete props class', () {
              final propsElement = getInterfaceElement(result, 'ExtendsV2Props');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                // From extending type
                'v2_lateRequiredProp_inSubclass': PropRequiredness.late,
                'v2_optionalProp_inSubclass': PropRequiredness.none,
                // From supertype
                'v2_lateRequiredProp': PropRequiredness.late,
                'v2_optionalProp': PropRequiredness.none,
                'v2_annotationRequiredProp': PropRequiredness.annotation,
                // From mixin
                'v2_lateRequiredProp_inMixin': PropRequiredness.late,
                'v2_optionalProp_inMixin': PropRequiredness.none,
                'v2_annotationRequiredProp_inMixin': PropRequiredness.annotation,
              });
            });

            test('a v3 concrete props class', () {
              final propsElement = getInterfaceElement(result, 'ExtendsV3Props');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                // From extending type
                'v3_lateRequiredProp_inSubclass': PropRequiredness.late,
                'v3_optionalProp_inSubclass': PropRequiredness.none,
                // From supertype
                'v3_lateRequiredProp': PropRequiredness.late,
                'v3_optionalProp': PropRequiredness.none,
                'v3_annotationRequiredProp': PropRequiredness.annotation,
                // From mixin
                'v3_lateRequiredProp_inMixin': PropRequiredness.late,
                'v3_optionalProp_inMixin': PropRequiredness.none,
                'v3_annotationRequiredProp_inMixin': PropRequiredness.annotation,
              });
            });

            test('a v4 concrete props class', () {
              final propsElement = getInterfaceElement(result, 'ExtendsV4Props');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                // From extending type
                'v4_lateRequiredProp_inSubclass': PropRequiredness.late,
                'v4_optionalProp_inSubclass': PropRequiredness.none,
                // From supertype
                'v4_lateRequiredProp': PropRequiredness.late,
                'v4_optionalProp': PropRequiredness.none,
                'v4_annotationRequiredProp': PropRequiredness.annotation,
              });
            });
          });

          group('props classes where requiredness changes in overrides - uses greatest requiredness', () {
            setUpAll(() {
              // Verify our base class used by other tests
              final propsElement = getInterfaceElement(result, 'OverriddenTestBaseProps');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v4_lateRequiredProp_optionalInOtherType': PropRequiredness.late,
                'v4_lateRequiredProp_annotationRequiredInOtherType': PropRequiredness.late,
                'v4_annotationRequiredProp_optionalInOtherType': PropRequiredness.annotation,
                'v4_annotationRequiredProp_lateRequiredInOtherType': PropRequiredness.annotation,
                'v4_optionalProp_annotationRequiredInOtherType': PropRequiredness.none,
                'v4_optionalProp_lateRequiredInOtherType': PropRequiredness.none,
              });
            });

            test('when requiredness changes in overrides', () {
              final propsElement = getInterfaceElement(result, 'OverriddenTestSubtypeProps');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                // Requiredness from base class (OverriddenTestBaseProps) wins:
                'v4_lateRequiredProp_optionalInOtherType': PropRequiredness.late,
                'v4_lateRequiredProp_annotationRequiredInOtherType': PropRequiredness.late,
                'v4_annotationRequiredProp_optionalInOtherType': PropRequiredness.annotation,
                // Requiredness from subclass (OverriddenTestSubtypeProps) wins:
                'v4_annotationRequiredProp_lateRequiredInOtherType': PropRequiredness.late,
                'v4_optionalProp_annotationRequiredInOtherType': PropRequiredness.annotation,
                'v4_optionalProp_lateRequiredInOtherType': PropRequiredness.late,
              });
            });

            test('when requiredness changes in "overrides" from mixing in unrelated types', () {
              final propsElement = getInterfaceElement(result, 'OverriddenTestUnrelatedClassProps');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                // Requiredness from OverriddenTestBaseProps wins:
                'v4_lateRequiredProp_optionalInOtherType': PropRequiredness.late,
                'v4_lateRequiredProp_annotationRequiredInOtherType': PropRequiredness.late,
                'v4_annotationRequiredProp_optionalInOtherType': PropRequiredness.annotation,
                // Requiredness from OverriddenTestBaseProps wins:
                'v4_annotationRequiredProp_lateRequiredInOtherType': PropRequiredness.late,
                'v4_optionalProp_annotationRequiredInOtherType': PropRequiredness.annotation,
                'v4_optionalProp_lateRequiredInOtherType': PropRequiredness.late,
              });
            });
          });

          group('props classes where requiredness is ignored', () {
            setUpAll(() {
              // Verify without ignores present
              final propsElement = getInterfaceElement(result, 'Ignore2PropsMixin');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'lateRequired_1_ignored': PropRequiredness.late,
                'lateRequired_1_notIgnored': PropRequiredness.late,
                'optional_1_lateRequiredInOtherType_ignored': PropRequiredness.late,
                'optional_1_lateRequiredInOtherType_notIgnored': PropRequiredness.late,
                'lateRequired_1_optionalInOtherType_ignored': PropRequiredness.late,
                'lateRequired_1_optionalInOtherType_notIgnored': PropRequiredness.late,
                'lateRequired_2_ignored': PropRequiredness.late,
                'lateRequired_2_notIgnored': PropRequiredness.late,
              });
            });

            test('in concrete type', () {
              final propsElement = getInterfaceElement(result, 'IgnoreInConcreteClassProps');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'lateRequired_1_ignored': PropRequiredness.ignoredByConsumingClass,
                'lateRequired_1_notIgnored': PropRequiredness.late,
                'optional_1_lateRequiredInOtherType_ignored': PropRequiredness.ignoredByConsumingClass,
                'optional_1_lateRequiredInOtherType_notIgnored': PropRequiredness.late,
                'lateRequired_1_optionalInOtherType_ignored': PropRequiredness.ignoredByConsumingClass,
                'lateRequired_1_optionalInOtherType_notIgnored': PropRequiredness.late,
                'lateRequired_2_ignored': PropRequiredness.ignoredByConsumingClass,
                'lateRequired_2_notIgnored': PropRequiredness.late,
              });
            });
          });

          group('props classes with disabled validation via class default props in', () {
            test('UiComponent (not UiComponent2) component', () {
              final propsElement = getInterfaceElement(result, 'Component1WithDefaultsProps');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v3_lateRequiredProp': PropRequiredness.late,
                'v3_lateRequiredProp_defaulted': PropRequiredness.ignoredViaDefault,
              });
            });

            test('a v2 boilerplate UiComponent2', () {
              final propsElement = getInterfaceElement(result, 'V2WithDefaultsProps');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v2_lateRequiredProp': PropRequiredness.late,
                'v2_lateRequiredProp_defaulted': PropRequiredness.ignoredViaDefault,
              });
            });

            test('a v3 boilerplate UiComponent2', () {
              final propsElement = getInterfaceElement(result, 'V3WithDefaultsProps');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v3_lateRequiredProp': PropRequiredness.late,
                'v3_lateRequiredProp_defaulted': PropRequiredness.ignoredViaDefault,
              });

              group('a v4 boilerplate UiComponent2 declared with a', () {
                test('concrete props class', () {
                  final propsElement = getInterfaceElement(result, 'V4WithDefaultsConcreteProps');
                  verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                    'v4_lateRequiredProp': PropRequiredness.late,
                    'v4_lateRequiredProp_defaulted': PropRequiredness.ignoredViaDefault,
                  });
                });

                test('props mixin (shorthand syntax)', () {
                  final propsElement = getInterfaceElement(result, 'V4WithDefaultsShorthandProps');
                  verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                    'v4_lateRequiredProp': PropRequiredness.late,
                    'v4_lateRequiredProp_defaulted': PropRequiredness.ignoredViaDefault,
                  });
                });
              });
            });
          });
        });
      });
    });
  });
}
