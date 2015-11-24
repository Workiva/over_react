@TestOn('vm')
library declaration_parsing_test;

import 'package:analyzer/analyzer.dart' hide startsWith;
import 'package:barback/barback.dart';
import 'package:mockito/mockito.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/src/transformer/declaration_parsing.dart';
import 'package:web_skin_dart/src/ui_core/transformer_generation/annotations.dart' as annotations;

main() {
  group('ComponentDeclarations', () {
    group('shouldParse()', () {
      bool shouldParse(String source) => ComponentDeclarations.shouldParse(source);

      group('returns true when the source contains', () {
        test('"@Factory"',           () => expect(shouldParse('@Factory()\nvar Foo;'), isTrue));
        test('"@Props"',             () => expect(shouldParse('@Props()\nclass Foo {}'), isTrue));
        test('"@State"',             () => expect(shouldParse('@State()\nclass Foo {}'), isTrue));
        test('"@Component"',         () => expect(shouldParse('@Component()\nclass Foo {}'), isTrue));
        test('"@AbstractProps"',     () => expect(shouldParse('@AbstractProps()\nclass Foo {}'), isTrue));
        test('"@AbstractState"',     () => expect(shouldParse('@AbstractState()\nclass Foo {}'), isTrue));
        test('"@AbstractComponent"', () => expect(shouldParse('@AbstractComponent()\nclass Foo {}'), isTrue));
        test('"@PropsMixin"',        () => expect(shouldParse('@PropsMixin()\nclass Foo {}'), isTrue));
        test('"@StateMixin"',        () => expect(shouldParse('@StateMixin()\nclass Foo {}'), isTrue));
      });

      test('returns false when no matching annotations are found', () {
        expect(shouldParse('class FooComponent extends UiComponent<FooProps> {}'), isFalse,
            reason: 'should not return true for an unannotated class');

        expect(shouldParse('@Bar\nclass Foo {}'), isFalse,
            reason: 'should not return true for a class with non-matching annotations');

        expect(shouldParse('/// Component that...\nclass Foo {}'), isFalse,
            reason: 'should not return true when an annotation class name is not used as an annotation');
      });
    });

    group('parses', () {
      MockTransformLogger logger;
      SourceFile sourceFile;
      CompilationUnit unit;
      ComponentDeclarations declarations;

      tearDown(() {
        logger = null;
        sourceFile = null;
        unit = null;
        declarations = null;
      });

      void setUpAndParse(String source) {
        logger = new MockTransformLogger();
        sourceFile = new SourceFile(source);
        unit = parseCompilationUnit(source);
        declarations = new ComponentDeclarations(unit, sourceFile, logger);
      }

      void verifyNoErrors() {
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

      test('an empty file', () {
        setUpAndParse('');

        verifyNoErrors();
        expectEmptyDeclarations();
        expect(declarations.declaresComponent, isFalse);
      });

      test('a component', () {
        setUpAndParse('''
          @Factory()    UiFactory<FooProps> Foo;
          @Props()      class FooProps {}
          @Component()  class FooComponent {}
        ''');
        verifyNoErrors();

        expect(declarations.factory.node?.variables.variables.single.name.name, 'Foo');
        expect(declarations.props.node?.name.name, 'FooProps');
        expect(declarations.component.node?.name.name, 'FooComponent');

        expect(declarations.factory.meta,   new isInstanceOf<annotations.Factory>());
        expect(declarations.props.meta,     new isInstanceOf<annotations.Props>());
        expect(declarations.component.meta, new isInstanceOf<annotations.Component>());

        expectEmptyDeclarations(factory: false, props: false, component: false);
        expect(declarations.declaresComponent, isTrue);
      });

      test('a stateful component', () {
        setUpAndParse('''
          @Factory()    UiFactory<FooProps> Foo;
          @Props()      class FooProps {}
          @State()      class FooState {}
          @Component()  class FooComponent {}
        ''');
        verifyNoErrors();

        expect(declarations.factory.node?.variables.variables.single.name.name, 'Foo');
        expect(declarations.props.node?.name.name, 'FooProps');
        expect(declarations.state.node?.name.name, 'FooState');
        expect(declarations.component.node?.name.name, 'FooComponent');

        expect(declarations.factory.meta,   new isInstanceOf<annotations.Factory>());
        expect(declarations.props.meta,     new isInstanceOf<annotations.Props>());
        expect(declarations.state.meta,     new isInstanceOf<annotations.State>());
        expect(declarations.component.meta, new isInstanceOf<annotations.Component>());

        expectEmptyDeclarations(factory: false, props: false, state: false, component: false);
        expect(declarations.declaresComponent, isTrue);
      });

      test('props mixins', () {
        setUpAndParse('''
          @PropsMixin() class FooPropsMixin1 {}
          @PropsMixin() class FooPropsMixin2 {}
        ''');
        verifyNoErrors();

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
        verifyNoErrors();

        expect(declarations.stateMixins, hasLength(2));

        expect(declarations.stateMixins[0].node.name.name, 'FooStateMixin1');
        expect(declarations.stateMixins[1].node.name.name, 'FooStateMixin2');
        expect(declarations.stateMixins[0].meta, new isInstanceOf<annotations.StateMixin>());
        expect(declarations.stateMixins[1].meta, new isInstanceOf<annotations.StateMixin>());

        expectEmptyDeclarations(stateMixins: false);
        expect(declarations.declaresComponent, isFalse);
      });

      test('abstract props classes', () {
        setUpAndParse('''
          @AbstractProps() class AbstractFooProps1 {}
          @AbstractProps() class AbstractFooProps2 {}
        ''');

        expect(declarations.abstractProps, hasLength(2));

        expect(declarations.abstractProps[0].node.name.name, 'AbstractFooProps1');
        expect(declarations.abstractProps[1].node.name.name, 'AbstractFooProps2');
        expect(declarations.abstractProps[0].meta, new isInstanceOf<annotations.AbstractProps>());
        expect(declarations.abstractProps[1].meta, new isInstanceOf<annotations.AbstractProps>());

        expectEmptyDeclarations(abstractProps: false);
        expect(declarations.declaresComponent, isFalse);

        verifyNoErrors();
      });

      test('abstract state classes', () {
        setUpAndParse('''
          @AbstractState() class AbstractFooState1 {}
          @AbstractState() class AbstractFooState2 {}
        ''');
        verifyNoErrors();

        expect(declarations.abstractState, hasLength(2));

        expect(declarations.abstractState[0].node.name.name, 'AbstractFooState1');
        expect(declarations.abstractState[1].node.name.name, 'AbstractFooState2');
        expect(declarations.abstractState[0].meta, new isInstanceOf<annotations.AbstractState>());
        expect(declarations.abstractState[1].meta, new isInstanceOf<annotations.AbstractState>());

        expectEmptyDeclarations(abstractState: false);
        expect(declarations.declaresComponent, isFalse);
      });

      group('and initializes annotations with the correct arguments for', () {
        test('a stateful component', () {
          setUpAndParse('''
            @Factory()
            UiFactory<FooProps> Foo;

            @Props(keyNamespace: "bar")
            class FooProps {}

            @State(keyNamespace: "baz")
            class FooState {}

            @Component(isWrapper: true)
            class FooComponent {}
          ''');
          verifyNoErrors();

          expect(declarations.props.meta.keyNamespace, 'bar');
          expect(declarations.state.meta.keyNamespace, 'baz');
          expect(declarations.component.meta.isWrapper, isTrue);
        });

        test('a props mixin', () {
          setUpAndParse('''
            @PropsMixin(keyNamespace: "bar")
            class FooPropsMixin {}
          ''');
          verifyNoErrors();
          expect(declarations.propsMixins.single.meta.keyNamespace, 'bar');
        });

        test('a state mixin', () {
          setUpAndParse('''
            @StateMixin(keyNamespace: "bar")
            class FooStateMixin {}
          ''');
          verifyNoErrors();
          expect(declarations.stateMixins.single.meta.keyNamespace, 'bar');
        });

        test('an abstract props class', () {
          setUpAndParse('''
            @AbstractProps(keyNamespace: "bar")
            class AbstractFooProps {}
          ''');
          verifyNoErrors();
          expect(declarations.abstractProps.single.meta.keyNamespace, 'bar');
        });

        test('an abstract state class', () {
          setUpAndParse('''
            @AbstractState(keyNamespace: "bar")
            class AbstractFooState {}
          ''');
          verifyNoErrors();
          expect(declarations.abstractState.single.meta.keyNamespace, 'bar');
        });
      });

      group('and logs a hard error when', () {
        const String factorySrc   = '\n@Factory()\nUiFactory<FooProps> Foo;\n';
        const String propsSrc     = '\n@Props()\nclass FooProps {}\n';
        const String componentSrc = '\n@Component()\nclass FooComponent {}\n';

        const String stateSrc     = '\n@State()\nclass FooState {}\n';

        tearDown(() {
          expect(declarations.hasErrors, isTrue);
          expectEmptyDeclarations(reason: 'Declarations with errors should always be null/empty.');
          // Verify that there are no errors other than the ones we explicitly verified.
          verifyNoMoreInteractions(logger);
        });

        group('a component is declared without', () {
          test('a factory', () {
            setUpAndParse(propsSrc + componentSrc);
            verify(logger.error('To define a component, there must also be a `@Factory` within the same file, but none were found.', span: any));
          });

          test('a props class', () {
            setUpAndParse(factorySrc + componentSrc);
            verify(logger.error('To define a component, there must also be a `@Props` within the same file, but none were found.', span: any));
          });

          test('a component class', () {
            setUpAndParse(factorySrc + propsSrc);
            verify(logger.error('To define a component, there must also be a `@Component` within the same file, but none were found.', span: any));
          });

          test('a factory or a props class', () {
            setUpAndParse(componentSrc);
            verify(logger.error('To define a component, there must also be a `@Factory` within the same file, but none were found.', span: any));
            verify(logger.error('To define a component, there must also be a `@Props` within the same file, but none were found.', span: any));
          });

          test('a factory or a component class', () {
            setUpAndParse(propsSrc);
            verify(logger.error('To define a component, there must also be a `@Factory` within the same file, but none were found.', span: any));
            verify(logger.error('To define a component, there must also be a `@Component` within the same file, but none were found.', span: any));
          });

          test('a component or props class', () {
            setUpAndParse(factorySrc);
            verify(logger.error('To define a component, there must also be a `@Component` within the same file, but none were found.', span: any));
            verify(logger.error('To define a component, there must also be a `@Props` within the same file, but none were found.', span: any));
          });
        });

        group('a state class is declared without', () {
          test('any component pieces', () {
            setUpAndParse(stateSrc);
            verify(logger.error('To define a component, a `@State` must be accompanied by the following annotations within the same file: @Factory, @Component, @Props.', span: any));
          });

          test('some component pieces', () {
            setUpAndParse(stateSrc + componentSrc);
            /// Should only log regarding the missing pieces, and not the state.
            verify(logger.error('To define a component, there must also be a `@Factory` within the same file, but none were found.', span: any));
            verify(logger.error('To define a component, there must also be a `@Props` within the same file, but none were found.', span: any));
          });
        });

        group('a component is declared with multiple', () {
          test('factories', () {
            setUpAndParse(factorySrc * 2 + propsSrc + componentSrc);
            verify(logger.error(
                argThat(startsWith('To define a component, there must be a single `@Factory` per file, but 2 were found.')), span: any
            )).called(2);
          });

          test('props classes', () {
            setUpAndParse(factorySrc + propsSrc * 2 + componentSrc);
            verify(logger.error(
                argThat(startsWith('To define a component, there must be a single `@Props` per file, but 2 were found.')), span: any
            )).called(2);
          });

          test('component classes', () {
            setUpAndParse(factorySrc + propsSrc + componentSrc * 2);
            verify(logger.error(
                argThat(startsWith('To define a component, there must be a single `@Component` per file, but 2 were found.')), span: any
            )).called(2);
          });

          test('state classes', () {
            setUpAndParse(factorySrc + propsSrc + componentSrc + stateSrc * 2);
            verify(logger.error(
                argThat(startsWith('To define a component, there must not be more than one `@State` per file, but 2 were found.')), span: any
            )).called(2);
          });
        });

        group('an annotation is used on the wrong kind of declaration:', () {
          test('@Factory on a non-top-level-variable', () {
            setUpAndParse('@Factory() class NotAVariable {}');
            verify(logger.error('`@Factory` can only be used on top-level variable declarations.', span: any));
          });

          test('@Props on a non-class', () {
            setUpAndParse('@Props() var notAClass;');
            verify(logger.error('`@Props` can only be used on classes.', span: any));
          });

          test('@Component on a non-class', () {
            setUpAndParse('@Component() var notAClass;');
            verify(logger.error('`@Component` can only be used on classes.', span: any));
          });

          test('@State on a non-class', () {
            setUpAndParse('@Props() var notAClass;');
            verify(logger.error('`@Props` can only be used on classes.', span: any));
          });

          test('@AbstractProps on a non-class', () {
            setUpAndParse('@AbstractProps() var notAClass;');
            verify(logger.error('`@AbstractProps` can only be used on classes.', span: any));
          });

          test('@AbstractState on a non-class', () {
            setUpAndParse('@AbstractState() var notAClass;');
            verify(logger.error('`@AbstractState` can only be used on classes.', span: any));
          });

          test('@PropsMixin on a non-class', () {
            setUpAndParse('@PropsMixin() var notAClass;');
            verify(logger.error('`@PropsMixin` can only be used on classes.', span: any));
          });

          test('@StateMixin on a non-class', () {
            setUpAndParse('@StateMixin() var notAClass;');
            verify(logger.error('`@StateMixin` can only be used on classes.', span: any));
          });
        });
      });
    });
  });
}


class MockTransformLogger extends Mock implements TransformLogger {
  noSuchMethod(i) => super.noSuchMethod(i);
}
