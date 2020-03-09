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

// ignore_for_file: deprecated_member_use_from_same_package

@TestOn('vm')
library declaration_parsing_test;

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react/src/builder/generation/parsing.dart';
import 'package:over_react/src/builder/generation/parsing/validation.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import './util.dart';

main() {
  group('ComponentDeclarations', () {
    group('mightContainDeclarations()', () {
      group('returns true when the source contains an annotation', () {
        test('"@Factory"',           () => expect(mightContainDeclarations(factorySrc), isTrue));
        test('"@Props"',             () => expect(mightContainDeclarations(propsSrc), isTrue));
        test('"@State"',             () => expect(mightContainDeclarations(stateSrc), isTrue));
        test('"@Component"',         () => expect(mightContainDeclarations(componentSrc), isTrue));
        test('"@Component2"',        () => expect(mightContainDeclarations(component2Src), isTrue));
        test('"@AbstractProps"',     () => expect(mightContainDeclarations(abstractPropsSrc), isTrue));
        test('"@AbstractState"',     () => expect(mightContainDeclarations(abstractStateSrc), isTrue));
        test('"@AbstractComponent"', () => expect(mightContainDeclarations(abstractComponentSrc), isTrue));
        test('"@AbstractComponent2"',() => expect(mightContainDeclarations(abstractComponent2Src), isTrue));
        test('"@PropsMixin"',        () => expect(mightContainDeclarations(propsMixinSrc), isTrue));
        test('"@StateMixin"',        () => expect(mightContainDeclarations(stateMixinSrc), isTrue));
      });

      group('returns true when the source contains a reference to one of the base types', () {
        const types = [
          'UiFactory',
          'UiProps',
          'UiState',
          'UiComponent',
          'UiComponent2',
          'UiStatefulComponent',
          'UiStatefulComponent2',
        ];

        for (var type in types) {
          test(type, () => expect(mightContainDeclarations(type), isTrue));
        };
      });

      test('returns true when there is an over_react part file', () {
        expect(mightContainDeclarations('part "foo.over_react.g.dart";'), isTrue);
      });

      test('returns false for other code', () {
        expect(mightContainDeclarations(r'''
          part 'something.g.dart';
        
          class NotAComponent {}
          mixin SomethingProps on SomethingUnrelatedToOverReact {}
        '''), isFalse);
      });
    });

    group('parses', () {
      MockLogger logger;
      SourceFile sourceFile;
      CompilationUnit unit;
      List<BoilerplateDeclaration> declarations;

      void setUpAndParse(String source) {
        logger = MockLogger();
        sourceFile = SourceFile.fromString(source);
        unit = parseString(content: source).unit;

        final errorCollector = ErrorCollector.log(sourceFile, logger);

        final members = BoilerplateMembers.detect(unit);
        declarations = getBoilerplateDeclarations(members, errorCollector).toList();
        for (var declaration in declarations) {
          declaration.validate(errorCollector);
        }
      }

      void verifyNoMoreErrorLogs() {
        verifyNever(logger.warning(any));
        verifyNever(logger.severe(any));
      }

      tearDown(() {
        // Verify that there were no errors other than the ones we explicitly verified.
        verifyNoMoreErrorLogs();

        logger = null;
        sourceFile = null;
        unit = null;
        declarations = null;
      });

      group('and successfully collects declarations for', () {
        test('an empty file', () {
          setUpAndParse('');

          expect(declarations, isEmpty);
        });

        group('(legacy syntax)', () {
          group('a component', () {
            void testDualClassSetup({
              bool backwardsCompatible = true,
              bool isPrivate = false,
              bool isStatefulComponent = false,
              int componentVersion = 1,
            }) {
              OverReactSrc ors;
              if (isStatefulComponent) {
                ors = OverReactSrc.state(
                    backwardsCompatible: backwardsCompatible,
                    isPrivate: isPrivate,
                    componentVersion: componentVersion);
              } else {
                ors = OverReactSrc.props(
                    backwardsCompatible: backwardsCompatible,
                    isPrivate: isPrivate,
                    componentVersion: componentVersion);
              }
              setUpAndParse(ors.source);

              expect(declarations, [isA<LegacyClassComponentDeclaration>()]);
              final decl = declarations[0] as LegacyClassComponentDeclaration;

              expect(decl.component, isNotNull);
              expect(decl.factory?.name?.name, ors.baseName);
              expect(decl.props?.name?.name, '_\$${ors.baseName}Props');

              expect(decl.props.meta, isA<annotations.Props>());

              if (isStatefulComponent) {
                expect(decl.state?.name?.name, '_\$${ors.baseName}State');
                expect(decl.state.meta, isA<annotations.State>());
              }

              expect(decl.component?.name?.name, '${ors.baseName}Component');

              final boilerplateVersion = backwardsCompatible
                  ? Version.v2_legacyBackwardsCompat
                  : Version.v3_legacyDart2Only;
              if (componentVersion == 1) {
                expect(decl.component.meta, isA<annotations.Component>());
                expect(decl.component.isComponent2(boilerplateVersion), isFalse);
              } else if (componentVersion == 2) {
                expect(decl.component.meta, isA<annotations.Component2>());
                expect(decl.component.isComponent2(boilerplateVersion), isTrue);
              }
            }

            group('that is stateless', () {
              group('(v1 - deprecated)', () {
                group('with backwards compatible boilerplate', () {
                  test('with public consumable class', testDualClassSetup);
                  test('with private consumable class', () {
                    testDualClassSetup(isPrivate: true);
                  });
                });

                group('with Dart 2 only boilerplate', () {
                  test('with public consumable class', () {
                    testDualClassSetup(backwardsCompatible: false);
                  });
                  test('with private consumable class', () {
                    testDualClassSetup(backwardsCompatible: false, isPrivate: true);
                  });
                });
              });

              group('(v2)', () {
                group('with backwards compatible boilerplate', () {
                  test('with public consumable class', () {
                    testDualClassSetup(componentVersion: 2);
                  });
                  test('with private consumable class', () {
                    testDualClassSetup(componentVersion: 2, isPrivate: true);
                  });
                });

                group('with Dart 2 only boilerplate', () {
                  test('with public consumable class', () {
                    testDualClassSetup(componentVersion: 2, backwardsCompatible: false);
                  });
                  test('with private consumable class', () {
                    testDualClassSetup(componentVersion: 2, backwardsCompatible: false, isPrivate: true);
                  });
                });
              });
            });

            group('that is stateful', () {
              group('and uses the @Component annotation (deprecated)', () {
                group('with backwards compatible boilerplate', () {
                  test('with public consumable class', () {
                    testDualClassSetup(isStatefulComponent: true);
                  });
                  test('with private consumable class', () {
                    testDualClassSetup(isStatefulComponent: true, isPrivate: true);
                  });
                });

                group('with Dart 2 only boilerplate', () {
                  test('with public consumable class', () {
                    testDualClassSetup(isStatefulComponent: true, backwardsCompatible: false);
                  });
                  test('with private consumable class', () {
                    testDualClassSetup(isStatefulComponent: true, backwardsCompatible: false, isPrivate: true);
                  });
                });
              });

              group('and uses the @Component2 annotation', () {
                group('with backwards compatible boilerplate', () {
                  test('with public consumable class', () {
                    testDualClassSetup(isStatefulComponent: true, componentVersion: 2);
                  });
                  test('with private consumable class', () {
                    testDualClassSetup(isStatefulComponent: true, isPrivate: true, componentVersion: 2);
                  });
                });

                group('with Dart 2 only boilerplate', () {
                  test('with public consumable class', () {
                    testDualClassSetup(isStatefulComponent: true, backwardsCompatible: false, componentVersion: 2);
                  });
                  test('with private consumable class', () {
                    testDualClassSetup(isStatefulComponent: true, backwardsCompatible: false, isPrivate: true,
                        componentVersion: 2);
                  });
                });
              });
            });

            group('with mismatched names', () {
              test('', () {
                setUpAndParse(r'''
                  @Factory()
                  UiFactory<BarProps> Foo = _$Foo;
                  
                  @Props()
                  class _$BarProps extends UiProps {}
                  
                  @Component()
                  class BazComponent extends UiComponent<BarProps> {
                    render() {}
                  }
                  
                  class BarProps extends _$BarProps {}
                ''');

                final component = expectSingleOfType<LegacyClassComponentDeclaration>(declarations);
                expect(component.factory?.name?.name, 'Foo');
                expect(component.props?.name?.name, endsWith('BarProps'));
                expect(component.state, isNull);
                expect(component.component?.name?.name, 'BazComponent');
              });

              test('that is stateful', () {
                setUpAndParse(r'''
                  
                  @Factory()
                  UiFactory<BarProps> Foo = _$Foo;
                  
                  @Props()
                  class _$BarProps extends UiProps {}
                  
                  @State()
                  class _$QuxState extends UiState {}
                  
                  @Component()
                  class BazComponent extends UiStatefulComponent<BarProps, QuxState> {
                    render() {}
                  }
                  
                  class BarProps extends _$BarProps {}
                  class QuxState extends _$QuxState {}
                ''');

                final component = expectSingleOfType<LegacyClassComponentDeclaration>(declarations);
                expect(component.factory?.name?.name, 'Foo');
                expect(component.props?.name?.name, endsWith('BarProps'));
                expect(component.state?.name?.name, endsWith('QuxState'));
                expect(component.component?.name?.name, 'BazComponent');
              });

              test('and other non-component boilerplate declarations in the file', () {
                setUpAndParse(r'''
                  @Factory()
                  UiFactory<BarProps> Foo = _$Foo;
                  
                  @Props()
                  class _$BarProps extends UiProps {}
                  
                  @Component()
                  class BazComponent extends UiComponent<BarProps> {
                    render() {}
                  }
                  
                  class BarProps extends _$BarProps {}                  
                  
                  @PropsMixin() 
                  abstract class CorgePropsMixin {
                    Map get props;
                  }
                  
                  @StateMixin() 
                  abstract class GarplyStateMixin {
                    Map get state;
                  }
                ''');

                expect(declarations, unorderedEquals([
                  isA<LegacyClassComponentDeclaration>(),
                  isA<PropsMixinDeclaration>(),
                  isA<StateMixinDeclaration>(),
                ]));

                final component = declarations.firstWhereType<LegacyClassComponentDeclaration>();
                expect(component.factory?.name?.name, 'Foo');
                expect(component.props?.name?.name, endsWith('BarProps'));
                expect(component.state, isNull);
                expect(component.component?.name?.name, 'BazComponent');
              });
            });
          });

          group('props mixins', () {
            void testPropsMixins(String source, List<String> mixinNames) {
              setUpAndParse(source);

              expect(declarations, hasLength(mixinNames.length));
              final mixins = expectAllOfType<PropsMixinDeclaration>(declarations);

              for (var mixin in mixins) {
                expect(mixinNames, contains(mixin.propsMixin.name.name));
                expect(mixin.propsMixin.meta, isA<annotations.PropsMixin>());
              }
            }

            test('with backwards compatible boilerplate', () {
              testPropsMixins(OverReactSrc.propsMixin(numMixins: 3).source,
                  ['FooPropsMixin1', 'FooPropsMixin2', 'FooPropsMixin3']);
            });

            test('with Dart 2 only boilerplate', () {
              testPropsMixins(OverReactSrc.propsMixin(backwardsCompatible: false, numMixins: 3).source,
                  ['_\$FooPropsMixin1', '_\$FooPropsMixin2', '_\$FooPropsMixin3']);
            });
          });

          group('state mixins', () {
            void testStateMixins(String source, List<String> mixinNames) {
              setUpAndParse(source);

              expect(declarations, hasLength(mixinNames.length));
              final mixins = expectAllOfType<StateMixinDeclaration>(declarations);

              for (var mixin in mixins) {
                expect(mixinNames, contains(mixin.stateMixin.name.name));
                expect(mixin.stateMixin.meta, isA<annotations.StateMixin>());
              }
            }

             test('with backwards compatible boilerplate', () {
               testStateMixins(OverReactSrc.stateMixin(numMixins: 3).source,
                   ['FooStateMixin1', 'FooStateMixin2', 'FooStateMixin3']);
             });

             test('with Dart 2 only boilerplate', () {
               testStateMixins(OverReactSrc.stateMixin(backwardsCompatible: false, numMixins: 3).source,
                   ['_\$FooStateMixin1', '_\$FooStateMixin2', '_\$FooStateMixin3']);
             });
          });

          group('abstract props class with builder-compatible dual-class setup', () {
            void testAbstractPropsDualClassSetup({backwardsCompatible = true, isPrivate = false}) {
              final ors = OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, isPrivate: isPrivate);
              setUpAndParse(ors.source);

              final decl = expectSingleOfType<LegacyAbstractClassComponentDeclaration>(declarations);

              expect(decl.props, isNotNull);
              expect(decl.state, isNull);
              expect(decl.component, isNull);

              expect(decl.props.name.name, '_\$${ors.baseName}Props');
              expect(decl.props.meta, TypeMatcher<annotations.TypedMap>());
            }

            group('with backwards compatible boilerplate', () {
              test('with public consumable class', testAbstractPropsDualClassSetup);
              test('with private consumable class', () {
                testAbstractPropsDualClassSetup(isPrivate: true);
              });
            });

            group('with Dart 2 only boilerplate', () {
              test('with public consumable class', () {
                testAbstractPropsDualClassSetup(backwardsCompatible: false);
              });
              test('with private consumable class', () {
                testAbstractPropsDualClassSetup(backwardsCompatible: false, isPrivate: true);
              });
            });
          });

          group('abstract state class with builder-compatible dual-class setup', () {
            void testAbstractStateDualClassSetup({backwardsCompatible = true, isPrivate = false}) {
              final ors = OverReactSrc.abstractState(backwardsCompatible: true, isPrivate: isPrivate);
              setUpAndParse(ors.source);

              final decl = expectSingleOfType<LegacyAbstractClassComponentDeclaration>(declarations);

              expect(decl.props, isNull);
              expect(decl.state, isNotNull);
              expect(decl.component, isNull);

              expect(decl.state.name?.name, '_\$${ors.baseName}State');
              expect(decl.state.meta, TypeMatcher<annotations.TypedMap>());
            }

            group('with backwards compatible boilerplate', () {
              test('with public consumable class', testAbstractStateDualClassSetup);
              test('with private consumable class', () {
                testAbstractStateDualClassSetup(isPrivate: true);
              });
            });

            group('with Dart 2 only boilerplate', () {
              test('with public consumable class', () {
                testAbstractStateDualClassSetup(backwardsCompatible: false);
              });
              test('with private consumable class', () {
                testAbstractStateDualClassSetup(backwardsCompatible: false, isPrivate: true);
              });
            });
          });

          group('and initializes annotations with the correct arguments', () {
            group('with backwards-compatible boilerplate for', () {
              test('a stateful component', () {
                setUpAndParse('''
                  @Factory()
                  UiFactory<FooProps> Foo = _\$Foo;
  
                  @Props(keyNamespace: "bar")
                  class _\$FooProps {}
  
                  class FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {}
  
                  @State(keyNamespace: "baz")
                  class _\$FooState extends _\$FooState with _\$FooStateAccessorsMixin {}
  
                  class FooState extends _\$FooState with _\$FooStateAccessorsMixin {}
  
                  @Component(isWrapper: true)
                  class FooComponent {}
                ''');

                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
              });

              test('a stateful Component2', () {
                setUpAndParse('''
                  @Factory()
                  UiFactory<FooProps> Foo = _\$Foo;
  
                  @Props(keyNamespace: "bar")
                  class _\$FooProps {}
  
                  class FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {}
  
                  @State(keyNamespace: "baz")
                  class _\$FooState extends _\$FooState with _\$FooStateAccessorsMixin {}
  
                  class FooState extends _\$FooState with _\$FooStateAccessorsMixin {}
  
                  @Component2(isWrapper: true)
                  class FooComponent {}
                ''');

                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
              });

              test('a props mixin', () {
                setUpAndParse('''
                  @PropsMixin(keyNamespace: "bar")
                  class FooPropsMixin {}
                ''');
                final decl = expectSingleOfType<PropsMixinDeclaration>(declarations);
                expect(decl.propsMixin.meta.keyNamespace, 'bar');
              });

              test('a state mixin', () {
                setUpAndParse('''
                  @StateMixin(keyNamespace: "bar")
                  class FooStateMixin {}
                ''');
                final decl = expectSingleOfType<StateMixinDeclaration>(declarations);
                expect(decl.stateMixin.meta.keyNamespace, 'bar');
              });

              test('an abstract props class', () {
                setUpAndParse('''
                  @AbstractProps(keyNamespace: "bar")
                  class _\$AbstractFooProps {}
                  class AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractClassComponentDeclaration>(declarations);
                expect(decl.props.meta.keyNamespace, 'bar');
              });

              test('an abstract state class', () {
                setUpAndParse('''
                  @AbstractState(keyNamespace: "bar")
                  class _\$AbstractFooState {}
                  class AbstractFooState extends _\$AbstractFooState with _\$AbstractFooStateAccessorsMixin {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractClassComponentDeclaration>(declarations);
                expect(decl.state.meta.keyNamespace, 'bar');
              });
            });

            group('with Dart 2 only boilerplate for', () {
              test('a stateful component', () {
                setUpAndParse('''
                  @Factory()
                  UiFactory<FooProps> Foo = _\$Foo;
  
                  @Props(keyNamespace: "bar")
                  class _\$FooProps {}
  
                  @State(keyNamespace: "baz")
                  class _\$FooState {}
  
                  @Component(isWrapper: true)
                  class FooComponent {}
                ''');
                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
              });

              test('a stateful Component2', () {
                setUpAndParse('''
                  @Factory()
                  UiFactory<FooProps> Foo = _\$Foo;
  
                  @Props(keyNamespace: "bar")
                  class _\$FooProps {}
  
                  @State(keyNamespace: "baz")
                  class _\$FooState {}
  
                  @Component2(isWrapper: true)
                  class FooComponent {}
                ''');
                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
              });

              test('a props mixin', () {
                setUpAndParse('''
                  @PropsMixin(keyNamespace: "bar")
                  class _\$FooPropsMixin {}
                ''');
                final decl = expectSingleOfType<PropsMixinDeclaration>(declarations);
                expect(decl.propsMixin.meta.keyNamespace, 'bar');
              });

              test('a state mixin', () {
                setUpAndParse('''
                  @StateMixin(keyNamespace: "bar")
                  class _\$FooStateMixin {}
                ''');
                final decl = expectSingleOfType<StateMixinDeclaration>(declarations);
                expect(decl.stateMixin.meta.keyNamespace, 'bar');
              });

              test('an abstract props class', () {
                setUpAndParse('''
                  @AbstractProps(keyNamespace: "bar")
                  class _\$AbstractFooProps {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractClassComponentDeclaration>(declarations);
                expect(decl.props.meta.keyNamespace, 'bar');
              });

              test('an abstract state class', () {
                setUpAndParse('''
                  @AbstractState(keyNamespace: "bar")
                  class _\$AbstractFooState {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractClassComponentDeclaration>(declarations);
                expect(decl.state.meta.keyNamespace, 'bar');
              });
            });
          });
        });

        group('edge cases', () {
          test('empty props/state mixins', () {
            setUpAndParse(r'''
              mixin FooPropsMixin on UiProps {}
              mixin FooStateMixin on UiState {}
            ''');

            expect(declarations, unorderedEquals([
              isA<PropsMixinDeclaration>(),
              isA<StateMixinDeclaration>(),
            ]));
          });

          test('a class that kind of looks like state mixin but isn\'t', () {
            setUpAndParse(r'''
              mixin FooStateMixin<TState extends UiState> on react.Component {
                foo() {}
              }            
            ''');

            expect(declarations, isEmpty);
          });

          test('a class that kind of looks like state but isn\'t', () {
            setUpAndParse(r'''            
              class FooState {}            
            
              UiFactory<Foo> Foo = _$Foo;
              
              class FooProps extends UiProps { }
              
              class FooComponent extends UiComponent2<FooProps> {}
            ''');

            final decl = expectSingleOfType<ClassComponentDeclaration>(declarations);
            expect(decl.state, isNull);
          });

          test('multiple factories with flip-flopped names', () {
            setUpAndParse(r'''                                      
              UiFactory<FooProps> Foo = connectFlux()(ConnectedFoo);
              
              UiFactory<FooProps> ConnectedFoo = _$ConnectedFoo;
              
              class _$FooProps extends UiProps { }
              
              class FooComponent extends UiComponent2<FooProps> {}
            ''');

            final decl = expectSingleOfType<ClassComponentDeclaration>(declarations);
            expect(decl.factory.name.name, 'ConnectedFoo');
          });
        });

        group('(new syntax)', () {
          group('a component', () {
            test('that is stateless (shorthand)', () {
              setUpAndParse(r'''
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  mixin FooProps on UiProps {
                    String foo;
                  }
                  
                  class FooComponent extends UiComponent2<FooProps> {
                    render() {}
                  }
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<ClassComponentDeclaration>(),
              ]));

              final propsMixinDecl = declarations.firstWhereType<PropsMixinDeclaration>();
              expect(propsMixinDecl.propsMixin?.name?.name, 'FooProps');

              final decl = declarations.firstWhereType<ClassComponentDeclaration>();

              expect(decl.factory?.name?.name, 'Foo');
              expect(decl.props?.b?.name?.name, 'FooProps');
              expect(decl.component?.name?.name, 'FooComponent');
              expect(decl.state?.either, isNull);

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.b.meta, isA<annotations.Props>());
              expect(decl.component.meta, isA<annotations.Component>());
            });

            test('that is stateless (verbose)', () {
              setUpAndParse(r'''
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  mixin FooPropsMixin on UiProps {
                    String foo;
                  }
                  
                  class FooProps = UiProps with FooPropsMixin;
                  
                  class FooComponent extends UiComponent2<FooProps> {
                    render() {}
                  }
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<ClassComponentDeclaration>(),
              ]));

              final propsMixinDecl = declarations.firstWhereType<PropsMixinDeclaration>();
              expect(propsMixinDecl.propsMixin?.name?.name, 'FooPropsMixin');

              final decl = declarations.firstWhereType<ClassComponentDeclaration>();

              expect(decl.factory?.name?.name, 'Foo');
              expect(decl.props?.a?.name?.name, 'FooProps');
              expect(decl.component?.name?.name, 'FooComponent');
              expect(decl.state?.either, isNull);

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.a.meta, isA<annotations.Props>());
              expect(decl.component.meta, isA<annotations.Component>());
            });

            test('that is stateful', () {
              setUpAndParse(r'''
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  mixin FooProps on UiProps {
                    String foo;
                  }
                  
                  mixin FooState on UiState {
                    String bar;
                  }
                  
                  class FooComponent extends UiStatefulComponent2<FooProps, FooState> {
                    render() {}
                  }
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<StateMixinDeclaration>(),
                isA<ClassComponentDeclaration>(),
              ]));

              final propsMixinDecl = declarations.firstWhereType<PropsMixinDeclaration>();
              expect(propsMixinDecl.propsMixin?.name?.name, 'FooProps');

              final stateMixinDecl = declarations.firstWhereType<StateMixinDeclaration>();
              expect(stateMixinDecl.stateMixin?.name?.name, 'FooState');

              final decl = declarations.firstWhereType<ClassComponentDeclaration>();

              expect(decl.factory?.name?.name, 'Foo');
              expect(decl.props?.b?.name?.name, 'FooProps');
              expect(decl.component?.name?.name, 'FooComponent');
              expect(decl.state?.b?.name?.name, 'FooState');

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.b.meta, isA<annotations.Props>());
              expect(decl.state.b.meta, isA<annotations.State>());
              expect(decl.component.meta, isA<annotations.Component>());
            });

            test('that is stateful (verbose)', () {
              setUpAndParse(r'''
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  mixin FooPropsMixin on UiProps {
                    String foo;
                  }
                  
                  class FooProps = UiProps with FooPropsMixin;
                  
                  mixin FooStateMixin on UiState {
                    String bar;
                  }
                  
                  class FooState = UiState with FooStateMixin;
                  
                  class FooComponent extends UiStatefulComponent2<FooProps, FooState> {
                    render() {}
                  }
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<StateMixinDeclaration>(),
                isA<ClassComponentDeclaration>(),
              ]));

              final propsMixinDecl = declarations.firstWhereType<PropsMixinDeclaration>();
              expect(propsMixinDecl.propsMixin?.name?.name, 'FooPropsMixin');

              final stateMixinDecl = declarations.firstWhereType<StateMixinDeclaration>();
              expect(stateMixinDecl.stateMixin?.name?.name, 'FooStateMixin');

              final decl = declarations.firstWhereType<ClassComponentDeclaration>();

              expect(decl.factory?.name?.name, 'Foo');
              expect(decl.props?.a?.name?.name, 'FooProps');
              expect(decl.component?.name?.name, 'FooComponent');
              expect(decl.state?.a?.name?.name, 'FooState');

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.a.meta, isA<annotations.Props>());
              expect(decl.state.a.meta, isA<annotations.State>());
              expect(decl.component.meta, isA<annotations.Component>());
            });
          });

          test('props mixins', () {
            setUpAndParse(r'''
              mixin FooPropsMixin on UiProps {}
              mixin BarPropsMixin on UiProps {}
              mixin BazPropsMixin on UiProps {}
            ''');

            final mixins = expectLengthAndAllOfType<PropsMixinDeclaration>(declarations, 3);

            expect(mixins.map((m) => m.propsMixin.name.name).toList(),
                ['FooPropsMixin', 'BarPropsMixin', 'BazPropsMixin']);
          });
          
          test('state mixins', () {
            setUpAndParse(r'''
              mixin FooStateMixin on UiState {}
              mixin BarStateMixin on UiState {}
              mixin BazStateMixin on UiState {}
            ''');

            final mixins = expectLengthAndAllOfType<StateMixinDeclaration>(declarations, 3);

            expect(mixins.map((m) => m.stateMixin.name.name).toList(),
                ['FooStateMixin', 'BarStateMixin', 'BazStateMixin']);
          });

          test('abstract props class', () {
            setUpAndParse(r'''
              abstract class FooProps implements UiProps, BarProps {}
            ''');
            expect(declarations, isEmpty);
          });

          test('abstract state class', () {
            setUpAndParse(r'''
              abstract class FooState implements UiState, BarState {}
            ''');
            expect(declarations, isEmpty);
          });

          group('and initializes annotations with the correct arguments', () {
            group('a stateful component (using non-mixin annotations)', () {
              test('(using non-mixin annotations)', () {
                setUpAndParse(r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;

                  @Props(keyNamespace: "bar")
                  mixin FooProps on UiProps {}

                  @State(keyNamespace: "baz")
                  mixin FooState on UiState {}

                  @Component2(isWrapper: true, subtypeOf: BarComponent)
                  class FooComponent extends Component2 {
                    render() {}
                  }
                ''');

                expect(declarations, contains(isA<ClassComponentDeclaration>()));
                final decl = declarations.firstWhereType<ClassComponentDeclaration>();

                expect(decl.props.b.meta.keyNamespace, 'bar');
                expect(decl.state.b.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
                expect(decl.component.configSubtypeOf?.name, 'BarComponent');
              });

              test('(using mixin annotations)', () {
                setUpAndParse(r'''
                  @Factory()
                  UiFactory<FooProps> Foo = _$Foo;
  
                  @PropsMixin(keyNamespace: "bar")
                  mixin FooProps on UiProps {}
  
                  @StateMixin(keyNamespace: "baz")
                  mixin FooState on UiState {}
  
                  @Component2(isWrapper: true, subtypeOf: BarComponent)
                  class FooComponent extends Component2 {
                    render() {}
                  }
                ''');

                expect(declarations, contains(isA<ClassComponentDeclaration>()));
                final decl = declarations.firstWhereType<ClassComponentDeclaration>();

                expect(decl.props.b.meta.keyNamespace, 'bar');
                expect(decl.state.b.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
                expect(decl.component.configSubtypeOf?.name, 'BarComponent');
              });
            });

            test('a props mixin', () {
              setUpAndParse('''
                @PropsMixin(keyNamespace: "bar")
                mixin FooPropsMixin on UiProps {}
              ''');
              final decl = expectSingleOfType<PropsMixinDeclaration>(declarations);
              expect(decl.propsMixin.meta.keyNamespace, 'bar');
            });

            test('a state mixin', () {
              setUpAndParse('''
                @StateMixin(keyNamespace: "bar")
                mixin FooStateMixin on UiState {}
              ''');
              final decl = expectSingleOfType<StateMixinDeclaration>(declarations);
              expect(decl.stateMixin.meta.keyNamespace, 'bar');
            });
          });
        });
      });

      const String restOfComponent = '''
        @Props()
        class _\$FooProps {}

        @Component()
        class FooComponent {}
      ''';

      group('does not log a hard error when', () {
        group('the factory is', () {
          group('public and initialized with', () {
            test('correct _\$ prefixed variable name', () {
              setUpAndParse('''
                @Factory()
                UiFactory<FooProps> Foo = _\$Foo;

                $restOfComponent
              ''');

              verifyNever(logger.severe(any));
            });
          });

          group('private and initialized with', () {
            test('correct _\$ prefixed variable name', () {
              setUpAndParse('''
                @Factory()
                UiFactory<FooProps> _Foo = _\$_Foo;

                $restOfComponent
              ''');

              verifyNever(logger.severe(any));
            });
          });
        });
      });

      group('and logs a hard error when', () {
        void verifyErrorLog(String publicClassName) {
          verify(logger.severe(contains(
            'Non-static class member `meta` is declared in _\$$publicClassName. '
            '`meta` is a field declared by the over_react builder, and is therefore not '
            'valid for use as a class member in any class annotated with  @Props(), @State(), '
            '@AbstractProps(), @AbstractState(), @PropsMixin(), or @StateMixin()'
          )));
        }

        void verifyMetaErrors(String body) {
          test('a props class', () {
            final ors = OverReactSrc.props(backwardsCompatible: false, body: body);
            setUpAndParse(ors.source);
            verifyErrorLog(ors.propsClassName);
          });

          test('a state class', () {
            final ors = OverReactSrc.state(backwardsCompatible: false, body: body);
            setUpAndParse(ors.source);
            verifyErrorLog(ors.stateClassName);
          });

          test('an abstract props class', () {
            final ors = OverReactSrc.abstractProps(backwardsCompatible: false, body: body);
            setUpAndParse(ors.source);
            verifyErrorLog(ors.propsClassName);
          });

          test('an abstract state class', () {
            final ors = OverReactSrc.abstractState(backwardsCompatible: false, body: body);
            setUpAndParse(ors.source);
            verifyErrorLog(ors.stateClassName);
          });

          test('a props mixin class', () {
            final ors = OverReactSrc.propsMixin(backwardsCompatible: false, body: body);
            setUpAndParse(ors.source);
            verifyErrorLog(ors.propsMixinClassName);
          });

          test('a state mixin class', () {
            final ors = OverReactSrc.stateMixin(backwardsCompatible: false, body: body);
            setUpAndParse(ors.source);
            verifyErrorLog(ors.stateMixinClassName);
          });
        }

        group('non-static `meta` field is declared in', () {
          const body = 'String meta;';
          verifyMetaErrors(body);
        });

        group('non-static `meta` method is declared in', () {
          const body = 'String get meta => \'do not do this\';';
          verifyMetaErrors(body);
        });

        group('there is not Dart-2 compatible naming on', () {
          test('a class annotated with @Props()', () {
            setUpAndParse(propsSrcDart1 + componentSrc + factorySrc);
            verify(logger.severe(contains(
                'The class `FooProps` does not start with `_\$`. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with `_\$` on Dart 2')));
          });

          test('a class annotated with @State()', () {
            setUpAndParse(stateSrcDart1 + componentSrc + propsSrc + companionClassProps + factorySrc);
            verify(logger.severe(contains(
                'The class `FooState` does not start with `_\$`. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with `_\$` on Dart 2')));
          });

          test('a class annotated with @AbstractProps()', () {
            setUpAndParse(abstractPropsSrcDart1 + abstractComponentSrc);
            verify(logger.severe(contains(
                'The class `AbstractFooProps` does not start with `_\$`. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with `_\$` on Dart 2')));
          });

          test('a class annotated with @AbstractState()', () {
            setUpAndParse(abstractStateSrcDart1 + abstractComponentSrc + abstractPropsSrc);
            verify(logger.severe(contains(
                'The class `AbstractFooState` does not start with `_\$`. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with `_\$` on Dart 2')));
          });
        });

        group('a component is declared without', () {
          test('a factory', () {
            setUpAndParse(propsSrc + companionClassProps + componentSrc);
            verify(logger.severe(contains(errorNoFactory)));
          });

          test('a props class', () {
            setUpAndParse(factorySrc + componentSrc);
            verify(logger.severe(contains(errorNoProps)));
          });

          test('a component class', () {
            setUpAndParse(factorySrc + propsSrc);
            verify(logger.severe(contains(errorNoComponent)));
          });

          test('a factory or a props class', () {
            setUpAndParse(componentSrc);
            verify(logger.severe(contains(errorComponentClassOnly)));
          });

          test('a factory or a props class (v2 component)', () {
            setUpAndParse(component2Src);
            verify(logger.severe(contains(errorComponentClassOnly)));
          });

          test('a factory or a component class', () {
            setUpAndParse(propsSrc);
            verify(logger.severe(contains(errorPropsClassOnly)));;
          });

          test('a component or props class', () {
            setUpAndParse(factorySrc);
            verify(logger.severe(contains(errorFactoryOnly)));
          });
        });

        group('a state class is declared without', () {
          test('any component pieces', () {
            setUpAndParse(stateSrc);
            verify(logger.severe(contains(errorStateOnly)));
          });

          test('some component pieces', () {
            setUpAndParse(stateSrc + componentSrc);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger.severe(contains(errorComponentClassOnly)));
          });

          test('some component2 pieces', () {
            setUpAndParse(stateSrc + component2Src);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger.severe(contains(errorComponentClassOnly)));
          });
        });

        test('a component v2 uses legacy lifecycle methods', () {
          setUpAndParse(factorySrc + propsSrc + component2LegacySrc);
          /// Should log for each legacy method, suggesting the alternative.
          verify(logger.severe(contains('Use getDerivedStateFromProps instead.')));
          verify(logger.severe(contains('Use init instead.')));
          verify(logger.severe(contains('Use getSnapshotBeforeUpdate instead.')));
        });

        group('a factory is', () {
          test('declared without an initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo;

              $restOfComponent
            ''');

            verify(logger.severe(contains(
                'Factory variables are stubs for the generated factories, and should '
                  'be initialized with the valid variable name for builder compatibility. '
                  'Should be: `Foo = _\$Foo`')));
          });
          test('declared using multiple variables', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo = _\$Foo, Bar = _\$Bar;

              $restOfComponent
            ''');

            verify(logger.severe(contains('Factory declarations must be a single variable.')));
          });

          test('public and declared with an invalid initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo = \$Foo;

              $restOfComponent
            ''');

            verify(logger.severe(contains(
                'Factory variables are stubs for the generated factories, and should '
                  'be initialized with the valid variable name for builder compatibility. '
                  'Should be: `Foo = _\$Foo`')));

          });

          test('private and declared with an invalid initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> _Foo = \$_Foo;

              $restOfComponent
            ''');

            verify(logger.severe(contains(
                'Factory variables are stubs for the generated factories, and should '
                  'be initialized with the valid variable name for builder compatibility. '
                  'Should be: `_Foo = _\$_Foo`')));
          });
        });

        group('a static meta field with backwards compatible boilerplate', () {
          group('for a props class', () {
            test('has the wrong type', () {
              setUpAndParse(factorySrc + propsSrc + component2Src + '''
                class FooProps {
                  static const StateMeta meta = _\$metaForFooProps;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `PropsMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + component2Src + '''
                class FooProps {
                  static const PropsMeta meta = \$metaForBarProps;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooProps`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse(factorySrc + privatePropsSrc + component2Src + '''
                class _FooProps {
                  static const PropsMeta meta = \$metaForFooProps;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_FooProps`')));
            });
          });

          group('for a state class', () {
            test('has the wrong type', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + stateSrc + component2Src + '''
                class FooState {
                  static const PropsMeta meta = _\$metaForFooState;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `StateMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + stateSrc + component2Src + '''
                class FooState {
                  static const StateMeta meta = \$metaForBarState;
                }
              ''');
              verify(logger.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooState`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + component2Src + privateStateSrc + '''
                class _FooState {
                  static const StateMeta meta = \$metaForBarState;
                }
              ''');
              verify(logger.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_FooState`')));
            });
          });

          group('for an abstract props class', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @AbstractProps() abstract class _\$AbstractFooProps {}
                abstract class AbstractFooProps {
                  static const StateMeta meta = _\$metaForAbstractFooProps;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `PropsMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @AbstractProps() abstract class _\$AbstractFooProps {}
                abstract class AbstractFooProps {
                  static const PropsMeta meta = \$metaForAbstractBarProps;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                    '`_\$metaForAbstractFooProps`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @AbstractProps() abstract class _\$_AbstractFooProps {}
                abstract class _AbstractFooProps {
                  static const PropsMeta meta = \$metaForAbstractBarProps;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                    '`_\$metaFor_AbstractFooProps`')));
            });
          });

          group('for an abstract state class', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @AbstractState() abstract class _\$AbstractFooState {}
                abstract class AbstractFooState {
                  static const PropsMeta meta = _\$metaForAbstractFooState;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `StateMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @AbstractState() abstract class _\$AbstractFooState {}
                abstract class AbstractFooState {
                  static const StateMeta meta = \$metaForAbstractBarState;
                }
              ''');
              verify(logger.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaForAbstractFooState`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @AbstractState() abstract class _\$_AbstractFooState {}
                abstract class _AbstractFooState {
                  static const StateMeta meta = \$metaForAbstractBarState;
                }
              ''');
              verify(logger.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_AbstractFooState`')));
            });
          });

          group('for a props mixin', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @PropsMixin() abstract class FooPropsMixin {
                  static const StateMeta meta = _\$metaForFooPropsMixin;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `PropsMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @PropsMixin() abstract class FooPropsMixin {
                  static const PropsMeta meta = \$metaForBarPropsMixin;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooPropsMixin`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @PropsMixin() abstract class _FooPropsMixin {
                  static const PropsMeta meta = \$metaForBarPropsMixin;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_FooPropsMixin`')));
            });
          });

          group('for a state mixin', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @StateMixin() abstract class FooStateMixin {
                  static const PropsMeta meta = _\$metaForFooStateMixin;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `StateMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @StateMixin() abstract class FooStateMixin {
                  static const StateMeta meta = \$metaForBarStateMixin;
                }
              ''');
              verify(logger.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooStateMixin`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @StateMixin() abstract class _FooStateMixin {
                  static const StateMeta meta = \$metaForBarStateMixin;
                }
              ''');
              verify(logger.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_FooStateMixin`')));
            });
          });
        });
      });

      group('and logs a warning when', () {
        group('on Dart 2 only boilerplate', () {
          group('a static `meta` field is declared in ', () {
            void verifyWarningLog(String publicClassName) {
              verify(logger.warning(contains(
                'Static class member `meta` is declared in _\$$publicClassName. '
                '`meta` is a field declared by the over_react builder, and therefore this '
                'class member will be unused and should be removed or renamed.'
              )));
            }

            void verifyMetaWarnings(String body) {
              test('a props class', () {
                final ors = OverReactSrc.props(backwardsCompatible: false, body: body);
                setUpAndParse(ors.source);
                verifyWarningLog(ors.propsClassName);
              });

              test('a state class', () {
                final ors = OverReactSrc.state(backwardsCompatible: false, body: body);
                setUpAndParse(ors.source);
                verifyWarningLog(ors.stateClassName);
              });

              test('an abstract props class', () {
                final ors = OverReactSrc.abstractProps(backwardsCompatible: false, body: body);
                setUpAndParse(ors.source);
                verifyWarningLog(ors.propsClassName);
              });

              test('an abstract state class', () {
                final ors = OverReactSrc.abstractState(backwardsCompatible: false, body: body);
                setUpAndParse(ors.source);
                verifyWarningLog(ors.stateClassName);
              });

              test('a props mixin class', () {
                final ors = OverReactSrc.propsMixin(backwardsCompatible: false, body: body);
                setUpAndParse(ors.source);
                verifyWarningLog(ors.propsMixinClassName);
              });

              test('a state mixin class', () {
                final ors = OverReactSrc.stateMixin(backwardsCompatible: false, body: body);
                setUpAndParse(ors.source);
                verifyWarningLog(ors.stateMixinClassName);
              });
            }

            group('static `meta` field is declared in', () {
              const body = 'static const String meta = "foo";';
              verifyMetaWarnings(body);
            });

            group('static `meta` method is declared in', () {
              const body = 'static String get meta => \'do not do this\';';
              verifyMetaWarnings(body);
            });
          });
        });
      });

      group('and throws an error when', () {
        group('`subtypeOf` is an unsupported expression that is not an identifier', () {
          void sharedUnsupportedExpressionTest(String componentAnnotationName) {
            expect(() {
              setUpAndParse('''
                @Factory()
                UiFactory<FooProps> Foo = _\$Foo;

                @Props()
                class _\$FooProps {}

                @$componentAnnotationName(subtypeOf: const [])
                class FooComponent {}
              ''');
            }, throwsA(startsWith('`subtypeOf` must be an identifier')));
          }

          test('within a @Component() annotation (deprecated)', () {
            sharedUnsupportedExpressionTest('Component');
          });

          test('within a @Component2() annotation', () {
            sharedUnsupportedExpressionTest('Component2');
          });
        });
      });
    });
  });
}
