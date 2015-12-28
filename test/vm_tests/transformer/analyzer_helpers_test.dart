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
          ), throws);
        });

        test('an interpolated String', () {
          expect(() => instantiateAnnotation(
              parseAndGetSingleMember('@TestAnnotation("\$someVariable")\nvar a;'),
              TestAnnotation
          ), throws);
        });

        test('a constant variable', () {
          expect(() => instantiateAnnotation(
              parseAndGetSingleMember('const int one = 1;\n@TestAnnotation(one)\nvar a;'),
              TestAnnotation
          ), throws);
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
