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

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/over_react_builder_parsing.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/prop_declarations/props_set_by_factory.dart';
import 'package:test/test.dart';

import '../../../util/shared_analysis_context.dart';
import 'util.dart';

void main() {
  group('props_set_by_factory', () {
    final sharedContext = SharedAnalysisContext.overReact;

    setUpAll(sharedContext.warmUpAnalysis);

    group('getPropsSetByFactory', () {
      group(', using factory elements successfully returned by getFactoryElement,', () {
        /// Parses and resolves [source] and returns the expression that is returned from
        /// a function named `returnsUsageOfFactory`.
        ///
        /// There must be exactly one function with that name, and it can either be an arrow function
        /// or a block function with exactly one return statement with an explicit value.
        ///
        /// For example,
        /// ```dart
        /// await getExpressionToTest(r'''
        ///   returnsUsageOfFactory() => Foo()();
        /// ''');
        /// ```
        /// Returns the element referenced by `Foo`.
        Future<Element> getFactoryElementToTest(String source) async {
          final result = await resolveFileAndGeneratedPart(
              sharedContext,
              r'''
                // @dart=2.12
                  import 'package:over_react/over_react.dart';
                  part '{{PART_PATH}}';
                  
                  mixin TestProps on UiProps {
                    String? prop1;
                    String? prop2;
                    String? prop3;
                  }
                  UiFactory<TestProps> Test = castUiFactory(_$Test);
                ''' +
                  source);

          final testFunction = allDescendantsOfType<FunctionDeclaration>(result.unit)
              .singleWhere((e) => e.name.name == 'returnsUsageOfFactory');
          final returnValue = testFunction.functionExpression.body.returnExpressions.single;

          final componentUsage = getComponentUsageFromExpression(returnValue);
          if (componentUsage == null) {
            throw ArgumentError('returnsUsageOfFactory return value $returnValue'
                ' is not a component usage that can be identified by `getComponentUsageFromExpression`');
          }

          final factory = componentUsage.factory;
          if (factory == null) {
            throw ArgumentError('Usage in returnsUsageOfFactory ${componentUsage.node} does not have a factory');
          }

          final factoryElement = getFactoryElement(factory);
          if (factoryElement == null) {
            throw ArgumentError('factoryElement for factory $factory was null');
          }

          return factoryElement;
        }

        group('returns props set in factories defined in class', () {
          group('methods:', () {
            test('instance', () async {
              final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
                class SomeClass {
                  TestProps factoryInstanceMethod() => Test()..prop1 = '1'..prop2 = '2';
                }
                returnsUsageOfFactory() => SomeClass().factoryInstanceMethod()();
              ''');
              expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
            });

            test('static', () async {
              final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
                class SomeClass {
                  static TestProps factoryStaticMethod() => Test()..prop1 = '1'..prop2 = '2';
                }
                returnsUsageOfFactory() => SomeClass.factoryStaticMethod()();
              ''');
              expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
            });
          });

          group('fields:', () {
            test('instance', () async {
              final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
                class SomeClass {
                  BuilderOnlyUiFactory<TestProps> factoryInstanceVar = () => Test()..prop1 = '1'..prop2 = '2';
                }
                returnsUsageOfFactory() => SomeClass().factoryInstanceVar()();
              ''');
              expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
            });

            test('static', () async {
              final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
                class SomeClass {
                  static BuilderOnlyUiFactory<TestProps> factoryStaticVar = () => Test()..prop1 = '1'..prop2 = '2';
                }
                returnsUsageOfFactory() => SomeClass.factoryStaticVar()();
              ''');
              expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
            });
          });
        });

        group('returns props set in factories that are top-level function', () {
          test('declarations', () async {
            final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
              TestProps topLevelFunctionDeclaration() => Test()..prop1 = '1'..prop2 = '2';
              returnsUsageOfFactory() => topLevelFunctionDeclaration()();
            ''');
            expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
          });

          test('variables', () async {
            final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
              BuilderOnlyUiFactory<TestProps> topLevelFunctionVar = () => Test()..prop1 = '1'..prop2 = '2';
              returnsUsageOfFactory() => topLevelFunctionVar()();
            ''');
            expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
          });
        });

        group('returns props set in factories that are local function', () {
          test('declarations', () async {
            final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
              test() {
                TestProps localFunctionDeclaration() => Test()..prop1 = '1'..prop2 = '2';
                returnsUsageOfFactory() => localFunctionDeclaration()();
              }
            ''');
            expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
          });

          test('variables', () async {
            final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''
              test() {
                BuilderOnlyUiFactory<TestProps> localFunctionVar = () => Test()..prop1 = '1'..prop2 = '2';
                returnsUsageOfFactory() => localFunctionVar()();
              }
            ''');
            expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
          });
        });

        test('unwraps parentheses in return values', () async {
          final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''            
            TestProps testFactory() => ((Test()..prop1 = '1'..prop2 = '2'));
            returnsUsageOfFactory() => testFactory()();
          ''');
          expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'prop2']));
        });

        test('returns prefixed props with their prefix', () async {
          final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''            
            TestProps testFactory() => ((Test()..prop1 = '1'..aria.label = 'label'));
            returnsUsageOfFactory() => testFactory()();
          ''');
          expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1', 'aria.label']));
        });

        test('does not return non-assignment cascaded members', () async {
          final factoryElement = await getFactoryElementToTest(/*language=dart*/ r'''            
            TestProps testFactory() => Test()..prop1 = '1'..addProps({})..hashCode;
            returnsUsageOfFactory() => testFactory()();
          ''');
          expect(getPropsSetByFactory(factoryElement), unorderedEquals(<String>['prop1']));
        });
      });
    });
  });
}
