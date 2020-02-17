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
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import 'fixtures/connect_flux_counter.dart';
import 'fixtures/connect_flux_store.dart';
import 'fixtures/redux_actions.dart';

main() {
  Context context1;
  Context context2;
  Context context3;

  setUp(() {
    store1.dispatch(ResetAction());
    store2.dispatch(ResetAction());
    store3.dispatch(ResetAction());

    context1 = createContext();
    context2 = createContext();
    context3 = createContext();
  });

  group('ReduxMultiProvider', () {
    test('creates a provider for every store', () async {
      final Context1ConnectedFluxComponent =
          connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
        mapStateToProps: (state) =>
            (ConnectFluxCounter()..currentCount = state.count),
        mapActionsToProps: (actions) =>
            (ConnectFluxCounter()..increment = actions.incrementAction),
        context: context1,
      )(ConnectFluxCounter);

      final Context2ConnectedFluxComponent =
          connectFlux<FluxStore2, FluxActions, ConnectFluxCounterProps>(
        mapStateToProps: (state) =>
            (ConnectFluxCounter()..currentCount = state.count),
        mapActionsToProps: (actions) =>
            (ConnectFluxCounter()..increment = actions.incrementAction),
        context: context2,
      )(ConnectFluxCounter);

      final Context3ConnectedFluxComponent =
          connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
        mapStateToProps: (state) =>
            (ConnectFluxCounter()..currentCount = state.count),
        mapActionsToProps: (actions) =>
            (ConnectFluxCounter()..increment = actions.incrementAction),
        context: context3,
      )(ConnectFluxCounter);

      final jacket = mount(
          Dom.div()(
            (ReduxMultiProvider()
              ..storesByContext = {
                context1: store1,
                context2: store2,
                context3: store3,
              }
            )(
              (Context1ConnectedFluxComponent()..addTestId('context1'))(),
              (Context2ConnectedFluxComponent()..addTestId('context2'))(),
              (Context3ConnectedFluxComponent()..addTestId('context3'))(),
            ),
          ),
          attachedToDocument: true);

      final context1Counter = queryByTestId(jacket.mountNode, 'context1');
      final context2Counter = queryByTestId(jacket.mountNode, 'context2');
      final context3Counter = queryByTestId(jacket.mountNode, 'context3');

      final context1Button = queryByTestId(context1Counter, 'button-increment');
      final context2Button = queryByTestId(context2Counter, 'button-increment');
      final context3Button = queryByTestId(context3Counter, 'button-increment');

      click(context1Button);

      click(context2Button);
      click(context2Button);

      click(context3Button);
      click(context3Button);
      click(context3Button);
      await Future(() {});

      expect(findDomNode(context1Counter).innerHtml, contains('Count: 1'));
      expect(findDomNode(context2Counter).innerHtml, contains('Count: 200'),
          reason:
              'Two clicks each incrementing 100 (since it is the "big counter").');
      expect(findDomNode(context3Counter).innerHtml, contains('Count: 3'));
    });
  });
}

class ReduxState {
  final String field;

  ReduxState(this.field);
}

ReduxState reducer(ReduxState oldState, dynamic action) =>
    ReduxState(action.field ?? oldState.field);
