// Copyright 2020 Workiva Inc.
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

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import 'fixtures/connect_flux_counter.dart';
import 'fixtures/connect_flux_store.dart';
import 'fixtures/counter.dart';
import 'fixtures/redux_actions.dart';
import 'fixtures/store.dart' as redux_store;

// ignore_for_file: avoid_types_on_closure_parameters

main() {
  group('connectFlux', () {
    UiFactory<ConnectFluxCounterProps> ConnectedCounter;
    TestJacket<ConnectFluxCounterComponent> jacket;
    final counterRef = createRef<ConnectFluxCounterComponent>();

    JsConnectOptions connectOptions;
    final originalConnect = mockableJsConnect;

    setUpAll(() {
      mockableJsConnect = ([
        Function mapStateToProps,
        dynamic mapDispatchToProps,
        Function mergeProps,
        JsConnectOptions options,
      ]) {
        connectOptions = options;
        return originalConnect(
            mapStateToProps, mapDispatchToProps, mergeProps, options);
      };
    });

    tearDownAll(() {
      mockableJsConnect = originalConnect;
    });

    setUp(() async {
      ConnectedCounter = null;
      jacket = null;
      // Reset stores state to initialState value
      store1.dispatch(ResetAction());
      store2.dispatch(ResetAction());

      // wait for state to update
      await Future(() {});
    });

    group('behaves like redux with', () {
      group('Provider Usage', () {
        test('throws without a provider', () {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
          )(ConnectFluxCounter);

          expect(() => render(ConnectedCounter()('test')), throwsA(anything));
        });

        test('does not throw with a provider', () {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>()(
                  ConnectFluxCounter);

          expect(
            () => render(
              (ReduxProvider()..store = store1)(
                ConnectedCounter()('test'),
              ),
            ),
            isNot(throwsA(anything)),
          );
        });
      });

      group('forwardRef', () {
        test('when true: forwards the ref to the wrapped component', () {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
                  forwardRef: true)(ConnectFluxCounter);

          render(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );
          expect(counterRef.current, isA<ConnectFluxCounterComponent>());
        });
      });

      group('mapStateToProps properly maps the state to the components props',
          () {
        test('on inital load', () {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
                  mapStateToProps: (state) =>
                      (ConnectFluxCounter()..currentCount = state.count),
                  forwardRef: true)(ConnectFluxCounter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );

          expect(counterRef.current.props.currentCount, 0);
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));
        });

        test('after triggered', () async {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
                  mapStateToProps: (state) =>
                      (ConnectFluxCounter()..currentCount = state.count),
                  mapActionsToProps: (actions) => (ConnectFluxCounter()
                    ..increment = actions.incrementAction
                    ..decrement = actions.decrementAction),
                  forwardRef: true)(ConnectFluxCounter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );

          expect(counterRef.current.props.currentCount, 0);
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));

          var dispatchButton =
              queryByTestId(jacket.mountNode, 'button-increment');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          expect(counterRef.current.props.currentCount, 1);
          expect(jacket.mountNode.innerHtml, contains('Count: 1'));
        });
      });

      group(
          'mapStateToPropsWithOwnProps properly maps the state to the components props',
          () {
        test('on inital load', () {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
                  mapStateToPropsWithOwnProps: (state, ownProps) =>
                      (ConnectFluxCounter()..currentCount = state.count),
                  forwardRef: true)(ConnectFluxCounter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );

          expect(counterRef.current.props.currentCount, 0);
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));
        });

        test('after dispatch', () async {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToPropsWithOwnProps: (state, ownProps) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );

          expect(counterRef.current.props.currentCount, 0);
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));

          var dispatchButton =
              queryByTestId(jacket.mountNode, 'button-increment');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          expect(counterRef.current.props.currentCount, 1);
          expect(jacket.mountNode.innerHtml, contains('Count: 1'));
        });
      });

      group('mapActionsToProps', () {
        test('maps actions to props correctly', () async {
          final stateReferences = <FluxStore>[];

          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) {
              return ConnectFluxCounter()..currentCount = state.count;
            },
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );

          expect(counterRef.current.props.decrement, isA<Function>());

          expect(counterRef.current.props.currentCount, 0);
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));

          // Click button mapped to trigger `propFromDispatch` prop.
          var dispatchButton =
              queryByTestId(jacket.mountNode, 'button-decrement');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          expect(counterRef.current.props.currentCount, -1);
          expect(jacket.mountNode.innerHtml, contains('Count: -1'));
          stateReferences.forEach((store) => expect(store, isA<FluxStore>()));
        });
      });

      group('mapActionsToPropsWithOwnProps', () {
        test('maps actions to props correctly', () async {
          final stateReferences = <FluxStore>[];
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) {
              stateReferences.add(state);
              return ConnectFluxCounter()..currentCount = state.count;
            },
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );

          expect(counterRef.current.props.decrement, isA<Function>());

          expect(counterRef.current.props.currentCount, 0);
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));

          // Click button mapped to trigger `propFromDispatch` prop.
          var dispatchButton =
              queryByTestId(jacket.mountNode, 'button-decrement');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          expect(counterRef.current.props.currentCount, -1);
          expect(jacket.mountNode.innerHtml, contains('Count: -1'));
          stateReferences.forEach((store) => expect(store, isA<FluxStore>()));
        });
      });

      group('mergeProps', () {
        test('properly merges props based on consumer map', () async {
          final propsReferences = <ConnectFluxCounterProps>[];
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) {
              return ConnectFluxCounter()..decrement = actions.decrementAction;
            },
            mergeProps: (stateProps, dispatchProps, ownProps) {
              propsReferences.addAll([stateProps, dispatchProps, ownProps]);
              return ConnectFluxCounter()
                // Return whatever value is passed through ownProps until the state count is over 1
                ..currentCount = stateProps.currentCount < 1
                    ? ownProps.currentCount
                    : stateProps.currentCount
                ..decrement = ownProps.decrement;
            },
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()
                ..ref = counterRef
                // make `decrement` increment
                ..decrement = () {
                  store1.dispatch(IncrementAction());
                }
                ..currentCount = 900
              )('test'),
            ),
          );
          // `button-decrement` will be incrementing now
          var dispatchButton =
              queryByTestId(jacket.mountNode, 'button-decrement');

          expect(counterRef.current.props.decrement, isA<Function>());

          // state.count is at 0
          expect(counterRef.current.props.currentCount, 900);
          expect(jacket.mountNode.innerHtml, contains('Count: 900'));

          // Click button mapped to trigger `propFromDispatch` prop.
          click(dispatchButton); // state.count is now equal to 1

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          expect(counterRef.current.props.currentCount, 1);
          expect(jacket.mountNode.innerHtml, contains('Count: 1'));
          propsReferences.forEach(
              (store) => expect(store, isA<ConnectFluxCounterProps>()));
        });
      });

      group('Options', () {
        group('areOwnPropsEqual', () {
          test('', () {
            final propsReferences = <ConnectFluxCounterProps>[];
            ConnectedCounter =
                connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
              areOwnPropsEqual: expectAsync2((next, prev) {
                propsReferences.addAll([prev, next]);
                expect(next.id, 'test');
                expect(prev.id, 'test2');
                return true;
              }),
            )(ConnectFluxCounter);

            var whatever = connectOptions.areOwnPropsEqual(
                JsBackedMap.from({'id': 'test'}).jsObject,
                JsBackedMap.from({'id': 'test2'}).jsObject);

            expect(whatever, isTrue);
            propsReferences.forEach(
                (store) => expect(store, isA<ConnectFluxCounterProps>()));
          });
        });

        group('areStatePropsEqual', () {
          List<Map<String, dynamic>> methodsCalled;
          const mountMethodCalls = [
            'mapStateToProps',
            'mapStateToProps',
            'areStatePropsEqual',
          ];

          const updateMethodCalls = [
            'mapStateToProps',
            'areStatePropsEqual',
            'mapStateToProps',
            'areStatePropsEqual'
          ];

          setUp(() {
            methodsCalled = [];
          });

          test('', () async {
            ConnectedCounter =
                connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
              mapStateToProps: (state) {
                methodsCalled.add({'called': 'mapStateToProps'});
                return ConnectFluxCounter()..currentCount = state.count;
              },
              mapActionsToProps: (actions) =>
                  (ConnectFluxCounter()..increment = actions.incrementAction),
              areStatePropsEqual: (next, prev) {
                methodsCalled.add({
                  'called': 'areStatePropsEqual',
                  'prev': prev,
                  'next': next,
                });
                // Force it to always be true, meaning it shouldn't re-render if they change.
                return true;
              },
              forwardRef: true,
            )(ConnectFluxCounter);

            jacket = mount(
              (ReduxProvider()..store = store1)(
                (ConnectedCounter()
                  ..ref = counterRef
                  ..currentCount = 0
                )('test'),
              ),
            );

            // Because `areStatesEqual` is false, we expect additional method calls
            expect(methodsCalled.map((methodObj) => methodObj['called']),
                mountMethodCalls);
            for (final methodCall in methodsCalled) {
              if (methodCall['called'] == 'areStatePropsEqual') {
                expect(methodCall['prev'], isA<ConnectFluxCounterProps>());
                expect(methodCall['next'], isA<ConnectFluxCounterProps>());
              }
            }

            methodsCalled.clear();

            var dispatchButton =
                queryByTestId(jacket.mountNode, 'button-increment');
            click(dispatchButton);

            // wait for the next tick for the async dispatch to propagate
            await Future(() {});

            // store.state.count should be 1 but does not re-render due to override in `areStatePropsEqual`
            expect(methodsCalled.map((methodObj) => methodObj['called']),
                updateMethodCalls);
            for (final methodCall in methodsCalled) {
              if (methodCall['called'] == 'areStatePropsEqual') {
                expect(methodCall['prev'], isA<ConnectFluxCounterProps>());
                expect(methodCall['next'], isA<ConnectFluxCounterProps>());
              }
            }

            expect(jacket.mountNode.innerHtml, contains('Count: 0'));
          });

          test(
              'matches a standard Redux component when `areStatesEqual` is false',
              () async {
            final localReduxRef = createRef<CounterComponent>();

            final ReduxConnectedCounter =
                connect<redux_store.CounterState, CounterProps>(
              mapStateToProps: (state) {
                methodsCalled.add({'called': 'mapStateToProps'});
                return ConnectFluxCounter()..currentCount = state.count;
              },
              areStatePropsEqual: (next, prev) {
                methodsCalled.add({
                  'called': 'areStatePropsEqual',
                  'prev': prev,
                  'next': next,
                });
                // Force it to always be true, meaning it shouldn't re-render if they change.
                return true;
              },
              forwardRef: true,
              areStatesEqual: (_, __) => false,
            )(Counter);

            jacket = mount(
              (ReduxProvider()..store = redux_store.store1)(
                (ReduxConnectedCounter()
                  ..ref = localReduxRef
                  ..currentCount = 0
                )('test'),
              ),
            );

            // Because `areStatesEqual` is false, we expect additional method calls
            expect(methodsCalled.map((methodObj) => methodObj['called']),
                mountMethodCalls);
            for (final methodCall in methodsCalled) {
              if (methodCall['called'] == 'areStatePropsEqual') {
                expect(methodCall['prev'], isA<CounterProps>());
                expect(methodCall['next'], isA<CounterProps>());
              }
            }
            methodsCalled.clear();

            var dispatchButton =
                queryByTestId(jacket.mountNode, 'button-increment');
            click(dispatchButton);

            // wait for the next tick for the async dispatch to propagate
            await Future(() {});

            // store.state.count should be 1 but does not re-render due to override in `areStatePropsEqual`
            expect(methodsCalled.map((methodObj) => methodObj['called']),
                updateMethodCalls);
            for (final methodCall in methodsCalled) {
              if (methodCall['called'] == 'areStatePropsEqual') {
                expect(methodCall['prev'], isA<CounterProps>());
                expect(methodCall['next'], isA<CounterProps>());
              }
            }

            expect(jacket.mountNode.innerHtml, contains('Count: 0'));
          });
        });

        group('areMergedPropsEqual', () {
          test('', () {
            final propsReferences = <ConnectFluxCounterProps>[];

            ConnectedCounter =
                connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
              areMergedPropsEqual: expectAsync2((next, prev) {
                expect(next.id, 'test');
                expect(prev.id, 'test2');
                return true;
              }),
              pure: false,
            )(ConnectFluxCounter);

            var whatever = connectOptions.areMergedPropsEqual(
                JsBackedMap.from({'id': 'test'}).jsObject,
                JsBackedMap.from({'id': 'test2'}).jsObject);

            expect(whatever, isTrue);
            propsReferences.forEach(
                (store) => expect(store, isA<ConnectFluxCounterProps>()));
          });
        });
      });

      group('context', () {
        test('correctly renders with multiple contexts/stores', () async {
          var bigCounterContext = createContext();
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) {
              return ConnectFluxCounter()
                ..increment = actions.incrementAction
                ..decrement = actions.decrementAction;
            },
            forwardRef: true,
          )(ConnectFluxCounter);
          var ConnectedBigCounter =
              connectFlux<FluxStore2, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            context: bigCounterContext,
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount((ReduxProvider()..store = store1)(
            (ReduxProvider()
              ..store = store2
              ..context = bigCounterContext
            )(
              Dom.div()(
                ConnectedCounter()('test'),
                (ConnectedBigCounter()..addTestId('big-counter'))(),
              ),
            ),
          ));

          var bigCounter = queryByTestId(jacket.mountNode, 'big-counter');
          var dispatchButton = queryByTestId(bigCounter, 'button-increment');
          click(dispatchButton);

          await Future(() {});

          expect(bigCounter.innerHtml, contains('Count: 100'));
        });

        test('correctly renders when contexts are nested', () async {
          var bigCounterContext = createContext();

          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            forwardRef: true,
          )(ConnectFluxCounter);

          var ConnectedBigCounter =
              connectFlux<FluxStore2, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            context: bigCounterContext,
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount((ReduxProvider()..store = store1)(
            (ReduxProvider()
              ..store = store2
              ..context = bigCounterContext
            )(
              Dom.div()(
                (ConnectedCounter()..addTestId('outside'))('test'),
              ),
              Dom.div()(
                (ConnectedBigCounter()..addTestId('big-counter'))(
                  (ConnectedCounter()..addTestId('small-counter'))(),
                ),
              ),
            ),
          ));

          var bigCounter = queryByTestId(jacket.mountNode, 'big-counter');
          var smallCounter = queryByTestId(jacket.mountNode, 'small-counter');

          var smallDispatchButton =
              queryByTestId(smallCounter, 'button-increment');
          var dispatchButton = queryByTestId(bigCounter, 'button-increment');

          click(dispatchButton);
          click(smallDispatchButton);

          await Future(() {});

          // Big counter updated to 100
          expect(findDomNode(bigCounter).innerHtml, contains('Count: 100'),
              reason: 'Should have a count of 100');

          // Normal counter incremented only 1 at both instances
          expect(
              findDomNode(queryByTestId(jacket.mountNode, 'outside')).innerHtml,
              contains('Count: 1</div>'));
          expect(findDomNode(bigCounter).innerHtml, contains('Count: 1</div>'));
        });
      });
    });

    group('properly handles parameter combinations for', () {
      final testCases = {
        'just mapStateToProps (case1)': {
          'mapStateToProps': testMapStateToProps,
        },
        'just mapStateToPropsWithOwnProps (case2)': {
          'mapStateToPropsWithOwnProps': testMapStateToPropsWithOwnProps,
        },
        'both mapStateToProps and mapActionsToProps (case3)': {
          'mapStateToProps': testMapStateToProps,
          'mapActionsToProps': testMapActionsToProps,
        },
        'just mapActionsToProps (case4)': {
          'mapActionsToProps': testMapActionsToProps,
        },
        'both withOwnProps parameters (case5)': {
          'mapStateToPropsWithOwnProps': testMapStateToPropsWithOwnProps,
          'mapActionsToPropsWithOwnProps': testMapActionsToPropsWithOwnProps,
        },
        'just mapActionsToPropsWithOwnProps (case6)': {
          'mapActionsToPropsWithOwnProps': testMapActionsToPropsWithOwnProps,
        },
        'mapStateToProps and mapActionsToPropsWithOwnProps (case7)': {
          'mapStateToProps': testMapStateToProps,
          'mapActionsToPropsWithOwnProps': testMapActionsToPropsWithOwnProps,
        },
        'mapStateToPropsWithOwnProps and mapActionsToProps (case8)': {
          'mapStateToPropsWithOwnProps': testMapStateToPropsWithOwnProps,
          'mapActionsToProps': testMapActionsToProps,
        },
      };

      testParameterCases(testCases);
    });

    test('prints a warning when state is mutated directly', () async {
      final ConnectedFluxComponent =
          connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
        mapStateToProps: (state) => (ConnectFluxCounter()
          ..mutatedList = state.listYouDefShouldntMutate),
        mapActionsToProps: (actions) => (ConnectFluxCounter()
          ..mutateStoreDirectly = actions.mutateStoreDirectly),
      )(ConnectFluxCounter);

      final jacket = mount((ReduxProvider()..store = store1)(
        (ConnectedFluxComponent()..addTestId('flux-component'))(),
      ));

      final fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
      final fluxButton = queryByTestId(fluxCounter, 'button-increment');

      final logs = await recordConsoleLogsAsync(() async {
        click(fluxButton);
        await Future(() {});
      });

      expect(
          logs.first,
          contains(
              'The instance of the value mapped from store "FluxStore" to prop "ConnectFluxCounterProps.mutatedList" was mutated directly,'));
    }, tags: 'ddc');
  });
}

