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
import 'package:mockito/mockito.dart';
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:over_react/src/builder/generation/impl_generation.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import './util.dart';

main() {
  group('ImplGenerator', () {
    var validPropsSrc = PropsOrStateSrc(AnnotationType.props, '', 'FooProps', null).src;
    var validStateSrc = PropsOrStateSrc(AnnotationType.state, '', 'FooState', null).src;

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
      var buildOutput = implGenerator.outputContentsBuffer.toString();

      expect(() {
        parseCompilationUnit(buildOutput);
      }, returnsNormally, reason: 'transformed source should parse without errors:\n');
    }

    group('generates an implementation that parses correctly', () {
      void generateFromSource(String source) {
        setUpAndParse(source);

        implGenerator.generate(declarations);
      }

      tearDown(() {
        // Verify that there were no errors other than the ones we explicitly verified.
        verifyNoErrorLogs();

        verifyImplGenerationIsValid();
      });

      test('stateful components', () {
        generateFromSource(factorySrc + validPropsSrc + validStateSrc + componentSrc);
      });

      group('component', () {
        test('without extends/with/implements clause', () {
          generateFromSource(factorySrc + validPropsSrc + componentSrc);
        });

        test('with extends clause', () {
          generateFromSource(factorySrc + validPropsSrc + '''
            @Component()
            class FooComponent extends Bar {
              render() => null;
            }
          ''');
        });

        test('with extends/with clauses', () {
          generateFromSource(factorySrc + validPropsSrc + '''
            @Component()
            class FooComponent extends Bar with Baz {
              render() => null;
            }
          ''');
        });

        test('with extends/with clauses (multiple mixins)', () {
          generateFromSource(factorySrc + validPropsSrc + '''
            @Component()
            class FooComponent extends Bar with Baz, Qux {
              render() => null;
            }
          ''');
        });

        test('with implements clause', () {
          generateFromSource(factorySrc + validPropsSrc + '''
            @Component()
            class FooComponent implements Quux {
              render() => null;
            }
          ''');
        });

        test('with extends/with/implements clauses', () {
          generateFromSource(factorySrc + validPropsSrc + '''
            @Component()
            class FooComponent extends Bar with Baz, Qux implements Quux {
              render() => null;
            }
          ''');
        });

        group('that subtypes another component, referencing the component class via', () {
          test('a simple identifier', () {
            generateFromSource(factorySrc + validPropsSrc + '''
              @Component(subtypeOf: BarComponent)
              class FooComponent {}
            ''');

            expect(implGenerator.outputContentsBuffer.toString(), contains('parentType: \$BarComponentFactory'));
          });

          test('a prefixed identifier', () {
            generateFromSource(factorySrc + validPropsSrc + '''
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
            @PropsMixin() 
            class FooPropsMixin {
              Map get props;

              var bar;
              var baz;
            }
          ''');

          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooPropsMixin'));
        });

        test('with type parameters', () {
          generateFromSource('''
            @PropsMixin() 
            class FooPropsMixin<T extends Iterable, U> {
              Map get props;

              List<T> bar;
              U baz;
            }
          ''');

          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooPropsMixin<T extends Iterable, U> implements FooPropsMixin<T, U> {'));
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

          expect(implGenerator.outputContentsBuffer.toString(), contains('abstract class \$FooStateMixin<T extends Iterable<T>, U> implements FooStateMixin<T, U> {'));
        });
      });

      test('abstract props classes', () {
        generateFromSource(PropsOrStateSrc(AnnotationType.abstractProps, 'var bar;\nvar baz;', 'AbstractFooProps', null).src);
      });

      test('abstract state classes', () {
        generateFromSource(PropsOrStateSrc(AnnotationType.abstractState, 'var bar;\nvar baz;', 'AbstractFooState', null).src);
      });

      test('covariant keyword', () {
        generateFromSource(PropsOrStateSrc(AnnotationType.abstractProps, 'covariant String foo;', 'AbstractFooProps', null).src);
        expect(implGenerator.outputContentsBuffer.toString(), contains('String get foo => props[_\$key__foo___\$AbstractFooProps];'));
        expect(implGenerator.outputContentsBuffer.toString(), contains('set foo(covariant String value) => props[_\$key__foo___\$AbstractFooProps] = value;'));
      });

      group('accessors', () {
        test('that are absent', () {
          generateFromSource(PropsOrStateSrc(AnnotationType.abstractProps, '', 'AbstractFooProps', null).src);
        });

        test('with doc comments and annotations', () {
          var body = '''/// Doc comment
              @Annotation()
              var bar;''';
          generateFromSource(PropsOrStateSrc(AnnotationType.abstractProps, body, 'AbstractFooProps', null).src);
        });

        group('defined using comma-separated variables', () {
          test('on the same line', () {
            generateFromSource(PropsOrStateSrc(AnnotationType.abstractProps, 'var bar, baz, qux;', 'AbstractFooProps', null).src);
          });
        });

        // TODO: Do we need these abstract accessors tests?
//        group('shouldFixDdcAbstractAccessors', () {
//          /// The comment always inserted by this patching logic.
//          const String abstractAccessorsPatchComment = '/* fixDdcAbstractAccessors workaround: */';
//
//          group('does not patch abstract getters corresponding to the backing map for', () {
//            test('props classes', () {
//              setUpAndGenerate('''
//                @PropsMixin() class FooPropsMixin {
//                  // override isn't typically used here, but it's necessary to trigger the patching logic
//                  @override
//                  Map get props;
//
//                  var bar;
//                  var baz;
//                }
//              ''', shouldFixDdcAbstractAccessors: true);
//
//              expect(transformedFile.getTransformedText(), isNot(contains(abstractAccessorsPatchComment)));
//            });
//
//            test('state classes', () {
//              setUpAndGenerate('''
//                @StateMixin() class FooStateMixin {
//                  // override isn't typically used here, but it's necessary to trigger the patching logic
//                  @override
//                  Map get state;
//                }
//              ''', shouldFixDdcAbstractAccessors: true);
//
//              expect(transformedFile.getTransformedText(), isNot(contains(abstractAccessorsPatchComment)));
//            });
//          });
//
//          group('patches abstract accessors', () {
//            group('getters', () {
//              test('with types', () {
//                setUpAndGenerate('''
//                  @PropsMixin() abstract class FooPropsMixin {
//                    Map get props;
//
//                    @override
//                    Iterable get bar;
//                  }
//                ''', shouldFixDdcAbstractAccessors: true);
//
//                expect(transformedFile.getTransformedText(), contains(
//                    'Iterable get bar; $abstractAccessorsPatchComment set bar(covariant Iterable value);'
//                ));
//              });
//
//              test('without types', () {
//                setUpAndGenerate('''
//                  @PropsMixin() abstract class FooPropsMixin {
//                    Map get props;
//
//                    @override
//                    get bar;
//                  }
//                ''', shouldFixDdcAbstractAccessors: true);
//
//                expect(transformedFile.getTransformedText(), contains(
//                    'get bar; $abstractAccessorsPatchComment set bar(covariant value);'
//                ));
//              });
//            });
//
//            group('setters', () {
//              test('with types', () {
//                setUpAndGenerate('''
//                  @PropsMixin() abstract class FooPropsMixin {
//                    Map get props;
//
//                    @override
//                    set bar(Iterable value);
//                  }
//                ''', shouldFixDdcAbstractAccessors: true);
//
//                expect(transformedFile.getTransformedText(), contains(
//                    'set bar(Iterable value); $abstractAccessorsPatchComment Iterable get bar;'
//                ));
//              });
//
//              test('without types', () {
//                setUpAndGenerate('''
//                  @PropsMixin() abstract class FooPropsMixin {
//                    Map get props;
//
//                    @override
//                    set bar(value);
//                  }
//                ''', shouldFixDdcAbstractAccessors: true);
//
//                expect(transformedFile.getTransformedText(), contains(
//                    'set bar(value); $abstractAccessorsPatchComment get bar;'
//                ));
//              });
//            });
//
//            group('in all generated accessor classes', () {
//              const types = const <String, String>{
//                'props mixin': '''
//                    @PropsMixin() abstract class FooPropsMixin {
//                      Map get props;
//                      @override get bar;
//                    }
//                ''',
//                'state mixin': '''
//                    @StateMixin() abstract class FooStateMixin {
//                      Map get state;
//                      @override get bar;
//                    }
//                ''',
//                'props class': '''
//                    @Factory() UiFactory<FooProps> Foo;
//                    @Props() class FooProps {
//                      @override get bar;
//                    }
//                    @Component() class FooComponent {}
//                ''',
//                'state class': '''
//                    @Factory() UiFactory<FooProps> Foo;
//                    @Props() class FooProps {}
//                    @State() class FooState {
//                      @override get bar;
//                    }
//                    @Component() class FooComponent {}
//                ''',
//                'abstract props class': '''
//                    @AbstractProps() abstract class AbstractFooProps {
//                      @override get bar;
//                    }
//                ''',
//                'abstract state class': '''
//                    @AbstractState() abstract class AbstractFooState {
//                      @override get bar;
//                    }
//                ''',
//              };
//
//              types.forEach((String name, String source) {
//                test(name, () {
//                  setUpAndGenerate(source, shouldFixDdcAbstractAccessors: true);
//                  expect(transformedFile.getTransformedText(), contains(abstractAccessorsPatchComment));
//                });
//              });
//
//              group('unless shouldFixDdcAbstractAccessors is false', () {
//                types.forEach((String name, String source) {
//                  test(name, () {
//                    setUpAndGenerate(source, shouldFixDdcAbstractAccessors: false);
//                    expect(transformedFile.getTransformedText(), isNot(contains(abstractAccessorsPatchComment)));
//                  });
//                });
//              });
//            });
//          });
//        });
      });

//      group('static meta field', () {
//        void testStaticMetaField(String testName, StaticMetaTest smt) {
//          test(testName, () {
//            setUpAndGenerate(smt.source);
//
//            final metaClassName = '_\$${smt.className}Meta';
//            final expectedMetaClass = 'class $metaClassName {';
//            final expectedMetaForInstance = (new StringBuffer()
//              ..writeln('const ${smt.metaStructName} \$metaFor${smt.className} = const ${smt.metaStructName}(')
//              ..writeln('  fields: $metaClassName.${smt.constantListName},')
//              ..writeln('  keys: $metaClassName.${smt.keyListName},')
//              ..writeln(');')
//            ).toString();
//
//            expect(transformedFile.getTransformedText(), contains(expectedMetaClass));
//            expect(transformedFile.getTransformedText(), contains(expectedMetaForInstance));
//          });
//        }
//
//        testStaticMetaField('props class', StaticMetaTest.props);
//        testStaticMetaField('state class', StaticMetaTest.state);
//        testStaticMetaField('props mixin', StaticMetaTest.propsMixin);
//        testStaticMetaField('state mixin', StaticMetaTest.stateMixin);
//        testStaticMetaField('abstract props', StaticMetaTest.abstractProps);
//        testStaticMetaField('abstract state', StaticMetaTest.abstractState);
//      });
    });

    group('logs an error when', () {
      group('a component class', () {
        test('subtypes itself', () {
          setUpAndGenerate(factorySrc + validPropsSrc + '''
            @Component(subtypeOf: FooComponent)
            class FooComponent {}
          ''');

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
              absract class FooPropsMixin {
//                Map props;

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
        setUpAndGenerate(PropsOrStateSrc(AnnotationType.abstractProps, 'var bar = null;', 'AbstractFooProps', null).src);
        verify(logger.severe('Fields are stubs for generated setters/getters and should not have initializers.'));
      });

      group('accessors have', () {
        const expectedAccessorErrorMessage = '@requiredProp/@nullableProp/@Accessor cannot be used together.\n'
            'You can use `@Accessor(required: true)` or `isNullable: true` instead of the shorthand versions.';

        test('the Accessor and requiredProp annotation', () {
          var body = ''''@Accessor()
              @requiredProp
              var bar;''';
          setUpAndGenerate(PropsOrStateSrc(AnnotationType.abstractProps, body, 'AbstractFooProps', null).src);
          verify(logger.severe(expectedAccessorErrorMessage));
        });

        test('the Accessor and nullableRequiredProp annotation', () {
          var body = '''@Accessor()
              @nullableRequiredProp
              var bar;''';
          setUpAndGenerate(PropsOrStateSrc(AnnotationType.abstractProps, body, 'AbstractFooProps', null).src);
          verify(logger.severe(expectedAccessorErrorMessage));
        });

        test('the requiredProp and nullableRequiredProp annotation', () {
          var body = ''''@requiredProp
              @nullableRequiredProp
              var bar;''';
          setUpAndGenerate(PropsOrStateSrc(AnnotationType.abstractProps, body, 'AbstractFooProps', null).src);
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
          setUpAndGenerate(factorySrc + validPropsSrc + '''
            @Component()
            class FooComponent {
              typedPropsFactory(Map backingMap) => {};
            }
          ''');

          verify(logger.warning('Components should not add their own implementions of typedPropsFactory or typedStateFactory.'));
        });

        test('implements typedStateFactory', () {
          setUpAndGenerate(factorySrc + validPropsSrc + '''
            @Component()
            class FooComponent {
              typedStateFactory(Map backingMap) => {};
            }
          ''');

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
          setUpAndGenerate(PropsOrStateSrc(AnnotationType.abstractProps, body, 'AbstractFooProps', null).src);
          verify(logger.warning(expectedCommaSeparatedWarning));
        });

        test('with annotations', () {
          var body = ''''@Annotation()
            var bar, baz;''';
          setUpAndGenerate(PropsOrStateSrc(AnnotationType.abstractProps, body, 'AbstractFooProps', null).src);
          verify(logger.warning(expectedCommaSeparatedWarning));
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
//      expect(() => ImplGenerator.getComponentFactoryName(null), throwsArgumentError);
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
