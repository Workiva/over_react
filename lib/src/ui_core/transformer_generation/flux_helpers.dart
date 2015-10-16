library web_skin_dart.transformer_generation.flux_helpers;

import 'dart:async';
import 'package:w_flux/w_flux.dart';
import './helpers.dart';
import 'package:web_skin_dart/src/ui_core/component/typed_mixins.dart';

abstract class FluxUiComponent<TProps extends FluxUiProps> extends UiComponent<TProps> {
  /// List of store subscriptions created when the component mounts. These
  /// subscriptions are canceled when the component is unmounted.
  List<StreamSubscription> _subscriptions = [];

  componentWillMount() {
    super.componentWillMount();

    // Subscribe to all applicable stores. Stores returned by `redrawOn()` will
    // have their triggers mapped directly to this components redraw function.
    // Stores included in the `getStoreHandlers()` result will be listened to
    // and wired up to their respective handlers.
    Map<Store, Function> handlers = new Map.fromIterable(redrawOn(),
        value: (_) => (_) => redraw())..addAll(getStoreHandlers());
    handlers.forEach((store, handler) {
      StreamSubscription subscription = store.listen(handler);
      _subscriptions.add(subscription);
    });
  }

  componentWillUnmount() {
    super.componentWillUnmount();

    // Cancel all store subscriptions.
    _subscriptions.forEach((StreamSubscription subscription) {
      if (subscription != null) {
        subscription.cancel();
      }
    });
  }

  /// Define the list of [Store] instances that this component should listen to.
  /// When any of the returned [Store]s update their state, this component will
  /// redraw.
  ///
  /// If [store] is of type [Store] (in other words, if this component has a
  /// single Store passed in), this will return a list with said store as the
  /// only element by default. Otherwise, an empty list is returned.
  ///
  /// If [store] is actually a composite object with multiple stores, this
  /// method should be overridden to return a list with the stores that should
  /// be listened to.
  ///
  ///     @override
  ///     redrawOn() => [store.tasks, store.users];
  List<Store> redrawOn() {
    if (props.store is Store) {
      return [props.store];
    } else {
      return [];
    }
  }

  /// If you need more fine-grained control over store trigger handling,
  /// override this method to return a Map of stores to handlers. Whenever a
  /// store in the returned map triggers, the respective handler will be called.
  ///
  /// Handlers defined here take precedence over the [redrawOn] handling.
  /// If possible, however, [redrawOn] should be used instead of this in order
  /// to avoid keeping additional state within this component and manually
  /// managing redraws.
  Map<Store, Function> getStoreHandlers() {
    return {};
  }

  /// Register a [subscription] that should be canceled when the component
  /// unmounts. Cancellation will be handled automatically by
  /// [componentWillUnmount].
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}

abstract class FluxUiProps<ActionsT, StoresT> extends UiProps {
  String get _actionsPropKey => '${propKeyNamespace}actions';
  String get _storePropKey => '${propKeyNamespace}store';

  /// The prop defined by [ActionsT] that holds all [Action]s that
  /// this component needs access to.
  ///
  /// There is no strict rule on the [ActionsT] type. Depending on application
  /// structure, there may be [Action]s available directly on this object, or
  /// this object may represent a hierarchy of actions.
  ActionsT get actions => props[_actionsPropKey];
  set actions(ActionsT value) => props[_actionsPropKey] = value;

  /// The prop defined by [StoresT]. This object should either be an
  /// instance of [Store] or should provide access to one or more [Store]s.
  ///
  /// **Instead of storing state within this component via [setState], it is
  /// recommended that data be pulled directly from these stores.** This ensures
  /// that the data being used is always up to date and leaves the state
  /// management logic to the stores.
  ///
  /// If this component only needs data from a single [Store], then [StoresT]
  /// should be an instance of [Store]. This allows the default implementation
  /// of [redrawOn] to automatically subscribe to the store.
  ///
  /// If this component needs data from multiple [Store] instances, then
  /// [StoresT] should be a class that provides access to these multiple stores.
  /// Then, you can explicitly select the [Store] instances that should be
  /// listened to by overriding [redrawOn].
  StoresT get store => props[_storePropKey];
  set store(StoresT value) => props[_storePropKey] = value;
}

// Just in case people need it...
abstract class FluxUiStatefulComponent<TProps extends FluxUiProps, TState extends UiState>
    extends FluxUiComponent<TProps> with TypedStateGetter<TState> {

  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  //   BEGIN Typed state helpers
  //

   // Keep this Expando unparameterized to work around this bug: https://code.google.com/p/dart/issues/detail?id=18713
  Expando _typedStateCache = new Expando();

  /// Create, or get from cache, a typed state object corresponding to the current state Map.
  @override
  TState get state {
    var unwrappedState = this.unwrappedState;
    TState typedState = _typedStateCache[unwrappedState];
    if (typedState == null) {
      typedState = typedStateFactory(unwrappedState);
      _typedStateCache[unwrappedState] = typedState;
    }
    return typedState;
  }

  /// Use [state] instead;
  @deprecated
  TState get tState => state;

  /// The state Map that will be used to create the typed state object.
  Map get unwrappedState => super.state;

  /// Returns a typed state object backed by the specified Map.
  /// Required to properly instantiate the generic class parameter.
  TState typedStateFactory(Map stateMap);

  /// Returns a typed state object backed by a new Map.
  /// Convenient for use with getInitialState and setState.
  TState newState() => typedStateFactory({});

  //
  //   END Typed state helpers
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
}
