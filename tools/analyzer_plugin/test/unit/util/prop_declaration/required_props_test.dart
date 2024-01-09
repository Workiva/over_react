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
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/required_props.dart';
import 'package:test/test.dart';

import '../../../util/shared_analysis_context.dart';
import 'shared.dart';

void main() {
  group('required props utilities', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('getAllRequiredProps', () {
      late ResolvedUnitResult result;

      setUpAll(() async {
        result = await setUpResult(sharedContext);
      });

      void verifyRequiredProps(RequiredPropInfo info, {required Map<String, PropRequiredness> expected}) {
        expect(info.propRequirednessByName, expected);

        final expectedRequiredPropNames = expected.entries.where((e) => e.value.isRequired).map((e) => e.key).toList();
        expect(info.requiredFieldsByName, {
          for (final name in expectedRequiredPropNames) name: isA<FieldElement>().havingName(name),
        });
        expect(info.requiredPropNames, unorderedEquals(expectedRequiredPropNames));
      }

      group('returns required props for', () {
        test('a v2 concrete props class', () {
          final propsElement = getInterfaceElement(result, 'V2Props');
          verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
            'v2_lateRequiredProp': PropRequiredness.late,
            'v2_optionalProp': PropRequiredness.none,
            'v2_annotationRequiredProp': PropRequiredness.annotation,
          });
        });

        test('a v3 concrete props class', () {
          final propsElement = getInterfaceElement(result, 'V3Props');
          verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
            'v3_lateRequiredProp': PropRequiredness.late,
            'v3_optionalProp': PropRequiredness.none,
            'v3_annotationRequiredProp': PropRequiredness.annotation,
          });
        });

        test('a v4 props mixin', () {
          final propsElement = getInterfaceElement(result, 'V4Props');
          verifyRequiredProps(getAllRequiredProps(propsElement), expected: {
            'v4_lateRequiredProp': PropRequiredness.late,
            'v4_optionalProp': PropRequiredness.none,
            'v4_annotationRequiredProp': PropRequiredness.annotation,
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
            });
          });

          test('a v4 props mixin', () {
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
      });

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
    });
  });
}
