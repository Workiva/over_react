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

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import 'fixtures/connect_flux_counter.dart';
import 'fixtures/connect_flux_store.dart';
import 'fixtures/counter.dart';
import 'fixtures/redux_actions.dart';
import 'fixtures/flux_counter.dart';

main() {
  group('connectFlux integration -', () {
    FluxActions fluxActions;
    FluxStore fluxStore;
    FluxToReduxAdapterStore store1;

    FluxActions connectableStoreActions;
    TestConnectableFluxStore connectableFluxStore;
    TestConnectableFluxStore anotherConnectableFluxStore;
    ConnectFluxAdapterStore connectableFluxAdaptedStore;

    setUp(() {
      fluxActions = FluxActions();
      fluxStore = FluxStore(fluxActions);
      store1 = FluxToReduxAdapterStore(fluxStore, fluxActions);

      connectableStoreActions = FluxActions();
      connectableFluxStore = TestConnectableFluxStore(connectableStoreActions);
      anotherConnectableFluxStore =
          TestConnectableFluxStore(connectableStoreActions);
      connectableFluxAdaptedStore =
          ConnectFluxAdapterStore(connectableFluxStore, connectableStoreActions);
    });

    group('FluxToReduxAdapterStore', () {
      group('can receive both Flux and Redux updates', () {
        test('with the counter component using the `dispatch` prop', () async {
          final ConnectedFluxComponent =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) =>
                (ConnectFluxCounter()..actions = actions),
          )(ConnectFluxCounter);

          final ConnectedReduxComponent = connect<FluxStore, CounterProps>(
            mapStateToProps: (state) => (Counter()..currentCount = state.count),
          )(Counter);

          final jacket = mount((ReduxProvider()..store = store1)(
            (ConnectedFluxComponent()..addTestId('flux-component'))(),
            (ConnectedReduxComponent()..addTestId('redux-component'))(),
          ));

          final fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
          final reduxCounter =
              queryByTestId(jacket.mountNode, 'redux-component');

          final fluxButton = queryByTestId(fluxCounter, 'button-increment');
          final reduxButton = queryByTestId(reduxCounter, 'button-increment');

          click(fluxButton);
          await Future(() {});

          expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
          expect(findDomNode(reduxCounter).innerHtml, contains('Count: 1'));

          store1.dispatch(ResetAction());
          await Future(() {});

          expect(findDomNode(fluxCounter).innerHtml, contains('Count: 0'));
          expect(findDomNode(reduxCounter).innerHtml, contains('Count: 0'));

          click(reduxButton);
          await Future(() {});

          expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
          expect(findDomNode(reduxCounter).innerHtml, contains('Count: 1'));
        });

        test(
            'with the components using `mapDispatchToProps` and `mapActionsToProps`',
            () async {
          final ConnectedFluxComponent =
              connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
                (ConnectFluxCounter()..currentCount = state.count),
            mapActionsToProps: (actions) => (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
          )(ConnectFluxCounter);

          final ConnectedReduxComponent = connect<FluxStore, CounterProps>(
            mapStateToProps: (state) => (Counter()..currentCount = state.count),
            mapDispatchToProps: (dispatch) =>
                (Counter()..increment = () => dispatch(IncrementAction())),
          )(Counter);

          final jacket = mount((ReduxProvider()..store = store1)(
            (ConnectedFluxComponent()..addTestId('flux-component'))(),
            (ConnectedReduxComponent()..addTestId('redux-component'))(),
          ));

          final fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
          final reduxCounter =
              queryByTestId(jacket.mountNode, 'redux-component');

          final fluxButton = queryByTestId(fluxCounter, 'button-increment');
          final reduxButton = queryByTestId(reduxCounter, 'button-increment');

          click(fluxButton);
          await Future(() {});

          expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
          expect(findDomNode(reduxCounter).innerHtml, contains('Count: 1'));

          store1.dispatch(ResetAction());
          await Future(() {});

          expect(findDomNode(fluxCounter).innerHtml, contains('Count: 0'));
          expect(findDomNode(reduxCounter).innerHtml, contains('Count: 0'));

          click(reduxButton);
          await Future(() {});

          expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
          expect(findDomNode(reduxCounter).innerHtml, contains('Count: 1'));
        });
      });

      test('will not update Redux unless the component is impure', () async {
        final ConnectedFluxComponent =
            connectFlux<FluxStore, FluxActions, ConnectFluxCounterProps>(
          mapStateToProps: (state) =>
              (ConnectFluxCounter()..currentCount = state.count),
          mapActionsToProps: (actions) => (ConnectFluxCounter()
            ..increment = actions.incrementAction
            ..decrement = actions.decrementAction),
        )(ConnectFluxCounter);

        final ConnectedReduxComponent = connect<FluxStore, CounterProps>(
          mapStateToProps: (state) => (Counter()..currentCount = state.count),
          mapDispatchToProps: (dispatch) =>
              (Counter()..increment = () => dispatch(IncrementAction())),
        )(Counter);

        final jacket = mount((ReduxProvider()..store = store1)(
          (ConnectedFluxComponent()..addTestId('flux-component'))(),
          (ConnectedReduxComponent()..addTestId('redux-component'))(),
        ));

        final fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
        final reduxCounter = queryByTestId(jacket.mountNode, 'redux-component');

        final fluxButton = queryByTestId(fluxCounter, 'button-increment');
        final reduxButton = queryByTestId(reduxCounter, 'button-increment');

        click(fluxButton);
        await Future(() {});

        expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
        expect(findDomNode(reduxCounter).innerHtml, contains('Count: 0'));

        store1.dispatch(ResetAction());
        await Future(() {});

        expect(findDomNode(fluxCounter).innerHtml, contains('Count: 0'));
        expect(findDomNode(reduxCounter).innerHtml, contains('Count: 0'));

        click(reduxButton);
        await Future(() {});

        expect(findDomNode(fluxCounter).innerHtml, contains('Count: 1'));
        expect(findDomNode(reduxCounter).innerHtml, contains('Count: 0'));
      });

      test('properly maps store instances to actions', () {
        FluxActions tempActions = FluxActions();
        final tempFluxStore = FluxStore(tempActions);
        final tempFluxStore2 = FluxStore(tempActions);

        // Unused, but required to set up the actions
        // ignore: unused_local_variable
        final tempAdapterStore =
            FluxToReduxAdapterStore(tempFluxStore, tempActions);
        // ignore: unused_local_variable
        final tempAdapterStore2 =
            FluxToReduxAdapterStore(tempFluxStore2, tempActions);

        expect(actionsForStore[tempFluxStore], tempActions);
        expect(actionsForStore[tempFluxStore2], tempActions);
        expect(actionsForStore[tempFluxStore2], actionsForStore[tempFluxStore]);
      });
    });

    group('ConnectFluxAdapterStore', () {
      UiFactory<ConnectFluxCounterProps> ConnectedFluxComponent;
      UiFactory<CounterProps> ConnectedReduxComponent;
      TestJacket jacket;
      Element connectFluxCounter;
      Element reduxCounter;
      Element fluxCounter;
      List<Element> containerList;

      void verifyCount(List<Element> containers, int count) {
        for (final container in containers) {
          expect(findDomNode(container).innerHtml, contains('Count: $count'));
        }
      }

      Future waitForUpdate() async {
        await window.animationFrame;
        await window.animationFrame;
        await window.animationFrame;
        return Future(() {});
      }

      setUp(() {
        ConnectedFluxComponent = connectFlux<TestConnectableFluxStore,
            FluxActions, ConnectFluxCounterProps>(
          mapStateToProps: (state) =>
              (ConnectFluxCounter()..currentCount = state.count),
          mapActionsToProps: (actions) => (ConnectFluxCounter()
            ..increment = actions.incrementAction
            ..decrement = actions.decrementAction),
        )(ConnectFluxCounter);

        ConnectedReduxComponent =
            connect<TestConnectableFluxStore, CounterProps>(
          mapStateToProps: (state) => (Counter()..currentCount = state.count),
          mapDispatchToProps: (dispatch) =>
              (Counter()..increment = () => dispatch(IncrementAction())),
        )(Counter);

        jacket = mount((ReduxProvider()..store = connectableFluxAdaptedStore)(
          (ConnectedFluxComponent()..addTestId('connect-flux-component'))(),
          (ConnectedReduxComponent()..addTestId('redux-component'))(),
          (FluxCounter()
            ..store = connectableFluxStore
            ..actions = connectableStoreActions
            ..addTestId('flux-component')
          )(),
        ));

        connectFluxCounter =
            queryByTestId(jacket.mountNode, 'connect-flux-component');
        reduxCounter = queryByTestId(jacket.mountNode, 'redux-component');
        fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
        containerList = [connectFluxCounter, fluxCounter, reduxCounter];

        verifyCount(containerList, 0);
      });

      test('will keep Flux, Redux, and connectFlux components all in sync',
          () async {
        final fluxButton = queryByTestId(fluxCounter, 'button-increment');

        click(fluxButton);
        await waitForUpdate();

        verifyCount(containerList, 1);
      });

      test('can be updated by connectFlux or Flux', () async {
        final fluxButton = queryByTestId(fluxCounter, 'button-increment');
        final connectFluxButton =
            queryByTestId(connectFluxCounter, 'button-increment');

        click(fluxButton);
        await waitForUpdate();

        verifyCount(containerList, 1);

        click(connectFluxButton);
        await waitForUpdate();

        verifyCount(containerList, 2);
      });

      test('cannot be updated by a Redux component', () async {
        final fluxButton = queryByTestId(fluxCounter, 'button-increment');
        final reduxButton = queryByTestId(reduxCounter, 'button-increment');

        click(reduxButton);

        verifyCount(containerList, 0);

        click(fluxButton);
        await waitForUpdate();

        verifyCount(containerList, 1);

        click(reduxButton);
        await waitForUpdate();

        verifyCount(containerList, 1);
      });
    });

    group('extension methods', () {
      group('asReduxStore', () {
        test('returns a FluxToReduxAdapterStore', () {
          final store = fluxStore.asReduxStore(fluxActions);
          expect(store, isA<FluxToReduxAdapterStore>());
        });

        test('is idempotent', () {
          final aTmpStore = fluxStore.asReduxStore(fluxActions);
          final aSecondTmpStore = fluxStore.asReduxStore(fluxActions);
          final aDifferentTempStore =
              anotherFluxStore.asReduxStore(fluxActions);

          expect(identical(aTmpStore, aSecondTmpStore), isTrue);
          expect(identical(aTmpStore, aDifferentTempStore), isFalse);
        });
      });

      group('asConnectFluxStore', () {
        test('returns a ConnectFluxAdapterStore', () {
          final store = connectableFluxStore.asConnectFluxStore(fluxActions);
          expect(store, isA<ConnectFluxAdapterStore>());
        });

        test('prevents the use with a store that uses InfluxStoreMixin', () {
          expect(() => fluxStore.asConnectFluxStore(fluxActions),
              throwsArgumentError);
        });

        test('is idempotent', () {
          final aTmpStore =
              connectableFluxStore.asConnectFluxStore(fluxActions);
          final aSecondTmpStore =
              connectableFluxStore.asConnectFluxStore(fluxActions);
          final aDifferentTempStore =
              anotherConnectableFluxStore.asConnectFluxStore(fluxActions);

          expect(identical(aTmpStore, aSecondTmpStore), isTrue);
          expect(identical(aSecondTmpStore, aDifferentTempStore), isFalse);
        });
      });
    });
  });
}
