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
import 'package:logging/logging.dart';
//import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:over_react/src/builder/generation/impl_generation.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';
import 'package:transformer_utils/transformer_utils.dart';

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

    void setUpAndGenerate(String source, {bool shouldFixDdcAbstractAccessors: false}) {
      setUpAndParse(source);

      implGenerator = new ImplGenerator(logger, sourceFile);
//        ..shouldFixDdcAbstractAccessors = shouldFixDdcAbstractAccessors;
      implGenerator.generate(declarations);
    }

    void verifyNoErrorLogs() {
      verifyNever(logger.warning(any));
      verifyNever(logger.severe(any));

      expect(declarations.hasErrors, isFalse);
    }

    void verifyImplGenerationIsValid() {
      // TODO: verify this works for hte builder. Might not be able to parse compilation unit b/c build output is a part file.
      // With the builder, impl_gen outputs the contents to a string buffer,
      // [outputContentsBuffer]. Since this is a separate file which is part of
      // the source file's lib, it likely won't analyze on it
//      var transformedSource = transformedFile.getTransformedText();
      var buildOutput = implGenerator.outputContentsBuffer.toString();

      expect(() {
        parseCompilationUnit(buildOutput);
      }, returnsNormally, reason: 'transformed source should parse without errors:\n$transformedSource');
    }

    group('generates an implementation that parses correctly, preserving line numbers', () {
      void generateFromSource(String source) {
        setUpAndParse(source);

        implGenerator.generate(declarations);
      }

      tearDown(() {
        // Verify that there were no errors other than the ones we explicitly verified.
        verifyNoErrorLogs();

        verifyImplGenerationIsValid();
      });
//
//      test('stateful components', () {
//        generateFromSource('''
//          @Factory()
//          UiFactory<FooProps> Foo;
//
//          @Props()
//          class FooProps {
//            var bar;
//            var baz;
//          }
//
//          @State()
//          class FooState {
//            var bar;
//            var baz;
//          }
//
//          @Component()
//          class FooComponent {
//            render() {
//              return null;
//            }
//          }
//        ''');
//      });
//
      group('component', () {
//        test('without extends/with/implements clause', () {
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo = \$Foo;
//
//            @Props()
//            class FooProps {}
//
//            @Component()
//            class FooComponent {
//              render() => null;
//            }
//          ''');
//        });
//
//        test('with extends clause', () {
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            @Props()
//            class FooProps {}
//
//            @Component()
//            class FooComponent extends Bar {
//              render() => null;
//            }
//          ''');
//
//          expect(transformedFile.getTransformedText(), contains('extends Bar'),
//              reason: 'should preserve existing inheritance');
//        });
//
//        test('with extends/with clauses', () {
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            @Props()
//            class FooProps {}
//
//            @Component()
//            class FooComponent extends Bar with Baz {
//              render() => null;
//            }
//          ''');
//
//          expect(transformedFile.getTransformedText(), contains('extends Bar with Baz'),
//              reason: 'should preserve existing inheritance');
//        });
//
//        test('with extends/with clauses (multiple mixins)', () {
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            @Props()
//            class FooProps {}
//
//            @Component()
//            class FooComponent extends Bar with Baz, Qux {
//              render() => null;
//            }
//          ''');
//
//          expect(transformedFile.getTransformedText(), contains('extends Bar with Baz, Qux'),
//              reason: 'should preserve existing inheritance');
//        });
//
//        test('with extends/with clauses (multiple mixins, newlines)', () {
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            @Props()
//            class FooProps {}
//
//            @Component()
//            class FooComponent
//                extends Bar
//                with Baz, Qux {
//              render() => null;
//            }
//          ''');
//        });
//
//        test('with implements clause', () {
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            @Props()
//            class FooProps {}
//
//            @Component()
//            class FooComponent implements Quux {
//              render() => null;
//            }
//          ''');
//
//          expect(transformedFile.getTransformedText(), contains('implements Quux'),
//              reason: 'should preserve existing inheritance');
//        });
//
//        test('with extends/with/implements clauses', () {
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            @Props()
//            class FooProps {}
//
//            @Component()
//            class FooComponent extends Bar with Baz, Qux implements Quux {
//              render() => null;
//            }
//          ''');
//
//          expect(transformedFile.getTransformedText(), contains('extends Bar with Baz, Qux'),
//              reason: 'should preserve existing inheritance');
//
//          expect(transformedFile.getTransformedText(), contains('implements Quux'),
//              reason: 'should preserve existing inheritance');
//        });
//
//        test('with an initialized UiFactory with \$<UiFactory>', () {
//          final originalUiFactoryLine = 'UiFactory<FooProps> Foo = \$Foo;';
//          final transformedUiFactoryLine = 'UiFactory<FooProps> Foo = ([Map backingProps]) => new _\$FooPropsImpl(backingProps);';
//
//          generateFromSource('''
//              @Factory()
//              UiFactory<FooProps> Foo = \$Foo;
//
//              @Props()
//              class FooProps {}
//
//              @Component()
//              class FooComponent {
//                render() => null;
//              }
//            ''');
//
//          var transformedSource = transformedFile.getTransformedText();
//          expect(transformedSource, isNot(contains(originalUiFactoryLine)));
//          expect(transformedSource, contains(transformedUiFactoryLine));
//        });
//
//        test('with builder-compatible dual-class props setup', () {
//          final originalPrivateFooPropsLine = 'class _\$FooProps extends UiProps {';
//          final originalPublicFooPropsLine = 'class FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {';
//          final transformedFooPropsLine = 'class FooProps extends _\$FooProps';
//          final fooPropsImplExtendsPublicClass = 'class _\$FooPropsImpl extends FooProps';
//          final fooPropsImplExtendsPrivateClass = 'class _\$FooPropsImpl extends _\$FooProps';
//
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            class FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {
//              // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
//              static const PropsMeta meta = \$metaForFooProps;
//            }
//
//            @Props()
//            class _\$FooProps extends UiProps {}
//
//            @Component()
//            class FooComponent {
//              render() => null;
//            }
//          '''
//          );
//
//          var transformedSource = transformedFile.getTransformedText();
//          expect(transformedSource, contains(originalPrivateFooPropsLine));
//          expect(transformedSource, isNot(contains(originalPublicFooPropsLine)));
//          expect(transformedSource, contains(transformedFooPropsLine));
//          expect(transformedSource, contains(fooPropsImplExtendsPublicClass));
//          expect(transformedSource, isNot(contains(fooPropsImplExtendsPrivateClass)));
//        });
//
//        test('with builder-compatible dual-class state setup', () {
//          final originalPrivateFooStateLine = 'class _\$FooState extends UiState {';
//          final originalPublicFooStateLine = 'class FooState extends _\$FooState with _\$FooStateAccessorsMixin {';
//          final transformedFooStateLine = 'class FooState extends _\$FooState';
//          final fooStateImplExtendsPublicClass = 'class _\$FooStateImpl extends FooState';
//          final fooStateImplExtendsPrivateClass = 'class _\$FooStateImpl extends _\$FooState';
//
//          generateFromSource('''
//            @Factory()
//            UiFactory<FooProps> Foo;
//
//            class FooState extends _\$FooState with _\$FooStateAccessorsMixin {
//              // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
//              static const StateMeta meta = \$metaForFooState;
//            }
//
//            @Props()
//            class FooProps extends UiProps {}
//
//            @State()
//            class _\$FooState extends UiState {}
//
//            @Component()
//            class FooComponent {
//              render() => null;
//            }
//          '''
//          );
//
//          var transformedSource = transformedFile.getTransformedText();
//          expect(transformedSource, contains(originalPrivateFooStateLine));
//          expect(transformedSource, isNot(contains(originalPublicFooStateLine)));
//          expect(transformedSource, contains(transformedFooStateLine));
//          expect(transformedSource, contains(fooStateImplExtendsPublicClass));
//          expect(transformedSource, isNot(contains(fooStateImplExtendsPrivateClass)));
//        });

        group('that subtypes another component, referencing the component class via', () {
          test('a simple identifier', () {
            generateFromSource('''
              @Factory()
              UiFactory<FooProps> Foo;

              @Props()
              class FooProps {}

              @Component(subtypeOf: BarComponent)
              class FooComponent {}
            ''');

            expect(implGenerator.outputContentsBuffer.toString(), contains('parentType: \$BarComponentFactory'));
          });

          test('a prefixed identifier', () {
            generateFromSource('''
              @Factory()
              UiFactory<FooProps> Foo;

              @Props()
              class FooProps {}

              @Component(subtypeOf: baz.BarComponent)
              class FooComponent {}
            ''');

            expect(implGenerator.outputContentsBuffer.toString(), contains('parentType: baz.\$BarComponentFactory'));
          });
        });
      });

      group('for props mixins', () {
        test('without type parameters', () {
          generateFromSource('''
            @PropsMixin() class FooPropsMixin {
              Map get props;

              var bar;
              var baz;
            }
          ''');

          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooPropsMixin'));
        });

        test('with type parameters', () {
          generateFromSource('''
            @PropsMixin() class FooPropsMixin<T extends Iterable<T>, U> {
              Map get props;

              List<T> bar;
              U baz;
            }
          ''');

          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooPropsMixin<T extends Iterable<T>, U> {}'));
        });
      });

      group('for state mixins', () {
        test('without type parameters', () {
          generateFromSource('''
            @StateMixin() class FooStateMixin {
              Map get state;

              var bar;
              var baz;
            }
          ''');

          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooStateMixin'));
        });

        test('with type parameters', () {
          generateFromSource('''
            @StateMixin() class FooStateMixin<T extends Iterable<T>, U> {
              Map get state;

              List<T> bar;
              U baz;
            }
          ''');

          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooStateMixin<T extends Iterable<T>, U> {}'));
        });
      });

      test('abstract props classes', () {
        generateFromSource('''
          @AbstractProps() class AbstractFooProps {
            var bar;
            var baz;
          }
        ''');
      });
//
//      test('abstract props classes', () {
//        generateFromSource('''
//          @AbstractProps() class AbstractFooProps {
//            var bar;
//            var baz;
//          }
//        ''');
//      });

      test('abstract props classes with builder-compatible dual-class setup', () {
        final originalPrivateClassLine = 'class _\$AbstractFooProps {';
        final originalPublicClassLine = 'class AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {';
        final transformedFooPropsLine = 'class AbstractFooProps extends _\$AbstractFooProps';

        generateFromSource('''
          class AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {
            // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
            static const PropsMeta meta = \$metaForAbstractFooProps;
          }

          @AbstractProps()
          class _\$AbstractFooProps {
            var bar;
            var baz;
          }
        '''
        );

        // TODO: Update this test (and really the others in this file too) to better test build output
        var generationOutput = implGenerator.outputContentsBuffer.toString();
        expect(generationOutput, isNot(contains(originalPrivateClassLine));
//        expect(generationOutput, isNot(contains(originalPublicClassLine)));
//        expect(generationOutput, contains(transformedFooPropsLine));
      });

      test('abstract state classes', () {
        generateFromSource('''
          @AbstractState() class AbstractFooState {
            var bar;
            var baz;
          }
        ''');
      });

      test('abstract state classes with builder-compatible dual-class setup', () {
        final originalPrivateClassLine = 'class _\$AbstractFooState {';
        final originalPublicClassLine = 'class AbstractFooState extends _\$AbstractFooState with _\$AbstractFooStateAccessorsMixin {';
        final transformedFooStateLine = 'class AbstractFooState extends _\$AbstractFooState';

        generateFromSource('''
          class AbstractFooState extends _\$AbstractFooState with _\$AbstractFooStateAccessorsMixin {
            // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
            static const StateMeta meta = \$metaForAbstractFooState;
          }

          @AbstractState()
          class _\$AbstractFooState {
            var bar;
            var baz;
          }
        '''
        );
//
//        var transformedSource = transformedFile.getTransformedText();
//        expect(transformedSource, contains(originalPrivateClassLine));
//        expect(transformedSource, isNot(contains(originalPublicClassLine)));
//        expect(transformedSource, contains(transformedFooStateLine));
      });

      test('covariant keyword', () {
        generateFromSource('''
          @AbstractProps()
          class AbstractFooProps {
            covariant String foo;
          }
        ''');

//        expect(transformedFile.getTransformedText(), contains('String get foo => props[_\$key__foo__AbstractFooProps];'));
//        expect(transformedFile.getTransformedText(),
//            contains('set foo(covariant String value) => props[_\$key__foo__AbstractFooProps] = value;'));
      });

      group('accessors', () {
        test('that are absent', () {
          generateFromSource('''
            @AbstractProps()
            class AbstractFooProps {}
          ''');
        });

        test('with doc comments and annotations', () {
          generateFromSource('''
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
            generateFromSource('''
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

        group('shouldFixDdcAbstractAccessors', () {
          /// The comment always inserted by this patching logic.
          const String abstractAccessorsPatchComment = '/* fixDdcAbstractAccessors workaround: */';

          group('does not patch abstract getters corresponding to the backing map for', () {
            test('props classes', () {
              setUpAndGenerate('''
                @PropsMixin() class FooPropsMixin {  
                  // override isn't typically used here, but it's necessary to trigger the patching logic 
                  @override
                  Map get props;
      
                  var bar;
                  var baz;
                }
              ''', shouldFixDdcAbstractAccessors: true);

              expect(transformedFile.getTransformedText(), isNot(contains(abstractAccessorsPatchComment)));
            });

            test('state classes', () {
              setUpAndGenerate('''
                @StateMixin() class FooStateMixin {
                  // override isn't typically used here, but it's necessary to trigger the patching logic 
                  @override
                  Map get state;
                }
              ''', shouldFixDdcAbstractAccessors: true);

              expect(transformedFile.getTransformedText(), isNot(contains(abstractAccessorsPatchComment)));
            });
          });

          group('patches abstract accessors', () {
            group('getters', () {
              test('with types', () {
                setUpAndGenerate('''
                  @PropsMixin() abstract class FooPropsMixin {
                    Map get props;
                    
                    @override
                    Iterable get bar;
                  }
                ''', shouldFixDdcAbstractAccessors: true);

                expect(transformedFile.getTransformedText(), contains(
                    'Iterable get bar; $abstractAccessorsPatchComment set bar(covariant Iterable value);'
                ));
              });

              test('without types', () {
                setUpAndGenerate('''
                  @PropsMixin() abstract class FooPropsMixin {  
                    Map get props;
        
                    @override
                    get bar;
                  }
                ''', shouldFixDdcAbstractAccessors: true);

                expect(transformedFile.getTransformedText(), contains(
                    'get bar; $abstractAccessorsPatchComment set bar(covariant value);'
                ));
              });
            });

            group('setters', () {
              test('with types', () {
                setUpAndGenerate('''
                  @PropsMixin() abstract class FooPropsMixin {  
                    Map get props;
        
                    @override
                    set bar(Iterable value);
                  }
                ''', shouldFixDdcAbstractAccessors: true);

                expect(transformedFile.getTransformedText(), contains(
                    'set bar(Iterable value); $abstractAccessorsPatchComment Iterable get bar;'
                ));
              });

              test('without types', () {
                setUpAndGenerate('''
                  @PropsMixin() abstract class FooPropsMixin {  
                    Map get props;
        
                    @override
                    set bar(value);
                  }
                ''', shouldFixDdcAbstractAccessors: true);

                expect(transformedFile.getTransformedText(), contains(
                    'set bar(value); $abstractAccessorsPatchComment get bar;'
                ));
              });
            });

            group('in all generated accessor classes', () {
              const types = const <String, String>{
                'props mixin': '''
                    @PropsMixin() abstract class FooPropsMixin {  
                      Map get props;
                      @override get bar;
                    }
                ''',
                'state mixin': '''
                    @StateMixin() abstract class FooStateMixin {  
                      Map get state;
                      @override get bar;
                    }
                ''',
                'props class': '''
                    @Factory() UiFactory<FooProps> Foo;
                    @Props() class FooProps {  
                      @override get bar;
                    }
                    @Component() class FooComponent {}
                ''',
                'state class': '''
                    @Factory() UiFactory<FooProps> Foo;
                    @Props() class FooProps {}
                    @State() class FooState {
                      @override get bar;
                    }
                    @Component() class FooComponent {}
                ''',
                'abstract props class': '''
                    @AbstractProps() abstract class AbstractFooProps {  
                      @override get bar;
                    }
                ''',
                'abstract state class': '''
                    @AbstractState() abstract class AbstractFooState {  
                      @override get bar;
                    }
                ''',
              };

              types.forEach((String name, String source) {
                test(name, () {
                  setUpAndGenerate(source, shouldFixDdcAbstractAccessors: true);
                  expect(transformedFile.getTransformedText(), contains(abstractAccessorsPatchComment));
                });
              });

              group('unless shouldFixDdcAbstractAccessors is false', () {
                types.forEach((String name, String source) {
                  test(name, () {
                    setUpAndGenerate(source, shouldFixDdcAbstractAccessors: false);
                    expect(transformedFile.getTransformedText(), isNot(contains(abstractAccessorsPatchComment)));
                  });
                });
              });
            });
          });
        });
      });

      group('static meta field', () {
        void testStaticMetaField(String testName, StaticMetaTest smt) {
          test(testName, () {
            setUpAndGenerate(smt.source);

            final metaClassName = '_\$${smt.className}Meta';
            final expectedMetaClass = 'class $metaClassName {';
            final expectedMetaForInstance = (new StringBuffer()
              ..writeln('const ${smt.metaStructName} \$metaFor${smt.className} = const ${smt.metaStructName}(')
              ..writeln('  fields: $metaClassName.${smt.constantListName},')
              ..writeln('  keys: $metaClassName.${smt.keyListName},')
              ..writeln(');')
            ).toString();

            expect(transformedFile.getTransformedText(), contains(expectedMetaClass));
            expect(transformedFile.getTransformedText(), contains(expectedMetaForInstance));
          });
        }

        testStaticMetaField('props class', StaticMetaTest.props);
        testStaticMetaField('state class', StaticMetaTest.state);
        testStaticMetaField('props mixin', StaticMetaTest.propsMixin);
        testStaticMetaField('state mixin', StaticMetaTest.stateMixin);
        testStaticMetaField('abstract props', StaticMetaTest.abstractProps);
        testStaticMetaField('abstract state', StaticMetaTest.abstractState);
      });
    });

    group('logs an error when', () {


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

      group('accessors have', () {
        const expectedAccessorErrorMessage = '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
            'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.';

        test('the Accessor and requiredProp annotation', () {
          setUpAndGenerate('''
            @AbstractProps()
            class AbstractFooProps {
              @Accessor()
              @requiredProp
              var bar;
            }
          ''');
          verify(logger.error(expectedAccessorErrorMessage, span: any));
        });

        test('the Accessor and nullableRequiredProp annotation', () {
          setUpAndGenerate('''
            @AbstractProps()
            class AbstractFooProps {
              @Accessor()
              @nullableRequiredProp
              var bar;
            }
          ''');
          verify(logger.error(expectedAccessorErrorMessage, span: any));
        });

        test('the requiredProp and nullableRequiredProp annotation', () {
          setUpAndGenerate('''
            @AbstractProps()
            class AbstractFooProps {
              @requiredProp
              @nullableRequiredProp
              var bar;
            }
          ''');
          verify(logger.error(expectedAccessorErrorMessage, span: any));
        });
      });
    });

    group('logs a warning when', () {
      tearDown(() {
        verifyImplGenerationIsValid();
      });

      group('a Component', () {
        test('implements typedPropsFactory', () {
          setUpAndGenerate('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent {
              typedPropsFactory(Map backingMap) => {};
            }
          ''');

          verify(logger.warning('Components should not add their own implementions of typedPropsFactory or typedStateFactory.', span: any));
        });

        test('implements typedStateFactory', () {
          setUpAndGenerate('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props()
            class FooProps {}

            @Component()
            class FooComponent {
              typedStateFactory(Map backingMap) => {};
            }
          ''');

          verify(logger.warning('Components should not add their own implementions of typedPropsFactory or typedStateFactory.', span: any));
        });
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

    group('generates `call` on the _\$*PropsImpl class that matches the signature of UiProps', () {
      MethodDeclaration uiPropsCall;

      setUpAll(() async {
        var componentBase = parseDartFile((await Isolate.resolvePackageUri(Uri.parse(
            'package:over_react/src/component_declaration/component_base.dart'
        ))).toFilePath());

        ClassDeclaration uiPropsClass = componentBase.declarations
            .singleWhere((member) => member is ClassDeclaration && member.name?.name == 'UiProps');

        uiPropsCall = uiPropsClass.members
            .singleWhere((entity) => entity is MethodDeclaration && entity.name?.name == 'call');
      });
    });

    test('getComponentFactoryName() throws an error when its argument is null', () {
      expect(() => ImplGenerator.getComponentFactoryName(null), throwsArgumentError);
    });
  });
}

class StaticMetaTest {
  static const StaticMetaTest abstractProps = const StaticMetaTest._('@AbstractProps()', 'AbstractFooProps');
  static const StaticMetaTest abstractState = const StaticMetaTest._('@AbstractState()', 'AbstractFooState');
  static const StaticMetaTest props = const StaticMetaTest._('@Props()', 'FooProps');
  static const StaticMetaTest propsMixin = const StaticMetaTest._('@PropsMixin()', 'FooPropsMixin');
  static const StaticMetaTest state = const StaticMetaTest._('@State()', 'FooState');
  static const StaticMetaTest stateMixin = const StaticMetaTest._('@StateMixin()', 'FooStateMixin');

  final String annotation;
  final String className;

  const StaticMetaTest._(this.annotation, this.className);

  bool get isAbstract => annotation.contains('Abstract') || annotation.contains('Mixin');
  bool get isProps => annotation.contains('Props');
  String get constantListName => isProps ? '\$props' : '\$state';
  String get keyListName => isProps ? '\$propKeys' : '\$stateKeys';
  String get metaStructName => isProps ? 'PropsMeta' : 'StateMeta';
  bool get needsComponent => !isAbstract;

  String get source {
    final buffer = new StringBuffer();
    if (needsComponent) {
      buffer.writeln('@Factory() UiFactory<FooProps> Foo;');
      if (!isProps) {
        buffer.writeln('@Props() class FooProps {}');
      }
      buffer.writeln('@Component() class FooComponent {}');
    }
    buffer
      ..writeln('$annotation ${isAbstract ? "abstract " : ""}class $className {')
      ..writeln('  static const $metaStructName meta = \$metaFor$className;');
    if (isAbstract) {
      buffer.writeln('  Map get ${isProps ? "props" : "state"};');
    }
    buffer.writeln('}');
    return buffer.toString();
  }
}

class MockLogger extends Mock implements Logger {}
