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
import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react/src/transformer/declaration_parsing.dart';
import 'package:over_react/src/transformer/impl_generation.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';
import 'package:transformer_utils/transformer_utils.dart';

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

      sourceFile = new SourceFile.fromString(source);
      transformedFile = new TransformedSourceFile(sourceFile);

      unit = parseCompilationUnit(source);
      declarations = new ParsedDeclarations(unit, sourceFile, logger);
      implGenerator = new ImplGenerator(logger, transformedFile);
    }

    void setUpAndGenerate(String source, {bool shouldFixDdcAbstractAccessors: false}) {
      setUpAndParse(source);

      implGenerator = new ImplGenerator(logger, transformedFile)
        ..shouldFixDdcAbstractAccessors = shouldFixDdcAbstractAccessors;
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
      }, returnsNormally, reason: 'transformed source should parse without errors:\n$transformedSource');
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

        test('with an initialized UiFactory with \$<UiFactory>', () {
          final originalUiFactoryLine = 'UiFactory<FooProps> Foo = \$Foo;';
          final transformedUiFactoryLine = 'UiFactory<FooProps> Foo = ([Map backingProps]) => new _\$FooPropsImpl(backingProps);';

          preservedLineNumbersTest('''
              @Factory()
              UiFactory<FooProps> Foo = \$Foo;

              @Props()
              class FooProps {}

              @Component()
              class FooComponent {
                render() => null;
              }
            ''');

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource, isNot(contains(originalUiFactoryLine)));
          expect(transformedSource, contains(transformedUiFactoryLine));
        });

        test('with static PropsMeta and StateMeta declaration', () {
          final originalPropsMetaLine = 'static const PropsMeta meta = \$metaForFooProps;';
          final originalStateMetaLine = 'static const StateMeta meta = \$metaForFooState;';
          final transformedPropsMetaLine = 'static const PropsMeta meta = \$Props(FooProps);';
          final transformedStateMetaLine = 'static const StateMeta meta = \$State(FooState);';

          setUpAndGenerate('''
           @Factory()
           UiFactory<FooProps> Foo;
        
           @Props()
           class FooProps {
            static const PropsMeta meta = \$metaForFooProps;
           }
           
           @State()
           class FooState {
            static const StateMeta meta = \$metaForFooState;
           }
           
           @Component()
           class FooComponent {
            render() => null;
           }
           '''
          );

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource.contains(originalPropsMetaLine), isFalse);
          expect(transformedSource.contains(originalStateMetaLine), isFalse);
          expect(transformedSource, contains(transformedPropsMetaLine));
          expect(transformedSource, contains(transformedStateMetaLine));
        });

        test('with static PropsMeta declaration in PropsMixin', () {
          final originalLine = 'static const PropsMeta meta = \$metaForFooPropsMixin;';
          final transformedLine = 'static const PropsMeta meta = \$Props(FooPropsMixin);';

          setUpAndGenerate('''
            @PropsMixin()
            class FooPropsMixin {
              static const PropsMeta meta = \$metaForFooPropsMixin;
              
              Map get props;
            }
          '''
          );

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource.contains(originalLine), isFalse);
          expect(transformedSource, contains(transformedLine));
        });

        test('with static StateMeta declaration in StateMixin', () {
          final originalLine = 'static const StateMeta meta = \$metaForFooStateMixin; ';
          final transformedLine = 'static const StateMeta meta = \$State(FooStateMixin);';

          setUpAndGenerate('''
            @StateMixin()
            class FooStateMixin {
              static const StateMeta meta = \$metaForFooStateMixin;   
              
              Map get state;           
            }
          '''
          );

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource.contains(originalLine), isFalse);
          expect(transformedSource, contains(transformedLine));
        });

        test('with Props|State with clause contain \$ prefixed and non-prefixed mixin pairs', () {
          final prefixedFooPropsMixin = 'abstract class \$FooPropsMixin {}';
          final prefixedFooStateMixin = 'abstract class \$FooStateMixin {}';
          final prefixedBarPropsMixin = 'abstract class \$BarPropsMixin {}';
          final prefixedBarStateMixin = 'abstract class \$BarStateMixin {}';

          preservedLineNumbersTest('''
            @PropsMixin()
            class FooPropsMixin {
              Map get props;

              var bar;
              var baz;
            }
            
            @PropsMixin()
            class BarPropsMixin {
              Map get props;

              var bar;
              var baz;
            }
            
            @StateMixin() 
            class FooStateMixin {
              Map get state;

              var bar;
              var baz;
            } 
            
            @StateMixin() 
            class BarStateMixin {
              Map get state;

              var bar;
              var baz;
            } 
          ''');

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource, contains(prefixedFooPropsMixin));
          expect(transformedSource, contains(prefixedFooStateMixin));
          expect(transformedSource, contains(prefixedBarPropsMixin));
          expect(transformedSource, contains(prefixedBarStateMixin));
        });

        test('with builder-compatible dual-class props setup', () {
          final originalPrivateFooPropsLine = 'class _\$FooProps extends UiProps {';
          final originalPublicFooPropsLine = 'class FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {';
          final transformedFooPropsLine = 'class FooProps extends _\$FooProps';
          final fooPropsImplExtendsPublicClass = 'class _\$FooPropsImpl extends FooProps';
          final fooPropsImplExtendsPrivateClass = 'class _\$FooPropsImpl extends _\$FooProps';

          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;
        
            class FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {
              // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
              static const PropsMeta meta = \$metaForFooProps;
            }
           
            @Props()
            class _\$FooProps extends UiProps {}
            
            @AbstractProps() class AbstractFooProps {
              var bar;
              var baz;
            }
            
            @State()
            class FooState {}
           
            @Component()
            class FooComponent {
              render() => null;
            }
          '''
          );

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource, contains(originalPrivateFooPropsLine));
          expect(transformedSource, isNot(contains(originalPublicFooPropsLine)));
          expect(transformedSource, contains(transformedFooPropsLine));
          expect(transformedSource, contains(fooPropsImplExtendsPublicClass));
          expect(transformedSource, isNot(contains(fooPropsImplExtendsPrivateClass)));
        });

        test('with builder-compatible dual-class state setup', () {
          final originalPrivateFooStateLine = 'class _\$FooState extends UiState {';
          final originalPublicFooStateLine = 'class FooState extends _\$FooState with _\$FooStateAccessorsMixin {';
          final transformedFooStateLine = 'class FooState extends _\$FooState';
          final fooStateImplExtendsPublicClass = 'class _\$FooStateImpl extends FooState';
          final fooStateImplExtendsPrivateClass = 'class _\$FooStateImpl extends _\$FooState';

          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;
        
            class FooState extends _\$FooState with _\$FooStateAccessorsMixin {
              // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
              static const StateMeta meta = \$metaForFooState;
            }
           
            @Props()
            class FooProps extends UiProps {}
           
            @State()
            class _\$FooState extends UiState {}
           
            @Component()
            class FooComponent {
              render() => null;
            }
          '''
          );

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource, contains(originalPrivateFooStateLine));
          expect(transformedSource, isNot(contains(originalPublicFooStateLine)));
          expect(transformedSource, contains(transformedFooStateLine));
          expect(transformedSource, contains(fooStateImplExtendsPublicClass));
          expect(transformedSource, isNot(contains(fooStateImplExtendsPrivateClass)));
        });

        test('with builder-compatible dual-class abstract props setup', () {
          final originalPrivateClassLine = 'class _\$AbstractFooProps {';
          final originalPublicClassLine = 'class AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {';
          final transformedFooStateLine = 'class AbstractFooProps extends _\$AbstractFooProps';

          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;
            
            @Props()
            class FooProps extends UiProps {}
            
            @Component()
            class FooComponent {
              render() => null;
            }
          
            class AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {
              // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
              static const AbstractFooPropsMeta meta = \$metaForAbstractFooProps;
            }
            
            @AbstractProps() 
            class _\$AbstractFooProps {
              var bar;
              var baz;
            }
          '''
          );

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource, contains(originalPrivateClassLine));
          expect(transformedSource, isNot(contains(originalPublicClassLine)));
          expect(transformedSource, contains(transformedFooStateLine));
        });

        test('with builder-compatible dual-class abstract state setup', () {
          final originalPrivateClassLine = 'class _\$AbstractStateProps {';
          final originalPublicClassLine = 'class AbstractStateProps extends _\$AbstractStateProps with _\$AbstractStatePropsAccessorsMixin {';
          final transformedFooStateLine = 'class AbstractStateProps extends _\$AbstractStateProps';

          preservedLineNumbersTest('''
            @Factory()
            UiFactory<FooProps> Foo;
            
            @Props()
            class FooProps extends UiProps {}
            
            @Component()
            class FooComponent {
              render() => null;
            }
            
            class AbstractStateProps extends _\$AbstractStateProps with _\$AbstractFooStateAccessorsMixin {
              // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
              static const AbstractFooStateMeta meta = \$metaForAbstractStateProps;
            }
              
            @AbstractState() 
            class _\$AbstractStateProps {
              var bar;
              var baz;
            }
          '''
          );

          var transformedSource = transformedFile.getTransformedText();
          expect(transformedSource, contains(originalPrivateClassLine));
          expect(transformedSource, isNot(contains(originalPublicClassLine)));
          expect(transformedSource, contains(transformedFooStateLine));
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

      test('covariant keyword', () {
        preservedLineNumbersTest('''
          @AbstractProps()
          class AbstractFooProps {
            covariant String foo;
          }
        ''');

        expect(transformedFile.getTransformedText(), contains('String get foo => props[_\$key__foo__AbstractFooProps];'));
        expect(transformedFile.getTransformedText(),
            contains('set foo(covariant String value) => props[_\$key__foo__AbstractFooProps] = value;'));
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

          verify(logger.error('Factory variables are stubs for the generated factories, and should not have initializers'
              ' unless initialized with \$Foo for Dart 2 builder compatibility.', span: any));
        });

        test('declared with an \$ prefixed initializer matching the factory name', () {
          setUpAndGenerate('''
            @Factory()
            UiFactory<FooProps> Foo = \$Foo;

            $restOfComponent
          ''');

          verifyNever(logger.error('Factory variables are stubs for the generated factories, and should not have initializers'
              ' unless initialized with \$Foo for Dart 2 builder compatibility.', span: any));
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
        verifyTransformedSourceIsValid();
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

      test('generates `call` override on the _\$*PropsImpl class correctly, as a workaround for dart-lang/sdk#16030', () {
        setUpAndGenerate('''
          @Factory()
          UiFactory<FooProps> Foo;

          @Props()
          class FooProps {}

          @Component()
          class FooComponent {
            render() => null;
          }
        ''');

        var transformedSource = transformedFile.getTransformedText();
        var parsedTransformedSource = parseCompilationUnit(transformedSource);

        ClassDeclaration propsImplClass = parsedTransformedSource.declarations
            .singleWhere((entity) => entity is ClassDeclaration && entity.name?.name == r'_$FooPropsImpl');

        MethodDeclaration propsImplCall = propsImplClass.members
            .singleWhere((entity) => entity is MethodDeclaration && entity.name?.name == 'call');

        expect(propsImplCall.parameters.toSource(), uiPropsCall.parameters.toSource(),
            reason: 'should have the correct number of arguments');
        expect(propsImplCall.metadata, contains(predicate((meta) => meta.name?.name == 'override')),
            reason: 'should have @override');
        expect(propsImplCall.returnType, null,
            reason: 'should not be typed, since ReactElement may not be imported');
        expect(propsImplCall.isAbstract, isTrue,
            reason: 'should be abstract; the declaration is only for dart2js bug workaround purposes, '
                'and the inherited implementation should be used');
      });
    });

    test('getComponentFactoryName() throws an error when its argument is null', () {
      expect(() => ImplGenerator.getComponentFactoryName(null), throwsArgumentError);
    });
  });
}


class MockTransformLogger extends Mock implements TransformLogger {}