typedef mapStateToProps = Map Function(FluxStore);
typedef mapActionsToProps = Map Function(FluxActions);
typedef mapStateToPropsWithOwnProps = Map Function(
    FluxStore, ConnectFluxCounterProps);
typedef mapActionsToPropsWithOwnProps = Map Function(
    FluxActions, ConnectFluxCounterProps);

mapStateToProps get testMapStateToProps =>
    (state) => (ConnectFluxCounter()..currentCount = state.count);
mapActionsToProps get testMapActionsToProps =>
    (actions) => (ConnectFluxCounter()..increment = actions.incrementAction);
mapStateToPropsWithOwnProps get testMapStateToPropsWithOwnProps =>
    (state, ownProps) => (ConnectFluxCounter()..currentCount = state.count);
mapActionsToPropsWithOwnProps get testMapActionsToPropsWithOwnProps =>
    (actions, ownProps) =>
        (ConnectFluxCounter()..increment = actions.incrementAction);

void testParameterCases(Map<String, Map> cases) {
  for (final parameterCase in cases.keys) {
    final parameters = cases[parameterCase];
    bool shouldDomUpdate(Map parameters) =>
        (parameters['mapStateToProps'] != null ||
            parameters['mapStateToPropsWithOwnProps'] != null);

    test(parameterCase, () async {
      final ConnectedFluxComponent =
          connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
        mapStateToProps: parameters['mapStateToProps'],
        mapActionsToProps: parameters['mapActionsToProps'],
        mapStateToPropsWithOwnProps: parameters['mapStateToPropsWithOwnProps'],
        mapActionsToPropsWithOwnProps:
            parameters['mapActionsToPropsWithOwnProps'],
      )(ConnectFluxCounter);

      final jacket = mount((ReduxProvider()..store = store1)(
        (ConnectedFluxComponent()..addTestId('flux-component'))(),
      ));

      final fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
      final fluxButton = queryByTestId(fluxCounter, 'button-increment');

      expect(fluxStore.state.count, 0);

      click(fluxButton);
      await Future(() {});

      expect(fluxStore.state.count, 1);

      if (shouldDomUpdate(parameters)) {
        expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
      }

      store1.dispatch(ResetAction());
      await Future(() {});

      expect(fluxStore.state.count, 0);
      if (shouldDomUpdate(parameters)) {
        expect(findDomNode(fluxCounter).innerHtml, contains('Count: 0'));
      }
    });
  }
}
