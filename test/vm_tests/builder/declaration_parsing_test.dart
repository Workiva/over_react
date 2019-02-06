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

        group('a component ', () {
          void testPropsDualClassSetup({bool backwardsCompatible: true, bool isPrivate: false}) {
            final ors = OverReactSrc.props(backwardsCompatible: backwardsCompatible, isPrivate: isPrivate);
            setUpAndParse(ors.source);

            expect(declarations.factory.node?.variables?.variables?.single?.name
                ?.name, ors.baseName);
            expect(declarations.props.node?.name?.name, '_\$${ors.baseName}Props');
            expect(declarations.component.node?.name?.name, '${ors.baseName}Component');

            expect(declarations.factory.meta,   const TypeMatcher<annotations.Factory>());
            expect(declarations.props.meta,     const TypeMatcher<annotations.Props>());
            expect(declarations.component.meta, const TypeMatcher<annotations.Component>());

            expectEmptyDeclarations(
                factory: false, props: false, component: false);
            expect(declarations.declaresComponent, isTrue);
          }

          group('with backwards compatible boilerplate', () {
            test('with public consumable class', () {
              testPropsDualClassSetup();
            });
            test('with private consumable class', () {
              testPropsDualClassSetup(isPrivate: true);
            });
          });

          group('with Dart 2 only boilerplate', () {
            test('with public consumable class', () {
              testPropsDualClassSetup(backwardsCompatible: false);
            });
            test('with private consumable class', () {
              testPropsDualClassSetup(backwardsCompatible: false, isPrivate: true);
            });
          });
        });

        group('a stateful component', () {
          void testStateDualClassSetup({bool backwardsCompatible: true, bool isPrivate: false}) {
            final ors = OverReactSrc.state(backwardsCompatible: backwardsCompatible, isPrivate: isPrivate);
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

          group('with backwards compatible boilerplate', () {
            test('with public consumable class', () {
              testStateDualClassSetup();
            });
            test('with private consumable class', () {
              testStateDualClassSetup(isPrivate: true);
            });
          });

          group('with Dart 2 only boilerplate', () {
            test('with public consumable class', () {
              testStateDualClassSetup(backwardsCompatible: false);
            });
            test('with private consumable class', () {
              testStateDualClassSetup(backwardsCompatible: false, isPrivate: true);
            });
          });
        });

        group('props mixins', () {
          void testPropsMixins(String source, List<String> mixinNames) {
            setUpAndParse(source);
            expect(declarations.propsMixins, hasLength(mixinNames.length));

            declarations.propsMixins.forEach((propsMixin) {
              expect(mixinNames, contains(propsMixin.node.name.name));
              expect(propsMixin.meta, const TypeMatcher<annotations.PropsMixin>());
            });

            expectEmptyDeclarations(propsMixins: false);
            expect(declarations.declaresComponent, isFalse);
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
            expect(declarations.stateMixins, hasLength(mixinNames.length));

            declarations.stateMixins.forEach((stateMixin) {
              expect(mixinNames, contains(stateMixin.node.name.name));
              expect(stateMixin.meta, const TypeMatcher<annotations.StateMixin>());
            });

            expectEmptyDeclarations(stateMixins: false);
            expect(declarations.declaresComponent, isFalse);
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
          void testAbstractPropsDualClassSetup({backwardsCompatible: true, isPrivate: false}) {
            final ors = OverReactSrc.abstractProps(backwardsCompatible: backwardsCompatible, isPrivate: isPrivate);
            setUpAndParse(ors.source);

            expect(declarations.abstractProps, hasLength(1));
            expect(declarations.abstractProps[0].node?.name?.name, '_\$${ors.baseName}Props');
            expect(declarations.abstractProps[0].meta, new TypeMatcher<annotations.AbstractProps>());
          }

          group('with backwards compatible boilerplate', () {
            test('with public consumable class', () {
              testAbstractPropsDualClassSetup();
            });
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
          void testAbstractStateDualClassSetup({backwardsCompatible: true, isPrivate: false}) {
            final ors = OverReactSrc.abstractState(backwardsCompatible: true, isPrivate: isPrivate);
            setUpAndParse(ors.source);

            expect(declarations.abstractState, hasLength(1));
            expect(declarations.abstractState[0].node?.name?.name, '_\$${ors.baseName}State');
            expect(declarations.abstractState[0].meta, new TypeMatcher<annotations.AbstractState>());
          }

          group('with backwards compatible boilerplate', () {
            test('with public consumable class', () {
              testAbstractStateDualClassSetup();
            });
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

              expect(declarations.props.meta.keyNamespace, 'bar');
              expect(declarations.state.meta.keyNamespace, 'baz');
              expect(declarations.component.meta.isWrapper, isTrue);
            });

            test('a props mixin', () {
              setUpAndParse('''
                @PropsMixin(keyNamespace: "bar")
                class _\$FooPropsMixin {}
              ''');
              expect(declarations.propsMixins.single.meta.keyNamespace, 'bar');
            });

            test('a state mixin', () {
              setUpAndParse('''
                @StateMixin(keyNamespace: "bar")
                class _\$FooStateMixin {}
              ''');
              expect(declarations.stateMixins.single.meta.keyNamespace, 'bar');
            });

            test('an abstract props class', () {
              setUpAndParse('''
                @AbstractProps(keyNamespace: "bar")
                class _\$AbstractFooProps {}
              ''');
              expect(declarations.abstractProps.single.meta.keyNamespace, 'bar');
            });

            test('an abstract state class', () {
              setUpAndParse('''
                @AbstractState(keyNamespace: "bar")
                class _\$AbstractFooState {}
              ''');
              expect(declarations.abstractState.single.meta.keyNamespace, 'bar');
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

        tearDown(() {
          expect(declarations.hasErrors, isTrue, reason: 'Declarations with errors should always set `hasErrors` to true.');
          expectEmptyDeclarations(reason: 'Declarations with errors should always be null/empty.');
        });

        group('non-static `meta` field is declared in', () {
          final body = 'String meta;';
          verifyMetaErrors(body);
        });

        group('non-static `meta` method is declared in', () {
          final body = 'String get meta => \'do not do this\';';
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
            setUpAndParse(stateSrcDart1 + componentSrc + propsSrc + factorySrc);
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
            verify(logger.severe(contains('To define a component, there must also be a `@Factory` within the same file, but none were found.')));
          });

          test('a props class', () {
            setUpAndParse(factorySrc + componentSrc);
            verify(logger.severe(contains('To define a component, there must also be a `@Props` within the same file, but none were found.')));
          });

          test('a component class', () {
            setUpAndParse(factorySrc + propsSrc);
            verify(logger.severe(contains('To define a component, there must also be a `@Component` within the same file, but none were found.')));
          });

          test('a factory or a props class', () {
            setUpAndParse(componentSrc);
            verify(logger.severe(contains('To define a component, there must also be a `@Factory` within the same file, but none were found.')));
            verify(logger.severe(contains('To define a component, there must also be a `@Props` within the same file, but none were found.')));
          });

          test('a factory or a component class', () {
            setUpAndParse(propsSrc);
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
            setUpAndParse(stateSrc);
            verify(logger.severe(contains('To define a component, a `@State` must be accompanied by the following annotations within the same file: @Factory, @Component, @Props.')));
          });

          test('some component pieces', () {
            setUpAndParse(stateSrc + componentSrc);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger.severe(contains('To define a component, there must also be a `@Factory` within the same file, but none were found.')));
            verify(logger.severe(contains('To define a component, there must also be a `@Props` within the same file, but none were found.')));
          });
        });

        group('a component is declared with multiple', () {
          test('factories', () {
            setUpAndParse(factorySrc * 2 + propsSrc + componentSrc);
            verify(logger.severe(
                argThat(startsWith('To define a component, there must be a single `@Factory` per file, but 2 were found.'))
            )).called(2);
          });

          test('props classes', () {
            setUpAndParse(factorySrc + propsSrc * 2 + componentSrc);
            verify(logger.severe(
                argThat(startsWith('To define a component, there must be a single `@Props` per file, but 2 were found.'))
            )).called(2);
          });

          test('component classes', () {
            setUpAndParse(factorySrc + propsSrc + componentSrc * 2);
            verify(logger.severe(
                argThat(startsWith('To define a component, there must be a single `@Component` per file, but 2 were found.'))
            )).called(2);
          });

          test('state classes', () {
            setUpAndParse(factorySrc + propsSrc + componentSrc + stateSrc * 2);
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
          test('declared without an initializer', () {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo;

              $restOfComponent
            ''');

            verify(logger.severe(contains(
                'Factory variables are stubs for the generated factories, and should not have initializers'
                    ' unless initialized with a valid variable name for Dart 2 builder compatibility. Should be:\n'
                    '    _\$Foo')));
          });
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
              UiFactory<FooProps> Foo = \$Foo;

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
              UiFactory<FooProps> _Foo = \$_Foo;

              $restOfComponent
            ''');

            verify(logger.severe(contains(
                'Factory variables are stubs for the generated factories, and should not have initializers'
                    ' unless initialized with a valid variable name for Dart 2 builder compatibility. Should be:\n'
                    '    _\$_Foo')));
          });
        });

        group('a static meta field with backwards compatible boilerplate', () {
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
              setUpAndParse(factorySrc + privatePropsSrc + componentSrc + '''
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
              setUpAndParse(factorySrc + propsSrc + companionClassProps + componentSrc + privateStateSrc + '''
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
              final body = 'static const String meta;';
              verifyMetaWarnings(body);
            });

            group('static `meta` method is declared in', () {
              final body = 'static String get meta => \'do not do this\';';
              verifyMetaWarnings(body);
            });
          });
        });
      });

      group('and throws an error when', () {
        test('`subtypeOf` is an unsupported expression that is not an identifier', () {
          expect(() {
            setUpAndParse('''
              @Factory()
              UiFactory<FooProps> Foo = _\$Foo;

              @Props()
              class _\$FooProps {}

              @Component(subtypeOf: const [])
              class FooComponent {}
            ''');
          }, throwsA(startsWith('`subtypeOf` must be an identifier')));
        });
      });
    });
  });
}
