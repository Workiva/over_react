@TestOn('vm')
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react/src/builder/generation/parsing/ast_util.dart';
import 'package:test/test.dart';

main() {
  group('AST utilities:', () {
    // These extension-based tests make use of the explicit extension
    // "wrapping" syntax to ensure we're testing the right extension.
    //
    // A bonus to this is that it allows type parameters to be inferred
    // and passed into `parseAndGet` utilities.

    group('InitializerHelper', () {
      test('firstInitializer', () {
        expect(InitializerHelper(parseAndGetSingleWithType('''
          var foo = 'bar';
        ''')).firstInitializer, isNotNull);

        expect(InitializerHelper(parseAndGetSingleWithType('''
          var foo;
        ''')).firstInitializer, isNull);
      });

      test('firstVariable', () {
        expect(InitializerHelper(parseAndGetSingleWithType('''
          var foo, bar;
        ''')).firstVariable.name.name, 'foo');

        expect(InitializerHelper(parseAndGetSingleWithType('''
          var foo;
        ''')).firstVariable.name.name, 'foo');
      });
    });

    group('InitializerHelperTopLevel', () {
      test('firstInitializer', () {
        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          var foo = 'bar';
        ''')).firstInitializer, isNotNull);

        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          var foo;
        ''')).firstInitializer, isNull);
      });

      test('firstVariable', () {
        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          var foo, bar;
        ''')).firstVariable.name.name, 'foo');

        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          var foo;
        ''')).firstVariable.name.name, 'foo');
      });
    });

    group('TypeAnnotationNameHelper', () {
      group('typeNameWithoutPrefix', () {
        test('on a named type', () {
          expect(TypeAnnotationNameHelper(parseAndGetSingleWithType('''
            SomeTypeName foo;
          ''')).typeNameWithoutPrefix, 'SomeTypeName');

          expect(TypeAnnotationNameHelper(parseAndGetSingleWithType('''
            foo.SomeTypeName foo;
          ''')).typeNameWithoutPrefix, 'SomeTypeName');
        });

        test('not on a named type', () {
          expect(TypeAnnotationNameHelper(parseAndGetSingleWithType('''
            Function() foo;
          ''')).typeNameWithoutPrefix, isNull);
        });
      });
    });

    group('TypeNameHelper', () {
      test('nameWithoutPrefix', () {
        expect(TypeNameHelper(parseAndGetSingleWithType('''
          SomeTypeName foo;
        ''')).nameWithoutPrefix, 'SomeTypeName');

        expect(TypeNameHelper(parseAndGetSingleWithType('''
          foo.SomeTypeName foo;
        ''')).nameWithoutPrefix, 'SomeTypeName');
      });
    });

    group('NameHelper', () {
      test('nameWithoutPrefix', () {
        expect(NameHelper(parseAndGetFirstWithType('''
          SomeName foo;
        ''')).nameWithoutPrefix, 'SomeName');

        expect(NameHelper(parseAndGetFirstWithType('''
          foo.SomeName foo;
        ''')).nameWithoutPrefix, 'SomeName');
      });
    });

    group('SuperclassConstraint', () {
      test('hasSuperclassConstraint', () {
        expect(SuperclassConstraint(parseAndGetSingleWithType('''
          mixin Foo {}
        ''')).hasSuperclassConstraint('Bar'), isFalse);

        expect(SuperclassConstraint(parseAndGetSingleWithType('''
          mixin Foo on Baz, Qux {}
        ''')).hasSuperclassConstraint('Bar'), isFalse);

        expect(SuperclassConstraint(parseAndGetSingleWithType('''
          mixin Foo implements Bar {}
        ''')).hasSuperclassConstraint('Bar'), isFalse);

        expect(SuperclassConstraint(parseAndGetSingleWithType('''
          mixin Foo on Baz, Qux, Bar {}
        ''')).hasSuperclassConstraint('Bar'), isTrue);
      });
    });

    group('AbstractGetter', () {
      test('hasAbstractGetter', () {
        expect(AbstractGetter(parseAndGetSingleWithType('''
          abstract class Foo {
            String get foo;
          }
        ''')).hasAbstractGetter('String', 'foo'), isTrue);

        expect(AbstractGetter(parseAndGetSingleWithType('''
          abstract class Foo {
            Generic<String> get foo;
          }
        ''')).hasAbstractGetter('Generic<String>', 'foo'), isTrue);

        expect(AbstractGetter(parseAndGetSingleWithType('''
          abstract class Foo {
            String get foo => 'impl';
          }
        ''')).hasAbstractGetter('String', 'foo'), isFalse);

        expect(AbstractGetter(parseAndGetSingleWithType('''
          abstract class Foo {
            WrongType get foo;
          }
        ''')).hasAbstractGetter('String', 'foo'), isFalse);

        expect(AbstractGetter(parseAndGetSingleWithType('''
          abstract class Foo {
            String get wrongName;
          }
        ''')).hasAbstractGetter('String', 'foo'), isFalse);

        expect(AbstractGetter(parseAndGetSingleWithType('''
          abstract class Foo {
            String foo;
          }
        ''')).hasAbstractGetter('String', 'foo'), isFalse);

        expect(AbstractGetter(parseAndGetSingleWithType('''
          abstract class Foo {
            set foo(String value);
          }
        ''')).hasAbstractGetter('String', 'foo'), isFalse);
      });
    });

    group('MetadataHelper', () {
      AnnotatedNode unannotated() => parseAndGetSingleWithType<TopLevelVariableDeclaration>('''
          var foo;
      ''');

      AnnotatedNode annotated() => parseAndGetSingleWithType<TopLevelVariableDeclaration>('''
          @topLevel
          @Bar()
          @Baz.constructorName()
          @namespace.Qux()
          @namespace.Quux.constructorName()
          @_PrivateClass.constructorName()
          @Something._privateConstructorName()
          var foo;
      ''');

      test('getAnnotationWithName', () {
        expect(MetadataHelper(unannotated()).getAnnotationWithName('foo')?.toSource(), isNull);
        expect(
            MetadataHelper(annotated()).getAnnotationWithName('topLevel')?.toSource(), '@topLevel');
        expect(MetadataHelper(annotated()).getAnnotationWithName('Bar')?.toSource(), '@Bar()');
        expect(MetadataHelper(annotated()).getAnnotationWithName('Baz')?.toSource(),
            '@Baz.constructorName()');
        expect(MetadataHelper(annotated()).getAnnotationWithName('Qux')?.toSource(),
            '@namespace.Qux()');
        expect(MetadataHelper(annotated()).getAnnotationWithName('Quux')?.toSource(),
            '@namespace.Quux.constructorName()');
        expect(MetadataHelper(annotated()).getAnnotationWithName('_PrivateClass')?.toSource(),
            '@_PrivateClass.constructorName()');
        expect(MetadataHelper(annotated()).getAnnotationWithName('Something')?.toSource(),
            '@Something._privateConstructorName()');
      });

      test('getAnnotationWithNames', () {
//        expect(MetadataHelper(unannotated()).getAnnotationWithNames(), isTrue);
      });

      test('hasAnnotationWithName', () {
//        expect(MetadataHelper(unannotated()).hasAnnotationWithName(), isTrue);
      });

      test('hasAnnotationWithNames', () {
//        expect(MetadataHelper(unannotated()).hasAnnotationWithNames(), isTrue);
      });
    });

    group('SourceFileSpanHelper', () {});

    group('onlyImplementsThings', () {});

    group('anyDescendantIdentifiers', () {});
  });
}

T parseAndGetSingleWithType<T extends AstNode>(String source) =>
    parseAndGetAllWithType<T>(source).single;

T parseAndGetFirstWithType<T extends AstNode>(String source) =>
    parseAndGetAllWithType<T>(source).first;

List<T> parseAndGetAllWithType<T extends AstNode>(String source) {
  if (T == AstNode || T == dynamic || T == Object) {
    throw ArgumentError(
        'Generic parameter must not be AstNode; was it specified/inferred properly?');
  }

  final result = parseString(content: source, throwIfDiagnostics: false);
  expect(result.errors, isEmpty, reason: 'error parsing source $source');

  final visitor = _ParseAndGetVisitor<T>();
  result.unit.accept(visitor);
  return visitor._matchingNodes;
}

class _ParseAndGetVisitor<T extends AstNode> extends UnifyingAstVisitor<void> {
  final _matchingNodes = <T>[];

  @override
  void visitNode(AstNode node) {
    if (node is T) {
      _matchingNodes.add(node);
    }

    super.visitNode(node);
  }
}
