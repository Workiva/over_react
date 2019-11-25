import 'dart:html';
import 'package:logging/logging.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

import './fixtures/flawed_component.dart';
import './fixtures/flawed_component_on_mount.dart';
import './fixtures/flawed_component_that_renders_a_string.dart';
import './fixtures/flawed_component_that_renders_nothing.dart';

void sharedErrorBoundaryTests(BuilderOnlyUiFactory builder) {
  TestJacket<ErrorBoundaryMixin> jacket;
  ReactElement dummyChild;

  setUp(() {
    dummyChild = (Dom.div()..addTestId('dummyChild'))('hi there');
  });

  tearDown(() {
    jacket = null;
    dummyChild = null;
  });

  group('catches component errors', () {
    List<Map<String, List>> calls;
    DivElement mountNode;

    void verifyReact16ErrorHandlingWithoutErrorBoundary() {
      mountNode = DivElement();
      document.body.append(mountNode);
      var jacketOfFlawedComponentWithNoErrorBoundary = mount(Flawed()(), mountNode: mountNode);
      expect(mountNode.children, isNotEmpty, reason: 'test setup sanity check');

      final buttonThatShouldThrowAnErrorWhenClicked = queryByTestId(jacketOfFlawedComponentWithNoErrorBoundary.getInstance(), 'flawedComponent_flawedButton');
      expect(buttonThatShouldThrowAnErrorWhenClicked, isNotNull, reason: 'test setup sanity check');

      buttonThatShouldThrowAnErrorWhenClicked.click();
      expect(mountNode.children, isEmpty,
          reason: 'rendered trees not wrapped in an ErrorBoundary '
                  'should get unmounted when an error is thrown within child component lifecycle methods');

      mountNode.remove();
      mountNode = DivElement();
      document.body.append(mountNode);
    }

    setUp(() {
      // Verify the behavior of a component that throws when it is not wrapped in an error boundary first
      verifyReact16ErrorHandlingWithoutErrorBoundary();

      calls = [];
      jacket = mount(
        (builder()
          ..addProps(ErrorBoundaryPropsMapView({})..onComponentDidCatch = (err, info) {
            calls.add({'onComponentDidCatch': [err, info]});
          })
        )(Flawed()()),
        mountNode: mountNode,
      );
      expect(mountNode.children, isNotEmpty, reason: 'test setup sanity check');
      // Cause an error to be thrown within a ReactJS lifecycle method
      queryByTestId(jacket.getInstance(), 'flawedComponent_flawedButton').click();
    });

    tearDown(() {
      mountNode.remove();
      mountNode = null;
    });

    test('and calls `props.onComponentDidCatch`', () {
      expect(calls.single.keys, ['onComponentDidCatch']);
      final errArg = calls.single['onComponentDidCatch'][0];
      expect(errArg, isA<FlawedComponentException>());

      final infoArg = calls.single['onComponentDidCatch'][1];
      expect(infoArg, isA<ReactErrorInfo>());
    });

    test('and sets `state.hasError` to true as a result', () {
      expect(jacket.getDartInstance().state.hasError, isTrue);
    });

    test('and re-renders the tree as a result', () {
      expect(mountNode.children, isNotEmpty,
          reason: 'rendered trees wrapped in an ErrorBoundary '
                  'should NOT get unmounted when an error is thrown within child component lifecycle methods');
    });

    test('does not throw a null exception when `props.onComponentDidCatch` is not set', () {
      jacket = mount(builder()((Flawed()..addTestId('flawed'))()), mountNode: mountNode);
      // The click causes the componentDidCatch lifecycle method to execute
      // and we want to ensure that no Dart null error is thrown as a result of no consumer prop callback being set.
      expect(() => queryByTestId(jacket.getInstance(), 'flawedComponent_flawedButton').click(), returnsNormally);
    });
  });

  test('initializes with the expected default prop values', () {
    jacket = mount(builder()(dummyChild));

    expect(ErrorBoundaryPropsMapView(jacket.getProps()).identicalErrorFrequencyTolerance.inSeconds, 5);
  });

  test('initializes with the expected initial state values', () {
    jacket = mount(builder()(dummyChild));

    expect(jacket.getDartInstance().state.hasError, isFalse);
  });

  group('renders', () {
    test('its children when `state.error` is false', () {
      jacket = mount(builder()(dummyChild));
      expect(jacket.getDartInstance().state.hasError, isFalse, reason: 'test setup sanity check');

      expect(jacket.getNode().text, 'hi there');
    });

    test('its child when `state.error` is true and `state.showFallbackUIOnError` is false', () {
      jacket = mount(builder()(dummyChild));
      final component = jacket.getDartInstance();
      component.setState(component.newState()
        ..hasError = true
        ..showFallbackUIOnError = false
      );

      expect(jacket.getNode().text, 'hi there');
    });

    group('fallback UI when `state.error` is true', () {
      test('and `state.showFallbackUIOnError` is true ("unrecoverable" error state)', () {
        jacket = mount(builder()(dummyChild));
        expect(getByTestId(jacket.getInstance(), 'dummyChild'), isNotNull);
        final component = jacket.getDartInstance();
        component.setState(component.newState()
          ..hasError = true
          ..showFallbackUIOnError = true
        );

        expect(getByTestId(jacket.getInstance(), 'dummyChild'), isNull,
            reason: 'The child component tree should have been removed from the dom');
        expect(jacket.getNode(), hasAttr(defaultTestIdKey, 'ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode'));
      });

      test('and props.fallbackUIRenderer is set', () {
        ReactElement _fallbackUIRenderer(_, __) {
          return Dom.h4()('Something super not awesome just happened.');
        }

        jacket = mount((builder()..addProps(ErrorBoundaryPropsMapView({})..fallbackUIRenderer = _fallbackUIRenderer))(dummyChild));
        final component = jacket.getDartInstance();
        component.setState(component.newState()..hasError = true);

        expect(jacket.getNode(), hasNodeName('H4'), reason: '${ErrorBoundaryPropsMapView(jacket.getProps()).fallbackUIRenderer}');
        expect(jacket.getNode().text, 'Something super not awesome just happened.');
      });

      group('and then switches back to rendering the child', () {
        setUp(() {
          jacket = mount((builder()
            ..addProps(ErrorBoundaryPropsMapView({})
              ..fallbackUIRenderer = (_, __) => (Dom.div()..addTestId('fallbackNode'))('Something went wrong')
            )
          )(dummyChild));
          final component = jacket.getDartInstance();
          component.setState(component.newState()
            ..hasError = true
            ..showFallbackUIOnError = true
          );
          expect(getByTestId(jacket.getInstance(), 'dummyChild'), isNull);
          expect(getByTestId(jacket.getInstance(), 'fallbackNode'), isNotNull);
        });

        test('when reset() is called', () {
          jacket.getDartInstance().reset();
          expect(jacket.getDartInstance().state.hasError, isFalse);
          expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue);
          expect(getByTestId(jacket.getInstance(), 'dummyChild'), isNotNull);
          expect(getByTestId(jacket.getInstance(), 'fallbackNode'), isNull);
        });

        group('when a new child is passed in', () {
          test('', () {
            final newDummyChild = (Dom.div()..addTestId('newDummyChild'))('hi there');
            jacket.rerender((builder()
              ..addProps(ErrorBoundaryPropsMapView({})
                ..fallbackUIRenderer = (_, __) => (Dom.div()..addTestId('fallbackNode'))('Something went wrong')
              )
            )(newDummyChild));
            expect(jacket.getDartInstance().state.hasError, isFalse);
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue);
            expect(getByTestId(jacket.getInstance(), 'newDummyChild'), isNotNull);
            expect(getByTestId(jacket.getInstance(), 'fallbackNode'), isNull);
          });

          test('unless the new child also throws an error', () {
            jacket.rerender((builder()
              ..addProps(ErrorBoundaryPropsMapView({})
                ..fallbackUIRenderer = (_, __) => (Dom.div()..addTestId('fallbackNode'))('Something went wrong')
              )
            )((FlawedOnMount()..addTestId('flawed'))()));
            expect(jacket.getDartInstance().state.hasError, isTrue);
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue);
            expect(getByTestId(jacket.getInstance(), 'flawed'), isNull);
            expect(getByTestId(jacket.getInstance(), 'fallbackNode'), isNotNull);
          });
        });
      });
    });
  });

  group('gracefully handles errors in its tree when `props.fallbackUIRenderer` is not set', () {
    List<Map<String, List>> calls;
    dynamic flawedRenderedInstance;
    dynamic nestedFlawedRenderedInstance;
    const identicalErrorFrequencyToleranceInMs = 500;
    dynamic errorSentToComponentDidCatchCallback;
    dynamic errorInfoSentToComponentDidCatchCallback;
    dynamic errorSentToComponentIsUnrecoverableCallback;
    dynamic errorInfoSentToComponentIsUnrecoverableCallback;

    Element getFlawedButtonNode() => queryByTestId(jacket.getInstance(), 'flawedComponent_flawedButton');
    Element getFlawedButtonThatThrowsADifferentErrorNode() => queryByTestId(jacket.getInstance(), 'flawedComponent_flawedButtonThatThrowsADifferentError');
    Element getNestedFlawedButtonNode() => queryByTestId(jacket.getInstance(), 'nestedFlawedComponent_flawedButton');
    Element getNestedFlawedButtonThatThrowsADifferentErrorNode() => queryByTestId(jacket.getInstance(), 'nestedFlawedComponent_flawedButtonThatThrowsADifferentError');

    void _setCallbackVarValues() {
      expect(calls, isNotNull, reason: 'test setup sanity check');
      expect(calls, isNotEmpty, reason: 'test setup sanity check');
      expect(calls[0].keys.single, 'onComponentDidCatch', reason: 'test setup sanity check');
      expect(jacket.getDartInstance().state.hasError, isTrue, reason: 'test setup sanity check');

      final componentDidCatchCallbackArguments = calls[0]['onComponentDidCatch'];
      if (componentDidCatchCallbackArguments != null) {
        errorSentToComponentDidCatchCallback = componentDidCatchCallbackArguments[0];
        errorInfoSentToComponentDidCatchCallback = componentDidCatchCallbackArguments[1];
      }

      if (calls.length > 1) {
        expect(calls[1].keys.single, 'onComponentIsUnrecoverable', reason: 'test setup sanity check');
        final componentIsUnrecoverableCallbackArguments = calls[1]['onComponentIsUnrecoverable'];
        if (componentIsUnrecoverableCallbackArguments != null) {
          errorSentToComponentIsUnrecoverableCallback = componentIsUnrecoverableCallbackArguments[0];
          errorInfoSentToComponentIsUnrecoverableCallback = componentIsUnrecoverableCallbackArguments[1];
        }
      }
    }

    void sharedSetup({dynamic errorBoundaryChildren}) {
      final customChildrenUsed = errorBoundaryChildren != null;
      errorBoundaryChildren ??= (Flawed()..addTestId('flawedComponent'))(
        (Flawed()
          ..buttonTestIdPrefix = 'nestedFlawedComponent_'
          ..addTestId('nestedFlawedComponent')
        )(),
      );
      calls = [];

      jacket = mount(
        (builder()
          ..addProps(ErrorBoundaryPropsMapView({})
            ..identicalErrorFrequencyTolerance = const Duration(
                milliseconds: identicalErrorFrequencyToleranceInMs)
            ..onComponentDidCatch = (err, info) {
              calls.add({'onComponentDidCatch': [err, info]});
            }
            ..onComponentIsUnrecoverable = (err, info) {
              calls.add({'onComponentIsUnrecoverable': [err, info]});
            }
          )
        )(errorBoundaryChildren),
        attachedToDocument: true);

      if (!customChildrenUsed) {
        flawedRenderedInstance = getByTestId(jacket.getInstance(), 'flawedComponent');
        expect(flawedRenderedInstance, isNotNull, reason: 'test setup sanity check');

        nestedFlawedRenderedInstance = getByTestId(jacket.getInstance(), 'nestedFlawedComponent');
        expect(nestedFlawedRenderedInstance, isNotNull, reason: 'test setup sanity check');
      }
    }

    tearDown(() {
      calls = null;
      flawedRenderedInstance = null;
      nestedFlawedRenderedInstance = null;
      errorSentToComponentDidCatchCallback = null;
      errorInfoSentToComponentDidCatchCallback = null;
      errorSentToComponentIsUnrecoverableCallback = null;
      errorInfoSentToComponentIsUnrecoverableCallback = null;
    });

    group('and consecutive errors are thrown from the same component', () {
      Future<Null> triggerErrorsViaButtonClickThatSignifyAnUnrecoverableComponent({throwExtraError = false}) async {
        getFlawedButtonNode().click();
        expect(calls.length, 1, reason: 'test setup sanity check');
        expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');

        if (throwExtraError) getFlawedButtonThatThrowsADifferentErrorNode().click();

        calls.clear();
        await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs ~/ 2));

        getFlawedButtonNode().click();
        _setCallbackVarValues();
      }

      group('and the errors are exactly the same', () {
        group('and they occurred more frequently than the value of props.identicalErrorFrequencyTolerance', () {
          String errorBoundaryInnerHtmlBeforeUnrecoverableError;

          tearDown(() {
            errorBoundaryInnerHtmlBeforeUnrecoverableError = null;
          });

          group('and `_domAtTimeOfError` is not null:', () {
            setUp(() async {
              sharedSetup();

              expect(jacket.getNode(),
                  isNot(hasAttr(defaultTestIdKey, 'ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode')),
                  reason: 'test setup sanity check');
              errorBoundaryInnerHtmlBeforeUnrecoverableError = jacket.getNode().innerHtml;
              await triggerErrorsViaButtonClickThatSignifyAnUnrecoverableComponent();
            });

            test('the components wrapped by the ErrorBoundary get unmounted', () {
              expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNull,
                  reason: 'The flawed component should have been unmounted');
              expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue,
                  reason: 'Fallback UI should be rendered instead of the flawed component tree');
              expect(jacket.getNode(),
                  hasAttr(defaultTestIdKey, 'ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode'));
              expect(jacket.getNode().innerHtml, errorBoundaryInnerHtmlBeforeUnrecoverableError);
            });

            test('the correct callbacks are called with the correct arguments', () {
              expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isTrue,
                  reason: 'onComponentIsUnrecoverable should have been called');

              expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentIsUnrecoverableCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentDidCatchCallback, errorSentToComponentIsUnrecoverableCallback);

              expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentIsUnrecoverableCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentDidCatchCallback, errorInfoSentToComponentIsUnrecoverableCallback);
            });
          });

          // Test edge cases where `ErrorBoundaryComponent._domAtTimeOfError` is null
          group('and `_domAtTimeOfError` is null', () {
            // Assert that the error resulting from `findDomNode` being called on something
            // that is not an `Element` gets caught so that our ErrorBoundary itself does not throw.
            group('as a result of the ErrorBoundary wrapping around a component that renders a string:', () {
              setUp(() {
                sharedSetup(errorBoundaryChildren: FlawedWithStringChild()());
              });

              test('the fallback UI node is rendered by the boundary', () {
                expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue,
                    reason: 'Fallback UI should be rendered instead of the flawed component tree');
                expect(jacket.getNode(),
                    hasAttr(defaultTestIdKey, 'ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode'));
              });

              test('an empty string is rendered within the fallback UI node', () {
                expect(jacket.getNode().innerHtml, isEmpty);
              });

              test('the correct callbacks are called with the correct arguments', () {
                expect(calls.any((call) => call.keys.single == 'onComponentDidCatch'), isTrue,
                    reason: 'onComponentDidCatch should have been called');
                expect(calls.where((call) => call.keys.single == 'onComponentDidCatch')
                    .first['onComponentDidCatch'][0],
                    isA<FlawedWithStringChildComponentException>());
                expect(calls.where((call) => call.keys.single == 'onComponentDidCatch')
                    .first['onComponentDidCatch'][1],
                    isA<ReactErrorInfo>(),
                    reason: 'error info should have been passed to onComponentDidCatch as a string');

                expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isTrue,
                    reason: 'onComponentIsUnrecoverable should have been called');
                expect(calls.where((call) => call.keys.single == 'onComponentIsUnrecoverable')
                    .first['onComponentIsUnrecoverable'][0],
                    isA<FlawedWithStringChildComponentException>());
                expect(calls.where((call) => call.keys.single == 'onComponentIsUnrecoverable')
                    .first['onComponentIsUnrecoverable'][1],
                    isA<ReactErrorInfo>(),
                    reason: 'error info should have been passed to onComponentIsUnrecoverable as a string');
              });
            });

            // Assert that `dangerouslySetInnerHTML` is passed an empty string - not null.
            group('as a result of the ErrorBoundary wrapping around a component that renders nothing:', () {
              setUp(() {
                sharedSetup(errorBoundaryChildren: FlawedWithNoChild()());
              });

              test('the fallback UI node is rendered by the boundary', () {
                expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue,
                    reason: 'Fallback UI should be rendered instead of the flawed component tree');
                expect(jacket.getNode(),
                    hasAttr(defaultTestIdKey, 'ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode'));
              });

              test('an empty string is rendered within the fallback UI node', () {
                expect(jacket.getNode().innerHtml, isEmpty);
              });

              test('the correct callbacks are called with the correct arguments', () {
                expect(calls.any((call) => call.keys.single == 'onComponentDidCatch'), isTrue,
                    reason: 'onComponentDidCatch should have been called');
                expect(calls.where((call) => call.keys.single == 'onComponentDidCatch')
                    .first['onComponentDidCatch'][0],
                    isA<FlawedWithNoChildComponentException>());
                expect(calls.where((call) => call.keys.single == 'onComponentDidCatch')
                    .first['onComponentDidCatch'][1],
                    isA<ReactErrorInfo>(),
                    reason: 'error info should have been passed to onComponentDidCatch as a string');

                expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isTrue,
                    reason: 'onComponentIsUnrecoverable should have been called');
                expect(calls.where((call) => call.keys.single == 'onComponentIsUnrecoverable')
                    .first['onComponentIsUnrecoverable'][0],
                    isA<FlawedWithNoChildComponentException>());
                expect(calls.where((call) => call.keys.single == 'onComponentIsUnrecoverable')
                    .first['onComponentIsUnrecoverable'][1],
                    isA<ReactErrorInfo>(),
                    reason: 'error info should have been passed to onComponentIsUnrecoverable as a string');
              });
            });
          });
        });

        group('and they occurred less frequently than the value of props.identicalErrorFrequencyTolerance:', () {
          setUp(() async {
            sharedSetup();

            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs + 50));

            getFlawedButtonNode().click();
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });

          // Test that unrecoverable errors that come after recoverable ones produce the same behavior
          // as unrecoverable errors that are the first caught by the ErrorBoundary after being mounted.
          group('but are then followed by two more errors that are exactly the same, '
              'more frequent than the value of props.identicalErrorFrequencyTolerance', () {
            setUp(() async {
              await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs + 50));
              calls.clear();
              await triggerErrorsViaButtonClickThatSignifyAnUnrecoverableComponent();
            });

            test('the components wrapped by the ErrorBoundary get unmounted', () {
              expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNull,
                  reason: 'The flawed component should have been unmounted');
              expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue,
                  reason: 'Fallback UI should be rendered instead of the flawed component tree');
            });

            test('the correct callbacks are called with the correct arguments', () {
              expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isTrue,
                  reason: 'onComponentIsUnrecoverable should have been called');

              expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentIsUnrecoverableCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentDidCatchCallback, errorSentToComponentIsUnrecoverableCallback);

              expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentIsUnrecoverableCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentDidCatchCallback, errorInfoSentToComponentIsUnrecoverableCallback);
            });
          });
        });
      });

      group('and there are two twin errors with a different one being caught in between them', () {
          String errorBoundaryInnerHtmlBeforeUnrecoverableError;

          tearDown(() {
            errorBoundaryInnerHtmlBeforeUnrecoverableError = null;
          });

          group('and they occurred more frequently than the value of props.identicalErrorFrequencyTolerance '
              'and `_domAtTimeOfError` is not null:', () {
            setUp(() async {
              sharedSetup();

              expect(jacket.getNode(),
                  isNot(hasAttr(defaultTestIdKey, 'ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode')),
                  reason: 'test setup sanity check');
              errorBoundaryInnerHtmlBeforeUnrecoverableError = jacket.getNode().innerHtml;
              await triggerErrorsViaButtonClickThatSignifyAnUnrecoverableComponent(throwExtraError: true);
            });

            test('the components wrapped by the ErrorBoundary get unmounted', () {
              expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNull,
                  reason: 'The flawed component should have been unmounted');
              expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue,
                  reason: 'Fallback UI should be rendered instead of the flawed component tree');
              expect(jacket.getNode(),
                  hasAttr(defaultTestIdKey, 'ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode'));
              expect(jacket.getNode().innerHtml, errorBoundaryInnerHtmlBeforeUnrecoverableError);
            });

            test('the correct callbacks are called with the correct arguments', () {
              expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isTrue,
                  reason: 'onComponentIsUnrecoverable should have been called');

              expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentIsUnrecoverableCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentDidCatchCallback, errorSentToComponentIsUnrecoverableCallback);

              expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentIsUnrecoverableCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentDidCatchCallback, errorInfoSentToComponentIsUnrecoverableCallback);
          });
        });

        group('and they occurred less frequently than the value of props.identicalErrorFrequencyTolerance:', () {
          setUp(() async {
            sharedSetup();

            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');

            getFlawedButtonThatThrowsADifferentErrorNode().click();

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs + 50));

            getFlawedButtonNode().click();
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });

          // Test that unrecoverable errors that come after recoverable ones produce the same behavior
          // as unrecoverable errors that are the first caught by the ErrorBoundary after being mounted.
          group('but are then followed by two more errors that are exactly the same, '
              'more frequent than the value of props.identicalErrorFrequencyTolerance', () {
            setUp(() async {
              await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs + 50));
              calls.clear();
              await triggerErrorsViaButtonClickThatSignifyAnUnrecoverableComponent();
            });

            test('the components wrapped by the ErrorBoundary get unmounted', () {
              expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNull,
                  reason: 'The flawed component should have been unmounted');
              expect(jacket.getDartInstance().state.showFallbackUIOnError, isTrue,
                  reason: 'Fallback UI should be rendered instead of the flawed component tree');
            });

            test('the correct callbacks are called with the correct arguments', () {
              expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isTrue,
                  reason: 'onComponentIsUnrecoverable should have been called');

              expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentIsUnrecoverableCallback, isA<FlawedComponentException>());
              expect(errorSentToComponentDidCatchCallback, errorSentToComponentIsUnrecoverableCallback);

              expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentIsUnrecoverableCallback, isA<ReactErrorInfo>());
              expect(errorInfoSentToComponentDidCatchCallback, errorInfoSentToComponentIsUnrecoverableCallback);
            });
          });
        });
      });

      group('and the errors are different', () {
        setUp(sharedSetup);

        group('and they occurred more frequently than the value of props.identicalErrorFrequencyTolerance:', () {
          setUp(() async {
            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');
            final firstError = calls[0]['onComponentDidCatch'][0];

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs ~/ 2));

            getFlawedButtonThatThrowsADifferentErrorNode().click();
            final secondError = calls[0]['onComponentDidCatch'][0];

            expect('$firstError', isNot('$secondError'), reason: 'test setup sanity check');
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException2>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });
        });

        group('and they occurred less frequently than the value of props.identicalErrorFrequencyTolerance', () {
          setUp(() async {
            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');
            final firstError = calls[0]['onComponentDidCatch'][0];

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs + 50));

            getFlawedButtonThatThrowsADifferentErrorNode().click();
            final secondError = calls[0]['onComponentDidCatch'][0];

            expect('$firstError', isNot('$secondError'), reason: 'test setup sanity check');
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'flawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException2>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });
        });
      });
    });

    group('and consecutive errors are thrown from different components in the same tree', () {
      setUp(sharedSetup);

      group('and the errors are exactly the same', () {
        group('and they occurred more frequently than the value of props.identicalErrorFrequencyTolerance:', () {
          setUp(() async {
            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');
            final firstError = calls[0]['onComponentDidCatch'][0];

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs ~/ 2));

            getNestedFlawedButtonNode().click();
            final secondError = calls[0]['onComponentDidCatch'][0];

            expect('$firstError', '$secondError', reason: 'test setup sanity check');
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'nestedFlawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });
        });

        group('and they occurred less frequently than the value of props.identicalErrorFrequencyTolerance:', () {
          setUp(() async {
            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');
            final firstError = calls[0]['onComponentDidCatch'][0];

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs + 50));

            getNestedFlawedButtonNode().click();
            final secondError = calls[0]['onComponentDidCatch'][0];

            expect('$firstError', '$secondError', reason: 'test setup sanity check');
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'nestedFlawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });
        });
      });

      group('and the errors are different', () {
        group('and they occurred more frequently than the value of props.identicalErrorFrequencyTolerance:', () {
          setUp(() async {
            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');
            final firstError = calls[0]['onComponentDidCatch'][0];

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs ~/ 2));

            getNestedFlawedButtonThatThrowsADifferentErrorNode().click();
            final secondError = calls[0]['onComponentDidCatch'][0];

            expect('$firstError', isNot('$secondError'), reason: 'test setup sanity check');
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'nestedFlawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException2>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });
        });

        group('and they occurred less frequently than the value of props.identicalErrorFrequencyTolerance:', () {
          setUp(() async {
            getFlawedButtonNode().click();
            expect(calls.length, 1, reason: 'test setup sanity check');
            expect(calls.single.keys.single, isNot('onComponentIsUnrecoverable'), reason: 'test setup sanity check');
            final firstError = calls[0]['onComponentDidCatch'][0];

            calls.clear();
            await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs + 50));

            getNestedFlawedButtonThatThrowsADifferentErrorNode().click();
            final secondError = calls[0]['onComponentDidCatch'][0];

            expect('$firstError', isNot('$secondError'), reason: 'test setup sanity check');
            _setCallbackVarValues();
          });

          test('the components wrapped by the ErrorBoundary get remounted', () {
            expect(getByTestId(jacket.getInstance(), 'nestedFlawedComponent'), isNotNull,
                reason: 'The flawed component should have been remounted');
            expect(jacket.getDartInstance().state.showFallbackUIOnError, isFalse,
                reason: 'Fallback UI should be not be rendered');
          });

          test('the correct callbacks are called with the correct arguments', () {
            expect(calls.any((call) => call.keys.single == 'onComponentIsUnrecoverable'), isFalse,
                reason: 'onComponentIsUnrecoverable should not have been called');

            expect(errorSentToComponentDidCatchCallback, isA<FlawedComponentException2>());
            expect(errorInfoSentToComponentDidCatchCallback, isA<ReactErrorInfo>());
          });
        });
      });
    });
  });

  group('logs errors using a `logger`', () {
    List<Map<String, List>> calls;
    List<LogRecord> logRecords;
    const identicalErrorFrequencyToleranceInMs = 500;

    // Cause an error to be thrown within a ReactJS lifecycle method
    void triggerAComponentError() {
      queryByTestId(jacket.getInstance(), 'flawedComponent_flawedButton').click();
    }

    void sharedSetup({String loggerName, bool shouldLogErrors = true, Logger customLogger}) {
      calls = [];
      jacket = mount(
        (ErrorBoundary()
          ..loggerName = loggerName
          ..shouldLogErrors = shouldLogErrors
          ..logger = customLogger
          ..identicalErrorFrequencyTolerance = const Duration(milliseconds: identicalErrorFrequencyToleranceInMs)
          ..onComponentDidCatch = (err, info) {
            calls.add({'onComponentDidCatch': [err, info]});
          }
          ..onComponentIsUnrecoverable = (err, info) {
            calls.add({'onComponentIsUnrecoverable': [err, info]});
          }
        )(Flawed()()),
        attachedToDocument: true,
      );

      logRecords = [];
      final subscription =
          Logger(customLogger?.name ?? loggerName ?? defaultErrorBoundaryLoggerName).onRecord.listen(logRecords.add);
      addTearDown(subscription.cancel);
    }

    tearDown(() {
      logRecords = null;
    });

    test('when `props.shouldLogErrors` is false', () {
      sharedSetup(shouldLogErrors: false);
      triggerAComponentError();
      expect(logRecords, isEmpty);
    });

    group('provided via `props.logger`', () {
      test('', () {
        sharedSetup(customLogger: Logger('myCustomLoggerLoggerName'));
        triggerAComponentError();

        expect(logRecords, hasLength(1));
        expect(logRecords.single.level, Level.SEVERE);
        expect(logRecords.single.loggerName, 'myCustomLoggerLoggerName');
        expect(logRecords.single.error, calls.single['onComponentDidCatch'][0]);

        ReactErrorInfo infoSentToCallback = calls.single['onComponentDidCatch'][1];
        expect(logRecords.single.stackTrace, infoSentToCallback.dartStackTrace);
        expect(logRecords.single.message, 'An error was caught by an ErrorBoundary:'
            ' \nInfo: ${infoSentToCallback.componentStack}');
      });

      test('and `props.loggerName` is also set', () {
        sharedSetup(loggerName: 'somethingElse', customLogger: Logger('myCustomLoggerLoggerName'));
        triggerAComponentError();

        expect(logRecords.single.loggerName, 'myCustomLoggerLoggerName');
      });
    });

    group('when `props.loggerName` is not set', () {
      setUp(sharedSetup);

      test('and a component error is caught', () {
        triggerAComponentError();

        expect(logRecords, hasLength(1));
        expect(logRecords.single.level, Level.SEVERE);
        expect(logRecords.single.loggerName, defaultErrorBoundaryLoggerName);
        expect(logRecords.single.error, calls.single['onComponentDidCatch'][0]);

        ReactErrorInfo infoSentToCallback = calls.single['onComponentDidCatch'][1];
        expect(logRecords.single.stackTrace, infoSentToCallback.dartStackTrace);
        expect(logRecords.single.message, 'An error was caught by an ErrorBoundary:'
            ' \nInfo: ${infoSentToCallback.componentStack}');
      });

      test('and an unrecoverable component error is caught', () async {
        triggerAComponentError();
        await Future.delayed(const Duration(milliseconds: identicalErrorFrequencyToleranceInMs ~/ 2));
        triggerAComponentError();

        expect(logRecords, hasLength(2));
        expect(logRecords[1].level, Level.SEVERE);
        expect(logRecords[1].loggerName, defaultErrorBoundaryLoggerName);
        expect(logRecords[1].error, calls[2]['onComponentIsUnrecoverable'][0]);

        ReactErrorInfo infoSentToCallback = calls[2]['onComponentIsUnrecoverable'][1];
        expect(logRecords[1].stackTrace, infoSentToCallback.dartStackTrace);
        expect(logRecords[1].message,
            'An unrecoverable error was caught by an ErrorBoundary (attempting to remount it was unsuccessful):'
            ' \nInfo: ${infoSentToCallback.componentStack}');
      });

      group('but then `props.loggerName` is set to a non-null value', () {
        setUp(() {
          Logger('myCustomErrorLoggerName').clearListeners();
          jacket.rerender(
            (ErrorBoundary()
              ..loggerName = 'myCustomErrorLoggerName'
              ..identicalErrorFrequencyTolerance = const Duration(milliseconds: identicalErrorFrequencyToleranceInMs)
              ..onComponentDidCatch = (err, info) {
                calls.add({'onComponentDidCatch': [err, info]});
              }
              ..onComponentIsUnrecoverable = (err, info) {
                calls.add({'onComponentIsUnrecoverable': [err, info]});
              }
            )(Flawed()())
          );
          final subscription = Logger('myCustomErrorLoggerName').onRecord.listen(logRecords.add);
          addTearDown(subscription.cancel);
        });

        test('and a component error is caught', () {
          triggerAComponentError();

          expect(logRecords.single.loggerName, 'myCustomErrorLoggerName');
        });

        group('and then to a null value', () {
          setUp(() {
            Logger(defaultErrorBoundaryLoggerName).clearListeners();
            jacket.rerender(
              (ErrorBoundary()
                ..loggerName = null
                ..identicalErrorFrequencyTolerance = const Duration(milliseconds: identicalErrorFrequencyToleranceInMs)
                ..onComponentDidCatch = (err, info) {
                  calls.add({'onComponentDidCatch': [err, info]});
                }
                ..onComponentIsUnrecoverable = (err, info) {
                  calls.add({'onComponentIsUnrecoverable': [err, info]});
                }
              )(Flawed()())
            );
            final subscription = Logger(defaultErrorBoundaryLoggerName).onRecord.listen(logRecords.add);
            addTearDown(subscription.cancel);
          });

          test('and a component error is caught', () {
            triggerAComponentError();

            expect(logRecords.single.loggerName, defaultErrorBoundaryLoggerName,
                reason: 'The loggerName should fall back to `defaultErrorBoundaryLoggerName` '
                        'if a consumer attempts to set it to null');
          });
        });
      });
    });
  });

//  group('throws a PropError when', () {
//    test('more than one child is provided', () {
//      expect(() => mount(builder()(dummyChild, dummyChild)),
//          throwsPropError_Value([dummyChild, dummyChild], 'children'));
//    });
//
//    test('an invalid child is provided', () {
//      expect(() => mount(builder()('oh hai')),
//          throwsPropError_Value(['oh hai'], 'children'));
//    });
//  });
}
