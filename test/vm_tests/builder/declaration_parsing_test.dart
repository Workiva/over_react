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
library declaration_parsing_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:mockito/mockito.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import './util.dart';

main() {
  group('ComponentDeclarations', () {
    group('mightContainDeclarations()', () {
      bool mightContainDeclarations(String source) => ParsedDeclarations.mightContainDeclarations(source);

      group('returns true when the source contains', () {
        test('"@Factory"',           () => expect(mightContainDeclarations(factorySrc), isTrue));
        test('"@Props"',             () => expect(mightContainDeclarations(propsSrc), isTrue));
        test('"@State"',             () => expect(mightContainDeclarations(stateSrc), isTrue));
        test('"@Component"',         () => expect(mightContainDeclarations(componentSrc), isTrue));
        test('"@AbstractProps"',     () => expect(mightContainDeclarations(abstractPropsSrc), isTrue));
        test('"@AbstractState"',     () => expect(mightContainDeclarations(abstractStateSrc), isTrue));
        test('"@AbstractComponent"', () => expect(mightContainDeclarations(abstractComponentSrc), isTrue));
        test('"@PropsMixin"',        () => expect(mightContainDeclarations(propsMixinSrc), isTrue));
        test('"@StateMixin"',        () => expect(mightContainDeclarations(stateMixinSrc), isTrue));
      });

      test('returns false when no matching annotations are found', () {
        expect(mightContainDeclarations('class FooComponent extends UiComponent<FooProps> {}'), isFalse,
            reason: 'should not return true for an unannotated class');

        expect(mightContainDeclarations('@Bar\nclass Foo {}'), isFalse,
            reason: 'should not return true for a class with non-matching annotations');

        expect(mightContainDeclarations('/// Component that...\nclass Foo {}'), isFalse,
            reason: 'should not return true when an annotation class name is not used as an annotation');
      });
    });

    group('parses', () {
      MockLogger logger;
      SourceFile sourceFile;
      CompilationUnit unit;
      ParsedDeclarations declarations;

      void setUpAndParse(String source) {
        logger = new MockLogger();
        sourceFile = new SourceFile.fromString(source);
        unit = parseCompilationUnit(source);
        declarations = new ParsedDeclarations(unit, sourceFile, logger);
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

      void expectEmptyDeclarations({
        factory: true,
        props: true,
        state: true,
        component: true,
        abstractProps: true,
        abstractState: true,
        propsMixins: true,
        stateMixins: true,
        String reason
      }) {
        expect(declarations.factory,       factory       ? isNull  : isNotNull,  reason: reason);
        expect(declarations.props,         props         ? isNull  : isNotNull,  reason: reason);
        expect(declarations.state,         state         ? isNull  : isNotNull,  reason: reason);
        expect(declarations.component,     component     ? isNull  : isNotNull,  reason: reason);
        expect(declarations.abstractProps, abstractProps ? isEmpty : isNotEmpty, reason: reason);
        expect(declarations.abstractState, abstractState ? isEmpty : isNotEmpty, reason: reason);
        expect(declarations.propsMixins,   propsMixins   ? isEmpty : isNotEmpty, reason: reason);
        expect(declarations.stateMixins,   stateMixins   ? isEmpty : isNotEmpty, reason: reason);
      }

      group('and successfully collects declarations for', () {
        tearDown(() {
          expect(declarations.hasErrors, isFalse);
        });

        test('an empty file', () {
          setUpAndParse('');

          expectEmptyDeclarations();
          expect(declarations.declaresComponent, isFalse);
        });

        group('a component with Dart 1 and Dart 2 compatible dual-class props setup', () {
          void testPropsDualClassSetup({bool isPrivate: false}) {
            final ors = OverReactSrc.props(isPrivate: isPrivate);
            setUpAndParse(ors.source);

            expect(declarations.factory.node?.variables?.variables?.single?.name
                ?.name, ors.baseName);
            expect(declarations.props.node?.name?.name, '_\$${ors.baseName}Props');
            expect(declarations.component.node?.name?.name, '${ors.baseName}Component');

            expect(declarations.factory.meta,
                const TypeMatcher<annotations.Factory>());
            expect(declarations.props.meta,
                const TypeMatcher<annotations.Props>());
            expect(declarations.component.meta,
                const TypeMatcher<annotations.Component>());

            expectEmptyDeclarations(
                factory: false, props: false, component: false);
            expect(declarations.declaresComponent, isTrue);
          }
          test('with public consumable class', () {
            testPropsDualClassSetup();
          });
          test('with priavte consumable class', () {
            testPropsDualClassSetup(isPrivate: true);
          });
        });

        group('a stateful component with builder-compatible dual-class state setup', () {
          void testStateDualClassSetup({bool isPrivate: false}) {
            final ors = OverReactSrc.state(isPrivate: isPrivate);
            setUpAndParse(ors.source);

            expect(declarations.factory.node?.variables?.variables?.single?.name?.name, ors.baseName);
            expect(declarations.props.node?.name?.name, '_\$${ors.baseName}Props');
            expect(declarations.state.node?.name?.name, '_\$${ors.baseName}State');
            expect(declarations.component.node?.name?.name, '${ors.baseName}Component');

            expect(declarations.factory.meta,   const TypeMatcher<annotations.Factory>());
            expect(declarations.props.meta,     const TypeMatcher<annotations.Props>());
            expect(declarations.state.meta,     const TypeMatcher<annotations.State>());
            expect(declarations.component.meta, const TypeMatcher<annotations.Component>());

            expectEmptyDeclarations(factory: false, props: false, state: false, component: false);
            expect(declarations.declaresComponent, isTrue);
          }
          test('with public consumable class', () {
            testStateDualClassSetup();
          });
          test('with private consumable class', () {
            testStateDualClassSetup(isPrivate: true);
          });
        });

        test('props mixins', () {
          setUpAndParse('''
            @PropsMixin() class FooPropsMixin1 {}
            @PropsMixin() class FooPropsMixin2 {}
          ''');

          expect(declarations.propsMixins, hasLength(2));

          expect(declarations.propsMixins[0].node.name.name, 'FooPropsMixin1');
          expect(declarations.propsMixins[1].node.name.name, 'FooPropsMixin2');
          expect(declarations.propsMixins[0].meta, const TypeMatcher<annotations.PropsMixin>());
          expect(declarations.propsMixins[1].meta, const TypeMatcher<annotations.PropsMixin>());

          expectEmptyDeclarations(propsMixins: false);
          expect(declarations.declaresComponent, isFalse);
        });

        test('state mixins', () {
          setUpAndParse('''
            @StateMixin() class FooStateMixin1 {}
            @StateMixin() class FooStateMixin2 {}
          ''');

          expect(declarations.stateMixins, hasLength(2));

          expect(declarations.stateMixins[0].node.name.name, 'FooStateMixin1');
          expect(declarations.stateMixins[1].node.name.name, 'FooStateMixin2');
          expect(declarations.stateMixins[0].meta, const TypeMatcher<annotations.StateMixin>());
          expect(declarations.stateMixins[1].meta, const TypeMatcher<annotations.StateMixin>());

          expectEmptyDeclarations(stateMixins: false);
          expect(declarations.declaresComponent, isFalse);
        });

        group('abstract props class with builder-compatible dual-class setup', () {
          void testAbstractPropsDualClassSetup({isPrivate: false}) {
            final ors = OverReactSrc.abstractProps(isPrivate: isPrivate);
            setUpAndParse(ors.source);

            expect(declarations.abstractProps, hasLength(1));
            expect(declarations.abstractProps[0].node?.name?.name, '_\$${ors.baseName}Props');
            expect(declarations.abstractProps[0].meta, new TypeMatcher<annotations.AbstractProps>());
          }
          test('with public consumable class', () {
            testAbstractPropsDualClassSetup();
          });
          test('with priavte consumable class', () {
            testAbstractPropsDualClassSetup(isPrivate: true);
          });
        });

        group('abstract state class with builder-compatible dual-class setup', () {
          void testAbstractStateDualClassSetup({isPrivate: false}) {
            final ors = OverReactSrc.abstractState(isPrivate: isPrivate);
            setUpAndParse(ors.source);

            expect(declarations.abstractState, hasLength(1));
            expect(declarations.abstractState[0].node?.name?.name, '_\$${ors.baseName}State');
            expect(declarations.abstractState[0].meta, new TypeMatcher<annotations.AbstractState>());
          }
          test('with public consumable class', () {
            testAbstractStateDualClassSetup();
          });
          test('with priavte consumable class', () {
            testAbstractStateDualClassSetup(isPrivate: true);
          });
        });

        group('and initializes annotations with the correct arguments for', () {
          test('a stateful component', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo;

              @Props(keyNamespace: "bar")
              class _\$FooProps {}
              
              class FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {}

              @State(keyNamespace: "baz")
              class _\$FooState {}
              
              class FooState extends _\$FooState with _\$FooStateAccessorsMixin {}

              @Component(isWrapper: true)
              class FooComponent {}
            ''');

            expect(declarations.props.meta.keyNamespace, 'bar');
            expect(declarations.state.meta.keyNamespace, 'baz');
            expect(declarations.component.meta.isWrapper, isTrue);
          });

          test('a props mixin', () {
            setUpAndParse('''
              @PropsMixin(keyNamespace: "bar")
              class FooPropsMixin {}
            ''');
            expect(declarations.propsMixins.single.meta.keyNamespace, 'bar');
          });

          test('a state mixin', () {
            setUpAndParse('''
              @StateMixin(keyNamespace: "bar")
              class FooStateMixin {}
            ''');
            expect(declarations.stateMixins.single.meta.keyNamespace, 'bar');
          });

          test('an abstract props class', () {
            setUpAndParse('''
              @AbstractProps(keyNamespace: "bar")
              class _\$AbstractFooProps {}
              class AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {}
            ''');
            expect(declarations.abstractProps.single.meta.keyNamespace, 'bar');
          });

          test('an abstract state class', () {
            setUpAndParse('''
              @AbstractState(keyNamespace: "bar")
              class _\$AbstractFooState {}
              class AbstractFooState extends _\$AbstractFooState with _\$AbstractFooStateAccessorsMixin {}
            ''');
            expect(declarations.abstractState.single.meta.keyNamespace, 'bar');
          });
        });
      });

      const String restOfComponent = '''
        @Props()
        class _\$FooProps {}
        class FooProps {}

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
        tearDown(() {
          expect(declarations.hasErrors, isTrue, reason: 'Declarations with errors should always set `hasErrors` to true.');
          expectEmptyDeclarations(reason: 'Declarations with errors should always be null/empty.');
        });

        group('there is not Dart-2 compatible naming on', () {
          test('a class annotated with @Props()', () {
            setUpAndParse(propsSrcDart1 + componentSrc + factorySrc);
            verify(logger.severe(contains(
                'The class `FooProps` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2')));
          });

          test('a class annotated with @State()', () {
            setUpAndParse(stateSrcDart1 + componentSrc + propsSrc + companionClassProps + factorySrc);
            verify(logger.severe(contains(
                'The class `FooState` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2')));
          });

          test('a class annotated with @AbstractProps()', () {
            setUpAndParse(abstractPropsSrcDart1 + abstractComponentSrc);
            verify(logger.severe(contains(
                'The class `AbstractFooProps` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2')));
          });

          test('a class annotated with @AbstractState()', () {
            setUpAndParse(abstractStateSrcDart1 + abstractComponentSrc + abstractPropsSrc + companionClassAbstractProps);
            verify(logger.severe(contains(
                'The class `AbstractFooState` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2')));
          });
        });

        group('a component is declared without', () {
          test('a factory', () {
            setUpAndParse(propsSrc + companionClassProps + componentSrc);
            verify(logger.severe(contains('To define a component, there must also be a `@Factory` within the same file, but none were found.')));
          });

          test('a props class', () {
            setUpAndParse(factorySrc + componentSrc);
            verify(logger.severe(contains('To define a component, there must also be a `@Props` within the same file, but none were found.')));
          });

          test('a component class', () {
            setUpAndParse(factorySrc + propsSrc + companionClassProps);
            verify(logger.severe(contains('To define a component, there must also be a `@Component` within the same file, but none were found.')));
          });

          test('a factory or a props class', () {
            setUpAndParse(componentSrc);
            verify(logger.severe(contains('To define a component, there must also be a `@Factory` within the same file, but none were found.')));
            verify(logger.severe(contains('To define a component, there must also be a `@Props` within the same file, but none were found.')));
          });

          test('a factory or a component class', () {
            setUpAndParse(propsSrc + companionClassProps);
            verify(logger.severe(contains('To define a component, there must also be a `@Factory` within the same file, but none were found.')));
            verify(logger.severe(contains('To define a component, there must also be a `@Component` within the same file, but none were found.')));
          });

          test('a component or props class', () {
            setUpAndParse(factorySrc);
            verify(logger.severe(contains('To define a component, there must also be a `@Component` within the same file, but none were found.')));
            verify(logger.severe(contains('To define a component, there must also be a `@Props` within the same file, but none were found.')));
          });
        });

        group('a state class is declared without', () {
          test('any component pieces', () {
            setUpAndParse(stateSrc + companionClassState);
            verify(logger.severe(contains('To define a component, a `@State` must be accompanied by the following annotations within the same file: @Factory, @Component, @Props.')));
          });

          test('some component pieces', () {
            setUpAndParse(stateSrc + componentSrc + companionClassState);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger.severe(contains('To define a component, there must also be a `@Factory` within the same file, but none were found.')));
            verify(logger.severe(contains('To define a component, there must also be a `@Props` within the same file, but none were found.')));
          });
        });

        group('a component is declared with multiple', () {
          test('factories', () {
            setUpAndParse(factorySrc * 2 + propsSrc + companionClassProps + componentSrc);
            verify(logger.severe(
                argThat(startsWith('To define a component, there must be a single `@Factory` per file, but 2 were found.'))
            )).called(2);
          });

          test('props classes', () {
            setUpAndParse(factorySrc + propsSrc * 2 + companionClassProps*2 + componentSrc);
            verify(logger.severe(
                argThat(startsWith('To define a component, there must be a single `@Props` per file, but 2 were found.'))
            )).called(2);
          });

          test('component classes', () {
            setUpAndParse(factorySrc + propsSrc + companionClassProps + componentSrc * 2);
            verify(logger.severe(
                argThat(startsWith('To define a component, there must be a single `@Component` per file, but 2 were found.'))
            )).called(2);
          });

          test('state classes', () {
            setUpAndParse(factorySrc + propsSrc + companionClassProps + componentSrc + stateSrc * 2 + companionClassState*2);
            verify(logger.severe(
                argThat(startsWith('To define a component, there must not be more than one `@State` per file, but 2 were found.'))
            )).called(2);
          });
        });

        group('an annotation is used on the wrong kind of declaration:', () {
          test('@Factory on a non-top-level-variable', () {
            setUpAndParse('@Factory() class NotAVariable {}');
            verify(logger.severe(contains('`@Factory` can only be used on top-level variable declarations.')));
          });

          test('@Props on a non-class', () {
            setUpAndParse('@Props() var notAClass;');
            verify(logger.severe(contains('`@Props` can only be used on classes.')));
          });

          test('@Component on a non-class', () {
            setUpAndParse('@Component() var notAClass;');
            verify(logger.severe(contains('`@Component` can only be used on classes.')));
          });

          test('@State on a non-class', () {
            setUpAndParse('@Props() var notAClass;');
            verify(logger.severe(contains('`@Props` can only be used on classes.')));
          });

          test('@AbstractProps on a non-class', () {
            setUpAndParse('@AbstractProps() var notAClass;');
            verify(logger.severe(contains('`@AbstractProps` can only be used on classes.')));
          });

          test('@AbstractState on a non-class', () {
            setUpAndParse('@AbstractState() var notAClass;');
            verify(logger.severe(contains('`@AbstractState` can only be used on classes.')));
          });

          test('@PropsMixin on a non-class', () {
            setUpAndParse('@PropsMixin() var notAClass;');
            verify(logger.severe(contains('`@PropsMixin` can only be used on classes.')));
          });

          test('@StateMixin on a non-class', () {
            setUpAndParse('@StateMixin() var notAClass;');
            verify(logger.severe(contains('`@StateMixin` can only be used on classes.')));
          });
        });

        group('a factory is', () {
          test('declared using multiple variables', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo, Bar;

              $restOfComponent
            ''');

            verify(logger.severe(contains('Factory declarations must be a single variable.')));
          });

          test('public and declared with an invalid initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo = null;

              $restOfComponent
            ''');

            verify(logger.severe(contains(
                'Factory variables are stubs for the generated factories, and should not have initializers'
                    ' unless initialized with a valid variable name for Dart 2 builder compatibility. Should be:\n'
                    '    _\$Foo')));
          });

          test('private and declared with an invalid initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> _Foo = null;

              $restOfComponent
            ''');

            verify(logger.severe(contains(
                'Factory variables are stubs for the generated factories, and should not have initializers'
                    ' unless initialized with a valid variable name for Dart 2 builder compatibility. Should be:\n'
                    '    _\$_Foo')));
          });
        });

        group('a static meta field', () {
          group('for a props class', () {
            test('has the wrong type', () {
              setUpAndParse(factorySrc + propsSrc + componentSrc + '''
                class FooProps {
                  static const StateMeta meta = _\$metaForFooProps;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `PropsMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + componentSrc + '''
                class FooProps {
                  static const PropsMeta meta = \$metaForBarProps;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooProps`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + componentSrc + '''
                class _FooProps {
                  static const PropsMeta meta = \$metaForBarProps;
                }
              ''');
              verify(logger.severe(contains('Static PropsMeta field in accessor class must be initialized to:'
                  '`_\$metaFor_FooProps`')));
            });
          });

          group('for a state class', () {
            test('has the wrong type', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + stateSrc + componentSrc + '''
                class FooState {
                  static const PropsMeta meta = _\$metaForFooState;
                }
              ''');
              verify(logger.severe(contains('Static meta field in accessor class must be of type `StateMeta`')));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + stateSrc + componentSrc + '''
                class FooState {
                  static const StateMeta meta = \$metaForBarState;
                }
              ''');
              verify(logger.severe(contains('Static StateMeta field in accessor class must be initialized to:'
                  '`_\$metaForFooState`')));
            });

            test('is private and initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + componentSrc + stateSrc + '''
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
                @AbstractProps() abstract class _\$AbstractFooProps {}
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
                @AbstractState() abstract class _\$AbstractFooState {}
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

      group('and throws an error when', () {
        test('`subtypeOf` is an unsupported expression that is not an identifier', () {
          expect(() {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo = \$Foo;

              @Props()
              class _\$FooProps {}
              class FooProps {}

              @Component(subtypeOf: const [])
              class FooComponent {}
            ''');
          }, throwsA(startsWith('`subtypeOf` must be an identifier')));
        });
      });
    });
  });
}
