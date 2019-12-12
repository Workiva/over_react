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
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import './fixtures/counter.dart';
import './fixtures/store.dart';

// ignore_for_file: avoid_types_on_closure_parameters

/// Main entry point for AbstractTransition testing
main() {
  group('connect', () {
    UiFactory<CounterProps> ConnectedCounter;
    TestJacket<CounterComponent> jacket;
    final counterRef = createRef<CounterComponent>();

    JsConnectOptions connectOptions;
    var originalConnect = mockableJsConnect;

    mockableJsConnect = (
        [
          Function mapStateToProps,
          dynamic mapDispatchToProps,
          Function mergeProps,
          JsConnectOptions options,
        ]
      ) {
        connectOptions = options;
        return originalConnect(mapStateToProps, mapDispatchToProps, mergeProps, options);
      };

    setUp(() async {
      ConnectedCounter = null;
      jacket = null;
      // Reset stores state to initalState value.
      store1.dispatch(ResetAction());
      store2.dispatch(ResetAction());

      // wait for state to update
      await Future(() {});
    });

    group('Provider Usage', (){
      test('throws without a provider', () {
        ConnectedCounter = connect<CounterState, CounterProps>()(Counter);

        expect(() => render(ConnectedCounter()('test')), throwsA(anything));
      });

      test('does not throw with a provider', () {
        ConnectedCounter = connect<CounterState, CounterProps>()(Counter);

        expect(() => render(
            (ReduxProvider()..store = store1)(
              ConnectedCounter()('test'),
            ),
          ),
          isNot(throwsA(anything)),
        );
      });
    });

    group('forwardRef', (){
      test('when true: forwards the ref to the wrapped component', () {
        ConnectedCounter = connect<CounterState, CounterProps>(forwardRef: true)(Counter);

        render(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ),
        );
        expect(counterRef.current, isA<CounterComponent>());
      });
    });

    group('mapStateToProps properly maps the state to the components props', (){
      test('on inital load', () {
        ConnectedCounter = connect<CounterState, CounterProps>(mapStateToProps: (state){
          return Counter()..currentCount = state.count;
        }, forwardRef: true)(Counter);

        jacket = mount(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ),
        );

        expect(counterRef.current.props.currentCount, 0);
        expect(jacket.mountNode.innerHtml, contains('Count: 0'));
      });

      test('after dispatch', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(mapStateToProps: (state){
          return Counter()..currentCount = state.count;
        }, forwardRef: true)(Counter);

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

    group('mapStateToPropsWithOwnProps properly maps the state to the components props', (){
      test('on inital load', () {
        ConnectedCounter = connect<CounterState, CounterProps>(mapStateToPropsWithOwnProps: (state, ownProps){
          return Counter()..currentCount = state.count;
        }, forwardRef: true)(Counter);

        jacket = mount(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()..ref = counterRef)('test'),
          ),
        );

        expect(counterRef.current.props.currentCount, 0);
        expect(jacket.mountNode.innerHtml, contains('Count: 0'));
      });

      test('after dispatch', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(mapStateToPropsWithOwnProps: (state, ownProps){
          return Counter()..currentCount = state.count;
        }, forwardRef: true)(Counter);

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

    group('mapDispatchToProps', (){
      test('maps dispatcher to props correctly', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state){
            expect(state, isA<CounterState>());
            return Counter()..currentCount = state.count;
          },
          mapDispatchToProps: (dispatch){
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
        var dispatchButton = queryByTestId(jacket.mountNode, 'button-decrement');
        click(dispatchButton);

        // wait for the next tick for the async dispatch to propagate
        await Future(() {});

        expect(counterRef.current.props.currentCount, -1);
        expect(jacket.mountNode.innerHtml, contains('Count: -1'));
      });
    });

    group('mapDispatchToPropsWithOwnProps', (){
      test('maps dispatcher to props correctly', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state){
            expect(state, isA<CounterState>());
            return Counter()..currentCount = state.count;
          },
          mapDispatchToPropsWithOwnProps: (dispatch, ownProps){
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
        var dispatchButton = queryByTestId(jacket.mountNode, 'button-decrement');
        click(dispatchButton);

        // wait for the next tick for the async dispatch to propagate
        await Future(() {});

        expect(counterRef.current.props.currentCount, -1);
        expect(jacket.mountNode.innerHtml, contains('Count: -1'));
      });
    });

    group('mergeProps', (){
      test('properly merges props based on consumer map', () async {
        ConnectedCounter = connect<CounterState, CounterProps>(
          mapStateToProps: (state){
            return Counter()..currentCount = state.count;
          },
          mapDispatchToProps: (dispatch){
            return Counter()..decrement = () => dispatch(DecrementAction());
          },
          mergeProps: (stateProps, dispatchProps, ownProps) {
            expect(stateProps, isA<CounterProps>());
            expect(dispatchProps, isA<CounterProps>());
            expect(ownProps, isA<CounterProps>());
            return Counter()
                // Return whatever value is passed through ownProps until the state count is over 1
                ..currentCount = stateProps.currentCount < 1 ? ownProps.currentCount : stateProps.currentCount
                ..decrement = ownProps.decrement;
          },
          forwardRef: true,
        )(Counter);

        jacket = mount(
          (ReduxProvider()..store = store1)(
            (ConnectedCounter()
                ..ref = counterRef
                // make `decrement` increment
                ..decrement = () {store1.dispatch(IncrementAction());}
                ..currentCount = 900
            )('test'),
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
            JsBackedMap.from({'id':'test'}).jsObject,
            JsBackedMap.from({'id':'test2'}).jsObject
          );

          expect(whatever, isTrue);
        });
      });

      group('areStatePropsEqual', (){
        test('', () async {
          List<String> methodsCalled = [];
          ConnectedCounter = connect<CounterState, CounterProps>(
            mapStateToProps: (state) {
              methodsCalled.add('mapStateToProps');
              return Counter()..currentCount = state.count;
            },
            areStatePropsEqual: (next, prev) {
              expect(next, isA<CounterProps>());
              expect(prev, isA<CounterProps>());
              methodsCalled.add('areStatePropsEqual');
              // Force it to always be true, meaing it shouldnt re-render if they change.
              return true;
            },
            forwardRef: true,
          )(Counter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef..currentCount = 0)('test'),
            ),
          );
          expect(methodsCalled, ['mapStateToProps']);
          methodsCalled.clear();

          var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          // store.state.count should be 1 but does not re-render due to override in `areStatePropsEqual`

          expect(methodsCalled, ['mapStateToProps', 'areStatePropsEqual']);
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
            JsBackedMap.from({'id':'test'}).jsObject,
            JsBackedMap.from({'id':'test2'}).jsObject
          );

          expect(whatever, isTrue);
        });
      });

      group('areStatesEqual', (){
        test('', () async {
          List<String> methodsCalled = [];
          ConnectedCounter = connect<CounterState, CounterProps>(
            areStatesEqual: (next, prev) {
              expect(next, isA<CounterState>());
              expect(prev, isA<CounterState>());
              methodsCalled.add('areStatesEqual');
              return true;
            },
            mapStateToProps: (state) {
              methodsCalled.add('mapStateToProps');
              return Counter()..currentCount = state.count;
            },
            forwardRef: true,
          )(Counter);

          jacket = mount(
            (ReduxProvider()..store = store1)(
              (ConnectedCounter()..ref = counterRef..currentCount = 0)('test'),
            ),
          );

          expect(methodsCalled, contains('mapStateToProps'));
          expect(methodsCalled, contains('areStatesEqual'));
          methodsCalled.clear();

          var dispatchButton = queryByTestId(jacket.mountNode, 'button-increment');
          click(dispatchButton);

          // wait for the next tick for the async dispatch to propagate
          await Future(() {});

          // only calls `areStatesEqual` and does not call `mapStateToProps` since it returned `true`.
          expect(methodsCalled, isNot(contains('mapStateToProps')));
          expect(methodsCalled, contains('areStatesEqual'));
          expect(jacket.mountNode.innerHtml, contains('Count: 0'));
        });
      });
    });

    group('context', (){
      test('correctly renders with multiple contexts/stores', () async {
        var bigCounterContext = createContext();
        ConnectedCounter = connect<CounterState, CounterProps>(
              mapStateToProps: (state){
                return Counter()..currentCount = state.count;
              },
              forwardRef: true,
            )(Counter);
        var ConnectedBigCounter = connect<BigCounterState, CounterProps>(
              mapStateToProps: (state){
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

        await Future((){});

        expect(bigCounter.innerHtml, contains('Count: 100'));
      });

      test('correctly renderes when contexts are nested', () async {
        var bigCounterContext = createContext();
        ConnectedCounter = connect<CounterState, CounterProps>(
              mapStateToProps: (state){
                return Counter()..currentCount = state.count;
              },
              forwardRef: true,
            )(Counter);
        var ConnectedBigCounter = connect<BigCounterState, CounterProps>(
              mapStateToProps: (state){
                return Counter()..currentCount = state.bigCount;
              },
              context: bigCounterContext,
              forwardRef: true,
            )(Counter);

        jacket = mount(
          (ReduxProvider()..store = store1)(
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
          )
        );

        var bigCounter = queryByTestId(jacket.mountNode, 'big-counter');
        var smallCounter = queryByTestId(jacket.mountNode, 'small-counter');

        var smallDispatchButton = queryByTestId(smallCounter, 'button-increment');
        var dispatchButton = queryByTestId(bigCounter, 'button-increment');

        click(dispatchButton);
        click(smallDispatchButton);

        await Future((){});

        // Big counter updated to 100
        expect(findDomNode(bigCounter).innerHtml, contains('Count: 100'), reason: 'Should have a count of 100');

        // Normal counter incremented only 1 at both instances
        expect(findDomNode(queryByTestId(jacket.mountNode, 'outside')).innerHtml, contains('Count: 1</div>'));
        expect(findDomNode(bigCounter).innerHtml, contains('Count: 1</div>'));
      });
    });
  });
}


