import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:test/test.dart';

import '../../test_util.dart';

main() {
  group('ast_util', () {
    test('allDescendants returns all descendants in breadth-first order', () {
      // language=dart
      final unit = parseAndGetUnit(r'''
        class A {}
        class B {}
      ''');
      expect(allDescendants(unit), [
        isA<ClassDeclaration>(), // class A {}
        isA<ClassDeclaration>(), // class B {}
        isA<Identifier>(), // A
        isA<Identifier>(), // B
      ]);
    });

    group('FunctionBody.returnExpressions', () {
      test('BlockFunctionBody', () {
        // language=dart
        final body = parseAndGetNode<BlockFunctionBody>(r'''
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
        // language=dart
        final body = parseAndGetNode<ExpressionFunctionBody>(r'''
          expressionBody() => theExpression;
        ''');

        expect(body.returnExpressions.map((e) => e.toSource()).toList(), [
          'theExpression',
        ]);
      });

      test('EmptyFunctionBody', () {
        // language=dart
        final body = parseAndGetNode<EmptyFunctionBody>(r'''
          abstract class Foo {
            emptyFunctionBody();
          }
        ''');

        expect(body.returnExpressions, isEmpty);
      });
    });
  });
}
