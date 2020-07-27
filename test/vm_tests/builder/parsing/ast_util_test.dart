// Copyright 2020 Workiva Inc.
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

@TestOn('vm')
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/builder/parsing/ast_util.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import '../ast_test_util.dart';

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

      test('hasConfig', () {
        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          final Foo = uiFunction<FooPropsMixin>(
            (props) => Dom.div()(), 
            \$FooConfig, // ignore: undefined_identifier
          );
        ''')).hasGeneratedConfigArg, true);

        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          final Foo = uiFunction<UiProps>(
            (props) => Dom.div()(), 
            FunctionComponentConfig(),
          );
        ''')).hasGeneratedConfigArg, false);

        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          final Foo = someHOC(uiFunction<FooPropsMixin>(
            (props) => Dom.div()(), 
            \$FooConfig, // ignore: undefined_identifier
          ));
        ''')).hasGeneratedConfigArg, true);

        expect(InitializerHelperTopLevel(parseAndGetSingleWithType('''
          final Foo = uiFunction<FooPropsMixin>(
            (props) => Dom.div()(), 
            FunctionComponentConfig(
              propsFactory: PropsFactory.fromUiFactory(Bar),
            ),
          );
        ''')).hasGeneratedConfigArg, false);
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
          var annotatedNode;
      ''');

      AnnotatedNode annotated() => parseAndGetSingleWithType<TopLevelVariableDeclaration>('''
          @foo
          @Bar()
          @Baz.constructorName()
          @namespace.Qux()
          @namespace.Quux.constructorName()
          @_PrivateClass.constructorName()
          @Something._privateConstructorName()
          var annotatedNode;
      ''');

      test('getAnnotationWithName', () {
        expect(MetadataHelper(unannotated()).getAnnotationWithName('foo')?.toSource(), isNull);
        expect(MetadataHelper(annotated()).getAnnotationWithName('foo')?.toSource(), '@foo');
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
        expect(MetadataHelper(unannotated()).getAnnotationWithNames({'foo'})?.toSource(), isNull);
        expect(MetadataHelper(annotated()).getAnnotationWithNames({'foo'})?.toSource(), '@foo');
        expect(MetadataHelper(annotated()).getAnnotationWithNames({'notFoo', 'Bar'})?.toSource(),
            '@Bar()');
        expect(MetadataHelper(annotated()).getAnnotationWithNames({'notFoo', 'NotBar'})?.toSource(),
            isNull);
      });

      test('hasAnnotationWithName', () {
        expect(MetadataHelper(unannotated()).hasAnnotationWithName('foo'), isFalse);
        expect(MetadataHelper(annotated()).hasAnnotationWithName('foo'), isTrue);
        expect(MetadataHelper(annotated()).hasAnnotationWithName('notFoo'), isFalse);
      });

      test('hasAnnotationWithNames', () {
        expect(MetadataHelper(unannotated()).hasAnnotationWithNames({'foo'}), isFalse);
        expect(MetadataHelper(annotated()).hasAnnotationWithNames({'foo'}), isTrue);
        expect(MetadataHelper(annotated()).hasAnnotationWithNames({'notFoo', 'Bar'}), isTrue);
        expect(MetadataHelper(annotated()).hasAnnotationWithNames({'notFoo', 'NotBar'}), isFalse);
      });
    });

    group('SourceFileSpanHelper', () {
      group('spanFor', () {
        SourceFile sourceFile;

        setUpAll(() {
          // Offsets of characters, for convenience
          //              012345678
          const source = 'main() {}';
          sourceFile = SourceFile.fromString(source);
        });

        test('AST Nodes', () {
          final node = parseAndGetSingleWithType<FunctionDeclaration>(sourceFile.getText(0)).name;
          final span = sourceFile.spanFor(node);
          expect(span.start.offset, 0);
          expect(span.length, 4);
        });

        test('tokens', () {
          final token = parseAndGetSingleWithType<FunctionDeclaration>(sourceFile.getText(0))
              .functionExpression
              .parameters
              .leftParenthesis;
          final span = sourceFile.spanFor(token);
          expect(span.start.offset, 4);
          expect(span.length, 1);
        });
      });
    });

    test('onlyImplementsThings', () {
      ClassishDeclaration parseAndGetClassish(String source) =>
          parseAndGetSingleWithType<NamedCompilationUnitMember>(source).asClassish();

      bool _onlyImplementsThings(String source) =>
          onlyImplementsThings(parseAndGetClassish(source));

      expect(_onlyImplementsThings('class Foo {}'), isFalse);
      expect(_onlyImplementsThings('class Foo extends Bar {}'), isFalse);
      expect(_onlyImplementsThings('class Foo extends Bar implements Baz {}'), isFalse);

      expect(_onlyImplementsThings('class Foo = Bar with Baz;'), isFalse);
      expect(_onlyImplementsThings('class Foo = Bar with Bar implements Qux;'), isFalse);

      expect(_onlyImplementsThings('mixin Foo {}'), isFalse);

      expect(_onlyImplementsThings('class Foo implements Baz {}'), isTrue);
      expect(_onlyImplementsThings('class Foo implements Bar, Baz {}'), isTrue);

      expect(_onlyImplementsThings('class Foo implements Bar { static var field; }'), isTrue);
      expect(_onlyImplementsThings('class Foo implements Bar { static method() {} }'), isTrue);
      expect(_onlyImplementsThings('class Foo implements Bar { var field; }'), isFalse);
      expect(_onlyImplementsThings('class Foo implements Bar { method() {} }'), isFalse);

      expect(_onlyImplementsThings('mixin Foo implements Baz {}'), isTrue);
      expect(_onlyImplementsThings('mixin Foo implements Bar, Baz {}'), isTrue);
      expect(_onlyImplementsThings('mixin Foo on Bar {}'), isTrue);
      expect(_onlyImplementsThings('mixin Foo on Bar implements Baz {}'), isTrue);
    });

    test('anyDescendantIdentifiers', () {
      Expression parseAndGetInitializer(String source) =>
          parseAndGetSingleWithType<TopLevelVariableDeclaration>(source).firstInitializer;

      bool _anyDescendantIdentifiersInInitializer(String source, bool Function(Identifier) test) =>
          anyDescendantIdentifiers(parseAndGetInitializer(source), test);

      expect(_anyDescendantIdentifiersInInitializer('''
        final directReference = bar;
      ''', (name) => name.name == 'bar'), isTrue);

      expect(_anyDescendantIdentifiersInInitializer('''
        final nestedReference1 = bar.something();
      ''', (name) => name.name == 'bar'), isTrue);

      expect(_anyDescendantIdentifiersInInitializer('''
        final nestedReference2 = someCall(() {
          bar;
        });
      ''', (name) => name.name == 'bar'), isTrue);
      expect(_anyDescendantIdentifiersInInitializer('''
        final nestedReference2 = someCall(() {
          bar;
        });
      ''', (name) => name.name == 'foo'), isFalse);
    });
  });
}
