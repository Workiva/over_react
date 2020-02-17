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
    setUp(() async {
      // Reset stores state to initialState value
      store1.dispatch(ResetAction());
      store2.dispatch(ResetAction());

      // wait for state to update
      await Future(() {});
    });

    group('FluxToReduxAdapterStore', () {
      group('can receive both Flux and Redux updates', () {
        test('with the counter component using the `dispatch` prop', () async {
          final ConnectedFluxComponent = connectFlux<FluxStore,
              FluxActions,
              ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
            (ConnectFluxCounter()
              ..currentCount = state.count),
          )(ConnectFluxCounter);

          final ConnectedReduxComponent = connect<FluxStore, CounterProps>(
            mapStateToProps: (state) =>
            (Counter()
              ..currentCount = state.count),
            pure: false,
          )(Counter);

          final jacket = mount(
              (ReduxProvider()
                ..store = store1)(
                (ConnectedFluxComponent()
                  ..addTestId('flux-component'))(),
                (ConnectedReduxComponent()
                  ..addTestId('redux-component'))(),
              )
          );

          final fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
          final reduxCounter = queryByTestId(
              jacket.mountNode, 'redux-component');

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
            'with the components using `mapDispatchToProps` and `mapActionsToProps`', () async {
          final ConnectedFluxComponent = connectFlux<FluxStore,
              FluxActions,
              ConnectFluxCounterProps>(
            mapStateToProps: (state) =>
            (ConnectFluxCounter()
              ..currentCount = state.count),
            mapActionsToProps: (actions) =>
            (ConnectFluxCounter()
              ..increment = actions.incrementAction
              ..decrement = actions.decrementAction),
          )(ConnectFluxCounter);

          final ConnectedReduxComponent = connect<FluxStore, CounterProps>(
            mapStateToProps: (state) =>
            (Counter()
              ..currentCount = state.count),
            mapDispatchToProps: (dispatch) =>
            (Counter()
              ..increment = () => dispatch(IncrementAction())),
            pure: false,
          )(Counter);

          final jacket = mount(
              (ReduxProvider()
                ..store = store1)(
                (ConnectedFluxComponent()
                  ..addTestId('flux-component'))(),
                (ConnectedReduxComponent()
                  ..addTestId('redux-component'))(),
              )
          );

          final fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
          final reduxCounter = queryByTestId(
              jacket.mountNode, 'redux-component');

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
        final ConnectedFluxComponent = connectFlux<FluxStore,
            FluxActions,
            ConnectFluxCounterProps>(
          mapStateToProps: (state) =>
          (ConnectFluxCounter()
            ..currentCount = state.count),
          mapActionsToProps: (actions) =>
          (ConnectFluxCounter()
            ..increment = actions.incrementAction
            ..decrement = actions.decrementAction),
        )(ConnectFluxCounter);

        final ConnectedReduxComponent = connect<FluxStore, CounterProps>(
          mapStateToProps: (state) =>
          (Counter()
            ..currentCount = state.count),
          mapDispatchToProps: (dispatch) =>
          (Counter()
            ..increment = () => dispatch(IncrementAction())),
        )(Counter);

        final jacket = mount(
            (ReduxProvider()
              ..store = store1)(
              (ConnectedFluxComponent()
                ..addTestId('flux-component'))(),
              (ConnectedReduxComponent()
                ..addTestId('redux-component'))(),
            )
        );

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
        final tempAdapterStore = FluxToReduxAdapterStore(tempFluxStore, tempActions);
        final tempAdapterStore2 = FluxToReduxAdapterStore(tempFluxStore2, tempActions);

        expect(actionsForStore[tempFluxStore], tempActions);
        expect(actionsForStore[tempFluxStore2], tempActions);
        expect(actionsForStore[tempFluxStore2], actionsForStore[tempFluxStore]);
      });
    });
    
    group('ConnectableFluxStore', () {
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

      Future<Duration> waitForUpdate() async {
        return Future.delayed(Duration(seconds: 1));
      }

      setUp(() {
        ConnectedFluxComponent = connectFlux<TestConnectableFluxStore,
            FluxActions,
            ConnectFluxCounterProps>(
          mapStateToProps: (state) =>
              (ConnectFluxCounter()
                ..currentCount = state.count),
          mapActionsToProps: (actions) =>
              (ConnectFluxCounter()
                ..increment = actions.incrementAction
                ..decrement = actions.decrementAction),
        )(ConnectFluxCounter);

        ConnectedReduxComponent = connect<TestConnectableFluxStore, CounterProps>(
          mapStateToProps: (state) =>
              (Counter()
                ..currentCount = state.count),
          mapDispatchToProps: (dispatch) =>
              (Counter()
                ..increment = () => dispatch(IncrementAction())),
          pure: false,
        )(Counter);

        jacket = mount(
            (ReduxProvider()
              ..store = connectableFluxAdaptedStore)(
              (ConnectedFluxComponent()
                ..addTestId('connect-flux-component'))(),
              (ConnectedReduxComponent()
                ..addTestId('redux-component'))(),
              (FluxCounter()
                ..store = connectableFluxStore
                ..actions = connectableStoreActions
                ..addTestId('flux-component')
              )(),
            )
        );

        connectFluxCounter = queryByTestId(jacket.mountNode, 'connect-flux-component');
        reduxCounter = queryByTestId(jacket.mountNode, 'redux-component');
        fluxCounter = queryByTestId(jacket.mountNode, 'flux-component');
        containerList = [connectFluxCounter, fluxCounter, reduxCounter];

        verifyCount(containerList, 0);
      });

      tearDown(() {
        connectableStoreActions.resetAction();
        connectableFluxStore.trigger();
      });

      test('will keep Flux, Redux, and connectFlux components all in sync', () async {
        final fluxButton = queryByTestId(fluxCounter, 'button-increment');

        click(fluxButton);
        await waitForUpdate();

        verifyCount(containerList, 1);
      });

      test('can be updated by connectFlux or Flux', () async {
        final fluxButton = queryByTestId(fluxCounter, 'button-increment');
        final connectFluxButton = queryByTestId(connectFluxCounter, 'button-increment');

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
  });
}
