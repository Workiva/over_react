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
import 'package:redux/redux.dart' as redux;
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import 'fixtures/connect_flux_counter.dart';
import 'fixtures/connect_flux_store.dart';
import 'fixtures/counter.dart';
import 'fixtures/non_component_two_counter.dart';
import 'fixtures/redux_actions.dart';
import 'fixtures/store.dart' as redux_store;

// ignore_for_file: avoid_types_on_closure_parameters

main() {
  group('connectFlux', () {
    UiFactory<ConnectFluxCounterProps> ConnectedCounter;
    TestJacket<ConnectFluxCounterComponent> jacket;
    final counterRef = createRef<ConnectFluxCounterComponent>();

    FluxActions fluxActions;
    FluxStore fluxStore;
    FluxToReduxAdapterStore store1;

    FluxActions bigFluxActions;
    FluxStore2 bigFluxCounter;
    FluxToReduxAdapterStore store2;

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
        return originalConnect(mapStateToProps, mapDispatchToProps, mergeProps, options);
      };
    });

    tearDownAll(() {
      mockableJsConnect = originalConnect;
    });

    setUp(() {
      ConnectedCounter = null;
      jacket = null;

      fluxActions = FluxActions();
      fluxStore = FluxStore(fluxActions);
      store1 = FluxToReduxAdapterStore(fluxStore, fluxActions);

      bigFluxActions = FluxActions();
      bigFluxCounter = FluxStore2(bigFluxActions);
      store2 = FluxToReduxAdapterStore(bigFluxCounter, bigFluxActions);
    });

    group('behaves like redux with', () {
      test('errors when wrapping a UiComponent', () {
        expect(
            () => connectFlux<FluxStore, FluxActions, NonComponentTwoCounterProps>()(
                NonComponentTwoCounter),
            throwsArgumentError);
      });

      group('Provider Usage', () {
        test('throws without a provider', () {
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
          )(ConnectFluxCounter);

          expect(() => render(ConnectedCounter()('test')), throwsA(anything));
        });

        test('does not throw with a provider', () {
          ConnectedCounter =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>()(ConnectFluxCounter);

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
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
              forwardRef: true)(ConnectFluxCounter);

          render(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );
          expect(counterRef.current, isA<ConnectFluxCounterComponent>());
        });
      });

      group('mapStateToProps properly maps the state to the components props', () {
        test('on inital load', () {
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
              mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
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
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
              mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
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

          var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          expect(counterRef.current.props.currentCount, 1);
          expect(jacket.mountNode.innerHtml, contains('Count: 1'));
        });
      });

      group('mapStateToPropsWithOwnProps properly maps the state to the components props', () {
        test('on inital load', () {
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
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
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
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

          var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
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

          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
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
          var dispatchButton = queryByTestId(jacket.mountNode, 'button-decrement');
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
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
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
          var dispatchButton = queryByTestId(jacket.mountNode, 'button-decrement');
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
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) {
              return ConnectFluxCounter()..decrement = actions.decrementAction;
            },
            mergeProps: (stateProps, dispatchProps, ownProps) {
              propsReferences.addAll([stateProps, dispatchProps, ownProps]);
              return ConnectFluxCounter()
                // Return whatever value is passed through ownProps until the state count is over 1
                ..currentCount =
                    stateProps.currentCount < 1 ? ownProps.currentCount : stateProps.currentCount
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
                ..currentCount = 900)('test'),
            ),
          );
          // `button-decrement` will be incrementing now
          var dispatchButton = queryByTestId(jacket.mountNode, 'button-decrement');

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
          propsReferences.forEach((store) => expect(store, isA<ConnectFluxCounterProps>()));
        });
      });

      group('Options', () {
        group('areOwnPropsEqual', () {
          test('', () {
            final propsReferences = <ConnectFluxCounterProps>[];
            ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
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
            propsReferences.forEach((store) => expect(store, isA<ConnectFluxCounterProps>()));
          });
        });

        group('areStatePropsEqual', () {
          List<Map<String, dynamic>> methodsCalled;
          const expectedMountMethodCalls = [
            'mapStateToProps',
            'mapStateToProps',
            'areStatePropsEqual',
          ];

          const expectedUpdateMethodCalls = [
            'mapStateToProps',
            'areStatePropsEqual',
          ];

          setUp(() {
            methodsCalled = [];
          });

          test('', () async {
            ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
              mapStateToProps: (state) {
                methodsCalled.add({'called': 'mapStateToProps', 'state': state});
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
                (ConnectedCounter()..ref = counterRef)('test'),
              ),
            );

            // Because `areStatesEqual` is false, we expect additional method calls
            expect(
                methodsCalled,
                expectedMountMethodCalls
                    .map((expected) => containsPair('called', expected))
                    .toList());
            for (final methodCall in methodsCalled) {
              if (methodCall['called'] == 'areStatePropsEqual') {
                expect(methodCall['prev'], isA<ConnectFluxCounterProps>());
                expect(methodCall['next'], isA<ConnectFluxCounterProps>());
              }
            }

            methodsCalled.clear();

            var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
            click(dispatchButton);

            // wait for the next tick for the async dispatch to propagate
            await Future(() {});

            // store.state.count should be 1 but does not re-render due to override in `areStatePropsEqual`
            expect(
                methodsCalled,
                expectedUpdateMethodCalls
                    .map((expected) => containsPair('called', expected))
                    .toList());
            for (final methodCall in methodsCalled) {
              if (methodCall['called'] == 'areStatePropsEqual') {
                expect(methodCall['prev'], isA<ConnectFluxCounterProps>());
                expect(methodCall['next'], isA<ConnectFluxCounterProps>());
              }
            }

            expect(jacket.mountNode.innerHtml, contains('Count: 0'));
          });

          test('matches a Redux component with impure state when `areStatesEqual` is false',
              () async {
            final localReduxRef = createRef<CounterComponent>();

            final ReduxConnectedCounter = connect<redux_store.ImpureCounterState, CounterProps>(
              mapStateToProps: (state) {
                methodsCalled.add({
                  'called': 'mapStateToProps',
                  'state': state,
                });
                return Counter()..currentCount = state.count;
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

            // In this setup with an idiomatic redux store, we'd expect double the updates when the state is updated
            // since we're dealing with a new state object instance every time.
            //
            // However, in Flux, it's the same, identical state object (the Flux store) every time
            // which allows react-redux's memoization to skip the extra calls after the component renders.
            //
            // Simulate this by using an Redux store that has the same impurity as Flux stores.
            final impureReduxStore = redux.Store(redux_store.impureCounterStateReducer,
                initialState: redux_store.ImpureCounterState());

            jacket = mount(
              (ReduxProvider()..store = impureReduxStore)(
                (ReduxConnectedCounter()..ref = localReduxRef)('test'),
              ),
            );

            // Because `areStatesEqual` is false, we expect additional method calls
            expect(
                methodsCalled,
                expectedMountMethodCalls
                    .map((expected) => containsPair('called', expected))
                    .toList());
            for (final methodCall in methodsCalled) {
              if (methodCall['called'] == 'areStatePropsEqual') {
                expect(methodCall['prev'], isA<CounterProps>());
                expect(methodCall['next'], isA<CounterProps>());
              }
            }
            methodsCalled.clear();

            var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
            click(dispatchButton);

            // wait for the next tick for the async dispatch to propagate
            await Future(() {});

            // store.state.count should be 1 but does not re-render due to override in `areStatePropsEqual`
            expect(
                methodsCalled,
                expectedUpdateMethodCalls
                    .map((expected) => containsPair('called', expected))
                    .toList(),
                reason: 'connect\'s sequence of calls should match expectedUpdateMethodCalls');

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

            ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
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
            propsReferences.forEach((store) => expect(store, isA<ConnectFluxCounterProps>()));
          });
        });
      });

      group('context', () {
        test('correctly renders with multiple contexts/stores', () async {
          var bigCounterContext = createContext();
          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) {
              return ConnectFluxCounter()
                ..increment = actions.incrementAction
                ..decrement = actions.decrementAction;
            },
            forwardRef: true,
          )(ConnectFluxCounter);
          var ConnectedBigCounter = connectFlux<FluxStore2, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            context: bigCounterContext,
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount((ReduxProvider()..store = store1)(
            (ReduxProvider()
              ..store = store2
              ..context = bigCounterContext)(
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

          ConnectedCounter = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            forwardRef: true,
          )(ConnectFluxCounter);

          var ConnectedBigCounter = connectFlux<FluxStore2, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) => (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
            context: bigCounterContext,
            forwardRef: true,
          )(ConnectFluxCounter);

          jacket = mount((ReduxProvider()..store = store1)(
            (ReduxProvider()
              ..store = store2
              ..context = bigCounterContext)(
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

          var smallDispatchButton = queryByTestId(smallCounter, 'button-increment');
          var dispatchButton = queryByTestId(bigCounter, 'button-increment');

          click(dispatchButton);
          click(smallDispatchButton);

          await Future(() {});

          // Big counter updated to 100
          expect(findDomNode(bigCounter).innerHtml, contains('Count: 100'),
              reason: 'Should have a count of 100');

          // Normal counter incremented only 1 at both instances
          expect(findDomNode(queryByTestId(jacket.mountNode, 'outside')).innerHtml,
              contains('Count: 1</div>'));
          expect(findDomNode(bigCounter).innerHtml, contains('Count: 1</div>'));
        });
      });
    });

    group('properly handles parameter combinations for', () {
      final testCases = [
        ParameterTestCase(
          'just mapStateToProps (case1)',
          mapStateToProps: testMapStateToProps,
        ),
        ParameterTestCase(
          'just mapStateToPropsWithOwnProps (case2)',
          mapStateToPropsWithOwnProps: testMapStateToPropsWithOwnProps,
        ),
        ParameterTestCase(
          'both mapStateToProps and mapActionsToProps (case3)',
          mapStateToProps: testMapStateToProps,
          mapActionsToProps: testMapActionsToProps,
        ),
        ParameterTestCase(
          'just mapActionsToProps (case4)',
          mapActionsToProps: testMapActionsToProps,
        ),
        ParameterTestCase(
          'both withOwnProps parameters (case5)',
          mapStateToPropsWithOwnProps: testMapStateToPropsWithOwnProps,
          mapActionsToPropsWithOwnProps: testMapActionsToPropsWithOwnProps,
        ),
        ParameterTestCase(
          'just mapActionsToPropsWithOwnProps (case6)',
          mapActionsToPropsWithOwnProps: testMapActionsToPropsWithOwnProps,
        ),
        ParameterTestCase(
          'mapStateToProps and mapActionsToPropsWithOwnProps (case7)',
          mapStateToProps: testMapStateToProps,
          mapActionsToPropsWithOwnProps: testMapActionsToPropsWithOwnProps,
        ),
        ParameterTestCase(
          'mapStateToPropsWithOwnProps and mapActionsToProps (case8)',
          mapStateToPropsWithOwnProps: testMapStateToPropsWithOwnProps,
          mapActionsToProps: testMapActionsToProps,
        ),
      ];

      for (final parameterCase in testCases) {
        bool shouldDomUpdate() => parameterCase.mapStateToProps != null ||
            parameterCase.mapStateToPropsWithOwnProps != null;

        test(parameterCase.name, () async {
          final ConnectedFluxComponent =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: parameterCase.mapStateToProps,
            mapActionsToProps: parameterCase.mapActionsToProps,
            mapStateToPropsWithOwnProps: parameterCase.mapStateToPropsWithOwnProps,
            mapActionsToPropsWithOwnProps: parameterCase.mapActionsToPropsWithOwnProps,
          )(ConnectFluxCounter);

          final jacket2 = mount((ReduxProvider()..store = store1)(
            (ConnectedFluxComponent()
              ..actions = fluxActions
              ..addTestId('flux-component'))(),
          ));

          final fluxCounter = queryByTestId(jacket2.mountNode, 'flux-component');
          final fluxButton = queryByTestId(fluxCounter, 'button-increment');

          expect(fluxStore.state.count, 0);

          click(fluxButton);
          await Future(() {});

          expect(fluxStore.state.count, 1);

          if (shouldDomUpdate()) {
            expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
          }

          store1.dispatch(ResetAction());
          await Future(() {});

          expect(fluxStore.state.count, 0);
          if (shouldDomUpdate()) {
            expect(findDomNode(fluxCounter).innerHtml, contains('Count: 0'));
          }
        });
      }
    });

    test('prints a warning when state is mutated directly', () async {
      final ConnectedFluxComponent = connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
        mapStateToProps: (state) =>
            (ConnectFluxCounter()..mutatedList = state.listYouDefShouldntMutate),
        mapActionsToProps: (actions) =>
            (ConnectFluxCounter()..mutateStoreDirectly = actions.mutateStoreDirectly),
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

      logs.removeWhere((log) => log.contains('Cannot find native JavaScript type'));
      expect(
          logs.first,
          contains(
              'The instance of the value mapped from store "FluxStore" to prop "ConnectFluxCounterProps.mutatedList" was mutated directly,'));
    }, tags: 'ddc');
  });
}

