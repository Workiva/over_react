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
import 'package:logging/logging.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react/src/component_declaration/annotations.dart' as annotations;
import 'package:over_react/src/builder/generation/declaration_parsing.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

main() {
  group('ComponentDeclarations', () {
    group('mightContainDeclarations()', () {
      bool mightContainDeclarations(String source) => ParsedDeclarations.mightContainDeclarations(source);

      group('returns true when the source contains', () {
        test('"@Factory"',           () => expect(mightContainDeclarations('@Factory()\nvar Foo;'), isTrue));
        test('"@Props"',             () => expect(mightContainDeclarations('@Props()\nclass Foo {}'), isTrue));
        test('"@State"',             () => expect(mightContainDeclarations('@State()\nclass Foo {}'), isTrue));
        test('"@Component"',         () => expect(mightContainDeclarations('@Component()\nclass Foo {}'), isTrue));
        test('"@AbstractProps"',     () => expect(mightContainDeclarations('@AbstractProps()\nclass Foo {}'), isTrue));
        test('"@AbstractState"',     () => expect(mightContainDeclarations('@AbstractState()\nclass Foo {}'), isTrue));
        test('"@AbstractComponent"', () => expect(mightContainDeclarations('@AbstractComponent()\nclass Foo {}'), isTrue));
        test('"@PropsMixin"',        () => expect(mightContainDeclarations('@PropsMixin()\nclass Foo {}'), isTrue));
        test('"@StateMixin"',        () => expect(mightContainDeclarations('@StateMixin()\nclass Foo {}'), isTrue));
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

      void verifyNoErrorLogs() {
        verifyNever(logger.warning(any));
        verifyNever(logger.severe(any));
      }

      tearDown(() {
        // Verify that there were no errors other than the ones we explicitly verified.
        verifyNoErrorLogs();

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
        hasPrivateStateClass: false,
        hasPrivatePropsClass: false,
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
        expect(declarations.hasPrivateStateClass, hasPrivateStateClass);
        expect(declarations.hasPrivatePropsClass, hasPrivatePropsClass);
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
//
        // TODO: Remove this test or update it to toss an error since there's not accompanying consumable props class. I think I need to add that error checking in anyways
//        test('a component', () {
//          setUpAndParse('''
//            @Factory()    UiFactory<FooProps> Foo;
//            @Props()      class FooProps {}
//            @Component()  class FooComponent {}
//          ''');
//
//          expect(declarations.factory.node?.variables?.variables?.single?.name?.name, 'Foo');
//          expect(declarations.props.node?.name?.name, 'FooProps');
//          expect(declarations.props.companionNode, isNull);
//          expect(declarations.component.node?.name?.name, 'FooComponent');
//
//          expect(declarations.factory.meta,   new isInstanceOf<annotations.Factory>());
//          expect(declarations.props.meta,     new isInstanceOf<annotations.Props>());
//          expect(declarations.component.meta, new isInstanceOf<annotations.Component>());
//
//          expectEmptyDeclarations(factory: false, props: false, component: false);
//          expect(declarations.declaresComponent, isTrue);
//        });

        group('a component with builder-compatible dual-class props setup', () {
          void testPropsDualClassSetup({bool isPrivate: false}) {
            setUpAndParse('''
              @Factory()    UiFactory<FooProps> Foo;
              class ${isPrivate ? '_' : ''}FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {}
              @Props()      class _\$FooProps {}
              @Component()  class FooComponent {}
            ''');

            expect(declarations.factory.node?.variables?.variables?.single?.name
                ?.name, 'Foo');
            expect(declarations.props.node?.name?.name, '_\$FooProps');
            expect(declarations.hasPrivatePropsClass, isPrivate);
            expect(declarations.component.node?.name?.name, 'FooComponent');

            expect(declarations.factory.meta,
                const isInstanceOf<annotations.Factory>());
            expect(declarations.props.meta,
                const isInstanceOf<annotations.Props>());
            expect(declarations.component.meta,
                const isInstanceOf<annotations.Component>());

            expectEmptyDeclarations(
                factory: false, props: false, component: false, hasPrivatePropsClass: isPrivate);
            expect(declarations.declaresComponent, isTrue);
          }
          test('with public consumable class', () {
            testPropsDualClassSetup();
          });
          test('with priavte consumable class', () {
            testPropsDualClassSetup(isPrivate: true);
          });
        });

        // TODO: Write code and test to throw error if code formatted like this
//        test('a stateful component', () {
//          setUpAndParse('''
//            @Factory()    UiFactory<FooProps> Foo;
//            @Props()      class FooProps {}
//            @State()      class FooState {}
//            @Component()  class FooComponent {}
//          ''');
//
//          expect(declarations.factory.node?.variables?.variables?.single?.name?.name, 'Foo');
//          expect(declarations.props.node?.name?.name, 'FooProps');
////          expect(declarations.props.companionNode, isNull);
//          expect(declarations.state.node?.name?.name, 'FooState');
////          expect(declarations.state.companionNode, isNull);
//          expect(declarations.component.node?.name?.name, 'FooComponent');
//
//          expect(declarations.factory.meta,   new isInstanceOf<annotations.Factory>());
//          expect(declarations.props.meta,     new isInstanceOf<annotations.Props>());
//          expect(declarations.state.meta,     new isInstanceOf<annotations.State>());
//          expect(declarations.component.meta, new isInstanceOf<annotations.Component>());
//
//          expectEmptyDeclarations(factory: false, props: false, state: false, component: false);
//          expect(declarations.declaresComponent, isTrue);
//        });

        group('a stateful component with builder-compatible dual-class state setup', () {
          void testStateDualClassSetup({bool isPrivate: false}) {
            var possiblePrivatePrefix = isPrivate ? '_' : '';
            setUpAndParse('''
              @Factory()    UiFactory<${possiblePrivatePrefix}FooProps> Foo = $possiblePrivatePrefix\$Foo;
              class ${possiblePrivatePrefix}FooProps extends _\$FooProps with _\$FooPropsAccessorsMixin {}
              @Props()      class _\$FooProps {}
              @Component()  class FooComponent {}
              class ${possiblePrivatePrefix}FooState extends _\$FooState with _\$FooStateAccessorsMixin {}
              @State()      class _\$FooState {}
            ''');

            expect(declarations.factory.node?.variables?.variables?.single?.name?.name, 'Foo');
            expect(declarations.props.node?.name?.name, '_\$FooProps');
            expect(declarations.hasPrivatePropsClass, isPrivate);
            expect(declarations.state.node?.name?.name, '_\$FooState');
            expect(declarations.hasPrivateStateClass, isPrivate);
            expect(declarations.component.node?.name?.name, 'FooComponent');

            expect(declarations.factory.meta,   const isInstanceOf<annotations.Factory>());
            expect(declarations.props.meta,     const isInstanceOf<annotations.Props>());
            expect(declarations.state.meta,     const isInstanceOf<annotations.State>());
            expect(declarations.component.meta, const isInstanceOf<annotations.Component>());

            expectEmptyDeclarations(factory: false, props: false, state: false, component: false, hasPrivateStateClass: isPrivate, hasPrivatePropsClass: isPrivate);
            expect(declarations.declaresComponent, isTrue);
          }
          test('with public consumable class', () {
            testStateDualClassSetup();
          });
          test('with priavte consumable class', () {
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
          expect(declarations.propsMixins[0].meta, new isInstanceOf<annotations.PropsMixin>());
          expect(declarations.propsMixins[1].meta, new isInstanceOf<annotations.PropsMixin>());

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
          expect(declarations.stateMixins[0].meta, new isInstanceOf<annotations.StateMixin>());
          expect(declarations.stateMixins[1].meta, new isInstanceOf<annotations.StateMixin>());

          expectEmptyDeclarations(stateMixins: false);
          expect(declarations.declaresComponent, isFalse);
        });

        // TODO: write error for no-companion class and test
//        test('abstract props classes', () {
//          setUpAndParse('''
//            @AbstractProps() class AbstractFooProps1 {}
//            @AbstractProps() class AbstractFooProps2 {}
//          ''');
//
//          expect(declarations.abstractProps, hasLength(2));
//
//          expect(declarations.abstractProps[0].node.name.name, 'AbstractFooProps1');
////          expect(declarations.abstractProps[0].companionNode, isNull);
//          expect(declarations.abstractProps[1].node.name.name, 'AbstractFooProps2');
////          expect(declarations.abstractProps[1].companionNode, isNull);
//          expect(declarations.abstractProps[0].meta, new isInstanceOf<annotations.AbstractProps>());
//          expect(declarations.abstractProps[1].meta, new isInstanceOf<annotations.AbstractProps>());
//
//          expectEmptyDeclarations(abstractProps: false);
//          expect(declarations.declaresComponent, isFalse);
//        });

        group('abstract props class with builder-compatible dual-class setup', () {
          void testAbstractPropsDualClassSetup({isPrivate: false}) {
            setUpAndParse('''
              @AbstractProps() class _\$AbstractFooProps {}
              class ${isPrivate ? '_' : ''}AbstractFooProps extends _\$AbstractFooProps with _\$AbstractFooPropsAccessorsMixin {}
            ''');

            expect(declarations.abstractProps, hasLength(1));
            expect(declarations.abstractProps[0].node?.name?.name, '_\$AbstractFooProps');
            expect(declarations.hasPrivatePropsClass, isPrivate);
            expect(declarations.abstractProps[0].meta, new isInstanceOf<annotations.AbstractProps>());
          }
          test('with public consumable class', () {
            testAbstractPropsDualClassSetup();
          });
          test('with priavte consumable class', () {
            testAbstractPropsDualClassSetup(isPrivate: true);
          });
        });

        // TODO: write and test error for missing consumable class
//        test('abstract state classes', () {
//          setUpAndParse('''
//            @AbstractState() class AbstractFooState1 {}
//            @AbstractState() class AbstractFooState2 {}
//          ''');
//
//          expect(declarations.abstractState, hasLength(2));
//
//          expect(declarations.abstractState[0].node.name.name, 'AbstractFooState1');
////          expect(declarations.abstractState[0].companionNode, isNull);
//          expect(declarations.abstractState[1].node.name.name, 'AbstractFooState2');
////          expect(declarations.abstractState[1].companionNode, isNull);
//          expect(declarations.abstractState[0].meta, new isInstanceOf<annotations.AbstractState>());
//          expect(declarations.abstractState[1].meta, new isInstanceOf<annotations.AbstractState>());
//
//          expectEmptyDeclarations(abstractState: false);
//          expect(declarations.declaresComponent, isFalse);
//        });

        group('abstract state class with builder-compatible dual-class setup', () {
          void testAbstractStateDualClassSetup({isPrivate: false}) {
            setUpAndParse('''
              @AbstractState() class _\$AbstractFooState {}
              class ${isPrivate ? '_' : ''}AbstractFooState extends _\$AbstractFooState with _\$AbstractFooStateAccessorsMixin {}
            ''');

            expect(declarations.abstractState, hasLength(1));
            expect(declarations.abstractState[0].node?.name?.name, '_\$AbstractFooState');
            expect(declarations.hasPrivateStateClass, isPrivate);
            expect(declarations.abstractState[0].meta, new isInstanceOf<annotations.AbstractState>());
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

      group('and logs a hard error when', () {
        const String factorySrc            = '\n@Factory()\nUiFactory<FooProps> Foo = \$Foo;\n';
        const String componentSrc          = '\n@Component()\nclass FooComponent {}\n';
        const String abstractComponentSrc  = '\n@AbstractComponent()\nclass AbstractFooComponent {}\n';

        const String propsSrc              = '\n@Props()\nclass _\$FooProps {}\n';
        const String propsSrcDart1         = '\n@Props()\nclass FooProps {}\n';
        const String abstractPropsSrc      = '\n@AbstractProps()\nclass _\$AbstractFooProps {}\n';
        const String abstractPropsSrcDart1 = '\n@AbstractProps()\nclass AbstractFooProps {}\n';
        const String companionClassProps   = 'class FooProps {}';
        const String companionClassAbstractProps   = 'class AbstractFooProps {}';

        const String stateSrc              = '\n@State()\nclass _\$FooState {}\n';
        const String stateSrcDart1         = '\n@State()\nclass FooState {}\n';
        const String abstractStateSrcDart1 = '\n@AbstractState()\nclass AbstractFooState {}\n';
        const String companionClassState   = 'class FooState {}';
        const String companionClassAbstractState   = 'class AbstractFooState {}';

        tearDown(() {
          expect(declarations.hasErrors, isTrue, reason: 'Declarations with errors should always set `hasErrors` to true.');
          expectEmptyDeclarations(reason: 'Declarations with errors should always be null/empty.');
        });

        test('a companion props class is not found when a private _\$ prefixed props class is declared', () {
          setUpAndParse(factorySrc + propsSrc + componentSrc);
//          '''
//              @Factory()
//              UiFactory<FooProps> Foo = \$Foo;
//
//              @Props()
//              class _\$FooProps {}
//
//              @Component()
//              class FooComponent {}
//            ''');
          verify(logger.severe('_\$FooProps must have an accompanying companion class within the same file for Dart 2 builder compatibility, but one was not found.'));
        });

        test('a companion state class is not found when an private _\$ prefixed state class is declared', () {
          setUpAndParse('''
              @Factory()    
              UiFactory<FooProps> Foo = \$Foo;
              
              @Props()      
              class _\$FooProps {}
              class FooProps {}
              
              @State()
              class _\$FooState {}
              
              @Component()  
              class FooComponent {}
            ''');
          verify(logger.severe('_\$FooState must have an accompanying companion class within the same file for Dart 2 builder compatibility, but one was not found.'));
        });

        test('a companion abstract props class is not found  when an private _\$ prefixed abstract props class is declared', () {
          setUpAndParse('''
              @AbstractProps() 
              class _\$AbstractFooProps {}
            ''');
          verify(logger.severe('_\$AbstractFooProps must have an accompanying companion class within the same file for Dart 2 builder compatibility, but one was not found.'));
        });

        test('a compaion abstract state class is not found when an private _\$ prefixed abstract state class is declared', () {
          setUpAndParse('''
              @AbstractState() 
              class _\$AbstractStateProps {}
             ''');
          verify(logger.severe('_\$AbstractStateProps must have an accompanying companion class within the same file for Dart 2 builder compatibility, but one was not found.'));
        });

        group('there is not Dart-2 compatible naming on', () {
          test('a class annotated with @Props()', () {
            setUpAndParse(propsSrcDart1 + componentSrc + factorySrc);
            verify(logger.severe(
                'The class `FooProps` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2'));
          });

          test('a class annotated with @State()', () {
            setUpAndParse(stateSrcDart1 + componentSrc + propsSrc + companionClassProps + factorySrc);
            verify(logger.severe(
                'The class `FooState` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2'));
          });

          test('a class annotated with @AbstractProps()', () {
            setUpAndParse(abstractPropsSrcDart1 + abstractComponentSrc);
            verify(logger.severe(
                'The class `AbstractFooProps` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2'));
          });

          test('a class annotated with @AbstractState()', () {
            setUpAndParse(abstractStateSrcDart1 + abstractComponentSrc + abstractPropsSrc + companionClassAbstractProps);
            verify(logger.severe(
                'The class `AbstractFooState` does not start with _\$. All Props, State, '
                    'AbstractProps, and AbstractState classes should begin with _\$ under Dart 2'));
          });
        });

        group('a component is declared without', () {
          test('a factory', () {
            setUpAndParse(propsSrc + companionClassProps + componentSrc);
            verify(logger.severe('To define a component, there must also be a `@Factory` within the same file, but none were found.'));
          });

          test('a props class', () {
            setUpAndParse(factorySrc + componentSrc);
            verify(logger.severe('To define a component, there must also be a `@Props` within the same file, but none were found.'));
          });

          test('a component class', () {
            setUpAndParse(factorySrc + propsSrc + companionClassProps);
            verify(logger.severe('To define a component, there must also be a `@Component` within the same file, but none were found.'));
          });

          test('a factory or a props class', () {
            setUpAndParse(componentSrc);
            verify(logger.severe('To define a component, there must also be a `@Factory` within the same file, but none were found.'));
            verify(logger.severe('To define a component, there must also be a `@Props` within the same file, but none were found.'));
          });

          test('a factory or a component class', () {
            setUpAndParse(propsSrc + companionClassProps);
            verify(logger.severe('To define a component, there must also be a `@Factory` within the same file, but none were found.'));
            verify(logger.severe('To define a component, there must also be a `@Component` within the same file, but none were found.'));
          });

          test('a component or props class', () {
            setUpAndParse(factorySrc);
            verify(logger.severe('To define a component, there must also be a `@Component` within the same file, but none were found.'));
            verify(logger.severe('To define a component, there must also be a `@Props` within the same file, but none were found.'));
          });
        });

        group('a state class is declared without', () {
          test('any component pieces', () {
            setUpAndParse(stateSrc + companionClassState);
            verify(logger.severe('To define a component, a `@State` must be accompanied by the following annotations within the same file: @Factory, @Component, @Props.'));
          });

          test('some component pieces', () {
            setUpAndParse(stateSrc + componentSrc + companionClassState);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger.severe('To define a component, there must also be a `@Factory` within the same file, but none were found.'));
            verify(logger.severe('To define a component, there must also be a `@Props` within the same file, but none were found.'));
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
            verify(logger.severe('`@Factory` can only be used on top-level variable declarations.'));
          });

          test('@Props on a non-class', () {
            setUpAndParse('@Props() var notAClass;');
            verify(logger.severe('`@Props` can only be used on classes.'));
          });

          test('@Component on a non-class', () {
            setUpAndParse('@Component() var notAClass;');
            verify(logger.severe('`@Component` can only be used on classes.'));
          });

          test('@State on a non-class', () {
            setUpAndParse('@Props() var notAClass;');
            verify(logger.severe('`@Props` can only be used on classes.'));
          });

          test('@AbstractProps on a non-class', () {
            setUpAndParse('@AbstractProps() var notAClass;');
            verify(logger.severe('`@AbstractProps` can only be used on classes.'));
          });

          test('@AbstractState on a non-class', () {
            setUpAndParse('@AbstractState() var notAClass;');
            verify(logger.severe('`@AbstractState` can only be used on classes.'));
          });

          test('@PropsMixin on a non-class', () {
            setUpAndParse('@PropsMixin() var notAClass;');
            verify(logger.severe('`@PropsMixin` can only be used on classes.'));
          });

          test('@StateMixin on a non-class', () {
            setUpAndParse('@StateMixin() var notAClass;');
            verify(logger.severe('`@StateMixin` can only be used on classes.'));
          });
        });

        group('a static meta field', () {
          group('for a props class', () {
            test('has the wrong type', () {
              setUpAndParse(factorySrc + propsSrc + componentSrc + '''
                class FooProps {
                  static const StateMeta meta = \$metaForFooProps;
                }
              ''');
              verify(logger.severe('Static meta field in accessor class must be of type `PropsMeta`'));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + componentSrc + '''
                class FooProps {
                  static const PropsMeta meta = \$metaForBarProps;
                }
              ''');
              verify(logger.severe('Static PropsMeta field in accessor class must be initialized to `\$metaForFooProps`'));
            });
          });

          group('for a state class', () {
            test('has the wrong type', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + stateSrc + componentSrc + '''
                class FooState {
                  static const PropsMeta meta = \$metaForFooState;
                }
              ''');
              verify(logger.severe('Static meta field in accessor class must be of type `StateMeta`'));
            });

            test('is initialized incorrectly', () {
              setUpAndParse(factorySrc + propsSrc + companionClassProps + stateSrc + componentSrc + '''
                class FooState {
                  static const StateMeta meta = \$metaForBarState;
                }
              ''');
              verify(logger.severe('Static StateMeta field in accessor class must be initialized to `\$metaForFooState`'));
            });
          });

          group('for an abstract props class', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @AbstractProps() abstract class _\$AbstractFooProps {}
                abstract class AbstractFooProps {
                  static const StateMeta meta = \$metaForAbstractFooProps;
                }
              ''');
              verify(logger.severe('Static meta field in accessor class must be of type `PropsMeta`'));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @AbstractProps() abstract class _\$AbstractFooProps {}
                abstract class AbstractFooProps {
                  static const PropsMeta meta = \$metaForAbstractBarProps;
                }
              ''');
              verify(logger.severe('Static PropsMeta field in accessor class must be initialized to `\$metaForAbstractFooProps`'));
            });
          });

          group('for an abstract state class', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @AbstractState() abstract class _\$AbstractFooState {}
                abstract class AbstractFooState {
                  static const PropsMeta meta = \$metaForAbstractFooState;
                }
              ''');
              verify(logger.severe('Static meta field in accessor class must be of type `StateMeta`'));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @AbstractState() abstract class _\$AbstractFooState {}
                abstract class AbstractFooState {
                  static const StateMeta meta = \$metaForAbstractBarState;
                }
              ''');
              verify(logger.severe('Static StateMeta field in accessor class must be initialized to `\$metaForAbstractFooState`'));
            });
          });

          group('for a props mixin', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @PropsMixin() abstract class FooPropsMixin {
                  static const StateMeta meta = \$metaForFooPropsMixin;
                }
              ''');
              verify(logger.severe('Static meta field in accessor class must be of type `PropsMeta`'));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @PropsMixin() abstract class FooPropsMixin {
                  static const PropsMeta meta = \$metaForBarPropsMixin;
                }
              ''');
              verify(logger.severe('Static PropsMeta field in accessor class must be initialized to `\$metaForFooPropsMixin`'));
            });
          });

          group('for a state mixin', () {
            test('has the wrong type', () {
              setUpAndParse('''
                @StateMixin() abstract class FooStateMixin {
                  static const PropsMeta meta = \$metaForFooStateMixin;
                }
              ''');
              verify(logger.severe('Static meta field in accessor class must be of type `StateMeta`'));
            });

            test('is initialized incorrectly', () {
              setUpAndParse('''
                @StateMixin() abstract class FooStateMixin {
                  static const StateMeta meta = \$metaForBarStateMixin;
                }
              ''');
              verify(logger.severe('Static StateMeta field in accessor class must be initialized to `\$metaForFooStateMixin`'));
            });
          });
        });
      });

      // TODO: Throw an error when the factory is incorrectly initialized
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


class MockLogger extends Mock implements Logger {}
