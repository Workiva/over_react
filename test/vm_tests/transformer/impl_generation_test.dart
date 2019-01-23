// Copyright 2016 Workiva Inc.
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
library impl_generation_test;

import 'dart:isolate';

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:mockito/mockito.dart';
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:over_react/src/builder/generation/impl_generation.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import './util.dart';

main() {
  group('ImplGenerator', () {
    ImplGenerator implGenerator;

    MockLogger logger;
    SourceFile sourceFile;
    CompilationUnit unit;
    ParsedDeclarations declarations;

    tearDown(() {
      implGenerator = null;
    });

    void setUpAndParse(String source) {
      logger = new MockLogger();

      sourceFile = new SourceFile.fromString(source);

      unit = parseCompilationUnit(source);
      declarations = new ParsedDeclarations(unit, sourceFile, logger);
      implGenerator = new ImplGenerator(logger, sourceFile);
    }

    void setUpAndGenerate(String source) {
      setUpAndParse(source);

      implGenerator = new ImplGenerator(logger, sourceFile);
      implGenerator.generate(declarations);
    }

    void verifyNoErrorLogs() {
      verifyNever(logger.warning(any));
      verifyNever(logger.severe(any));

      expect(declarations.hasErrors, isFalse);
    }

    void verifyImplGenerationIsValid() {
      var buildOutput = implGenerator.outputContentsBuffer.toString();

      expect(() {
        parseCompilationUnit(buildOutput);
      }, returnsNormally, reason: 'transformed source should parse without errors:\n');
    }

    void generateFromSource(String source) {
      setUpAndParse(source);
      implGenerator.generate(declarations);
    }

    group('generates an implementation that parses correctly', () {
      tearDown(() {
        // Verify that there were no errors other than the ones we explicitly verified.
        verifyNoErrorLogs();
        verifyImplGenerationIsValid();
      });

      test('stateful components', () {
        generateFromSource(OverReactSrc.state().source);
      });

      test('component', () {
        generateFromSource(OverReactSrc.props().source);
      });

      group('that subtypes another component, referencing the component class via', () {
        test('a simple identifier', () {
          generateFromSource(OverReactSrc.props(componentAnnotationArg: 'subtypeOf: BarComponent').source);
          expect(implGenerator.outputContentsBuffer.toString(), contains('parentType: \$BarComponentFactory'));
        });

        test('a prefixed identifier', () {
          generateFromSource(OverReactSrc.props(componentAnnotationArg: 'subtypeOf: baz.BarComponent').source);
          expect(implGenerator.outputContentsBuffer.toString(), contains('parentType: baz.\$BarComponentFactory'));
        });
      });

      group('for props mixins', () {
        test('without type parameters', () {
          generateFromSource(OverReactSrc.propsMixin().source);
          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooPropsMixin'));
        });

        test('with type parameters', () {
          generateFromSource(OverReactSrc.propsMixin(typeParameters: true).source);
          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooPropsMixin<T extends Iterable, U> implements FooPropsMixin<T, U> {'));
        });
      });

      group('and includes concrete accessors class for state mixins', () {
        test('without type parameters', () {
          generateFromSource(OverReactSrc.stateMixin().source);
          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooStateMixin'));
        });

        test('with type parameters', () {
          generateFromSource(OverReactSrc.stateMixin(typeParameters: true).source);
          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooStateMixin<T extends Iterable, U> implements FooStateMixin<T, U> {'));
        });
      });

      group('and includes concrete accessors class for abstract props classes', () {
        test('without type parameters', () {
          final sourceContainer = OverReactSrc.abstractProps();
          generateFromSource(sourceContainer.source);
          expect(implGenerator.outputContentsBuffer.toString(), contains(
              'abstract class _\$${sourceContainer
                  .propsClassName}AccessorsMixin implements _\$${sourceContainer.propsClassName} {'));
        });

        test('with type parameters', () {
          final sourceContainer = OverReactSrc.abstractProps();
          generateFromSource(sourceContainer.source);
          expect(implGenerator.outputContentsBuffer.toString(), contains(
              'abstract class _\$${sourceContainer
                  .propsClassName}AccessorsMixin${sourceContainer.typeParamSrc} implements _\$${sourceContainer.propsClassName}${sourceContainer.typeParamSrcWithoutBounds} {'));
        });
      });

      test('for abstract state classes', () {
        generateFromSource(OverReactSrc.abstractState().source);
      });

      test('for covariant keyword', () {
        generateFromSource(OverReactSrc.abstractProps(body: 'covariant String foo;').source);
        expect(implGenerator.outputContentsBuffer.toString(), contains('String get foo => props[_\$key__foo___\$AbstractFooProps];'));
        expect(implGenerator.outputContentsBuffer.toString(), contains('set foo(covariant String value) => props[_\$key__foo___\$AbstractFooProps] = value;'));
      });

      group('accessors', () {
        test('that are absent', () {
          generateFromSource(OverReactSrc.abstractProps().source);
        });

        test('with doc comments and annotations', () {
          var body = '''/// Doc comment
              @Annotation()
              var bar;''';
          generateFromSource(OverReactSrc.abstractProps(body: body).source);
        });

        group('defined using comma-separated variables', () {
          test('on the same line', () {
            generateFromSource(OverReactSrc.abstractProps(body: 'var bar, baz, qux;').source);
          });
        });
      });

      group('static meta field', () {
        void testStaticMetaField(String testName, OverReactSrc sourceContainer) {
          test(testName, () {
            setUpAndGenerate(sourceContainer.source);
            final accessorsClassName = testName.contains('mixin')
                ? '\$${sourceContainer.propsOrStateOrMixinClassName}'
                : '_\$${sourceContainer
                .propsOrStateOrMixinClassName}AccessorsMixin';
            final propsOrStateOrMixinClassName = sourceContainer.propsOrStateOrMixinClassName;
            final annotatedPropsOrStateOrMixinClassName = testName.contains('mixin') ? propsOrStateOrMixinClassName : '_\$$propsOrStateOrMixinClassName';
            final expectedAccessorsMixinClass = 'abstract class $accessorsClassName implements $annotatedPropsOrStateOrMixinClassName';
            final metaStructName = sourceContainer.metaStructName(sourceContainer.annotation);
            final expectedMetaForInstance = (new StringBuffer()
              ..writeln('const $metaStructName _\$metaFor$propsOrStateOrMixinClassName = const $metaStructName(')
              ..writeln('  fields: $accessorsClassName.${sourceContainer.constantListName},')
              ..writeln('  keys: $accessorsClassName.${sourceContainer.keyListName},')
              ..writeln(');')
            ).toString();

            expect(implGenerator.outputContentsBuffer.toString(), contains(expectedAccessorsMixinClass));
            expect(implGenerator.outputContentsBuffer.toString(), contains(expectedMetaForInstance));
          });
        }

        testStaticMetaField('props class', OverReactSrc.props());
        testStaticMetaField('state class', OverReactSrc.state());
        testStaticMetaField('props mixin', OverReactSrc.propsMixin());
        testStaticMetaField('state mixin', OverReactSrc.stateMixin());
        testStaticMetaField('abstract props', OverReactSrc.abstractProps());
        testStaticMetaField('abstract state', OverReactSrc.abstractState());
      });
    });

    group('logs an error when', () {
      group('a component class', () {
        test('subtypes itself', () {
          setUpAndGenerate(OverReactSrc.props(componentAnnotationArg: 'subtypeOf: FooComponent').source);
          verify(logger.severe('A component cannot be a subtype of itself.'));
        });
      });

      group('a props mixin is', () {
        const String expectedPropsGetterError =
            'Props mixin classes must declare an abstract props getter `Map get props;` '
            'so that they can be statically analyzed properly.';

        test('declared without an abstract `props` getter', () {
          setUpAndGenerate('''
            @PropsMixin()
            abstract class FooPropsMixin {
              var bar;
            }
          ''');
          verify(logger.severe(expectedPropsGetterError));
        });

        group('declared with a malformed `props` getter:', () {
          test('a field', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class FooPropsMixin {
                Map props;

                var bar;
              }
            ''');
            verify(logger.severe(expectedPropsGetterError));
          });

          test('a getter of the wrong type', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class FooPropsMixin {
                NotAMap get props;

                var bar;
              }
            ''');
            verify(logger.severe(expectedPropsGetterError));
          });

          test('an untyped getter', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class FooPropsMixin {
                get props;

                var bar;
              }
            ''');
            verify(logger.severe(expectedPropsGetterError));
          });

          test('a concrete getter', () {
            setUpAndGenerate('''
              @PropsMixin()
              abstract class FooPropsMixin {
                Map get props => null;

                var bar;
              }
            ''');
            verify(logger.severe(expectedPropsGetterError));
          });
        });
      });

      group('a state mixin is', () {
        const String expectedStateGetterError =
            'State mixin classes must declare an abstract state getter `Map get state;` '
            'so that they can be statically analyzed properly.';

        test('declared without an abstract `state` getter', () {
          setUpAndGenerate('''
            @StateMixin()
            abstract class FooStateMixin {
              var bar;
            }
          ''');
          verify(logger.severe(expectedStateGetterError));
        });

        group('declared with a malformed `state` getter:', () {
          test('a field', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class FooStateMixin {
                Map state;

                var bar;
              }
            ''');
            verify(logger.severe(expectedStateGetterError));
          });

          test('a getter of the wrong type', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class FooStateMixin {
                NotAMap get state;

                var bar;
              }
            ''');
            verify(logger.severe(expectedStateGetterError));
          });

          test('an untyped getter', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class FooStateMixin {
                get state;

                var bar;
              }
            ''');
            verify(logger.severe(expectedStateGetterError));
          });

          test('a concrete getter', () {
            setUpAndGenerate('''
              @StateMixin()
              abstract class FooStateMixin {
                Map get state => null;

                var bar;
              }
            ''');
            verify(logger.severe(expectedStateGetterError));
          });
        });
      });

      test('accessors are declared as fields with initializers', () {
        setUpAndGenerate(OverReactSrc.abstractProps(body: 'var bar = null;').source);
        verify(logger.severe('Fields are stubs for generated setters/getters and should not have initializers.'));
      });

      group('accessors have', () {
        const expectedAccessorErrorMessage = '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
            'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.';

        test('the Accessor and requiredProp annotation', () {
          var body = '''@Accessor()
              @requiredProp
              var bar;''';
          setUpAndGenerate(OverReactSrc.abstractProps(body: body).source);
          verify(logger.severe(expectedAccessorErrorMessage));
        });

        test('the Accessor and nullableRequiredProp annotation', () {
          var body = '''@Accessor()
              @nullableRequiredProp
              var bar;''';
          setUpAndGenerate(OverReactSrc.abstractProps(body: body).source);
          verify(logger.severe(expectedAccessorErrorMessage));
        });

        test('the requiredProp and nullableRequiredProp annotation', () {
          var body = '''@requiredProp
              @nullableRequiredProp
              var bar;''';
          setUpAndGenerate(OverReactSrc.abstractProps(body: body).source);
          verify(logger.severe(expectedAccessorErrorMessage));
        });
      });
    });

    group('logs a warning when', () {
      tearDown(() {
        verifyImplGenerationIsValid();
      });

      group('a Component', () {
        test('implements typedPropsFactory', () {
          setUpAndGenerate(OverReactSrc.props(componentBody: 'typedPropsFactory(Map backingMap) => {};').source);
          verify(logger.warning('Components should not add their own implementions of typedPropsFactory or typedStateFactory.'));
        });

        test('implements typedStateFactory', () {
          setUpAndGenerate(OverReactSrc.props(componentBody: 'typedStateFactory(Map backingMap) => {};').source);
          verify(logger.warning('Components should not add their own implementions of typedPropsFactory or typedStateFactory.'));
        });
      });

      group('comma-separated variables are declared', () {
        const String expectedCommaSeparatedWarning =
            'Note: accessors declared as comma-separated variables will not all be generated '
            'with the original doc comments and annotations; only the first variable will.';

        test('with doc comments', () {
          var body = '''/// Doc comment
              var bar, baz;''';
          setUpAndGenerate(OverReactSrc.abstractProps(body: body).source);
          verify(logger.warning(expectedCommaSeparatedWarning));
        });

        test('with annotations', () {
          var body = '''@Annotation()
            var bar, baz;''';
          setUpAndGenerate(OverReactSrc.abstractProps(body: body).source);
          verify(logger.warning(expectedCommaSeparatedWarning));
        });
      });
    });
  });
}

