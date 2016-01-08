@TestOn('vm')
library analyzer_helpers_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/analyzer_helpers.dart';

main() {
  group('analyzer_helpers', () {
    CompilationUnitMember parseAndGetSingleMember(String source) {
      var compilationUnit = parseCompilationUnit(source);
      return compilationUnit.declarations.single;
    }

    group('instantiateAnnotation()', () {
      group('instantiates an annotation with a parameter value specified as', () {
        test('a string literal', () {
          TestAnnotation instance = instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation("hello")\nvar a;'),
              TestAnnotation
          );
          expect(instance.positional, "hello");
        });

        test('a concatenated string literal', () {
          TestAnnotation instance = instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation("hello " "there")\nvar a;'),
              TestAnnotation
          );
          expect(instance.positional, "hello there");
        });

        test('a boolean literal', () {
          TestAnnotation instance = instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation(true)\nvar a;'),
              TestAnnotation
          );
          expect(instance.positional, true);
        });

        test('an integer literal', () {
          TestAnnotation instance = instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation(1)\nvar a;'),
              TestAnnotation
          );
          expect(instance.positional, 1);
        });

        test('a null literal', () {
          TestAnnotation instance = instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation(null)\nvar a;'),
              TestAnnotation
          );
          expect(instance.positional, null);
        });
      });

      group('throws when an annotation parameter value is specified as an unsupported value:', () {
        test('a constant expression', () {
          expect(() => instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation(const [])\nvar a;'),
              TestAnnotation
          ), throwsA(startsWith('Unsupported expression: Must be a string, boolean, integer, or null literal.')));
        });

        test('an interpolated String', () {
          expect(() => instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation("\$someVariable")\nvar a;'),
              TestAnnotation
          ), throwsA(startsWith('Unsupported expression: Must not be an interpolated string.')));
        });

        test('an identifier', () {
          expect(() => instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation(someIdentifier)\nvar a;'),
              TestAnnotation
          ), throwsA(startsWith('Unsupported expression: Must be a string, boolean, integer, or null literal.')));
        });

        group('(except when `onUnsupportedArgument` is specified)', () {
          test('positional parameter', () {
            Expression unsupportedArgument;

            TestAnnotation instance = instantiateAnnotation(
                parseAndGetSingleMember('@TestAnnotation(const [])\nvar a;'),
                TestAnnotation,
                onUnsupportedArgument: (Expression expression) {
                  unsupportedArgument = expression;
                  return 'value to be passed to constructor instead';
                }
            );

            expect(unsupportedArgument, const isInstanceOf<Expression>());
            expect(instance.positional, equals('value to be passed to constructor instead'),
                reason: 'should have passed the return value of `onUnsupportedArgument` to the constructor');
          });

          test('named parameter', () {
            Expression unsupportedArgument;

            TestAnnotation instance = instantiateAnnotation(
                parseAndGetSingleMember('@TestAnnotation.namedConstructor(namedConstructorOnly: const [])\nvar a;'),
                TestAnnotation,
                onUnsupportedArgument: (Expression expression) {
                  unsupportedArgument = expression;
                  return 'value to be passed to constructor instead';
                }
            );

            expect(unsupportedArgument, const isInstanceOf<NamedExpression>());
            expect((unsupportedArgument as NamedExpression).name.label.name, equals('namedConstructorOnly'));
            expect(instance.namedConstructorOnly, equals('value to be passed to constructor instead'),
                reason: 'should have passed the return value of `onUnsupportedArgument` to the constructor');
          });
        });
      });

      test('instantiates an annotation with both named and positional parameters', () {
        TestAnnotation instance = instantiateAnnotation(
            parseAndGetSingleMember('@TestAnnotation(1, named: 2)\nvar a;'),
            TestAnnotation
        );
        expect(instance.positional, 1);
        expect(instance.named, 2);
      });

      test('instantiates an annotation using a named constructor', () {
        TestAnnotation instance = instantiateAnnotation(
            parseAndGetSingleMember('@TestAnnotation.namedConstructor(namedConstructorOnly: true)\nvar a;'),
            TestAnnotation
        );
        expect(instance.namedConstructorOnly, true);
      });

      test('throws if the annotation cannot be constructed', () {
        expect(() => instantiateAnnotation(
            parseAndGetSingleMember('@TestAnnotation(1, 2, 3, 4, "way more parameters than were declared")\nvar a;'),
            TestAnnotation
        ), throwsA(startsWith('Unable to instantiate annotation')));
      });

      test('throws if the annotation is not used as a constructor', () {
        expect(() => instantiateAnnotation(
            parseAndGetSingleMember('@TestAnnotation\nvar a;'),
            TestAnnotation
        ), throwsA(startsWith('Annotation not invocation of constructor')));
      });

      test('returns null when the member is not annotated', () {
        expect(instantiateAnnotation(
            parseAndGetSingleMember('var a;'),
            TestAnnotation
        ), isNull);
      });

      test('returns null when the member has only non-matching annotations', () {
        expect(instantiateAnnotation(
            parseAndGetSingleMember('@NonexistantAnnotation\nvar a;'),
            TestAnnotation
        ), isNull);
      });

      test('returns null when the member has no annotations', () {
        expect(instantiateAnnotation(
            parseAndGetSingleMember('var a;'),
            TestAnnotation
        ), isNull);
      });
    });

    group('NodeWithMeta', () {
      test('instantiates and provides access to an annotation for a given node', () {
        var member = parseAndGetSingleMember('@TestAnnotation("hello")\nvar a;');
        var nodeWithMeta = new NodeWithMeta<TopLevelVariableDeclaration, TestAnnotation>(member);

        expect(nodeWithMeta.node, same(member));
        expect(nodeWithMeta.metaNode, isNotNull);
        expect(nodeWithMeta.metaNode.name.name, 'TestAnnotation');
        expect(nodeWithMeta.meta, isNotNull);
        expect(nodeWithMeta.meta.positional, 'hello');
      });

      test('partially instantiates an "incomplete" annotation', () {
        var member = parseAndGetSingleMember('@TestAnnotation(someIdentifier, named: "hello")\nvar a;');
        var nodeWithMeta = new NodeWithMeta<TopLevelVariableDeclaration, TestAnnotation>(member);

        expect(nodeWithMeta.node, same(member));
        expect(nodeWithMeta.metaNode, isNotNull);
        expect(nodeWithMeta.metaNode.name.name, 'TestAnnotation');

        expect(nodeWithMeta.isIncomplete, isTrue);
        expect(nodeWithMeta.unsupportedArguments, hasLength(1));
        expect(() => nodeWithMeta.meta, throwsStateError);

        expect(nodeWithMeta.potentiallyIncompleteMeta, isNotNull,
            reason: 'should still have attempted to instantiate the incomplete annotation');
        expect(nodeWithMeta.potentiallyIncompleteMeta.named, equals('hello'),
            reason: 'should still have passed the supported argument');
        expect(nodeWithMeta.potentiallyIncompleteMeta.positional, isNull,
            reason: 'should have used null for unsupported argument');
      });

      test('gracefully handles a node without an annotation', () {
        var member = parseAndGetSingleMember('var a;');
        var nodeWithMeta = new NodeWithMeta<TopLevelVariableDeclaration, TestAnnotation>(member);

        expect(nodeWithMeta.node, same(member));
        expect(nodeWithMeta.metaNode, isNull);
        expect(nodeWithMeta.meta, isNull);
      });
    });
  });
}


class TestAnnotation {
  final positional;
  final named;
  final namedConstructorOnly;
  const TestAnnotation(this.positional, {this.named}) : namedConstructorOnly = null;
  const TestAnnotation.namedConstructor({this.namedConstructorOnly}) : positional = null, named = null;
}
