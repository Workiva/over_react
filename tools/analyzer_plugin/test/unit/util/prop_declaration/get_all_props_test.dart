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

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/get_all_props.dart';
import 'package:test/test.dart';

import '../../../util/shared_analysis_context.dart';
import 'shared.dart';

void main() {
  group('get_all_props', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('getAllProps', () {
      late ResolvedUnitResult result;

      setUpAll(() async {
        result = await setUpResult(sharedContext);
      });

      group('returns only the expected props from', () {
        test('a v2 concrete props class', () {
          final propsElement = getInterfaceElement(result, 'V2Props');
          final allProps = getAllProps(propsElement);
          expect(
              allProps.map((e) => e.name).toList(),
              unorderedEquals(<String>[
                'v2_lateRequiredProp',
                'v2_optionalProp',
                'v2_annotationRequiredProp',
              ]));
          expect(allProps, everyElement(isA<FieldElement>().havingIsSynthetic(false)));
        });

        test('a v3 concrete props class', () {
          final propsElement = getInterfaceElement(result, 'V3Props');
          final allProps = getAllProps(propsElement);
          expect(
              allProps.map((e) => e.name).toList(),
              unorderedEquals(<String>[
                'v3_lateRequiredProp',
                'v3_optionalProp',
                'v3_annotationRequiredProp',
              ]));
          expect(allProps, everyElement(isA<FieldElement>().havingIsSynthetic(false)));
        });

        test('a v4 props mixin', () {
          final propsElement = getInterfaceElement(result, 'V4Props');
          final allProps = getAllProps(propsElement);
          expect(
              allProps.map((e) => e.name).toList(),
              unorderedEquals(<String>[
                'v4_lateRequiredProp',
                'v4_optionalProp',
                'v4_annotationRequiredProp',
              ]));
          expect(allProps, everyElement(isA<FieldElement>().havingIsSynthetic(false)));
        });

        test('DomProps', () {
          final propsElement = getImportedInterfaceElement(result, 'DomProps');
          final allProps = getAllProps(propsElement);
          expect(
              allProps.map((e) => e.name).toList(),
              allOf([
                contains('disabled'),
                // Also declared in UbiquitousDomPropsMixin
                contains('onClick'),
                contains('id'),
                // Also declared in ClassNamePropsMixin
                contains('className'),
              ]));
          expect(allProps, everyElement(isA<FieldElement>().havingIsSynthetic(false)));
        });

        group('props classes that extend from other props classes, including props from supertypes', () {
          test('a v2 concrete props class', () {
            final propsElement = getInterfaceElement(result, 'ExtendsV2Props');
            final allProps = getAllProps(propsElement);
            expect(
                allProps.map((e) => e.name).toList(),
                unorderedEquals(<String>[
                  // From extending type
                  'v2_lateRequiredProp_inSubclass',
                  'v2_optionalProp_inSubclass',
                  // From supertype
                  'v2_lateRequiredProp',
                  'v2_optionalProp',
                  'v2_annotationRequiredProp',
                ]));
            expect(allProps, everyElement(isA<FieldElement>().havingIsSynthetic(false)));
          });

          test('a v3 concrete props class', () {
            final propsElement = getInterfaceElement(result, 'ExtendsV3Props');
            final allProps = getAllProps(propsElement);
            expect(
                allProps.map((e) => e.name).toList(),
                unorderedEquals(<String>[
                  // From extending type
                  'v3_lateRequiredProp_inSubclass',
                  'v3_optionalProp_inSubclass',
                  // From supertype
                  'v3_lateRequiredProp',
                  'v3_optionalProp',
                  'v3_annotationRequiredProp',
                ]));
            expect(allProps, everyElement(isA<FieldElement>().havingIsSynthetic(false)));
          });

          test('a v4 props mixin', () {
            final propsElement = getInterfaceElement(result, 'ExtendsV4Props');
            final allProps = getAllProps(propsElement);
            expect(
                allProps.map((e) => e.name).toList(),
                unorderedEquals(<String>[
                  // From extending type
                  'v4_lateRequiredProp_inSubclass',
                  'v4_optionalProp_inSubclass',
                  // From supertype
                  'v4_lateRequiredProp',
                  'v4_optionalProp',
                  'v4_annotationRequiredProp',
                ]));
            expect(allProps, everyElement(isA<FieldElement>().havingIsSynthetic(false)));
          });
        });
      });

      group('returns an empty list for UiProps', () {
        test('(the one from builder_helpers.dart)', () {
          final builderHelpersUiProps = getImportedInterfaceElement(result, 'UiProps');
          expect(getAllProps(builderHelpersUiProps), isEmpty);
        });

        test('(the one from component_base.dart)', () {
          final builderHelpersUiProps = getImportedInterfaceElement(result, 'UiProps');
          final componentBaseUiProps =
              builderHelpersUiProps.allSupertypes.map((type) => type.element).singleWhere((e) => e.name == 'UiProps');
          expect(componentBaseUiProps, isNot(builderHelpersUiProps), reason: 'test setup check');
          expect(getAllProps(componentBaseUiProps), isEmpty);
        });
      });

      test('returns an empty list for a class that is not a props class', () {
        final notAPropsClass = getInterfaceElement(result, 'NotAPropsClass');
        expect(getAllProps(notAPropsClass), isEmpty);
      });
    });
  });
}
