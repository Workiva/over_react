import 'dart:async';

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/flux_component.dart';
import 'package:w_common/disposable.dart';
import 'package:w_flux/w_flux.dart';

class FluxHook<TActions, TStore extends Store> {
  final TStore store;
  final TActions actions;
  final Disposable _disposer;
  final BatchedRedraws _batchedRedrawer;
  void Function(StreamSubscription) _addSubscription;

  FluxHook._(this.actions, this.store, this._disposer, this._batchedRedrawer, this._addSubscription);

  void redraw() => _batchedRedrawer.redraw();
  void addSubscription(StreamSubscription subscription) => _addSubscription(subscription);
  Future<Null> dispose() => _disposer.dispose();
}

FluxHook<TActions, TStore> useFlux<TActions, TStore extends Store>(TActions actions, TStore store, {
  /// Define the list of [Store] instances that this component should listen to.
  ///
  /// When any of the returned [Store]s update their state, this component will
  /// redraw.
  ///
  /// If `props.store` is of type [Store] (in other words, if this component has a
  /// single Store passed in), this will return a list with said store as the
  /// only element by default. Otherwise, an empty list is returned.
  ///
  /// If `props.store` is actually a composite object with multiple stores, this
  /// method should be overridden to return a list with the stores that should
  /// be listened to.
  ///
  ///     @override
  ///     redrawOn() => [store.tasks, store.users];
  List<TStore> redrawOn,
  /// Redraws the component for a given [store].
  ///
  /// Called whenever an event is emitted by one of the stores returned by
  /// [redrawOn] that don't have custom store handlers (defined in
  /// [getStoreHandlers]).
  ///
  /// Override and call super to add custom behavior.
  void Function(TStore store) handleRedrawOn,
  Map<TStore, StoreHandler> storeHandlers = const {},
}) {
  final disposer = useRef(Disposable());
  final batchedRedrawer = useRef(BatchedRedraws());
  final subscriptions = useRef(<StreamSubscription>[]);
  final latestStore = useState(store);

  final _handleRedrawOn = (handleRedrawOn ?? latestStore.set) as dynamic Function(Store);
  final _redrawOn = redrawOn ?? (store is Store ? [store] : const []);

  void addSubscription(StreamSubscription subscription) {
    subscriptions.current.add(subscription);
  }

  void listenToStoreForRedraw(TStore store) {
    validateStoreDisposalState(store, batchedRedrawer.current, loggerIdPrefix: 'over_react.useFlux(hook).');
    final subscription = disposer.current.listenToStream(store, _handleRedrawOn);
    addSubscription(subscription);
  }

  void setUpStoreListeners() {
    // Subscribe to all applicable stores.
    //
    // Stores returned by `redrawOn()` will have their triggers mapped directly
    // to `handleRedrawOn`, which invokes this component's redraw function.
    //
    // Stores included in the `getStoreHandlers()` result will be listened to
    // and wired up to their respective handlers.
    final customStoreHandlers = storeHandlers;
    final storesWithoutCustomHandlers = _redrawOn.where((store) => !customStoreHandlers.containsKey(store));

    customStoreHandlers.forEach((store, handler) {
      validateStoreDisposalState(store, batchedRedrawer.current);
      final subscription = disposer.current.listenToStream(store, handler);
      addSubscription(subscription);
    });
    storesWithoutCustomHandlers.forEach(listenToStoreForRedraw);
  }

  useEffect(() {
    setUpStoreListeners();

    return () {
      // Cleanup on unmount
      batchedRedrawer.current?.shouldBatchRedraw = false;
      disposer.current?.dispose();
    };
  }, const []);

  return FluxHook._(actions, store, disposer.current, batchedRedrawer.current, addSubscription);
}
