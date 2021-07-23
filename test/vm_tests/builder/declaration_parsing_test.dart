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
import 'package:collection/collection.dart' show IterableExtension;
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react/src/builder/parsing.dart';
import 'package:over_react/src/builder/parsing/member_association.dart';
import 'package:over_react/src/builder/parsing/error_collection.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import './util.dart';
import 'parsing/parsing_helpers.dart';

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
        }
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
      MockLogger? logger;
      SourceFile? sourceFile;
      CompilationUnit? unit;
      List<BoilerplateDeclaration>? declarations;

      void setUpAndParse(String source) {
        logger = MockLogger();
        sourceFile = SourceFile.fromString(source);
        unit = parseString(content: source).unit;

        final errorCollector = ErrorCollector.log(sourceFile!, logger!);

        final members = detectBoilerplateMembers(unit!);
        declarations = getBoilerplateDeclarations(members, errorCollector).toList();
        for (var declaration in declarations!) {
          declaration.validate(errorCollector);
        }
      }

      void verifyNoMoreErrorLogs() {
        verifyNever(logger!.warning(any));
        verifyNever(logger!.severe(any));
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
              final decl = declarations![0] as LegacyClassComponentDeclaration;

              expect(decl.component, isNotNull);
              expect(decl.factory.name.name, ors.prefixedBaseName);
              expect(decl.props.name.name, '_\$${ors.prefixedBaseName}Props');

              expect(decl.props.meta, isA<annotations.Props>());

              if (isStatefulComponent) {
                expect(decl.state?.name.name, '_\$${ors.prefixedBaseName}State');
                expect(decl.state!.meta, isA<annotations.State>());
              }

              expect(decl.component.name.name, '${ors.prefixedBaseName}Component');

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

            test('with a factory that references the _\$ prefixed variable name', () {
              setUpAndParse(r'''
                @Factory()
                UiFactory<FooProps> Foo = connect(
                  mapStateToProps: (state) => _$Foo()..foo = state.foo,
                )(_$Foo);
                
                @Props()
                class _$FooProps extends UiProps {}
                  
                @Component()
                class FooComponent extends UiComponent<FooProps> {
                  render() {}
                }
              ''');

              final component = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);
              expect(component.factory.name.name, 'Foo');
              expect(component.props.name.name, endsWith('FooProps'));
              expect(component.state, isNull);
              expect(component.component.name.name, 'FooComponent');
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

                final component = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);
                expect(component.factory.name.name, 'Foo');
                expect(component.props.name.name, endsWith('BarProps'));
                expect(component.state, isNull);
                expect(component.component.name.name, 'BazComponent');
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

                final component = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);
                expect(component.factory.name.name, 'Foo');
                expect(component.props.name.name, endsWith('BarProps'));
                expect(component.state?.name.name, endsWith('QuxState'));
                expect(component.component.name.name, 'BazComponent');
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

                final component = declarations!.firstWhereType<LegacyClassComponentDeclaration>()!;
                expect(component.factory.name.name, 'Foo');
                expect(component.props.name.name, endsWith('BarProps'));
                expect(component.state, isNull);
                expect(component.component.name.name, 'BazComponent');
              });
            });

            group('missing generic params referencing props class', () {
              @isTest
              void sharedGenericTest(String name, String source) {
                test(name, () {
                  setUpAndParse(source);

                  final component = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);
                  expect(component.factory.name.name, 'Foo');
                  expect(component.props.name.name, endsWith('FooProps'));
                  expect(component.state, isNull);
                  expect(component.component.name.name, 'FooComponent');
                });
              }

              sharedGenericTest('on factory', r'''
                @Factory()
                UiFactory Foo = _$Foo;
                
                @Props()
                class _$FooProps extends UiProps {}
                
                @Component()
                class FooComponent extends UiComponent<FooProps> {
                  render() {}
                }
                
                class FooProps extends _$BarProps {}
              ''');

              sharedGenericTest('on component', r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;
                
                @Props()
                class _$FooProps extends UiProps {}
                
                @Component()
                class FooComponent extends UiComponent {
                  render() {}
                }
                
                class FooProps extends _$BarProps {}
              ''');

              sharedGenericTest('on both', r'''
                @Factory()
                UiFactory Foo = _$Foo;
                
                @Props()
                class _$FooProps extends UiProps {}
                
                @Component()
                class FooComponent extends UiComponent {
                  render() {}
                }
                
                class FooProps extends _$BarProps {}
              ''');
            });
          });

          group('props mixins', () {
            void testPropsMixins(String source, List<String> mixinNames) {
              setUpAndParse(source);

              expect(declarations, hasLength(mixinNames.length));
              final mixins = expectAllOfType<PropsMixinDeclaration>(declarations!);

              for (var mixin in mixins) {
                expect(mixinNames, contains(mixin.mixin.name.name));
                expect(mixin.mixin.meta, isA<annotations.PropsMixin>());
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
              final mixins = expectAllOfType<StateMixinDeclaration>(declarations!);

              for (var mixin in mixins) {
                expect(mixinNames, contains(mixin.mixin.name.name));
                expect(mixin.mixin.meta, isA<annotations.StateMixin>());
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
            void testAbstractPropsDualClassSetup({bool backwardsCompatible = true, bool isPrivate = false}) {
              final ors = OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, isPrivate: isPrivate);
              setUpAndParse(ors.source);

              final decl = expectSingleOfType<LegacyAbstractPropsDeclaration>(declarations!);

              expect(decl.props, isNotNull);

              expect(decl.props.name.name, '_\$${ors.prefixedBaseName}Props');
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
            void testAbstractStateDualClassSetup({bool backwardsCompatible = true, bool isPrivate = false}) {
              final ors = OverReactSrc.abstractState(backwardsCompatible: true, isPrivate: isPrivate);
              setUpAndParse(ors.source);

              final decl = expectSingleOfType<LegacyAbstractStateDeclaration>(declarations!);

              expect(decl.state, isNotNull);

              expect(decl.state.name.name, '_\$${ors.prefixedBaseName}State');
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

                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state!.meta.keyNamespace, 'baz');
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

                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state!.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
              });

              test('a props mixin', () {
                setUpAndParse('''
                  @PropsMixin(keyNamespace: "bar")
                  class FooPropsMixin {
                    Map get props;
                  }
                ''');
                final decl = expectSingleOfType<PropsMixinDeclaration>(declarations!);
                expect(decl.mixin.meta.keyNamespace, 'bar');
              });

              test('a state mixin', () {
                setUpAndParse('''
                  @StateMixin(keyNamespace: "bar")
                  class FooStateMixin {
                    Map get state;
                  }
                ''');
                final decl = expectSingleOfType<StateMixinDeclaration>(declarations!);
                expect(decl.mixin.meta.keyNamespace, 'bar');
              });

              test('an abstract props class', () {
                setUpAndParse('''
                  @AbstractProps(keyNamespace: "bar")
                  class _\$AbstractFooProps {}
                  class AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractPropsDeclaration>(declarations!);
                expect(decl.props.meta.keyNamespace, 'bar');
              });

              test('an abstract state class', () {
                setUpAndParse('''
                  @AbstractState(keyNamespace: "bar")
                  class _\$AbstractFooState {}
                  class AbstractFooState extends _\$AbstractFooState with _\$AbstractFooStateAccessorsMixin {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractStateDeclaration>(declarations!);
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
                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state!.meta.keyNamespace, 'baz');
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
                final decl = expectSingleOfType<LegacyClassComponentDeclaration>(declarations!);

                expect(decl.props.meta.keyNamespace, 'bar');
                expect(decl.state!.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
              });

              test('a props mixin', () {
                setUpAndParse('''
                  @PropsMixin(keyNamespace: "bar")
                  class _\$FooPropsMixin {
                    Map get props;
                  }
                ''');
                final decl = expectSingleOfType<PropsMixinDeclaration>(declarations!);
                expect(decl.mixin.meta.keyNamespace, 'bar');
              });

              test('a state mixin', () {
                setUpAndParse('''
                  @StateMixin(keyNamespace: "bar")
                  class _\$FooStateMixin {
                    Map get state;
                  }
                ''');
                final decl = expectSingleOfType<StateMixinDeclaration>(declarations!);
                expect(decl.mixin.meta.keyNamespace, 'bar');
              });

              test('an abstract props class', () {
                setUpAndParse('''
                  @AbstractProps(keyNamespace: "bar")
                  class _\$AbstractFooProps {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractPropsDeclaration>(declarations!);
                expect(decl.props.meta.keyNamespace, 'bar');
              });

              test('an abstract state class', () {
                setUpAndParse('''
                  @AbstractState(keyNamespace: "bar")
                  class _\$AbstractFooState {}
                ''');
                final decl = expectSingleOfType<LegacyAbstractStateDeclaration>(declarations!);
                expect(decl.state.meta.keyNamespace, 'bar');
              });
            });
          });
        });

        group('edge cases', () {
          test('a legacy props mapview class named like a normal props class', () {
            setUpAndParse(r'''            
              class FooProps extends UiProps with FooPropsMixin {
                @override
                final Map props;
              
                FooProps([Map backingMap]) : props = backingMap ?? {};
              }
            ''');

            final props = expectAllOfType<BoilerplateProps>(declarations!).firstOrNull;
            expect(props?.versionConfidences.maxConfidence.confidence, anyOf(isNull, Confidence.none));
          });

          test('a props class that should not be generated', () {
            setUpAndParse(r'''            
              class ManualProps extends UiProps {
                @override
                bool get $isClassGenerated => true;
              }
            ''');

            final props = expectAllOfType<BoilerplateProps>(declarations!).firstOrNull;
            expect(props?.versionConfidences.maxConfidence.confidence, anyOf(isNull, Confidence.none));
          });

          test('a props class that acts solely as an interface', () {
            setUpAndParse(r'''            
              abstract class FooProps implements UiProps, BarProps, BazProps {}
            ''');

            final props = expectAllOfType<BoilerplateProps>(declarations!).firstOrNull;
            expect(props?.versionConfidences.maxConfidence.confidence, anyOf(isNull, Confidence.none));
          });

          test('empty props/state mixins (regression test for these being skipped)', () {
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

            final decl = expectSingleOfType<ClassComponentDeclaration>(declarations!);
            expect(decl.state, isNull);
          });

          test('multiple factories with flip-flopped names', () {
            setUpAndParse(r'''                                      
              UiFactory<FooProps> Foo = connectFlux()(ConnectedFoo);
              
              UiFactory<FooProps> ConnectedFoo = _$ConnectedFoo;
              
              class _$FooProps extends UiProps { }
              
              class FooComponent extends UiComponent2<FooProps> {}
            ''');

            final decl = expectSingleOfType<ClassComponentDeclaration>(declarations!);
            expect(decl.factory.name.name, 'ConnectedFoo');
          });

          test('alias factories', () {
            setUpAndParse(r'''                                      
              UiFactory<FormActionInputProps> FormSubmitInput = ([backingMap]) =>
                  _FormActionInput(backingMap)..type = 'submit';
              
              UiFactory<FormActionInputProps> FormResetInput = ([backingMap]) =>
                  _FormActionInput(backingMap)..type = 'reset';
                  
              // Put this last so we know it's not getting picked just because it comes
              // before the other factories.    
              UiFactory<FormActionInputProps> _FormActionInput = _$_FormActionInput;
              
              mixin FormActionInputProps on UiProps {
                String type;
              }
              
              class FormActionInputComponent extends UiComponent2<FormActionInputProps> {}
            ''');

            expect(declarations, unorderedEquals([
              isA<ClassComponentDeclaration>(),
              isA<PropsMixinDeclaration>(),
            ]));

            final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;
            expect(decl.factory.name.name, '_FormActionInput');
          });

          test('more than one factory using a props mixin as a shorthand declaration', () {
            setUpAndParse(r'''                                      
              UiFactory<FooProps> Foo1 = _$Foo1;
              
              UiFactory<FooProps> Foo2 = _$Foo2;
              
              mixin FooProps on UiProps {}
              
              class FooComponent extends UiComponent2<FooProps> {}
            ''');

            expect(declarations, unorderedEquals([
              isA<ClassComponentDeclaration>(),
              isA<PropsMixinDeclaration>(),
            ]), reason: 'should parse the mixin and one of the factories properly');

            verify(logger!.severe(contains(errorFactoryOnly)));
          });

          test('multiple factories aliasing a private factory', () {
            setUpAndParse(r'''                                      
                UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
                  mapStateToProps: (state) => _Counter(),
                )(_Counter);
                
                UiFactory<CounterProps> CounterWithDifferentContext = connect<CounterState, CounterProps>(
                  mapStateToProps: (state) => _Counter(),
                  context: bigCounterContext,
                )(_Counter);
                
                UiFactory<CounterProps> _Counter = _$_Counter;
                
                mixin CounterPropsMixin on UiProps {}
                
                class CounterProps = UiProps with CounterPropsMixin, ConnectPropsMixin;
                
                class CounterComponent extends UiComponent2<CounterProps> {}
            ''');

            expect(declarations, unorderedEquals([
              isA<ClassComponentDeclaration>(),
              isA<PropsMixinDeclaration>(),
            ]));

            final componentDecl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

            expect(componentDecl.factory.name.name, '_Counter');
          });

          group('mismatched members names for legacy component', () {
            test('Version.v2_legacyBackwardsCompat', () {
              setUpAndParse(r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;

                @Props()
                class _$SomeRandomProps {}
                
                @State()
                class _$DifferentState {}
                
                @Component2() 
                class FooComponent extends UiStatefulComponent2<SomeRandomProps, DifferentState> {}
                
                class SomeRandomProps
                    extends _$SomeRandomProps with _$SomeRandomPropsAccessorsMixin {
                
                  static const PropsMeta meta = _$metaForSomeRandomProps;
                }

                class DifferentState
                    extends _$DifferentState with _$DifferentStateAccessorsMixin {
                
                  static const StateMeta meta = _$metaForDifferentState;
                }
              ''');

              final declaration = declarations!.firstWhereType<LegacyClassComponentDeclaration>()!;
              expect(declaration, isNotNull, reason: 'Sanity check to make sure a component is detected');

              expect(declaration.state, isNotNull, reason: 'A state class should have been detected');
              expect(declaration.state!.name.name, r'_$DifferentState');
              expect(declaration.state!.companion, isNotNull);

              expect(declaration.props, isNotNull, reason: 'A props class should have been detected');
              expect(declaration.props.name.name, r'_$SomeRandomProps');
              expect(declaration.props.companion, isNotNull);
            });

            test('Version.v3_legacyDart2Only', () {
              setUpAndParse(r'''
                @Factory()
                UiFactory<FooProps> Foo = _$Foo;
                
                @Props()
                class _$SomeRandomProps {}
                
                @State()
                class _$DifferentState {}
                
                @Component2() 
                class FooComponent extends UiStatefulComponent2<SomeRandomProps, DifferentState> {}
              ''');

              final declaration = declarations!.firstWhereType<LegacyClassComponentDeclaration>()!;
              expect(declaration, isNotNull, reason: 'Sanity check to make sure a component is detected');

              expect(declaration.state, isNotNull, reason: 'A state class should have been detected');
              expect(declaration.state!.name.name, r'_$DifferentState');
              expect(declaration.state!.companion, isNull);

              expect(declaration.props, isNotNull, reason: 'A props class should have been detected');
              expect(declaration.props.name.name, r'_$SomeRandomProps');
              expect(declaration.props.companion, isNull);
            });
          });

          group('multiple components in the same file', () {
            void testTwoComponents(BoilerplateVersions nonMixinVersion) {
              setUp(() {
                setUpAndParse('''
                  ${getBoilerplateString(version: BoilerplateVersions.v4, componentBaseName: 'FirstFoo')}
    
                  ${getBoilerplateString(version: nonMixinVersion, componentBaseName: 'SecondFoo')}
                ''');
              });

              test('detects the correct number of components', () {
                expect(declarations!.whereType<ClassComponentDeclaration>().length, 1,
                    reason: 'The mixin boilerplate should be the only thing found.');
                expect(declarations!.whereType<LegacyClassComponentDeclaration>().length, 1,
                    reason: 'The legacy component string should be the only thing found');
              });

              test('with names that match expectations', () {
                final mixinBasedMember = declarations!
                    .whereType<ClassComponentDeclaration>()
                    .firstWhereNameEquals('FirstFoo');
                final legacyBasedName = declarations!
                    .whereType<LegacyClassComponentDeclaration>()
                    .firstWhereNameEquals('SecondFoo');
                expect(mixinBasedMember, isNotNull);
                expect(legacyBasedName, isNotNull);
              });

              test('that are the correct version', () {
                final versionForMixin =
                resolveVersion(declarations!.firstWhereType<ClassComponentDeclaration>()!.members);
                final versionForLegacy = resolveVersion(
                    declarations!.firstWhereType<LegacyClassComponentDeclaration>()!.members);

                expect(versionForMixin.version, Version.v4_mixinBased);
                expect(
                    versionForLegacy.version,
                    nonMixinVersion == BoilerplateVersions.v2
                        ? Version.v2_legacyBackwardsCompat
                        : Version.v3_legacyDart2Only);
              });
            }

            group('and there is one legacy and one is v4_mixinBased', () {
              group('and the legacy version is a v2_legacyBackwardsCompat component', () {
                testTwoComponents(BoilerplateVersions.v2);
              });

              group('and the legacy version is a v3_legacyDart2Only', () {
                testTwoComponents(BoilerplateVersions.v3);
              });
            });

            group('and they are mixin based', () {
              late Iterable<ClassComponentDeclaration> componentDeclarations;

              setUp(() {
                setUpAndParse('''
                  ${getBoilerplateString(version: BoilerplateVersions.v4, componentBaseName: 'FirstFoo')}
    
                  ${getBoilerplateString(version: BoilerplateVersions.v4, componentBaseName: 'SecondFoo')}
                ''');

                componentDeclarations = declarations!.whereType<ClassComponentDeclaration>();
              });

              test('detects the correct number of components', () {
                expect(componentDeclarations.length, 2,
                    reason: 'There should be two different components.');
              });

              test('with names that match expectations', () {
                final firstComponent = componentDeclarations.firstWhereNameEquals('FirstFoo');
                final secondComponent = componentDeclarations.firstWhereNameEquals('SecondFoo');
                expect(firstComponent, isNotNull);
                expect(secondComponent, isNotNull);
              });

              test('that are the correct version', () {
                final versionForFirstMixin =
                    resolveVersion(componentDeclarations.firstWhereNameEquals('FirstFoo')!.members);
                final versionForSecondMixin =
                    resolveVersion(componentDeclarations.firstWhereNameEquals('SecondFoo')!.members);

                expect(versionForFirstMixin.version, Version.v4_mixinBased);
                expect(versionForSecondMixin.version, Version.v4_mixinBased);
              });
            });

            group('and there is a mix of abstract and concrete', () {
              late Iterable<LegacyClassComponentDeclaration> componentDeclarations;

              setUp(() {
                setUpAndParse('''
                  ${OverReactSrc.abstractState(needsComponent: false, baseName: 'StateFoo').source}
                  
                  ${OverReactSrc.abstractProps(needsComponent: false, baseName: 'PropsFoo').source}
    
                  ${getBoilerplateString(version: BoilerplateVersions.v2, componentBaseName: 'SecondFoo')}
                  
                  ${getBoilerplateString(version: BoilerplateVersions.v3, componentBaseName: 'ThirdFoo')}
                ''');

                componentDeclarations = declarations!.whereType<LegacyClassComponentDeclaration>();
              });

              test('detects the correct number of components', () {
                expect(componentDeclarations.length, 2,
                    reason: 'There should be two different components.');
              });

              test('with names that match expectations', () {
                final propsComponentDeclaration =
                    componentDeclarations.firstWhereNameEquals('PropsFoo');
                final stateComponentDeclaration =
                    componentDeclarations.firstWhereNameEquals('StateFoo');
                final secondComponent = componentDeclarations.firstWhereNameEquals('SecondFoo');
                final thirdComponent = componentDeclarations.firstWhereNameEquals('ThirdFoo');

                expect(propsComponentDeclaration, isNull);
                expect(stateComponentDeclaration, isNull);
                expect(secondComponent, isNotNull);
                expect(thirdComponent, isNotNull);

                final abstractProps = declarations!.whereType<LegacyAbstractPropsDeclaration>();
                expect(abstractProps.length, 1);
                expect(abstractProps.first.props.name.name, r'_$PropsFooProps');

                final abstractState = declarations!.whereType<LegacyAbstractStateDeclaration>();
                expect(abstractState.length, 1);
                expect(abstractState.first.state.name.name, r'_$StateFooState');
              });

              test('that are the correct version', () {
                final versionForFirstMixin =
                    resolveVersion(componentDeclarations.firstWhereNameEquals('SecondFoo')!.members);
                final versionForSecondMixin =
                    resolveVersion(componentDeclarations.firstWhereNameEquals('ThirdFoo')!.members);
                final abstractProps = resolveVersion(
                    declarations!.firstWhereType<LegacyAbstractPropsDeclaration>()!.members);
                final abstractState = resolveVersion(
                    declarations!.firstWhereType<LegacyAbstractStateDeclaration>()!.members);

                expect(versionForFirstMixin.version, Version.v2_legacyBackwardsCompat);
                expect(versionForSecondMixin.version, Version.v3_legacyDart2Only);
                expect(abstractProps.version, Version.v2_legacyBackwardsCompat);
                expect(abstractState.version, Version.v2_legacyBackwardsCompat);
              });
            });
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

              final propsMixinDecl = declarations!.firstWhereType<PropsMixinDeclaration>()!;
              expect(propsMixinDecl.mixin.name.name, 'FooProps');

              final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

              expect(decl.factory.name.name, 'Foo');
              expect(decl.props.b?.name.name, 'FooProps');
              expect(decl.component.name.name, 'FooComponent');
              expect(decl.state?.either, isNull);

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.b!.meta, isA<annotations.Props>());
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

              final propsMixinDecl = declarations!.firstWhereType<PropsMixinDeclaration>()!;
              expect(propsMixinDecl.mixin.name.name, 'FooPropsMixin');

              final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

              expect(decl.factory.name.name, 'Foo');
              expect(decl.props.a?.name.name, 'FooProps');
              expect(decl.component.name.name, 'FooComponent');
              expect(decl.state?.either, isNull);

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.a!.meta, isA<annotations.Props>());
              expect(decl.component.meta, isA<annotations.Component>());
            });

            test('whose props class has a body with static members', () {
              setUpAndParse(r'''
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  mixin FooPropsMixin on UiProps {
                    String foo;
                  }
                  
                  class FooProps extends UiProps with FooPropsMixin {
                    static PropsMeta meta;
                    static someMethod() {} 
                  }
                  
                  class FooComponent extends UiComponent2<FooProps> {
                    render() {}
                  }
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<ClassComponentDeclaration>(),
              ]));

              final propsMixinDecl = declarations!.firstWhereType<PropsMixinDeclaration>()!;
              expect(propsMixinDecl.mixin.name.name, 'FooPropsMixin');

              final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

              expect(decl.factory.name.name, 'Foo');
              expect(decl.props.a?.name.name, 'FooProps');
              expect(decl.component.name.name, 'FooComponent');
              expect(decl.state?.either, isNull);

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.a!.meta, isA<annotations.Props>());
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

              final propsMixinDecl = declarations!.firstWhereType<PropsMixinDeclaration>()!;
              expect(propsMixinDecl.mixin.name.name, 'FooProps');

              final stateMixinDecl = declarations!.firstWhereType<StateMixinDeclaration>()!;
              expect(stateMixinDecl.mixin.name.name, 'FooState');

              final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

              expect(decl.factory.name.name, 'Foo');
              expect(decl.props.b?.name.name, 'FooProps');
              expect(decl.component.name.name, 'FooComponent');
              expect(decl.state?.b?.name.name, 'FooState');

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.b!.meta, isA<annotations.Props>());
              expect(decl.state!.b!.meta, isA<annotations.State>());
              expect(decl.component.meta, isA<annotations.Component>());
            });

            test('that is stateful with "Mixin" name suffixes (shorthand)', () {
              setUpAndParse(r'''
                  UiFactory<FooProps> Foo = _$Foo;
                  
                  mixin FooPropsMixin on UiProps {
                    String foo;
                  }
                  
                  mixin FooStateMixin on UiState {
                    String bar;
                  }
                  
                  class FooComponent extends UiStatefulComponent2<FooPropsMixin, FooStateMixin> {
                    render() {}
                  }
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<StateMixinDeclaration>(),
                isA<ClassComponentDeclaration>(),
              ]));

              final propsMixinDecl = declarations!.firstWhereType<PropsMixinDeclaration>()!;
              expect(propsMixinDecl.mixin.name.name, 'FooPropsMixin');

              final stateMixinDecl = declarations!.firstWhereType<StateMixinDeclaration>()!;
              expect(stateMixinDecl.mixin.name.name, 'FooStateMixin');

              final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

              expect(decl.factory.name.name, 'Foo');
              expect(decl.props.b?.name.name, 'FooPropsMixin');
              expect(decl.component.name.name, 'FooComponent');
              expect(decl.state?.b?.name.name, 'FooStateMixin');

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.b!.meta, isA<annotations.Props>());
              expect(decl.state!.b!.meta, isA<annotations.State>());
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

              final propsMixinDecl = declarations!.firstWhereType<PropsMixinDeclaration>()!;
              expect(propsMixinDecl.mixin.name.name, 'FooPropsMixin');

              final stateMixinDecl = declarations!.firstWhereType<StateMixinDeclaration>()!;
              expect(stateMixinDecl.mixin.name.name, 'FooStateMixin');

              final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

              expect(decl.factory.name.name, 'Foo');
              expect(decl.props.a?.name.name, 'FooProps');
              expect(decl.component.name.name, 'FooComponent');
              expect(decl.state?.a?.name.name, 'FooState');

              expect(decl.factory.meta, isA<annotations.Factory>());
              expect(decl.props.a!.meta, isA<annotations.Props>());
              expect(decl.state!.a!.meta, isA<annotations.State>());
              expect(decl.component.meta, isA<annotations.Component>());
            });

            test('with a factory that references the _\$ prefixed variable name', () {
              setUpAndParse(r'''
                UiFactory<FooProps> Foo = connect(
                  mapStateToProps: (state) => _$Foo()..foo = state.foo,
                )(_$Foo);
                
                mixin FooProps on UiProps {}
                  
                class FooComponent extends UiComponent2<FooProps> {
                  render() {}
                }
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<ClassComponentDeclaration>(),
              ]));

              final component = declarations!.firstWhereType<ClassComponentDeclaration>()!;
              expect(component.factory.name.name, 'Foo');
              expect(component.props.b?.name.name, endsWith('FooProps'));
              expect(component.state, isNull);
              expect(component.component.name.name, 'FooComponent');
            });

            group('missing generic params referencing props class', () {
              void sharedGenericTest(String name, String source) {
                test(name, () {
                  setUpAndParse(source);

                  expect(declarations, unorderedEquals([
                    isA<PropsMixinDeclaration>(),
                    isA<ClassComponentDeclaration>(),
                  ]));

                  final component = declarations!.firstWhereType<ClassComponentDeclaration>()!;
                  expect(component.factory.name.name, 'Foo');
                  expect(component.props.either.name.name, endsWith('FooProps'));
                  expect(component.state, isNull);
                  expect(component.component.name.name, 'FooComponent');
                });
              }

              sharedGenericTest('on factory', r'''
                UiFactory Foo = _$Foo;
                mixin FooProps on UiProps {}
                class FooComponent extends UiComponent2<FooProps> {}
              ''');

              sharedGenericTest('on component', r'''
                UiFactory<FooProps> Foo = _$Foo;
                mixin FooProps on UiProps {}
                class FooComponent extends UiComponent2 {}
              ''');

              sharedGenericTest('on both', r'''
                UiFactory Foo = _$Foo;
                mixin FooProps on UiProps {}
                class FooComponent extends UiComponent2 {}
              ''');
            });
          });

          test('props mixins', () {
            setUpAndParse(r'''
              mixin FooPropsMixin on UiProps {}
              mixin BarPropsMixin on UiProps {}
              mixin BazPropsMixin on UiProps {}
            ''');

            final mixins = expectLengthAndAllOfType<PropsMixinDeclaration>(declarations!, 3);

            expect(mixins.map((m) => m.mixin.name.name).toList(),
                ['FooPropsMixin', 'BarPropsMixin', 'BazPropsMixin']);
          });

          test('state mixins', () {
            setUpAndParse(r'''
              mixin FooStateMixin on UiState {}
              mixin BarStateMixin on UiState {}
              mixin BazStateMixin on UiState {}
            ''');

            final mixins = expectLengthAndAllOfType<StateMixinDeclaration>(declarations!, 3);

            expect(mixins.map((m) => m.mixin.name.name).toList(),
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
                final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

                expect(decl.props.b!.meta.keyNamespace, 'bar');
                expect(decl.state!.b!.meta.keyNamespace, 'baz');
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
                final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

                expect(decl.props.b!.meta.keyNamespace, 'bar');
                expect(decl.state!.b!.meta.keyNamespace, 'baz');
                expect(decl.component.meta.isWrapper, isTrue);
                expect(decl.component.configSubtypeOf?.name, 'BarComponent');
              });
            });

            test('a props mixin', () {
              setUpAndParse('''
                @PropsMixin(keyNamespace: "bar")
                mixin FooPropsMixin on UiProps {}
              ''');
              final decl = expectSingleOfType<PropsMixinDeclaration>(declarations!);
              expect(decl.mixin.meta.keyNamespace, 'bar');
            });

            test('a state mixin', () {
              setUpAndParse('''
                @StateMixin(keyNamespace: "bar")
                mixin FooStateMixin on UiState {}
              ''');
              final decl = expectSingleOfType<StateMixinDeclaration>(declarations!);
              expect(decl.mixin.meta.keyNamespace, 'bar');
            });
          });

          group('props mapview', () {
            void sharedMapViewTests({required bool hasMapViewSuffix}) {
              // These tests ensure that the 'Props' in the name don't throw things off.
              final name = 'Foo${hasMapViewSuffix ? 'PropsMapView' : ''}';
              final propsName = '${name}Props';

              test('(shorthand)', () {
                setUpAndParse('''
                  UiFactory<$propsName> $name = _\$$name;
                  mixin $propsName on UiProps {}
                ''');

                expect(declarations, unorderedEquals([
                  isA<PropsMixinDeclaration>(),
                  isA<PropsMapViewOrFunctionComponentDeclaration>(),
                ]));
                final decl = declarations!.firstWhereType<PropsMapViewOrFunctionComponentDeclaration>()!;

                expect(decl.factories, hasLength(1));
                expect(decl.factories.first.name.name, name);
                expect(decl.props.b?.name.name, propsName);
                expect(decl.version, Version.v4_mixinBased);
              });

              test('(verbose)', () {
                setUpAndParse('''
                  UiFactory<$propsName> $name = _\$$name;
                  class $propsName = UiProps with FooPropsMixin;
                ''');
                final decl = expectSingleOfType<PropsMapViewOrFunctionComponentDeclaration>(declarations!);

                expect(decl.factories, hasLength(1));
                expect(decl.factories.first.name.name, name);
                expect(decl.props.a?.name.name, propsName);
                expect(decl.version, Version.v4_mixinBased);
              });
            }

            sharedMapViewTests(hasMapViewSuffix: false);

            group('with a mapview name suffix', () {
              sharedMapViewTests(hasMapViewSuffix: true);
            });
          });

          group('function component', () {
            test('(shorthand)', () {
              setUpAndParse('''
                UiFactory<FooPropsMixin> Foo = uiFunction(
                  (props) {
                    return Dom.div()();
                  },
                  _\$FooConfig, // ignore: undefined_identifier
                );
                
                final Bar = uiFunction<FooPropsMixin>(
                  (props) {
                    return Dom.div()();
                  },
                  _\$BarConfig, // ignore: undefined_identifier
                );
                
                UiFactory<FooPropsMixin> Baz = uiFunction<FooPropsMixin>(
                  (props) {
                    return Dom.div()();
                  }, 
                  UiFactoryConfig(
                    propsFactory: PropsFactory.fromUiFactory(Foo),
                  ),
                );
                
                UiFactory<FooPropsMixin> FooForwarded = forwardRef<FooPropsMixin>((props, ref) {
                  return (Foo()
                    ..ref = ref
                  )();
                })(Foo);
                
                mixin FooPropsMixin on UiProps {}
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<PropsMapViewOrFunctionComponentDeclaration>(),
              ]));
              final decl = declarations!.firstWhereType<PropsMapViewOrFunctionComponentDeclaration>()!;

              expect(decl.factories, hasLength(2));
              expect(decl.factories.map((factory) => factory.name.name), unorderedEquals([
                'Foo',
                'Bar',
              ]));
              expect(decl.props.b?.name.name, 'FooPropsMixin');
              expect(decl.version, Version.v4_mixinBased);
            });

            test('(verbose)', () {
              setUpAndParse('''
                final Foo = uiFunction<FooProps>(
                  (props) {
                    return Dom.div()();
                  },  
                  _\$FooConfig, // ignore: undefined_identifier
                );
                mixin FooPropsMixin on UiProps {}
                class FooProps = UiProps with FooPropsMixin;
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<PropsMapViewOrFunctionComponentDeclaration>(),
              ]));
              final decl = declarations!.firstWhereType<PropsMapViewOrFunctionComponentDeclaration>()!;

              expect(decl.factories, hasLength(1));
              expect(decl.factories.first.name.name, 'Foo');
              expect(decl.props.a?.name.name, 'FooProps');
              expect(decl.version, Version.v4_mixinBased);
            });

            test('generic UiProps', () {
              setUpAndParse('''
                final Foo = uiFunction<UiProps>(
                  (props) {
                    return Dom.div()();
                  }, 
                  UiFactoryConfig(),
                );
              ''');

              expect(declarations, isEmpty);
            });

            test('with public generated config', () {
              setUpAndParse('''
                UiFactory<FooPropsMixin> Foo = uiFunction(
                  (props) {
                    return Dom.div()();
                  },
                  \$FooConfig, // ignore: undefined_identifier
                );
                
                mixin FooPropsMixin on UiProps {}
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<PropsMapViewOrFunctionComponentDeclaration>(),
              ]));
              final decl = declarations!.firstWhereType<PropsMapViewOrFunctionComponentDeclaration>()!;

              expect(decl.factories, hasLength(1));
              expect(decl.factories.first.name.name, equals('Foo'));
              expect(decl.props.b?.name.name, 'FooPropsMixin');
              expect(decl.version, Version.v4_mixinBased);
            });

            test('wrapped in an hoc', () {
              setUpAndParse('''
                UiFactory<FooPropsMixin> Foo = someHOC(uiFunction(
                  (props) {
                    return Dom.div()();
                  },
                  _\$FooConfig, // ignore: undefined_identifier
                ));
                
                final Bar = someHOC(uiFunction<FooPropsMixin>(
                  (props) {
                    return Dom.div()();
                  },
                  _\$BarConfig, // ignore: undefined_identifier
                ));
                
                final Foo2 = someHOC(uiFunction<FooPropsMixin>(
                  (props) {
                    return Dom.div()();
                  },
                  UiFactoryConfig(
                    propsFactory: PropsFactory.uiFactory(Foo),
                  ), 
                ));
                
                final Bar2 = someHOC(uiFunction<UiProps>(
                  (props) {
                    return Dom.div()();
                  },
                  UiFactoryConfig(),
                ));
                
                mixin FooPropsMixin on UiProps {}
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<PropsMapViewOrFunctionComponentDeclaration>(),
              ]));
              final decl = declarations!.firstWhereType<PropsMapViewOrFunctionComponentDeclaration>()!;

              expect(decl.factories, hasLength(2));
              expect(decl.factories.map((factory) => factory.name.name), unorderedEquals([
                'Foo',
                'Bar',
              ]));
              expect(decl.props.b?.name.name, 'FooPropsMixin');
              expect(decl.version, Version.v4_mixinBased);
            });

            test('with multiple mixins in the same file', () {
              setUpAndParse('''
                UiFactory<FooPropsMixin> Foo = uiFunction(
                  (props) {
                    return Dom.div()();
                  },
                  _\$FooConfig, // ignore: undefined_identifier
                );
                
                final Bar = uiFunction<FooPropsMixin>(
                  (props) {
                    return Dom.div()();
                  },
                  _\$BarConfig, // ignore: undefined_identifier
                );
                
                UiFactory<BarPropsMixin> Baz = uiFunction(
                  (props) {
                    return Dom.div()();
                  },
                  _\$BazConfig, // ignore: undefined_identifier
                );
                
                mixin FooPropsMixin on UiProps {}
                mixin BarPropsMixin on UiProps {}
              ''');

              expect(declarations, unorderedEquals([
                isA<PropsMixinDeclaration>(),
                isA<PropsMixinDeclaration>(),
                isA<PropsMapViewOrFunctionComponentDeclaration>(),
                isA<PropsMapViewOrFunctionComponentDeclaration>(),
              ]));
              final decl = declarations!.whereType<PropsMapViewOrFunctionComponentDeclaration>().toList();
              expect(decl, hasLength(2));

              expect(decl.first.factories, hasLength(2));
              expect(decl.first.factories.map((factory) => factory.name.name), unorderedEquals([
                'Foo',
                'Bar',
              ]));
              expect(decl.first.props.b?.name.name, 'FooPropsMixin');
              expect(decl.first.version, Version.v4_mixinBased);

              expect(decl[1].factories, hasLength(1));
              expect(decl[1].factories.first.name.name, 'Baz');
              expect(decl[1].props.b?.name.name, 'BarPropsMixin');
              expect(decl[1].version, Version.v4_mixinBased);
            });
          });
        });

        group('(Dart >=2.9.0 syntax)', () {
          test('a component', () {
            setUpAndParse(r'''
                UiFactory<FooProps> Foo = castUiFactory(_$Foo);
                
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

            final propsMixinDecl = declarations!.firstWhereType<PropsMixinDeclaration>()!;
            expect(propsMixinDecl.mixin.name.name, 'FooProps');

            final decl = declarations!.firstWhereType<ClassComponentDeclaration>()!;

            expect(decl.factory.name.name, 'Foo');
            expect(decl.props.b?.name.name, 'FooProps');
            expect(decl.component.name.name, 'FooComponent');
            expect(decl.state?.either, isNull);

            expect(decl.factory.meta, isA<annotations.Factory>());
            expect(decl.props.b!.meta, isA<annotations.Props>());
            expect(decl.component.meta, isA<annotations.Component>());
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

              verifyNever(logger!.severe(any));
            });
          });

          group('private and initialized with', () {
            test('correct _\$ prefixed variable name', () {
              setUpAndParse('''
                @Factory()
                UiFactory<FooProps> _Foo = _\$_Foo;

                $restOfComponent
              ''');

              verifyNever(logger!.severe(any));
            });
          });
        });
      });

      group('and logs a hard error when', () {
        void verifyErrorLog(String publicClassName) {
          verify(logger!.severe(contains(
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
          test('a class annotated with @AbstractProps()', () {
            setUpAndParse(abstractPropsSrcDart1 + abstractComponentSrc);
            verify(logger!.severe(contains(
                'The class `AbstractFooProps` does not start with `_\$`. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with `_\$` on Dart 2')));
          });

          test('a class annotated with @AbstractState()', () {
            setUpAndParse(abstractStateSrcDart1 + abstractComponentSrc + abstractPropsSrc);
            verify(logger!.severe(contains(
                'The class `AbstractFooState` does not start with `_\$`. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with `_\$` on Dart 2')));
          });
        });

        group('a component is declared without', () {
          test('a factory', () {
            setUpAndParse(propsSrc + companionClassProps + componentSrc);
            verify(logger!.severe(contains(errorNoFactory)));
          });

          test('a props class', () {
            setUpAndParse(factorySrc + componentSrc);
            verify(logger!.severe(contains(errorNoProps)));
          });

          test('a component class', () {
            setUpAndParse(factorySrc + propsSrc);
            verify(logger!.severe(contains(errorNoComponent)));
          });

          test('a factory or a props class', () {
            setUpAndParse(componentSrc);
            verify(logger!.severe(contains(errorComponentClassOnly)));
          });

          test('a factory or a props class (v2 component)', () {
            setUpAndParse(component2Src);
            verify(logger!.severe(contains(errorComponentClassOnly)));
          });

          test('a factory or a component class', () {
            setUpAndParse(propsSrc);
            verify(logger!.severe(contains(errorPropsClassOnly)));
          });

          test('a component or props class', () {
            setUpAndParse(factorySrc);
            verify(logger!.severe(contains(errorFactoryOnly)));
          });
        });

        group('a function component is declared', () {
          test('without a props mixin', () {
            setUpAndParse(r'''
              final Foo = uiFunction<FooProps>(
                (props) {
                  return Dom.div()();
                },
                _$FooConfig, // ignore: undefined_identifier
              );
            ''');
            verify(logger!.severe(contains(errorFactoryOnly)));
          });

          test('without props typing arguments or left hand typing', () {
            setUpAndParse(r'''
              mixin FooProps on UiProps {}
              final Foo = uiFunction(
                (props) {
                  return Dom.div()();
                },
                _$FooConfig, // ignore: undefined_identifier
              );
            ''');
            verify(logger!.severe(contains(errorFactoryOnly)));
          });

          test('without a matching props mixin', () {
            setUpAndParse(r'''
              mixin FooPropsMixin on UiProps {}
              UiFactory<FooProps> Foo = uiFunction(
                (props) {
                  return Dom.div()();
                }, 
                _$FooConfig, // ignore: undefined_identifier
              );
            ''');
            verify(logger!.severe(contains(errorFactoryOnly)));
          });

          test('with a props mixin that is used by a component class', () {
            setUpAndParse(r'''
              UiFactory<FooProps> Foo = _$Foo;
              mixin FooProps on UiProps {}
              class FooComponent extends UiComponent2<FooProps> {}
              
              final Foo = uiFunction<FooProps>(
                (props) {
                  return Dom.div()();
                },
                _$FooConfig, // ignore: undefined_identifier
              );
            ''');
            verify(logger!.severe(contains(errorFactoryOnly)));
          });
        });

        group('a state class is declared without', () {
          test('any component pieces', () {
            setUpAndParse(stateSrc);
            verify(logger!.severe(contains(errorStateOnly)));
          });

          test('some component pieces', () {
            setUpAndParse(stateSrc + componentSrc);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger!.severe(contains(errorComponentClassOnly)));
          });

          test('some component2 pieces', () {
            setUpAndParse(stateSrc + component2Src);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger!.severe(contains(errorComponentClassOnly)));
          });
        });

        test('a component v2 uses legacy lifecycle methods', () {
          setUpAndParse(factorySrc + propsSrc + component2LegacySrc);
          /// Should log for each legacy method, suggesting the alternative.
          verify(logger!.severe(contains('Use getDerivedStateFromProps instead.')));
          verify(logger!.severe(contains('Use componentDidMount instead.')));
          verify(logger!.severe(contains('Use getSnapshotBeforeUpdate and/or componentDidUpdate instead.')));
        });

        group('a factory is', () {
          test('declared without an initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo;

              $restOfComponent
            ''');

            verify(logger!.severe(contains('Factory variables are stubs for generated code, and must'
                ' be initialized with an expression containing either'
                ' the generated factory (_\$Foo) or'
                ' the generated factory config (_\$FooConfig).')));
          });

          test('declared using multiple variables', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo = _\$Foo, Bar = _\$Bar;

              $restOfComponent
            ''');

            verify(logger!.severe(contains('Factory declarations must be a single variable.')));
          });

          test('public and declared with an invalid initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo = \$Foo;

              $restOfComponent
            ''');

            verify(logger!.severe(contains('Factory variables are stubs for generated code, and must'
                ' be initialized with an expression containing either'
                ' the generated factory (_\$Foo) or'
                ' the generated factory config (_\$FooConfig).')));
          });

          test('private and declared with an invalid initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> _Foo = \$_Foo;

              $restOfComponent
            ''');

            verify(logger!.severe(contains('Factory variables are stubs for generated code, and must'
                ' be initialized with an expression containing either'
                ' the generated factory (_\$_Foo) or'
                ' the generated factory config (_\$_FooConfig).')));
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
              verify(logger!.severe(contains('Static meta field in accessor class must be of type `PropsMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + component2Src + '''
                class FooProps {
                  static const PropsMeta meta = \$metaForBarProps;
                }
              ''');
              verify(logger!.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooProps`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse(factorySrc + privatePropsSrc + component2Src + '''
                class _FooProps {
                  static const PropsMeta meta = \$metaForFooProps;
                }
              ''');
              verify(logger!.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
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
              verify(logger!.severe(contains('Static meta field in accessor class must be of type `StateMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + stateSrc + component2Src + '''
                class FooState {
                  static const StateMeta meta = \$metaForBarState;
                }
              ''');
              verify(logger!.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooState`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + component2Src + privateStateSrc + '''
                class _FooState {
                  static const StateMeta meta = \$metaForBarState;
                }
              ''');
              verify(logger!.severe(contains('Static StateMeta field in accessor class must be initialized to:'
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
              verify(logger!.severe(contains('Static meta field in accessor class must be of type `PropsMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @AbstractProps() abstract class _\$AbstractFooProps {}
                abstract class AbstractFooProps {
                  static const PropsMeta meta = \$metaForAbstractBarProps;
                }
              ''');
              verify(logger!.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                    '`_\$metaForAbstractFooProps`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @AbstractProps() abstract class _\$_AbstractFooProps {}
                abstract class _AbstractFooProps {
                  static const PropsMeta meta = \$metaForAbstractBarProps;
                }
              ''');
              verify(logger!.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
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
              verify(logger!.severe(contains('Static meta field in accessor class must be of type `StateMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @AbstractState() abstract class _\$AbstractFooState {}
                abstract class AbstractFooState {
                  static const StateMeta meta = \$metaForAbstractBarState;
                }
              ''');
              verify(logger!.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaForAbstractFooState`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @AbstractState() abstract class _\$_AbstractFooState {}
                abstract class _AbstractFooState {
                  static const StateMeta meta = \$metaForAbstractBarState;
                }
              ''');
              verify(logger!.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_AbstractFooState`')));
            });
          });

          group('for a props mixin', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @PropsMixin() abstract class FooPropsMixin {
                  static const StateMeta meta = _\$metaForFooPropsMixin;
                  Map get props;
                }
              ''');
              verify(logger!.severe(contains('Static meta field in accessor class must be of type `PropsMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @PropsMixin() abstract class FooPropsMixin {
                  static const PropsMeta meta = \$metaForBarPropsMixin;
                  Map get props;
                }
              ''');
              verify(logger!.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooPropsMixin`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @PropsMixin() abstract class _FooPropsMixin {
                  static const PropsMeta meta = \$metaForBarPropsMixin;
                  Map get props;
                }
              ''');
              verify(logger!.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_FooPropsMixin`')));
            });
          });

          group('for a state mixin', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @StateMixin() abstract class FooStateMixin {
                  static const PropsMeta meta = _\$metaForFooStateMixin;
                  Map get state;
                }
              ''');
              verify(logger!.severe(contains('Static meta field in accessor class must be of type `StateMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @StateMixin() abstract class FooStateMixin {
                  static const StateMeta meta = \$metaForBarStateMixin;
                  Map get state;
                }
              ''');
              verify(logger!.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooStateMixin`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse('''
                @StateMixin() abstract class _FooStateMixin {
                  static const StateMeta meta = \$metaForBarStateMixin;
                  Map get state;
                }
              ''');
              verify(logger!.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_FooStateMixin`')));
            });
          });
        });

        group(
            'shorthand props syntax is used on mixins with extra superclass constraints'
                ' when declared part of a', () {
          test('props map view', () {
            setUpAndParse(r'''
              UiFactory<FooProps> Foo = _$Foo;
              mixin FooProps on UiProps, BarProps {}
            ''');
            verify(logger!.severe(allOf(
              contains('FooProps can\'t be used in shorthand syntax since it has'
                  ' the following `on` constraints: `BarProps`'),
              // verify the factory is used for the span
              contains('UiFactory<FooProps> Foo'),
            )));
          });

          test('component', () {
            setUpAndParse(r'''
              UiFactory<FooProps> Foo = _$Foo;
              mixin FooProps on UiProps, BarProps {}
              class FooComponent extends UiComponent2<FooProps> {}
            ''');
            verify(logger!.severe(allOf(
              contains('FooProps can\'t be used in shorthand syntax since it has'
                  ' the following `on` constraints: `BarProps`'),
              // verify the factory is used for the span
              contains('UiFactory<FooProps> Foo'),
            )));
          });
        });

        group(
            'shorthand state syntax is used on mixins with extra superclass constraints'
                ' when declared part of a', () {
          test('component', () {
            setUpAndParse(r'''
              UiFactory<FooProps> Foo = _$Foo;
              mixin FooProps on UiProps {}
              mixin FooState on UiState, BarState {}
              class FooComponent extends UiStatefulComponent2<FooProps, FooState> {}
            ''');
            verify(logger!.severe(allOf(
              contains('FooState can\'t be used in shorthand syntax since it has'
                  ' the following `on` constraints: `BarState`'),
              // verify the component is used for the span
              contains('FooComponent'),
            )));
          });
        });

        group('(new boilerplate)', () {
          // Tests the same codepath as "a component is declared without matching factory/props",
          // but using a different real-world scenario to ensure it behaves the same.
          test('a component doesn\'t get grouped with a factory/props due to mismatched name', () {
            setUpAndParse(r'''
              UiFactory<FooProps> Foo = _$Foo;
              mixin FooProps on UiProps {}
              class BarComponent<FooProps> extends UiComponent2 {
                render() {}
              }
            ''');

            verify(logger!.severe(contains(errorComponentClassOnly)));
          });

          group('a component is declared without matching factory/props', () {
            group('with a base class of', () {
              @isTest
              void sharedTest(String baseClassName) {
                test(baseClassName, () {
                  setUpAndParse('''
                    class FooComponent extends $baseClassName<FooProps> {
                      render() {}
                    }
                  ''');

                  verify(logger!.severe(contains(errorComponentClassOnly)));
                });
              }

              sharedTest('UiComponent2');
              sharedTest('UiStatefulComponent2');
              sharedTest('FluxUiComponent2');
              sharedTest('FluxUiStatefulComponent2');
            });

            group('unless', () {
              test('it has a nonstandard base class', () {
                setUpAndParse(r'''
                  class FooComponent extends SomeNonstandardBaseUiComponent<FooProps> {
                    render() {} 
                  }
                ''');
              });

              test('it is abstract', () {
                setUpAndParse(r'''
                  abstract class FooComponent extends UiComponent2<FooProps> {
                    render() {} 
                  }
                ''');
              });

              test('it overrides \$isClassGenerated', () {
                setUpAndParse(r'''
                  class FooComponent extends UiComponent2<FooProps> {
                    render() {}
                    
                    bool get $isClassGenerated => true;
                  }
                ''');
              });
            });
          });
        });
      });

      group('and logs a warning when', () {
        group('a component implements', () {
          test('typedPropsFactory', () {
            setUpAndParse(OverReactSrc.props(
              backwardsCompatible: false,
              componentBody: 'typedPropsFactory(Map backingMap) => {};',
            ).source);
            verify(logger!.warning(contains(
                'Components should not add their own implementations of typedPropsFactory.')));
          });

          test('typedPropsFactoryJs', () {
            setUpAndParse(OverReactSrc.props(
              backwardsCompatible: false,
              componentBody: 'typedPropsFactoryJs(JsBackedMap backingMap) => {};',
            ).source);
            verify(logger!.warning(contains(
                'Components should not add their own implementations of typedPropsFactoryJs.')));
          });

          test('typedStateFactory', () {
            setUpAndParse(OverReactSrc.props(
              backwardsCompatible: false,
              componentBody: 'typedStateFactory(Map backingMap) => {};',
            ).source);
            verify(logger!.warning(contains(
                'Components should not add their own implementations of typedStateFactory.')));
          });

          test('typedStateFactoryJs', () {
            setUpAndParse(OverReactSrc.props(
              backwardsCompatible: false,
              componentBody: 'typedStateFactoryJs(JsBackedMap backingMap) => {};',
            ).source);
            verify(logger!.warning(contains(
                'Components should not add their own implementations of typedStateFactoryJs.')));
          });
        });

        group('on Dart 2 only boilerplate', () {
          group('a static `meta` field is declared in ', () {
            void verifyWarningLog(String publicClassName) {
              verify(logger!.warning(contains(
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

extension on Iterable<ClassComponentDeclaration> {
  ClassComponentDeclaration? firstWhereNameEquals(String baseName) =>
      firstWhereOrNull((declaration) => normalizeNameAndRemoveSuffix(declaration.component) == baseName);
}

extension on Iterable<LegacyClassComponentDeclaration> {
  LegacyClassComponentDeclaration? firstWhereNameEquals(String baseName) =>
      firstWhereOrNull((declaration) => normalizeNameAndRemoveSuffix(declaration.component) == baseName);
}
