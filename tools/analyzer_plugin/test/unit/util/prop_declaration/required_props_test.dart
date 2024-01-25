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
        expect(PropRequiredness.none.isRequired, isFalse);
        expect(PropRequiredness.ignoredByConsumingClass.isRequired, isFalse);
        expect(PropRequiredness.late.isRequired, isTrue);
        expect(PropRequiredness.annotation.isRequired, isTrue);
      });

      test('maxRequiredness works as expected for all permutations', () {
        const late = PropRequiredness.late;
        const annotation = PropRequiredness.annotation;
        const ignoredByConsumingClass = PropRequiredness.ignoredByConsumingClass;
        const none = PropRequiredness.none;

        expect(maxRequiredness(late, late), late);
        expect(maxRequiredness(late, annotation), late);
        expect(maxRequiredness(late, ignoredByConsumingClass), late);
        expect(maxRequiredness(late, none), late);
        expect(maxRequiredness(late, null), late);

        expect(maxRequiredness(annotation, late), late);
        expect(maxRequiredness(annotation, annotation), annotation);
        expect(maxRequiredness(annotation, ignoredByConsumingClass), annotation);
        expect(maxRequiredness(annotation, none), annotation);
        expect(maxRequiredness(annotation, null), annotation);

        expect(maxRequiredness(ignoredByConsumingClass, late), late);
        expect(maxRequiredness(ignoredByConsumingClass, annotation), annotation);
        expect(maxRequiredness(ignoredByConsumingClass, ignoredByConsumingClass), ignoredByConsumingClass);
        expect(maxRequiredness(ignoredByConsumingClass, none), ignoredByConsumingClass);
        expect(maxRequiredness(ignoredByConsumingClass, null), ignoredByConsumingClass);

        expect(maxRequiredness(none, late), late);
        expect(maxRequiredness(none, annotation), annotation);
        expect(maxRequiredness(none, ignoredByConsumingClass), ignoredByConsumingClass);
        expect(maxRequiredness(none, none), none);
        expect(maxRequiredness(none, null), none);
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

      group('getIgnoredRequiredPropNames', () {
        test('returns the set of props specified in the @Props() annotation', () {
          final propsElement = getInterfaceElement(result, 'IgnoreRequiredPropsAnnotationTest_WithIgnoresProps');
          expect(getIgnoredRequiredPropNames(propsElement), unorderedEquals(<String>{'foo', 'bar'}));
        });

        test('returns null when @Props annotation does not have ignoreRequiredProps argument', () {
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
            // so this test case is slightly redundant with the extension test in the group below.
            test('concrete props class', () {
              final propsElement = getInterfaceElement(result, 'V4Props');
              verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
                'v4_lateRequiredProp': PropRequiredness.late,
                'v4_optionalProp': PropRequiredness.none,
                'v4_annotationRequiredProp': PropRequiredness.annotation,
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
        });
      });
    });
  });
}
