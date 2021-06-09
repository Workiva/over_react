// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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

library abstract_transition_test;

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import 'fixtures/counter.dart';
import 'fixtures/non_component_two_counter.dart';
import 'fixtures/redux_actions.dart';
import 'fixtures/store.dart';

// ignore_for_file: avoid_types_on_closure_parameters

/// Main entry point for AbstractTransition testing
main() {
  group('connect', () {
    UiFactory<CounterProps> ConnectedCounter;
    TestJacket<CounterComponent> jacket;
    final counterRef = createRef<CounterComponent>();
    Store<CounterState> store1;
    Store<BigCounterState> store2;

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

    setUp(() {
      ConnectedCounter = null;
      jacket = null;

      store1 = Store(counterStateReducer, initialState: CounterState());
      store2 = Store(bigCounterStateReducer, initialState: BigCounterState());
    });

    test('throws when mounting a UiComponent', () {
      expect(() => connect<CounterState, NonComponentTwoCounterProps>()(NonComponentTwoCounter), throwsArgumentError);
    });

    test('throws when multiple `mapStateToProps` type args are provided', () {
      expect(() => connect<CounterState, CounterProps>(
          mapStateToProps: (state) => {},
          makeMapStateToProps: (state, ownProps) => (_) => {}
        )(Counter),
        throwsArgumentError
      );
    });

    test('throws when multiple `mapDispatchToProps` type args are provided', () {
      expect(() => connect<CounterState, CounterProps>(
          mapDispatchToProps: (state) => {},
          makeMapDispatchToProps: (state, ownProps) => (_) => {}
        )(Counter),
        throwsArgumentError
      );
    });

    group('Provider Usage', () {
      test('throws without a provider', () {
        ConnectedCounter = connect<CounterState, CounterProps>()(Counter);

        expect(() => render(ConnectedCounter()('test')), throwsA(anything));
      });

      test('does not throw with a provider', () {
        ConnectedCounter = connect<CounterState, CounterProps>()(Counter);

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
            connect<CounterState, CounterProps>(forwardRef: true)(Counter);

        render(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ),
        );
        expect(counterRef.current, isA<CounterComponent>());
      });
    });

    group('mapStateToProps properly maps the state to the components props',
        () {
      test('on initial load', () {
        ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToProps: (state) {
              return Counter()..currentCount = state.count;
            },
            forwardRef: true)(Counter);

        jacket = mount(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ),
        );

        expect(counterRef.current.props.currentCount, 0);
        expect(jacket.mountNode.innerHtml, contains('Count: 0'));
      });

      test('after dispatch', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToProps: (state) {
              return Counter()..currentCount = state.count;
            },
            forwardRef: true)(Counter);

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

      test('without converting the props whatsoever', () {
        // Test functions/Maps to ensure they're not allowInterop'd,
        // test event handlers to ensure they're not otherwise converted
        testFunction() => 'foo';
        const testMap = {'foo': 'bar'};
        testEventHandler(SyntheticMouseEvent e) {}

        ConnectedCounter = connect<CounterState, CounterProps>(mapStateToProps: (state){
          return (Counter()
            ..currentCount = state.count
            ..['functionPropSetInsideHoc'] = testFunction
            ..['mapPropSetInsideHoc'] = testMap
            // We need to set a real event prop key to properly test this
            ..onMouseDown = testEventHandler
          );
        }, forwardRef: true)(Counter);

        jacket = mount(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()
              ..ref = counterRef
              ..['functionPropSetOnHoc'] = testFunction
              ..['mapPropSetOnHoc'] = testMap
              // We need to set a real event prop key to properly test this
              ..onMouseUp = testEventHandler
            )('test'),
          ),
        );

        final actualProps = counterRef.current.props;
        final expectedProps = {
          'functionPropSetInsideHoc': same(testFunction),
          'mapPropSetInsideHoc': same(testMap),
          'onMouseDown': same(testEventHandler),

          'functionPropSetOnHoc': same(testFunction),
          'mapPropSetOnHoc': same(testMap),
          'onMouseUp': same(testEventHandler),
        };
        // Filter out unrelated props that prevent us from using the default Map matcher
        final relevantPropKeys = {...actualProps}
            ..removeWhere((key, value) => !expectedProps.containsKey(key));

        expect(relevantPropKeys, expectedProps,
            reason: 'functions/maps should not be jsified, and event handlers should not be converted');
      });
    });

    group(
        'mapStateToPropsWithOwnProps properly maps the state to the components props',
        () {
      test('on initial load', () {
        ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToPropsWithOwnProps: (state, ownProps) {
              return Counter()..currentCount = state.count;
            },
            forwardRef: true)(Counter);

        jacket = mount(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ),
        );

        expect(counterRef.current.props.currentCount, 0);
        expect(jacket.mountNode.innerHtml, contains('Count: 0'));
      });

      test('after dispatch', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToPropsWithOwnProps: (state, ownProps) {
              return Counter()..currentCount = state.count;
            },
            forwardRef: true)(Counter);

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

    group('makeMapStateToProps', () {
      test('only calls factory on component mount', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
            makeMapStateToProps: expectAsync2((initialState, initialOwnProps) {
              return expectAsync1((state) {
                return Counter()..currentCount = state.count;
              }, count: 2);
            }, count: 1),
          forwardRef: true)(Counter);

        jacket = mount((ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ));

        expect(counterRef.current.props.currentCount, 0);

        var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
        // causes a state change that calls the makeMapStateToProps returned "real" mapStateToProps function.
        click(dispatchButton);

        // wait for the next tick for the async dispatch to propagate
        await Future(() {});

        expect(counterRef.current.props.currentCount, 1);
      });
    });

    group('makeMapStateToPropsWithOwnProps', () {
      test('only calls factory on component mount', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
            makeMapStateToPropsWithOwnProps: expectAsync2((initialState, initialOwnProps) {
              return expectAsync2((state, ownProps) {
                return Counter()..currentCount = state.count;
              }, count: 2);
            }, count: 1),
          forwardRef:true)(Counter);

        jacket = mount((ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ));

        expect(counterRef.current.props.currentCount, 0);

        var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
        // causes a state change that calls the makeMapStateToPropsWithOwnProps returned "real" mapStateToProps function.
        click(dispatchButton);

        // wait for the next tick for the async dispatch to propagate
        await Future(() {});

        expect(counterRef.current.props.currentCount, 1);
      });
    });

    group('makeMapDispatchToProps', () {
      test('only calls factory on initial load', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToProps: (state) => (Counter()..currentCount = state.count),
            makeMapDispatchToProps: expectAsync2((dispatch, initialOwnProps) {
              return expectAsync1((dispatch) {
                return Counter()..decrement = () => dispatch(DecrementAction());
              }, count: 1);
            }, count: 1),
            forwardRef: true)(Counter);

        jacket = mount((ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ));

        expect(counterRef.current.props.currentCount, 0);

        var dispatchButton = queryByTestId(jacket.mountNode, 'button-decrement');
        // causes a state change that calls the makeMapDispatchToProps returned "real" mapDispatchToProps function.
        click(dispatchButton);

        // wait for the next tick for the async dispatch to propagate
        await Future(() {});

        expect(counterRef.current.props.currentCount, -1);
      });
    });

    group('makeMapDispatchToPropsWithOwnProps', () {
      test('only calls factory on initial load', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToProps: (state) => (Counter()..currentCount = state.count),
            makeMapDispatchToPropsWithOwnProps: expectAsync2((dispatch, initialOwnProps) {
              return expectAsync2((dispatch, ownProps) {
                return Counter()..decrement = () => dispatch(DecrementAction());
              }, count: 1);
            }, count: 1),
          forwardRef:true)(Counter);

        jacket = mount((ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ));

        expect(counterRef.current.props.currentCount, 0);

        var dispatchButton = queryByTestId(jacket.mountNode, 'button-decrement');
        // causes a state change that calls the makeMapDispatchToPropsWithOwnProps returned "real" mapDispatchToProps function.
        click(dispatchButton);

        // wait for the next tick for the async dispatch to propagate
        await Future(() {});

        expect(counterRef.current.props.currentCount, -1);
      });
    });

    group('mapDispatchToProps', () {
      test('maps dispatcher to props correctly', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state) => (Counter()..currentCount = state.count),
          mapDispatchToProps: (dispatch) {
            return Counter()..decrement = () => dispatch(DecrementAction());
          },
          forwardRef: true,
        )(Counter);

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
      });
    });

    group('mapDispatchToPropsWithOwnProps', () {
      test('maps dispatcher to props correctly', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state) => (Counter()..currentCount = state.count),
          mapDispatchToPropsWithOwnProps: (dispatch, ownProps) {
            return Counter()..decrement = () => dispatch(DecrementAction());
          },
          forwardRef: true,
        )(Counter);

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
      });
    });

    group('mergeProps', () {
      test('properly merges props based on consumer map', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state) {
            return Counter()..currentCount = state.count;
          },
          mapDispatchToProps: (dispatch) {
            return Counter()..decrement = () => dispatch(DecrementAction());
          },
          mergeProps: (stateProps, dispatchProps, ownProps) {
            return Counter()
              // Return whatever value is passed through ownProps until the state count is over 1
              ..currentCount = stateProps.currentCount < 1
                  ? ownProps.currentCount
                  : stateProps.currentCount
              ..decrement = ownProps.decrement;
          },
          forwardRef: true,
        )(Counter);

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
      });
    });

    group('Options', () {
      group('areOwnPropsEqual', () {
        test('', () {
          ConnectedCounter = connect<CounterState, CounterProps>(
            areOwnPropsEqual: expectAsync2((next, prev) {
              expect(next, isA<CounterProps>());
              expect(prev, isA<CounterProps>());
              expect(next.id, 'test');
              expect(prev.id, 'test2');
              return true;
            }),
          )(Counter);

          var whatever = connectOptions.areOwnPropsEqual(
              JsBackedMap.from({'id': 'test'}).jsObject,
              JsBackedMap.from({'id': 'test2'}).jsObject);

          expect(whatever, isTrue);
        });
      });

      group('areStatePropsEqual', () {
        test('', () async {
          final calls = <Map<String, dynamic>>[];
          ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToProps: (state) {
              calls.add({'name': 'mapStateToProps'});
              return Counter()..currentCount = state.count;
            },
            areStatePropsEqual: (next, prev) {
              calls.add({'name': 'areStatePropsEqual', 'next': next, 'prev': prev});
              // Force it to always be true, meaning it shouldn't re-render if they change.
              return true;
            },
            forwardRef: true,
          )(Counter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()
                ..ref = counterRef
                ..currentCount = 0
              )('test'),
            ),
          );
          expect(calls, [
            {'name': 'mapStateToProps'},
          ]);
          calls.clear();

          var dispatchButton =
              queryByTestId(jacket.mountNode, 'button-increment');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          // store.state.count should be 1 but does not re-render due to override in `areStatePropsEqual`

          expect(calls, [
            {'name': 'mapStateToProps'},
            {
              'name': 'areStatePropsEqual',
              'next': isA<CounterProps>(),
              'prev': isA<CounterProps>(),
            }
          ]);
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));
        });
      });

      group('areMergedPropsEqual', () {
        test('', () {
          ConnectedCounter = connect<CounterState, CounterProps>(
            areMergedPropsEqual: expectAsync2((next, prev) {
              expect(next, isA<CounterProps>());
              expect(prev, isA<CounterProps>());
              expect(next.id, 'test');
              expect(prev.id, 'test2');
              return true;
            }),
            pure: false,
          )(Counter);

          var whatever = connectOptions.areMergedPropsEqual(
              JsBackedMap.from({'id': 'test'}).jsObject,
              JsBackedMap.from({'id': 'test2'}).jsObject);

          expect(whatever, isTrue);
        });
      });

      group('areStatesEqual', () {
        test('', () async {
          final calls = <Map<String, dynamic>>[];
          getCallNames() => calls.map((call) => call['name']).toList();

          ConnectedCounter = connect<CounterState, CounterProps>(
            areStatesEqual: (next, prev) {
              calls.add({
                'name': 'areStatesEqual',
                'prev': prev,
                'next': next,
              });
              return true;
            },
            mapStateToProps: (state) {
              calls.add({'name': 'mapStateToProps'});
              return Counter()..currentCount = state.count;
            },
            forwardRef: true,
          )(Counter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef)('test'),
            ),
          );

          expect(getCallNames(),
              containsAll({'areStatesEqual', 'mapStateToProps'}));
          expect(
              calls.firstWhere((call) => call['name'] == 'areStatesEqual'),
              {
                'name': 'areStatesEqual',
                'prev': isA<CounterState>(),
                'next': isA<CounterState>(),
              },
              reason: 'states should be passed in as arguments');
          calls.clear();

          var dispatchButton =
              queryByTestId(jacket.mountNode, 'button-increment');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          // only calls `areStatesEqual` and does not call `mapStateToProps` since it returned `true`.
          expect(getCallNames(), isNot(contains('mapStateToProps')));
          expect(getCallNames(), contains('areStatesEqual'));
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));
        });

        group('when not specified,', () {
          // This indirectly tests the memoization of wrapInteropValue
          test('does not rerender when the state object is identical', () async {
            List<String> methodsCalled = [];
            ConnectedCounter = connect<CounterState, CounterProps>(
              mapStateToProps: (state) {
                methodsCalled.add('mapStateToProps');
                return Counter()..currentCount = state.count;
              },
              forwardRef: true,
            )(Counter);

            final noopStore = Store<CounterState>((state, action) => state, initialState: CounterState(count: 0));

            jacket = mount(
              (ReduxProvider()..store = noopStore)(
                (ConnectedCounter()..ref = counterRef..currentCount = 0)('test'),
              ),
            );

            expect(methodsCalled, contains('mapStateToProps'));
            methodsCalled.clear();

            final stateBefore = noopStore.state;
            noopStore.dispatch('Dummy action that does not mutate state, but triggers connect');
            // wait for the next tick for the async dispatch to propagate
            await Future(() {});
            final stateAfter = noopStore.state;
            expect(stateAfter, same(stateBefore),
                reason: 'test setup check; store should have the exact same state object');

            expect(methodsCalled, isEmpty,
                reason: 'mapStateToProps should not be called since states are equal according to connect');
          });
        });
      });
    });

    group('context', () {
      test('correctly renders with multiple contexts/stores', () async {
        var bigCounterContext = createContext();
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state) {
            return Counter()..currentCount = state.count;
          },
          forwardRef: true,
        )(Counter);
        var ConnectedBigCounter = connect<BigCounterState, CounterProps>(
          mapStateToProps: (state) {
            return Counter()..currentCount = state.bigCount;
          },
          context: bigCounterContext,
          forwardRef: true,
        )(Counter);

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
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state) {
            return Counter()..currentCount = state.count;
          },
          forwardRef: true,
        )(Counter);
        var ConnectedBigCounter = connect<BigCounterState, CounterProps>(
          mapStateToProps: (state) {
            return Counter()..currentCount = state.bigCount;
          },
          context: bigCounterContext,
          forwardRef: true,
        )(Counter);

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
}
