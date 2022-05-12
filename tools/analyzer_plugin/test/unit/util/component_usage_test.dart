// Copyright 2021 Workiva Inc.
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

import 'dart:collection';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:test/test.dart';

import '../../test_util.dart';

void main() {
  group('component_usage', () {
    group('getComponentUsage', () {
      void sharedTests({required bool isResolved}) {
        group(
            'accurately detects and collects information on usages of OverReact components:',
            () {
          group('components with no cascades:', () {
            buildersToTest.forEach((name, builderSource) {
              test('$name', () async {
                final source = '${builderSource.source}()';

                final expressionNode = await parseInvocation(source,
                    imports: builderSource.imports, isResolved: isResolved);
                final componentUsage = getComponentUsage(expressionNode);

                checkComponentUsage(componentUsage, builderSource, source);
              });
            });
          });

          group('components with cascades:', () {
            buildersToTest.forEach((name, builderSource) {
              test('$name', () async {
                var cascadeSource = '${builderSource.source}..id = \'123\'';
                var source = '($cascadeSource)()';

                var expressionNode = await parseInvocation(source,
                    imports: builderSource.imports, isResolved: isResolved);
                var componentUsage = getComponentUsage(expressionNode);

                checkComponentUsage(
                    componentUsage, builderSource, source, cascadeSource);
              });
            });
          });

          group('components with no cascade but extra parens:', () {
            buildersToTest.forEach((name, builderSource) {
              test('$name', () async {
                var source = '(${builderSource.source})()';

                var expressionNode = await parseInvocation(source,
                    imports: builderSource.imports, isResolved: isResolved);
                var componentUsage = getComponentUsage(expressionNode);

                checkComponentUsage(componentUsage, builderSource, source);
              });
            });
          });

          // The not-resolved test case for this test is slightly redundant with
          // some of the cases in the next group, but the resolved case is important here.
          test('when containing a blocked method name (unless unresolved)',
              () async {
            const testCase = BuilderTestCase(
              source: 'toBuilder()',
              imports: fooComponents,
              componentName: 'Foo',
              unresolvedComponentName: 'toBuilder',
              factoryName: 'toBuilder',
              propsName: 'FooProps',
              isDom: false,
              isSvg: false,
            );
            final source = '(${testCase.source})()';

            final expressionNode = await parseInvocation(source,
                imports: testCase.imports, isResolved: isResolved);
            final componentUsage = getComponentUsage(expressionNode);

            if (isResolved) {
              checkComponentUsage(componentUsage, testCase, source);
            } else {
              expect(componentUsage, isNull,
                  reason:
                      'should not be detected as a usage when not resolved');
            }
          });
        });

        group(
            'returns null for invocations that are not fluent interface usages:',
            () {
          const {
            'Dom.h1()': 'not full invocation',
            'Foo()': 'not full invocation',
            'fooFactory()': 'not full invocation',
            'foo()': 'not a valid builder',
            'foo.bar()': 'not a valid builder',
            'foo().bar()': 'not a valid builder',
            'foo.bar.baz()': 'not a valid builder',
            'foo()()': 'not a valid builder',
            '_foo()()': 'not a valid builder',
            'toBuilder()': 'blocked method name',
            'toBuilder()()': 'blocked method name',
            'foo.toBuilder()': 'blocked method name',
            'foo().toBuilder()': 'blocked method name',
            'foo.bar.toBuilder()': 'blocked method name',
          }.forEach((source, reason) {
            test('`$source`', () async {
              final expressionNode =
                  await parseInvocation(source, isResolved: isResolved);
              var componentUsage = getComponentUsage(expressionNode);
              expect(componentUsage, isNull, reason: '$source is $reason');
            });
          });
        });
      }

      group('when the AST is resolved', () {
        sharedTests(isResolved: true);
      });

      group('when the AST is not resolved', () {
        sharedTests(isResolved: false);
      });
    });

    group('hasChildComponent', () {
      group('detects components within an argument list', () {
        group('when there is a single child that is a component', () {
          buildersToTest.forEach((name, builderSource) {
            test('and the child component uses a $name', () async {
              var childSource = '${builderSource.source}()';
              var source = 'SomeOtherComponent()($childSource)';

              final expressionNode = await parseInvocation(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });

        group('when there are multiple children, and only one is a component',
            () {
          buildersToTest.forEach((name, builderSource) {
            test('and the child component uses a $name', () async {
              var childSource = '${builderSource.source}()';
              var source =
                  'SomeOtherComponent()("other child 1", $childSource, "other child 2")';

              final expressionNode = await parseInvocation(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });
      });

      group('even when the components have any number of extra wrapping parens',
          () {
        buildersToTest.forEach((name, builderSource) {
          test('and the child component uses a $name', () async {
            var childSource = '${builderSource.source}()';
            var childSourceWithExtraParens = '((($childSource)))';
            var source = 'SomeOtherComponent()($childSourceWithExtraParens)';

            final expressionNode = await parseInvocation(source);

            expect(hasChildComponent(expressionNode.argumentList), isTrue);
          });
        });
      });

      test('returns false when there are only non-component arguments',
          () async {
        var source = 'SomeOtherComponent()(1, "non-component child", {})';
        final expressionNode = await parseInvocation(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });

      test(
          'returns false when there are nested components, but no top-level ones',
          () async {
        var source = 'SomeOtherComponent()([Foo()()])';
        final expressionNode = await parseInvocation(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });
    });

    group('identifyUsage', () {
      group('returns correct usage when', () {
        buildersToTest.forEach((name, builderSource) {
          group('', () {
            final cascadeSource = '${builderSource.source}..id = \'123\'';
            final source = '($cascadeSource)(\'stringChild\')';
            late InvocationExpression expressionNode;

            setUpAll(() async {
              expressionNode = await parseInvocation(source,
                  imports: builderSource.imports, isResolved: true);
            });

            test('node is a $name which is already a component usage', () {
              final componentUsage = identifyUsage(expressionNode);
              checkComponentUsage(
                  componentUsage, builderSource, source, cascadeSource);
            });

            group('node inside $name', () {
              test('is props cascade expression', () {
                final cascadeExpression = getComponentUsage(expressionNode)
                    ?.cascadeExpression
                    ?.cascadeSections
                    .firstOrNull;
                expect(cascadeExpression?.toSource(), '..id = \'123\'');
                final componentUsage = identifyUsage(cascadeExpression);
                checkComponentUsage(
                    componentUsage, builderSource, source, cascadeSource);
              });

              test('is a child should return null', () {
                final child = expressionNode.argumentList.arguments.firstOrNull;
                expect(child?.toSource(), '\'stringChild\'');
                final componentUsage = identifyUsage(child);
                expect(componentUsage, isNull);
              });
            });
          });

          group('a $name is a child of another component', () {
            final cascadeSource = '${builderSource.source}..id = \'123\'';
            final childSource = '($cascadeSource)(\'stringChild\')';
            final nestedSource = 'Bar()($childSource)';
            late InvocationExpression expressionNode;
            late InvocationExpression childExpression;

            setUpAll(() async {
              expressionNode = await parseInvocation(
                nestedSource,
                imports: builderSource.imports,
                isResolved: true,
              );

              expect(
                  expressionNode.argumentList.arguments.firstOrNull, isNotNull);
              expect(expressionNode.argumentList.arguments.firstOrNull,
                  isA<InvocationExpression>());
              childExpression = expressionNode
                  .argumentList.arguments.firstOrNull as InvocationExpression;
              expect(childExpression.toSource(), childSource);
            });

            test('and node is the parent component', () {
              final componentUsage = identifyUsage(expressionNode);
              checkComponentUsage(
                  componentUsage,
                  BuilderTestCase(
                    source: 'Bar()',
                    imports: '',
                    componentName: 'Bar',
                    unresolvedComponentName: 'Bar',
                    factoryName: 'Bar',
                    propsName: 'BarProps',
                    isDom: false,
                    isSvg: false,
                  ),
                  nestedSource);
            });

            test('and node is the child component', () {
              final componentUsage = identifyUsage(childExpression);
              checkComponentUsage(
                  componentUsage, builderSource, childSource, cascadeSource);
            });

            group('and the node inside the child component', () {
              test('is props cascade expression', () {
                final cascadeExpression = getComponentUsage(childExpression)
                    ?.cascadeExpression
                    ?.cascadeSections
                    .firstOrNull;
                expect(cascadeExpression?.toSource(), '..id = \'123\'');
                final componentUsage = identifyUsage(cascadeExpression);
                checkComponentUsage(
                    componentUsage, builderSource, childSource, cascadeSource);
              });

              test('is a child should return null', () {
                final child =
                    childExpression.argumentList.arguments.firstOrNull;
                expect(child?.toSource(), '\'stringChild\'');
                final componentUsage = identifyUsage(child);
                expect(componentUsage, isNull);
              });
            });
          });
        });
      });

      group('returns null when node has no parent component usage', () {
        {
          const source = /*language=dart*/ r'''
            class Foo {
              void foo() {
                var a = 'abc';
              }
            }
          ''';

          test('and node is a class declaration', () {
            final classDecl = parseAndGetNode<ClassDeclaration>(source);
            final componentUsage = identifyUsage(classDecl);
            expect(componentUsage, isNull);
          });

          test('and node is a method declaration', () {
            final methodDecl = parseAndGetNode<MethodDeclaration>(source);
            final componentUsage = identifyUsage(methodDecl);
            expect(componentUsage, isNull);
          });

          test('and node is a variable declaration', () {
            final variableDecl = parseAndGetNode<VariableDeclaration>(source);
            final componentUsage = identifyUsage(variableDecl);
            expect(componentUsage, isNull);
          });
        }

        test('and node is an invocation expression', () async {
          final expressionNode =
              await parseInvocation('Foo.foo(() => \'abc\')');
          final componentUsage = identifyUsage(expressionNode);
          expect(componentUsage, isNull);
        });

        test('and node is an argument of an invocation expression', () async {
          final expressionNode =
              await parseInvocation('Foo.foo(() => \'abc\')');
          final arg = expressionNode.argumentList.arguments.firstOrNull;
          expect(arg, isNotNull);
          final componentUsage = identifyUsage(arg);
          expect(componentUsage, isNull);
        });
      });
    });

    group('FluentComponentUsage', () {
      group('factoryTopLevelVariableElement', () {
        group('when the AST is resolved', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              final expressionNode = await parseInvocation(
                '${builderSource.source}()',
                imports: builderSource.imports,
                isResolved: true,
              );
              final componentUsage = getComponentUsage(expressionNode);

              expect(
                componentUsage?.factoryTopLevelVariableElement,
                // Only resolved component factories will have `factoryTopLevelVariableElement`
                name.contains('component factory')
                    ? isA<TopLevelVariableElement>().having((f) => f.name,
                        'name', equals(builderSource.componentName))
                    : isNull,
              );
            });
          });
        });

        test('when the AST is not resolved', () async {
          final usage = getComponentUsage(await parseInvocation(r'''
                Foo()()
            '''))!;

          expect(usage.factoryTopLevelVariableElement, isNull);
        });
      });

      group('propsClassElement and propsType', () {
        group('when the AST is resolved', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              final expressionNode = await parseInvocation(
                '${builderSource.source}()',
                imports: builderSource.imports,
                isResolved: true,
              );
              final componentUsage = getComponentUsage(expressionNode)!;

              expect(
                componentUsage.propsClassElement,
                isA<ClassElement>()
                    .having((c) => c.name, 'name', builderSource.propsName),
              );
              expect(
                componentUsage.builderType,
                isA<DartType>().having(
                    (t) => t.getDisplayString(withNullability: false),
                    'display name',
                    builderSource.propsName),
              );
            });
          });
        });

        test('when the AST is not resolved', () async {
          final usage = getComponentUsage(await parseInvocation(r'''
                Foo()()
            '''))!;

          expect(usage.propsClassElement, isNull);
          expect(usage.builderType, isNull);
        });
      });

      void sharedTests({required bool isResolved}) {
        group('cascaded helpers', () {
          late FluentComponentUsage usage;

          setUpAll(() async {
            usage = getComponentUsage(await parseInvocation('''
                (Foo()
                  ..setter1 = null
                  ..getter1
                  ..prefix.prefixedSetter1 = null
                  ..prefix.prefixedGetter1
                  ..["indexAssignment1"] = null
                  ..["indexRead1"]
                  ..methodInvocation1()
                  
                  // Don't group the same types of nodes together so that 
                  // we can verify the order in cascadedMembers (i.e., put all
                  // the "2"s together instead of right next to their "1"s).
                  ..setter2 = null
                  ..getter2
                  ..prefix.prefixedSetter2 = null
                  ..prefix.prefixedGetter2
                  ..["indexAssignment2"] = null
                  ..["indexRead2"]
                  ..methodInvocation2(null)
                )()
            ''', isResolved: isResolved))!;
          });

          group('return the expected values for different types of cascades',
              () {
            test('cascadedSetters', () {
              expect(usage.cascadedProps, [
                isA<PropAssignment>().havingStringName('setter1'),
                isA<PropAssignment>().havingStringName('prefixedSetter1'),
                isA<PropAssignment>().havingStringName('setter2'),
                isA<PropAssignment>().havingStringName('prefixedSetter2'),
              ]);
            });

            test('cascadedGetters', () {
              expect(usage.cascadedGetters, [
                isA<PropRead>().havingStringName('getter1'),
                isA<PropRead>().havingStringName('prefixedGetter1'),
                isA<PropRead>().havingStringName('getter2'),
                isA<PropRead>().havingStringName('prefixedGetter2'),
              ]);
            });

            test('cascadedIndexAssignments', () {
              expect(usage.cascadedIndexAssignments, [
                isA<IndexPropAssignment>()
                    .havingIndexValueSource('"indexAssignment1"'),
                isA<IndexPropAssignment>()
                    .havingIndexValueSource('"indexAssignment2"'),
              ]);
            });

            test('cascadedMethodInvocations', () {
              expect(usage.cascadedMethodInvocations, [
                isA<BuilderMethodInvocation>()
                    .havingStringName('methodInvocation1'),
                isA<BuilderMethodInvocation>()
                    .havingStringName('methodInvocation2'),
              ]);
            });
          });

          test(
              'cascadedMembers returns all values for different types of cascades,'
              ' in the order they appeared in the original source', () {
            expect(usage.cascadedMembers, [
              // "1"s
              isA<PropAssignment>().havingStringName('setter1'),
              isA<PropRead>().havingStringName('getter1'),
              isA<PropAssignment>().havingStringName('prefixedSetter1'),
              isA<PropRead>().havingStringName('prefixedGetter1'),
              isA<IndexPropAssignment>()
                  .havingIndexValueSource('"indexAssignment1"'),
              isA<BuilderMemberAccess>().havingSource('..["indexRead1"]'),
              isA<BuilderMethodInvocation>()
                  .havingStringName('methodInvocation1'),
              // "2"s
              isA<PropAssignment>().havingStringName('setter2'),
              isA<PropRead>().havingStringName('getter2'),
              isA<PropAssignment>().havingStringName('prefixedSetter2'),
              isA<PropRead>().havingStringName('prefixedGetter2'),
              isA<IndexPropAssignment>()
                  .havingIndexValueSource('"indexAssignment2"'),
              isA<BuilderMemberAccess>().havingSource('..["indexRead2"]'),
              isA<BuilderMethodInvocation>()
                  .havingStringName('methodInvocation2'),
            ]);
            expect(
                usage.cascadedMembers, hasLength(usage.cascadeSections.length),
                reason: 'all cascade sections should map to a cascaded member');
          });
        });

        group('children', () {
          test('no arguments', () async {
            final usage = getComponentUsage(await parseInvocation('''
                Foo()()
            ''', isResolved: isResolved))!;
            expect(usage.children, isEmpty);
          });

          group('variadic children', () {
            test('single argument', () async {
              final usage = getComponentUsage(await parseInvocation('''
                  Foo()(Dom.h1()())
              ''', isResolved: isResolved))!;
              expect(usage.children, [
                isA<ExpressionComponentChild>()
                    .havingSource('Dom.h1()()')
                    .havingIsVariadic(isTrue),
              ]);
            });

            test('multiple arguments', () async {
              final usage = getComponentUsage(await parseInvocation('''
                  Foo()(Dom.h1()(), 2, "3")
              ''', isResolved: isResolved))!;
              expect(usage.children, [
                isA<ExpressionComponentChild>()
                    .havingSource('Dom.h1()()')
                    .havingIsVariadic(isTrue),
                isA<ExpressionComponentChild>()
                    .havingSource('2')
                    .havingIsVariadic(isTrue),
                isA<ExpressionComponentChild>()
                    .havingSource('"3"')
                    .havingIsVariadic(isTrue),
              ]);
            });
          });

          group('children within single list literal', () {
            test('containing only expressions', () async {
              final usage = getComponentUsage(await parseInvocation('''
                  Foo()([Dom.h1()(), 2, "3"])
              ''', isResolved: isResolved))!;
              expect(usage.children, [
                isA<ExpressionComponentChild>()
                    .havingSource('Dom.h1()()')
                    .havingIsVariadic(isFalse),
                isA<ExpressionComponentChild>()
                    .havingSource('2')
                    .havingIsVariadic(isFalse),
                isA<ExpressionComponentChild>()
                    .havingSource('"3"')
                    .havingIsVariadic(isFalse),
              ]);
            });

            test('containing expressions and collection elements', () async {
              final usage = getComponentUsage(await parseInvocation('''
                  Foo()([
                    "expression",
                    ...someChildren,
                    if (condition) someChild,
                    if (condition) ...someChildren,
                    for (final item in items) renderChild(child),
                  ])
              ''', isResolved: isResolved))!;
              expect(usage.children, [
                isA<ExpressionComponentChild>()
                    .havingSource('"expression"')
                    .havingIsVariadic(isFalse),
                isA<CollectionElementComponentChild>()
                    .havingSource('...someChildren'),
                isA<CollectionElementComponentChild>()
                    .havingSource('if (condition) someChild'),
                isA<CollectionElementComponentChild>()
                    .havingSource('if (condition) ...someChildren'),
                isA<CollectionElementComponentChild>().havingSource(
                    'for (final item in items) renderChild(child)'),
              ]);
            });
          });

          test('children within multiple list literals', () async {
            final usage = getComponentUsage(await parseInvocation('''
                Foo()([1, 2], [3, 4])
            ''', isResolved: isResolved))!;
            expect(usage.children, [
              isA<ExpressionComponentChild>()
                  .havingSource('[1, 2]')
                  .havingIsVariadic(isTrue),
              isA<ExpressionComponentChild>()
                  .havingSource('[3, 4]')
                  .havingIsVariadic(isTrue),
            ]);
          });

          test('children within multiple list literals within a list literal',
              () async {
            final usage = getComponentUsage(await parseInvocation('''
                Foo()([[1, 2], [3, 4]])
            ''', isResolved: isResolved))!;
            expect(usage.children, [
              isA<ExpressionComponentChild>()
                  .havingSource('[1, 2]')
                  .havingIsVariadic(isFalse),
              isA<ExpressionComponentChild>()
                  .havingSource('[3, 4]')
                  .havingIsVariadic(isFalse),
            ]);
          });
        });

        group('PropAssignment getters return the correct values', () {
          test('for a simple prop', () async {
            final assignment = getComponentUsage(await parseInvocation('''
                (Foo()..cascadedProp = null)()
            ''', isResolved: isResolved))!.cascadedProps.single;

            expect(assignment.node, hasSource('..cascadedProp = null'));
            expect(assignment.name.name, 'cascadedProp');
            expect(assignment.prefix, isNull);
            expect(assignment.target, hasSource('Foo()'));
            expect(assignment.leftHandSide, hasSource('..cascadedProp'));
            expect(assignment.rightHandSide, hasSource('null'));
            expect(assignment.isInCascade, isTrue);
            expect(assignment.parentCascade, isNotNull);
          });

          test('for a prefixed prop', () async {
            final assignment = getComponentUsage(await parseInvocation('''
                (Foo()..dom.role = null)()
            ''', isResolved: isResolved))!.cascadedProps.single;

            expect(assignment.node, hasSource('..dom.role = null'));
            expect(assignment.name.name, 'role');
            expect(assignment.prefix, hasSource('dom'));
            expect(assignment.target, hasSource('..dom'));
            expect(assignment.leftHandSide, hasSource('..dom.role'));
            expect(assignment.rightHandSide, hasSource('null'));
            expect(assignment.isInCascade, isTrue);
            expect(assignment.parentCascade, isNotNull);
          });
        });

        group('PropAccess getters return the correct values', () {
          test('for a simple access', () async {
            final getter = getComponentUsage(await parseInvocation('''
                (Foo()..bar)()
            ''', isResolved: isResolved))!.cascadedGetters.single;

            expect(getter.node, hasSource('..bar'));
            expect(getter.name, hasSource('bar'));
          });

          test('for a prefixed access', () async {
            final getter = getComponentUsage(await parseInvocation('''
                (Foo()..bar.baz)()
            ''', isResolved: isResolved))!.cascadedGetters.single;

            expect(getter.node, hasSource('..bar.baz'));
            expect(getter.name, hasSource('baz'));
          });
        });

        test('IndexPropAssignment getters return the correct values', () async {
          final indexAssignment = getComponentUsage(await parseInvocation('''
              (Foo()..["bar"] = null)()
          ''', isResolved: isResolved))!.cascadedIndexAssignments.single;

          expect(indexAssignment.node, hasSource('..["bar"] = null'));
          expect(indexAssignment.leftHandSide, hasSource('..["bar"]'));
          expect(indexAssignment.index, hasSource('"bar"'));
          expect(indexAssignment.rightHandSide, hasSource('null'));
        });

        test('BuilderMethodInvocation getters return the correct values',
            () async {
          final invocation = getComponentUsage(await parseInvocation('''
              (Foo()..bar())()
          ''', isResolved: isResolved))!.cascadedMethodInvocations.single;

          expect(invocation.node, hasSource('..bar()'));
          expect(invocation.methodName, hasSource('bar'));
        });
      }

      group('when AST is not resolved', () => sharedTests(isResolved: false));
      group('when AST is resolved', () => sharedTests(isResolved: true));
    });

    group('typeCategoryForReactNode', () {
      Future<Expression> resolveExpression(String expression) =>
          parseExpression(expression, isResolved: true);

      group('returns `.primitive` for primitive-typed expressions:', () {
        const testCasesByName = {
          'bool': 'false',
          'null': 'null',
          'string': '""',
          'int': '1',
          'double': '1.0',
          'num': '(1 as num)',
        };

        testCasesByName.forEach((name, source) {
          test(name, () async {
            expect(typeCategoryForReactNode(await resolveExpression(source)),
                ReactNodeTypeCategory.primitive);
          });
        });
      });

      test('returns `.reactElement` for ReactElement-typed expressions:',
          () async {
        final expression = await parseExpression('Dom.div()()',
            isResolved: true,
            imports: 'import "package:over_react/over_react.dart"');
        expect(typeCategoryForReactNode(expression),
            ReactNodeTypeCategory.reactElement);
      });

      test('returns `.unknown` for expressions that could not be resolved:',
          () async {
        final expression = await parseExpression('someUnresolvedIdentifier', isResolved: false);
        expect(typeCategoryForReactNode(expression),
            ReactNodeTypeCategory.unknown);
      });

      group('returns `.other` for other types:', () {
        const testCasesByName = {
          'dynamic': '(Object() as dynamic)',
          'Object': 'Object()',
          'another type (Map)': '{}',
        };

        testCasesByName.forEach((name, source) {
          test(name, () async {
            expect(typeCategoryForReactNode(await resolveExpression(source)),
                ReactNodeTypeCategory.other);
          });
        });
      });
    });
  });
}

Matcher hasSource(dynamic source) => isA<AstNode>().havingSource(source);

extension<T extends AstNode> on TypeMatcher<T> {
  TypeMatcher<T> havingSource(dynamic matcher) =>
      having((node) => node.toSource(), 'node.toSource()', matcher);
}

extension<T extends BuilderMemberAccess> on TypeMatcher<T> {
  TypeMatcher<T> havingSource(dynamic matcher) =>
      having((p) => p.node.toSource(), 'node.toSource()', matcher);
}

extension<T extends PropAssignment> on TypeMatcher<T> {
  TypeMatcher<PropAssignment> havingStringName(dynamic matcher) =>
      having((p) => p.name.name, 'name.name', matcher);
}

extension<T extends PropRead> on TypeMatcher<T> {
  TypeMatcher<T> havingStringName(dynamic matcher) =>
      having((p) => p.name.name, 'name.name', matcher);
}

extension<T extends BuilderMethodInvocation> on TypeMatcher<T> {
  TypeMatcher<T> havingStringName(dynamic matcher) =>
      having((p) => p.methodName.name, 'methodName.name', matcher);
}

extension<T extends IndexPropAssignment> on TypeMatcher<T> {
  TypeMatcher<T> havingIndexValueSource(dynamic matcher) =>
      having((p) => p.index.toSource(), 'index.toSource', matcher);
}

extension<T extends ComponentChild> on TypeMatcher<T> {
  TypeMatcher<T> havingSource(dynamic matcher) =>
      having((c) => c.node.toSource(), 'node.toSource()', matcher);
}

extension<T extends ExpressionComponentChild> on TypeMatcher<T> {
  TypeMatcher<T> havingIsVariadic(dynamic matcher) =>
      having((c) => c.isVariadic, 'isVariadic', matcher);
}

void checkComponentUsage(FluentComponentUsage? componentUsage,
    BuilderTestCase builderSource, String source,
    [String? cascadeSource]) {
  expect(componentUsage, isNotNull);
  componentUsage!;
  expect(componentUsage.builder.toSource(), builderSource.source);
  expect(
    componentUsage.factory,
    isA<Identifier>().having(
        (f) => f.name,
        'name',
        equals(componentUsage.isBuilderResolved
            ? builderSource.factoryName
            // Remove the import namespace for unresolved AST.
            : builderSource.factoryName.split('.').last)),
  );
  expect(componentUsage.propsName,
      componentUsage.isBuilderResolved ? builderSource.propsName : isNull);
  expect(componentUsage.node.toSource(), source);
  expect(
      componentUsage.componentName,
      componentUsage.isBuilderResolved
          ? builderSource.componentName
          : builderSource.unresolvedComponentName);
  if (componentUsage.isBuilderResolved) {
    expect(componentUsage.isDom, builderSource.isDom);
    expect(componentUsage.isSvg, builderSource.isSvg);
  }
  expect(componentUsage.cascadeExpression?.toSource(), cascadeSource ?? isNull);
}

class BuilderTestCase {
  final String source;
  final String imports;
  final String componentName;
  final String? unresolvedComponentName;
  final String factoryName;
  final String propsName;
  final bool isDom;
  final bool isSvg;

  const BuilderTestCase({
    required this.source,
    required this.imports,
    required this.componentName,
    required this.unresolvedComponentName,
    required this.factoryName,
    required this.propsName,
    required this.isDom,
    required this.isSvg,
  });
}

const fooComponents = /*language=dart*/ r'''
import 'package:over_react/over_react.dart';
UiFactory<FooProps> Foo = _$Foo; // ignore: undefined_identifier, invalid_assignment
mixin FooProps on UiProps {}
class FooComponent extends UiComponent2<FooProps> {
  @override
  void render() {}
}
UiFactory<BarProps> Bar = _$Bar; // ignore: undefined_identifier, invalid_assignment
mixin BarProps on UiProps {}
class BarComponent extends UiComponent2<BarProps> {
  @override
  void render() {}
}
FooProps getFooBuilder() => Foo();
FooProps getBuilderForFoo() => Foo();
FooProps toBuilder() => Foo();
''';

/// An enumeration of all the supported OverReact component builders that can be detected
/// using [FluentComponentUsage], and used to target code when formatting.
///
/// Keys are descriptions, and values are [BuilderTestCase]s.
const buildersToTest = {
  'DOM factory': BuilderTestCase(
    source: 'Dom.h1()',
    imports: fooComponents,
    componentName: 'Dom.h1',
    unresolvedComponentName: 'Dom.h1',
    factoryName: 'h1',
    propsName: 'DomProps',
    isDom: true,
    isSvg: false,
  ),
  'DOM factory w/ SVG props': BuilderTestCase(
    source: 'Dom.circle()',
    imports: fooComponents,
    componentName: 'Dom.circle',
    unresolvedComponentName: 'Dom.circle',
    factoryName: 'circle',
    propsName: 'SvgProps',
    isDom: true,
    isSvg: true,
  ),
  'DOM factory w/ namespaced import': BuilderTestCase(
    source: 'foo_bar.Dom.h1()',
    imports:
        'import \'package:over_react/over_react.dart\' as foo_bar;$fooComponents',
    componentName: 'Dom.h1',
    unresolvedComponentName: 'foo_bar.Dom.h1',
    factoryName: 'h1',
    propsName: 'DomProps',
    isDom: true,
    isSvg: false,
  ),
  'component factory': BuilderTestCase(
    source: 'Foo()',
    imports: fooComponents,
    componentName: 'Foo',
    unresolvedComponentName: 'Foo',
    factoryName: 'Foo',
    propsName: 'FooProps',
    isDom: false,
    isSvg: false,
  ),
  'component factory w/ namespaced import': BuilderTestCase(
    source: 'foo_bar.ErrorBoundary()',
    imports:
        'import \'package:over_react/components.dart\' as foo_bar;$fooComponents',
    componentName: 'ErrorBoundary',
    unresolvedComponentName: 'foo_bar.ErrorBoundary',
    factoryName: 'foo_bar.ErrorBoundary',
    propsName: 'ErrorBoundaryProps',
    isDom: false,
    isSvg: false,
  ),
  'custom builder function (ending in keyword)': BuilderTestCase(
    source: 'getFooBuilder()',
    imports: fooComponents,
    componentName: 'Foo',
    unresolvedComponentName: 'getFooBuilder',
    factoryName: 'getFooBuilder',
    propsName: 'FooProps',
    isDom: false,
    isSvg: false,
  ),
  'custom builder function (not ending in keyword)': BuilderTestCase(
    source: 'getBuilderForFoo()',
    imports: fooComponents,
    componentName: 'Foo',
    unresolvedComponentName: 'getBuilderForFoo',
    factoryName: 'getBuilderForFoo',
    propsName: 'FooProps',
    isDom: false,
    isSvg: false,
  ),
};

/// Returns [expression] parsed as AST.
///
/// This is accomplished it by including the [expression] as a statement within a wrapper function
/// with any necessary [imports] at the top of the source. As a result, the offset of the
/// returned expression will not be 0.
///
/// To return resolved AST, set [isResolved] to true.
///
/// Throws if [expression] is not an [InvocationExpression].
Future<InvocationExpression> parseInvocation(
  String expression, {
  String imports = '',
  bool isResolved = false,
}) async {
  final parsedExpression = await parseExpression(expression, imports: imports, isResolved: isResolved);
  if (parsedExpression is InvocationExpression) {
    return parsedExpression;
  }
  throw ArgumentError.value(expression, 'expression',
      'was not a InvocationExpression; was $parsedExpression');
}

/// Parses [dartSource] and returns the unresolved AST, throwing if there are any syntax errors.
CompilationUnit parseAndGetUnit(String dartSource) {
  final result = parseString(
    content: dartSource,
    throwIfDiagnostics: false,
    path: 'dart source from string',
  );
  // `throwIfDiagnostics: true` throws, but does not include the actual errors in the exception.
  // We'll handle throwing when there are errors.
  if (result.errors.isNotEmpty) {
    throw ArgumentError('Parse errors in source:\n${result.errors.join('\n')}');
  }
  return result.unit;
}

/// Returns a lazy iterable of all descendants of [node], in breadth-first order.
Iterable<AstNode> allDescendants(AstNode node) sync* {
  final nodesQueue = Queue<AstNode>()..add(node);
  while (nodesQueue.isNotEmpty) {
    final current = nodesQueue.removeFirst();

    for (final child in current.childEntities) {
      if (child is AstNode) {
        yield child;
        nodesQueue.add(child);
      }
    }
  }
}

/// Returns a lazy iterable of all descendants of [node] of type [T], in breadth-first order.
Iterable<T> allDescendantsOfType<T extends AstNode>(AstNode node) =>
    allDescendants(node).whereType<T>();

/// Parses [dartSource] and returns the first node of type [T].
///
/// Useful for easily creating a node of a certain type for tests.
///
/// Throws if a matching node is not found.
///
/// Example:
/// ```dart
/// final body = parseAndGetNode<BlockFunctionBody>(r'''
///   myFunction() {
///     // ...
///   }
/// ''');
/// ```
T parseAndGetNode<T extends AstNode>(String dartSource) =>
    allDescendantsOfType<T>(parseAndGetUnit(dartSource)).first;
