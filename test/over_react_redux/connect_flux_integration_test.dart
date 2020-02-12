import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:test/test.dart';

import '../test_util/test_util.dart';
import './fixtures/connect_flux_counter.dart';
import './fixtures/connect_flux_store.dart';
import './fixtures/counter.dart';
import './fixtures/redux_actions.dart';

main() {
  group('connectFlux integration -', () {
    setUp(() async {
      // Reset stores state to initialState value
      store1.dispatch(ResetAction());
      store2.dispatch(ResetAction());

      // wait for state to update
      await Future(() {});
    });

    group('FluxToReduxAdapter Store', () {
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
    });
  });
}
