@TestOn('vm')
library impl_generation_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart';
import 'package:web_skin_dart/src/transformer/impl_generation.dart';
import 'package:web_skin_dart/src/transformer/source_file_helpers.dart';

main() {
  group('ImplGenerator', () {
    ImplGenerator implGenerator;

    MockTransformLogger logger;
    SourceFile sourceFile;
    TransformedSourceFile transformedFile;
    CompilationUnit unit;
    ParsedDeclarations declarations;

    void setUpAndParse(String source) {
      logger = new MockTransformLogger();

      sourceFile = new SourceFile(source);
      transformedFile = new TransformedSourceFile(sourceFile);

      unit = parseCompilationUnit(source);
      declarations = new ParsedDeclarations(unit, sourceFile, logger);
      implGenerator = new ImplGenerator(logger, transformedFile);
    }

    void setUpAndGenerate(String source) {
      setUpAndParse(source);

      implGenerator = new ImplGenerator(logger, transformedFile);
      implGenerator.generate(declarations);
    }

    void verifyNoErrorLogs() {
      // Check all permutations of optional parameters being specified
      // since they look like different calls to Mockito.
      verifyNever(logger.warning(any));
      verifyNever(logger.warning(any, span: any));
      verifyNever(logger.warning(any, asset: any));
      verifyNever(logger.warning(any, span: any, asset: any));
      verifyNever(logger.error(any));
      verifyNever(logger.error(any, span: any));
      verifyNever(logger.error(any, asset: any));
      verifyNever(logger.error(any, span: any, asset: any));

      expect(declarations.hasErrors, isFalse);
    }

    void verifyTransformedSourceIsValid() {
      var transformedSource = transformedFile.getTransformedText();

      expect(() {
        parseCompilationUnit(transformedSource);
      }, isNot(throws), reason: 'transformed source should parse without errors:\n$transformedSource');
    }

    group('generates an implementation that parses correctly, preserving line numbers', () {
      void preservedLineNumbersTest(String source) {
        var lines = source.split('\n');
        for (int i = 0; i < lines.length; i++) {
          lines[i] = '/* line $i start */${lines[i]}';
        }
        String numberedSource = lines.join('\n');

        setUpAndParse(numberedSource);

        implGenerator.generate(declarations);

        String transformedSource = transformedFile.getTransformedText();
        var transformedLines = transformedSource.split('\n');
        for (int i = 0; i < lines.length; i++) {
          expect(transformedLines[i], startsWith('/* line $i start */'));
        }
      }

      tearDown(() {
        // Verify that there were no errors other than the ones we explicitly verified.
        verifyNoErrorLogs();

        verifyTransformedSourceIsValid();
      });

      test('stateful components', () {
        preservedLineNumbersTest('''
          @Factory()
          UiFactory<FooProps> Foo;

          @Props()
          class FooProps {
            var bar;
            var baz;
          }

          @State()
          class FooState {
            var bar;
            var baz;
          }

          @Component()
          class FooComponent {
            render() {
              return null;
            }
          }
        ''');
      });

      group('component', () {
        test('without extends/with/implements clause', () {
          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent {
              render() => null;
            }
          ''');
        });

        test('with extends clause', () {
          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent extends Bar {
              render() => null;
            }
          ''');

          expect(transformedFile.getTransformedText(), contains('extends Bar'),
              reason: 'should preserve existing inheritance');
        });

        test('with extends/with clauses', () {
          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent extends Bar with Baz {
              render() => null;
            }
          ''');

          expect(transformedFile.getTransformedText(), contains('extends Bar with Baz'),
              reason: 'should preserve existing inheritance');
        });

        test('with extends/with clauses (multiple mixins)', () {
          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent extends Bar with Baz, Qux {
              render() => null;
            }
          ''');

          expect(transformedFile.getTransformedText(), contains('extends Bar with Baz, Qux'),
              reason: 'should preserve existing inheritance');
        });

        test('with extends/with clauses (multiple mixins, newlines)', () {
          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent
                extends Bar
                with Baz, Qux {
              render() => null;
            }
          ''');
        });

        test('with implements clause', () {
          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent implements Quux {
              render() => null;
            }
          ''');

          expect(transformedFile.getTransformedText(), contains('implements Quux'),
              reason: 'should preserve existing inheritance');
        });

        test('with extends/with/implements clauses', () {
          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent extends Bar with Baz, Qux implements Quux {
              render() => null;
            }
          ''');

          expect(transformedFile.getTransformedText(), contains('extends Bar with Baz, Qux'),
              reason: 'should preserve existing inheritance');

          expect(transformedFile.getTransformedText(), contains('implements Quux'),
              reason: 'should preserve existing inheritance');
        });

        group('that subtypes another component, referencing the component class via', () {
          test('a simple identifier', () {
            preservedLineNumbersTest('''
              @Factory()
              UiFactory<FooProps> Foo;

              @Props()
              class FooProps {}

              @Component(subtypeOf: BarComponent)
              class FooComponent {}
            ''');

            print(transformedFile.getTransformedText());
            expect(transformedFile.getTransformedText(), contains('parentType: \$BarComponentFactory'));
          });

          test('a prefixed identifier', () {
            preservedLineNumbersTest('''
              @Factory()
              UiFactory<FooProps> Foo;

              @Props()
              class FooProps {}

              @Component(subtypeOf: baz.BarComponent)
              class FooComponent {}
            ''');

            print(transformedFile.getTransformedText());
            expect(transformedFile.getTransformedText(), contains('parentType: baz.\$BarComponentFactory'));
          });
        });
      });

      test('props mixins', () {
        preservedLineNumbersTest('''
          @PropsMixin() class FooPropsMixin {
            Map get props;

            var bar;
            var baz;
          }
        ''');
      });

      test('state mixins', () {
        preservedLineNumbersTest('''
          @StateMixin() class FooStateMixin {
            Map get state;

            var bar;
            var baz;
          }
        ''');
      });

      test('abstract props classes', () {
        preservedLineNumbersTest('''
          @AbstractProps() class AbstractFooProps {
            var bar;
            var baz;
          }
        ''');
      });

      test('abstract state classes', () {
        preservedLineNumbersTest('''
          @AbstractState() class AbstractFooState {
            var bar;
            var baz;
          }
        ''');
      });

      group('accessors', () {
        test('that are absent', () {
          preservedLineNumbersTest('''
            @AbstractProps()
            class AbstractFooProps {}
          ''');
        });

        test('with doc comments and annotations', () {
          preservedLineNumbersTest('''
            @AbstractProps()
            class AbstractFooProps {
              /// Doc comment
              @Annotation()
              var bar;
            }
          ''');
        });

        group('defined using comma-separated variables', () {
          test('on the same line', () {
            preservedLineNumbersTest('''
              @AbstractProps()
              class AbstractFooProps {
                var bar, baz, qux;
              }
            ''');
          });

          test('on separate lines', () {
            String numberedSource = '''
              /* line 0 start */@AbstractProps()
              /* line 1 start */class AbstractFooProps {
              /* line 2 start */  var bar,
              /* line 3 start */      baz,
              /* line 4 start */      qux;
              /* line 5 start */}
            ''';

            setUpAndParse(numberedSource);

            implGenerator.generate(declarations);

            String transformedSource = transformedFile.getTransformedText();
            var transformedLines = transformedSource.split('\n');

            expect(transformedLines[0].trimLeft(), startsWith('/* line 0 start */'));
            expect(transformedLines[1].trimLeft(), startsWith('/* line 1 start */'));
            expect(transformedLines[2].trimLeft(), startsWith('/* line 2 start */'));
            // The leading comments on lines 3 and 4 get stripped out since comments
            // are not currently preserved for comma-separated accessors.
            // TODO: Uncomment these tests after comment preservation is added.
//            expect(transformedLines[3].trimLeft(), startsWith('/* line 3 start */'));
//            expect(transformedLines[4].trimLeft(), startsWith('/* line 4 start */'));
            expect(transformedLines[5].trimLeft(), startsWith('/* line 5 start */'));
          });
        });
      });
    });

    group('logs an error when', () {
      group('a factory is', () {
        const String restOfComponent = '''
          @Props()
          class FooProps {}

          @Component()
          class FooComponent {}
        ''';

        test('declared using multiple variables', () {
          setUpAndGenerate('''
            @Factory()
            UiFactory<FooProps> Foo, Bar;

            $restOfComponent
          ''');

          verify(logger.error('Factory declarations must a single variable.', span: any));
        });

        test('declared with an initializer', () {
          setUpAndGenerate('''
            @Factory()
            UiFactory<FooProps> Foo = null;

            $restOfComponent
          ''');

          verify(logger.error('Factory variables are stubs for the generated factories, and should not have initializers.', span: any));
        });
      });

      group('a component class', () {
        test('subtypes itself', () {
          setUpAndGenerate('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component(subtypeOf: FooComponent)
            class FooComponent {}
          ''');

          verify(logger.error('A component cannot be a subtype of itself.', span: any));
        });
      });

      group('a props mixin is', () {
        const String expectedPropsGetterError =
            'Props mixin classes must declare an abstract props getter `Map get props;` '
            'so that they can be statically analyzed properly.';

        test('declared without an abstract `props` getter', () {
          setUpAndGenerate('''
            @PropsMixin()
            class FooPropsMixin {
              var bar;
            }
          ''');
          verify(logger.error(expectedPropsGetterError, span: any));
        });

        group('declared with a malformed `props` getter:', () {
          test('a field', () {
            setUpAndGenerate('''
              @PropsMixin()
              class FooPropsMixin {
                Map props;

                var bar;
              }
            ''');
            verify(logger.error(expectedPropsGetterError, span: any));
          });

          test('a getter of the wrong type', () {
            setUpAndGenerate('''
              @PropsMixin()
              class FooPropsMixin {
                NotAMap get props;

                var bar;
              }
            ''');
            verify(logger.error(expectedPropsGetterError, span: any));
          });

          test('an untyped getter', () {
            setUpAndGenerate('''
              @PropsMixin()
              class FooPropsMixin {
                get props;

                var bar;
              }
            ''');
            verify(logger.error(expectedPropsGetterError, span: any));
          });

          test('a concrete getter', () {
            setUpAndGenerate('''
              @PropsMixin()
              class FooPropsMixin {
                Map get props => null;

                var bar;
              }
            ''');
            verify(logger.error(expectedPropsGetterError, span: any));
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
            class FooStateMixin {
              var bar;
            }
          ''');
          verify(logger.error(expectedStateGetterError, span: any));
        });

        group('declared with a malformed `state` getter:', () {
          test('a field', () {
            setUpAndGenerate('''
              @StateMixin()
              class FooStateMixin {
                Map state;

                var bar;
              }
            ''');
            verify(logger.error(expectedStateGetterError, span: any));
          });

          test('a getter of the wrong type', () {
            setUpAndGenerate('''
              @StateMixin()
              class FooStateMixin {
                NotAMap get state;

                var bar;
              }
            ''');
            verify(logger.error(expectedStateGetterError, span: any));
          });

          test('an untyped getter', () {
            setUpAndGenerate('''
              @StateMixin()
              class FooStateMixin {
                get state;

                var bar;
              }
            ''');
            verify(logger.error(expectedStateGetterError, span: any));
          });

          test('a concrete getter', () {
            setUpAndGenerate('''
              @StateMixin()
              class FooStateMixin {
                Map get state => null;

                var bar;
              }
            ''');
            verify(logger.error(expectedStateGetterError, span: any));
          });
        });
      });

      test('accessors are declared as fields with initializers', () {
        setUpAndGenerate('''
          @AbstractProps()
          class AbstractFooProps {
            var bar = null;
          }
        ''');
        verify(logger.error('Fields are stubs for generated setters/getters and should not have initializers.', span: any));
      });
    });

    group('logs a warning when', () {
      tearDown(() {
        verifyTransformedSourceIsValid();
      });

      group('comma-separated variables are declared', () {
        const String expectedCommaSeparatedWarning =
            'Note: accessors declared as comma-separated variables will not all be generated '
            'with the original doc comments and annotations; only the first variable will.';

        test('with doc comments', () {
          setUpAndGenerate('''
            @AbstractProps()
            class AbstractFooProps {
              /// Doc comment
              var bar, baz;
            }
          ''');
          verify(logger.warning(expectedCommaSeparatedWarning, span: any));
        });

        test('with annotations', () {
          setUpAndGenerate('''
            @AbstractProps()
            class AbstractFooProps {
              @Annotation()
              var bar, baz;
            }
          ''');
          verify(logger.warning(expectedCommaSeparatedWarning, span: any));
        });
      });
    });

    test('getComponentFactoryName() throws an error when its argument is null', () {
      expect(() => ImplGenerator.getComponentFactoryName(null), throwsArgumentError);
    });
  });
}


class MockTransformLogger extends Mock implements TransformLogger {
  @override
  noSuchMethod(i) => super.noSuchMethod(i);
}
