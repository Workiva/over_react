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
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/defaulted_props.dart';
import 'package:test/test.dart';

import '../../../util/shared_analysis_context.dart';
import 'shared_test_source.dart';
import 'util.dart';

void main() {
  group('defaulted_props', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('getDefaultedPropsForComponentWithPropsClass', () {
      late ResolvedUnitResult result;

      setUpAll(() async {
        result = await resolveFileAndGeneratedPart(sharedContext, sharedSourceTemplate);
      });

      group('returns defaulted props for the class component associated with a props element:', () {
        test('UiComponent (not UiComponent2) component', () {
          final propsElement = getInterfaceElement(result, 'Component1WithDefaultsProps');
          expect(getDefaultedPropsForComponentWithPropsClass(propsElement),
              unorderedEquals(<String>{'v3_lateRequiredProp_defaulted'}));
        });

        test('a v2 boilerplate UiComponent2', () {
          final propsElement = getInterfaceElement(result, 'V2WithDefaultsProps');
          expect(getDefaultedPropsForComponentWithPropsClass(propsElement),
              unorderedEquals(<String>{'v2_lateRequiredProp_defaulted'}));
        });

        group('a v4 boilerplate UiComponent2 declared with a', () {
          test('concrete props class', () {
            final propsElement = getInterfaceElement(result, 'V4ConcreteWithDefaultsProps');
            expect(getDefaultedPropsForComponentWithPropsClass(propsElement),
                unorderedEquals(<String>{'v4_lateRequiredProp_defaulted'}));
          });

          test('props mixin (shorthand syntax)', () {
            final propsElement = getInterfaceElement(result, 'V4ShorthandWithDefaultsProps');
            expect(getDefaultedPropsForComponentWithPropsClass(propsElement),
                unorderedEquals(<String>{'v4_lateRequiredProp_defaulted'}));
          });
        });

        group('class components without any defaults (returns empty set):', () {
          test('v2 boilerplate', () {
            final propsElement = getInterfaceElement(result, 'V2Props');
            expect(getDefaultedPropsForComponentWithPropsClass(propsElement), isEmpty);
          });

          group('v4 boilerplate declared with a', () {
            test('concrete props class', () {
              final propsElement = getInterfaceElement(result, 'V4ConcreteProps');
              expect(getDefaultedPropsForComponentWithPropsClass(propsElement), isEmpty);
            });

            test('props mixin (shorthand syntax)', () {
              final propsElement = getInterfaceElement(result, 'V4ShorthandProps');
              expect(getDefaultedPropsForComponentWithPropsClass(propsElement), isEmpty);
            });
          });
        });
      });

      group('returns null for', () {
        test('v3 boilerplate components, even if they have default props', () {
          final propsElement = getInterfaceElement(result, 'V3WithDefaultsProps');
          expect(getDefaultedPropsForComponentWithPropsClass(propsElement), isNull);
        });

        test('function components', () {
          final propsElement = getInterfaceElement(result, 'V4FunctionProps');
          expect(getDefaultedPropsForComponentWithPropsClass(propsElement), isNull);
        });

        test('props mixins not associated with a component', () {
          final propsElement = getInterfaceElement(result, 'V4PropsMixin');
          expect(getDefaultedPropsForComponentWithPropsClass(propsElement), isNull);
        });

        test('elements that are not props classes', () {
          final propsElement = getInterfaceElement(result, 'NotAPropsClass');
          expect(getDefaultedPropsForComponentWithPropsClass(propsElement), isNull);
        });
      });
    });
  });
}
