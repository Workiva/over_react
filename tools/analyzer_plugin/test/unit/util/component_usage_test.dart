import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:test/test.dart';

import '../../test_util.dart';
import 'test_data.dart';

void main() {
//  group('component_usage', () {
//    group('getComponentUsage', () {
//      test('allDescendants returns all descendants in breadth-first order', () async {
//        final usage = await parseAndGetResolvedUnit(/*language=dart*/ r'''
//          import 'package:over_react/over_react.dart';
//          var a = (Dom.div()
//            ..id = '1'
//          )();
//        ''');
//        final b = (usage.unit.declarations.first as TopLevelVariableDeclaration).variables.variables.first.initializer;
//        if (b is InvocationExpression) {
//          final a = getComponentUsage(b);
//          a.componentName;
//          expect(a, 'abc');
//        }
//      });
//    });
//  });
  group('component_usage', () {
    group('getComponentUsage', () {
      group('accurately detects and collects information on usages of OverReact components:', () {
        group('components with no cascades:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () {
              var source = '$builderSource()';

              final expressionNode = parseExpression(source);
              final componentUsage = getComponentUsage(expressionNode);

              expect(componentUsage, isNotNull, reason: builderSource);

              expect(componentUsage.builder.toSource(), builderSource);
              expect(componentUsage.node.toSource(), source);
              expect(componentUsage.cascadeExpression, isNull);
            });
          });
        });

        group('components with cascades:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () {
              var cascadeSource = '$builderSource..isFancy = true';
              var source = '($cascadeSource)()';

              var expressionNode = parseExpression(source);
              var componentUsage = getComponentUsage(expressionNode);
              expect(componentUsage, isNotNull);

              expect(componentUsage.builder.toSource(), builderSource);
              expect(componentUsage.node.toSource(), source);
              expect(componentUsage.cascadeExpression.toSource(), cascadeSource);
            });
          });
        });

        group('components with no cascade but extra parens:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () {
              var source = '($builderSource)()';

              var expressionNode = parseExpression(source);
              var componentUsage = getComponentUsage(expressionNode);
              expect(componentUsage, isNotNull);

              expect(componentUsage.builder.toSource(), builderSource);
              expect(componentUsage.node.toSource(), source);
              expect(componentUsage.cascadeExpression, isNull);
            });
          });
        });

        group('components with no children:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () {
              var source = '$builderSource()';

              var expressionNode = parseExpression(source);
              var componentUsage = getComponentUsage(expressionNode);
              expect(componentUsage, isNotNull);

              expect(componentUsage.childArgumentCount, 0);
              expect(componentUsage.hasVariadicChildren, false);
            });
          });
        });

        group('components with a single child:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () {
              var source = '$builderSource("foo")';

              var expressionNode = parseExpression(source);
              var componentUsage = getComponentUsage(expressionNode);
              expect(componentUsage, isNotNull);

              expect(componentUsage.childArgumentCount, 1);
              expect(componentUsage.hasVariadicChildren, true);
            });
          });
        });

        group('components with more than one child:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () {
              var source = '$builderSource("foo", "bar")';

              var expressionNode = parseExpression(source);
              var componentUsage = getComponentUsage(expressionNode);
              expect(componentUsage, isNotNull);

              expect(componentUsage.childArgumentCount, 2);
              expect(componentUsage.hasVariadicChildren, true);
            });
          });
        });

        group('components with list literal children:', () {
          buildersToTest.forEach((name, builderSource) {
            test('$name', () {
              var source = '$builderSource(["foo", "bar"])';

              var expressionNode = parseExpression(source);
              var componentUsage = getComponentUsage(expressionNode);
              expect(componentUsage, isNotNull);

              expect(componentUsage.childArgumentCount, 1);
              expect(componentUsage.hasVariadicChildren, false);
            });
          });
        });
      });

      test('returns null for invocations that aren\'t fluent interface usages', () {
        void verifyUsage(String source, String reason) {
          var expressionNode = parseExpression(source);
          var componentUsage = getComponentUsage(expressionNode);
          expect(componentUsage, isNull, reason: '$source is $reason');
        }

        const {
          'Dom.h1()': 'not full invocation',
          'Foo()': 'not full invocation',
          'fooFactory()': 'not full invocation',
          // This case is ambiguous, since it can be interpreted the same
          // as `fooBuilder()`, which *is* a full invocation:
          //     'getFooBuilder()': 'not full invocation',
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
            test('and the child component uses a $name', () {
              var childSource = '$builderSource()';
              var source = 'SomeOtherComponent()($childSource)';

              InvocationExpression expressionNode = parseExpression(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });

        group('when there are multiple children, and only one is a component', () {
          buildersToTest.forEach((name, builderSource) {
            test('and the child component uses a $name', () {
              var childSource = '$builderSource()';
              var source = 'SomeOtherComponent()("other child 1", $childSource, "other child 2")';

              InvocationExpression expressionNode = parseExpression(source);

              expect(hasChildComponent(expressionNode.argumentList), isTrue);
            });
          });
        });
      });

      group('even when the components have any number of extra wrapping parens', () {
        buildersToTest.forEach((name, builderSource) {
          test('and the child component uses a $name', () {
            var childSource = '$builderSource()';
            var childSourceWithExtraParens = '((($childSource)))';
            var source = 'SomeOtherComponent()($childSourceWithExtraParens)';

            InvocationExpression expressionNode = parseExpression(source);

            expect(hasChildComponent(expressionNode.argumentList), isTrue);
          });
        });
      });

      test('returns false when there are only non-component arguments', () {
        var source = 'SomeOtherComponent()(1, "non-component child", {})';

        InvocationExpression expressionNode = parseExpression(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });

      test('returns false when there are nested components, but no top-level ones', () {
        var source = 'SomeOtherComponent()([Foo()()])';

        InvocationExpression expressionNode = parseExpression(source);

        expect(hasChildComponent(expressionNode.argumentList), isFalse);
      });
    });
  });
}
