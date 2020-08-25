import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:test/test.dart';

import '../../test_util.dart';

void main() {
  group('component_usage', () {
    group('getComponentUsage', () {
      group('accurately detects and collects information on usages of OverReact components:', () {
        group('components with no cascades:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              final source = '${builderSource.source}()';

              final expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
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

              var expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source, cascadeSource);
            });
          });
        });

        group('components with no cascade but extra parens:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '(${builderSource.source})()';

              var expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);
            });
          });
        });

        group('components with no children:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}()';

              var expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 0);
              expect(componentUsage.hasVariadicChildren, false);
            });
          });
        });

        group('components with a single child:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}("foo")';

              var expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 1);
              expect(componentUsage.hasVariadicChildren, true);
            });
          });
        });

        group('components with more than one child:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}("foo", "bar")';

              var expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 2);
              expect(componentUsage.hasVariadicChildren, true);
            });
          });
        });

        group('components with list literal children:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () async {
              var source = '${builderSource.source}(["foo", "bar"])';

              var expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
              var componentUsage = getComponentUsage(expressionNode);

              checkComponentUsage(componentUsage, builderSource, source);

              expect(componentUsage.childArgumentCount, 1);
              expect(componentUsage.hasVariadicChildren, false);
            });
          });
        });
      });

      test('returns null for invocations that aren\'t fluent interface usages', () {
        Future<void> verifyUsage(String source, String reason) async {
          final expressionNode = await parseExpression(source);
          var componentUsage = getComponentUsage(expressionNode);
          expect(componentUsage, isNull, reason: '$source is $reason');
        }

        const {
          'Dom.h1()': 'not full invocation',
          'Foo()': 'not full invocation',
          'fooFactory()': 'not full invocation',
          'foo()': 'not a valid builder',
          'foo.bar()': 'not a valid builder',
          'foo()()': 'not a valid builder',
          '_foo()()': 'not a valid builder',
        }.forEach(verifyUsage);
      });
    });

    group('hasChildComponent', () {
      group('detects components within an argument list', () {
        group('when there is a single child that is a component', () {
          buildersToTest.forEach((name, builderSource) {
            test('and the child component uses a $name', () async {
              var childSource = '${builderSource.source}()';
              var source = 'SomeOtherComponent()($childSource)';

              final expressionNode = await parseExpression(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });

        group('when there are multiple children, and only one is a component', () {
          buildersToTest.forEach((name, builderSource) {
            test('and the child component uses a $name', () async {
              var childSource = '${builderSource.source}()';
              var source = 'SomeOtherComponent()("other child 1", $childSource, "other child 2")';

              final expressionNode = await parseExpression(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });
      });

      group('even when the components have any number of extra wrapping parens', () {
        buildersToTest.forEach((name, builderSource) {
          test('and the child component uses a $name', () async {
            var childSource = '${builderSource.source}()';
            var childSourceWithExtraParens = '((($childSource)))';
            var source = 'SomeOtherComponent()($childSourceWithExtraParens)';

            final expressionNode = await parseExpression(source);

            expect(hasChildComponent(expressionNode.argumentList), isTrue);
          });
        });
      });

      test('returns false when there are only non-component arguments', () async {
        var source = 'SomeOtherComponent()(1, "non-component child", {})';
        final expressionNode = await parseExpression(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });

      test('returns false when there are nested components, but no top-level ones', () async {
        var source = 'SomeOtherComponent()([Foo()()])';
        final expressionNode = await parseExpression(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });
    });

    group('identifyUsage', () {
      group('returns correct FluentComponentUsage usage when', () {
        buildersToTest.forEach((name, builderSource) {
          group('', () {
            final cascadeSource = '${builderSource.source}..id = \'123\'';
            final source = '($cascadeSource)(\'stringChild\')';
            InvocationExpression expressionNode;

            setUpAll(() async {
              expressionNode = await parseExpression(source, imports: builderSource.imports, isResolved: true);
            });

            test('node is a $name which is already a component usage', () {
              final componentUsage = identifyUsage(expressionNode);
              checkComponentUsage(componentUsage, builderSource, source, cascadeSource);
            });

            group('node inside $name', () {
              test('is props cascade expression', () {
                final cascadeExpression =
                    getComponentUsage(expressionNode).cascadeExpression.cascadeSections.firstOrNull;
                expect(cascadeExpression.toSource(), '..id = \'123\'');
                final componentUsage = identifyUsage(cascadeExpression);
                checkComponentUsage(componentUsage, builderSource, source, cascadeSource);
              });

              test('is a child should return null', () {
                final child = expressionNode.argumentList.arguments.firstOrNull;
                expect(child.toSource(), '\'stringChild\'');
                final componentUsage = identifyUsage(child);
                expect(componentUsage, isNull);
              });
            });
          });

          group('a $name is a child of another component', () {
            final cascadeSource = '${builderSource.source}..id = \'123\'';
            final childSource = '($cascadeSource)(\'stringChild\')';
            final nestedSource = 'Bar()($childSource)';
            InvocationExpression expressionNode;
            InvocationExpression childExpression;

            setUpAll(() async {
              expressionNode = await parseExpression(
                nestedSource,
                imports: builderSource.imports,
                isResolved: true,
              );

              expect(expressionNode.argumentList.arguments.firstOrNull, isNotNull);
              expect(expressionNode.argumentList.arguments.firstOrNull, isA<InvocationExpression>());
              childExpression = expressionNode.argumentList.arguments.firstOrNull as InvocationExpression;
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
                    isDom: false,
                    isSvg: false,
                  ),
                  nestedSource);
            });

            test('and node is the child component', () {
              final componentUsage = identifyUsage(childExpression);
              checkComponentUsage(componentUsage, builderSource, childSource, cascadeSource);
            });

            group('and the node inside the child component', () {
              test('is props cascade expression', () {
                final cascadeExpression =
                    getComponentUsage(childExpression).cascadeExpression.cascadeSections.firstOrNull;
                expect(cascadeExpression.toSource(), '..id = \'123\'');
                final componentUsage = identifyUsage(cascadeExpression);
                checkComponentUsage(componentUsage, builderSource, childSource, cascadeSource);
              });

              test('is a child should return null', () {
                final child = childExpression.argumentList.arguments.firstOrNull;
                expect(child.toSource(), '\'stringChild\'');
                final componentUsage = identifyUsage(child);
                expect(componentUsage, isNull);
              });
            });
          });
        });
      });

      group('returns null when node has no parent component usage', () {
        var source = /*language=dart*/ r'''
          class Foo {
            void foo() {
              var a = 'abc';
            }
          }
        ''';
        InvocationExpression expressionNode;

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

        test('and node is an invocation expression', () async {
          expressionNode = await parseExpression('Foo.foo(() => \'abc\')');
          final componentUsage = identifyUsage(expressionNode);
          expect(componentUsage, isNull);
        });

        test('and node is an argument of an invocation expression', () {
          final arg = expressionNode.argumentList.arguments.firstOrNull;
          expect(arg, isNotNull);
          final componentUsage = identifyUsage(arg);
          expect(componentUsage, isNull);
        });
      });
    });
  });
}

void checkComponentUsage(FluentComponentUsage componentUsage, BuilderTestCase builderSource, String source,
    [String cascadeSource]) {
  expect(componentUsage, isNotNull);
  expect(componentUsage.builder.toSource(), builderSource.source);
  expect(componentUsage.node.toSource(), source);
  expect(componentUsage.componentName, builderSource.componentName);
  expect(componentUsage.isDom, builderSource.isDom);
  expect(componentUsage.isSvg, builderSource.isSvg);
  expect(componentUsage.cascadeExpression?.toSource(), cascadeSource ?? isNull);
}

class BuilderTestCase {
  String source;
  String imports;
  String componentName;
  bool isDom;
  bool isSvg;
  BuilderTestCase({this.source, this.imports, this.componentName, this.isDom, this.isSvg});
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
''';

/// An enumeration of all the supported OverReact component builders that can be detected
/// using [FluentComponentUsage], and used to target code when formatting.
///
/// Keys are descriptions, and values are [BuilderTestCase]s.
final buildersToTest = {
  'DOM factory': BuilderTestCase(
    source: 'Dom.h1()',
    imports: fooComponents,
    componentName: 'h1',
    isDom: true,
    isSvg: false,
  ),
  'DOM factory w/ SVG props': BuilderTestCase(
    source: 'Dom.circle()',
    imports: fooComponents,
    componentName: 'circle',
    isDom: true,
    isSvg: true,
  ),
  'DOM factory w/ namespaced import': BuilderTestCase(
    source: 'foo_bar.Dom.h1()',
    imports: 'import \'package:over_react/over_react.dart\' as foo_bar;$fooComponents',
    componentName: 'h1',
    isDom: true,
    isSvg: false,
  ),
  'component factory': BuilderTestCase(
    source: 'Foo()',
    imports: fooComponents,
    componentName: 'Foo',
    isDom: false,
    isSvg: false,
  ),
  'custom builder function (ending in keyword)': BuilderTestCase(
    source: 'getFooBuilder()',
    imports: fooComponents,
    componentName: 'Foo',
    isDom: false,
    isSvg: false,
  ),
  'custom builder function (not ending in keyword)': BuilderTestCase(
    source: 'getBuilderForFoo()',
    imports: fooComponents,
    componentName: 'Foo',
    isDom: false,
    isSvg: false,
  ),
};