typedef MapStateToPropsCallback = Map Function(FluxStore);
typedef MapActionsToPropsCallback = Map Function(FluxActions);
typedef MapStateToPropsWithOwnPropsCallback = Map Function(FluxStore, ConnectFluxCounterProps);
typedef MapActionsToPropsWithOwnPropsCallback = Map Function(FluxActions, ConnectFluxCounterProps);

MapStateToPropsCallback get testMapStateToProps =>
    (state) => (ConnectFluxCounter()..currentCount = state.count);
MapActionsToPropsCallback get testMapActionsToProps =>
    (actions) => (ConnectFluxCounter()..increment = actions.incrementAction);
MapStateToPropsWithOwnPropsCallback get testMapStateToPropsWithOwnProps =>
    (state, ownProps) => (ConnectFluxCounter()..currentCount = state.count);
MapActionsToPropsWithOwnPropsCallback get testMapActionsToPropsWithOwnProps =>
    (actions, ownProps) => (ConnectFluxCounter()..increment = actions.incrementAction);

class ParameterTestCase {
  final String name;

  final MapStateToPropsCallback mapStateToProps;
  final MapActionsToPropsCallback mapActionsToProps;
  final MapStateToPropsWithOwnPropsCallback mapStateToPropsWithOwnProps;
  final MapActionsToPropsWithOwnPropsCallback mapActionsToPropsWithOwnProps;

  ParameterTestCase(this.name, {
    this.mapStateToProps,
    this.mapActionsToProps,
    this.mapStateToPropsWithOwnProps,
    this.mapActionsToPropsWithOwnProps,
  });
}
