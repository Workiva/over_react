import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';
import 'package:test/test.dart';

import '../../../test_util.dart';

void main() {
  group('ast_util', () {
    test('allDescendants returns all descendants in breadth-first order', () {
      final unit = parseAndGetUnit(/*language=dart*/ r'''
        // @dart=2.11
        class A {
          var field;
        }
        class B {}
      ''');
      expect(allDescendants(unit), [
        isA<ClassDeclaration>(), // class A {}
        isA<ClassDeclaration>(), // class B {}
        isA<FieldDeclaration>(), // var field;
        isA<VariableDeclarationList>(), // field
        isA<VariableDeclaration>(), // field
      ]);
    });

    group('FunctionBody.returnExpressions', () {
      test('BlockFunctionBody', () {
        final body = parseAndGetNode<BlockFunctionBody>(/*language=dart*/ r'''
          // @dart=2.11
          blockBody() {
            if (condition1) return fromIfStatement;
            if (condition2) {
              return fromIfBlock;
            }
            // intentionally empty return
            if (condition3) return;
            someOtherFunction() {
              return fromSomeOtherFuntion;
            }
            return fromBody;
          }
        ''');

        expect(body.returnExpressions.map((e) => e.toSource()).toList(), [
          'fromIfStatement',
          'fromIfBlock',
          'fromBody',
        ]);
      });

      test('ExpressionFunctionBody', () {
        final body = parseAndGetNode<ExpressionFunctionBody>(/*language=dart*/ r'''
          // @dart=2.11
          expressionBody() => theExpression;
        ''');

        expect(body.returnExpressions.map((e) => e.toSource()).toList(), [
          'theExpression',
        ]);
      });

      test('EmptyFunctionBody', () {
        final body = parseAndGetNode<EmptyFunctionBody>(/*language=dart*/ r'''
          // @dart=2.11
          abstract class Foo {
            emptyFunctionBody();
          }
        ''');

        expect(body.returnExpressions, isEmpty);
      });
    });

    group('lookup functions', () {
      Iterable<Expression> getAllPrintedExpressions(AstNode root) => allDescendantsOfType<InvocationExpression>(root)
          .where((e) => e.function.tryCast<Identifier>()?.name == 'print')
          .map((printCall) => printCall.argumentList.arguments[0]);

      group('lookUpVariable', () {
        test('looks up a variable', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            someFunction() {
              var foo = 0;
              print(foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect(lookUpVariable(usage.staticElement!, unit)?.name.lexeme, 'foo');
        });

        group('returns null when', () {
          test('the element does not correspond to a variable', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              someFunction() {
                foo() {}
                print(foo);
              }
            ''')).unit;
            final usage = getAllPrintedExpressions(unit).single as Identifier;
            expect(usage.name, 'foo', reason: 'test setup check');
            expect(usage.staticElement, isNotNull, reason: 'test setup check');
            expect(lookUpVariable(usage.staticElement!, unit), isNull);
          });

          test('the element does not exist within a given node', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              someFunction() {
                var foo = 0;
                print(foo);
              }
            ''')).unit;
            final usage = getAllPrintedExpressions(unit).single as Identifier;
            expect(usage.name, 'foo', reason: 'test setup check');
            expect(usage.staticElement, isNotNull, reason: 'test setup check');
            expect(lookUpVariable(usage.staticElement!, usage), isNull);
          });
        });
      });

      group('lookUpFunction', () {
        test('looks up a function declaration', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            someFunction() {
              foo() => 'I am the body';
              print(foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect(lookUpFunction(usage.staticElement!, unit)?.body.toSource(), contains('I am the body'));
        });

        test('looks up a variable initialize to a function', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            someFunction() {
              var foo = () => 'I am the body';
              print(foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect(lookUpFunction(usage.staticElement!, unit)?.body.toSource(), contains('I am the body'));
        });

        group('returns null when', () {
          test('the element does not correspond to a function', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              someFunction() {
                var foo = 1;
                print(foo);
              }
            ''')).unit;
            final usage = getAllPrintedExpressions(unit).single as Identifier;
            expect(usage.name, 'foo', reason: 'test setup check');
            expect(usage.staticElement, isNotNull, reason: 'test setup check');
            expect(lookUpFunction(usage.staticElement!, unit), isNull);
          });

          test('the element does not exist within a given node', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              someFunction() {
                foo() => 'I am the body';
                print(foo);
              }
            ''')).unit;
            final usage = getAllPrintedExpressions(unit).single as Identifier;
            expect(usage.name, 'foo', reason: 'test setup check');
            expect(usage.staticElement, isNotNull, reason: 'test setup check');
            expect(lookUpFunction(usage.staticElement!, usage), isNull);
          });
        });
      });

      group('lookUpDeclaration', () {
        test('looks up a function', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            someFunction() {
              foo() {}
              print(foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect((lookUpDeclaration(usage.staticElement!, unit) as FunctionDeclaration).name.lexeme, 'foo');
        });

        test('looks up a variable', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            someFunction() {
              var foo = 1;
              print(foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect((lookUpDeclaration(usage.staticElement!, unit) as VariableDeclaration).name.lexeme, 'foo');
        });

        test('looks up a class', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            class Foo {}
          
            someFunction() {
              print(Foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'Foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect((lookUpDeclaration(usage.staticElement!, unit) as ClassDeclaration).name.lexeme, 'Foo');
        });

        group('returns null when', () {
          test('the element does not correspond to a declaration', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              import 'dart:html';
            ''')).unit;
            final usage = allDescendantsOfType<ImportDirective>(unit).single;
            expect(usage.element, isNotNull, reason: 'test setup check');
            expect(lookUpFunction(usage.element!, unit), isNull);
          });

          test('the element does not exist within a given node', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              someFunction() {
                foo() {};
                print(foo);
              }
            ''')).unit;
            final usage = getAllPrintedExpressions(unit).single as Identifier;
            expect(usage.name, 'foo', reason: 'test setup check');
            expect(usage.staticElement, isNotNull, reason: 'test setup check');
            expect(lookUpFunction(usage.staticElement!, usage), isNull);
          });
        });
      });

      group('lookUpParameter', () {
        test('looks up a required parameter', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            someFunction(int foo) {
              print(foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect(lookUpParameter(usage.staticElement!, unit)?.name?.lexeme, 'foo');
        });

        test('looks up a named parameter', () async {
          final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
            // @dart=2.11
            someFunction({int foo}) {
              print(foo);
            }
          ''')).unit;
          final usage = getAllPrintedExpressions(unit).single as Identifier;
          expect(usage.name, 'foo', reason: 'test setup check');
          expect(usage.staticElement, isNotNull, reason: 'test setup check');
          expect(lookUpParameter(usage.staticElement!, unit)?.name?.lexeme, 'foo');
        });

        group('returns null when', () {
          test('the element does not correspond to a parameter', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              someFunction() {
                foo() {}
                print(foo);
              }
            ''')).unit;
            final usage = getAllPrintedExpressions(unit).single as Identifier;
            expect(usage.name, 'foo', reason: 'test setup check');
            expect(usage.staticElement, isNotNull, reason: 'test setup check');
            expect(lookUpParameter(usage.staticElement!, unit), isNull);
          });

          test('the element does not exist within a given node', () async {
            final unit = (await parseAndGetResolvedUnit(/*language=dart*/ r'''
              // @dart=2.11
              someFunction(int foo) {
                print(foo);
              }
            ''')).unit;
            final usage = getAllPrintedExpressions(unit).single as Identifier;
            expect(usage.name, 'foo', reason: 'test setup check');
            expect(usage.staticElement, isNotNull, reason: 'test setup check');
            expect(lookUpParameter(usage.staticElement!, usage), isNull);
          });
        });
      });
    });
  });
}
