import 'package:over_react/src/over_react_redux/over_react_flux.dart';
import 'package:w_flux/w_flux.dart';

class CounterActions {
  final Action<Null> smallIncrement = new Action();
  final Action<Null> smallDecrement = new Action();
  final Action<Null> bigIncrement = new Action();
  final Action<Null> bigDecrement = new Action();
  final Action<Null> addItem = new Action();
}

class CounterStore extends Store {
  int _smallCount = 0;
  int _bigCount = 0;
  List items = [];

  CounterStore(CounterActions actions) {
    triggerOnActionV2(actions.smallIncrement, (_) {
      _smallCount += 1;
      items.add('item');
//      items = [...items, 'item'];
    });
    triggerOnActionV2(actions.smallDecrement, (_) => _smallCount -= 1);
    triggerOnActionV2(actions.bigIncrement, (_) => _bigCount+= 10);
    triggerOnActionV2(actions.bigDecrement, (_) => _bigCount -= 10);
  }

  int get smallCount => _smallCount;
  int get bigCount => _bigCount;
}

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////

/// The application flux actions.
final fluxActions = CounterActions();

/// The application flux store.
final fluxStore = CounterStore(fluxActions);

/// The application store, adapted to be a Redux store.
final adaptedStore = FluxToReduxAdapterStore(fluxStore, fluxActions);
