library over_react.component_declaration.flux_component;

import 'dart:async';
import 'package:w_flux/w_flux.dart';
import './annotations.dart' as annotations;
import './transformer_helpers.dart';

/// Builds on top of [UiProps], adding typed props for [Action]s and [Store]s in order to integrate with w_flux.
///
/// Use with the over_react transformer via the `@Props()` ([annotations.Props]) annotation.
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

  /// The prop defined by [StoresT].
  ///
  /// This object should either be an instance of [Store] or should provide access to one or more [Store]s.
  ///
  /// __Instead of storing state within this component via `setState`, it is recommended that data be
  /// pulled directly from these stores.__ This ensures that the data being used is always up to date
  /// and leaves the state management logic to the stores.
  ///
  /// If this component only needs data from a single [Store], then [StoresT]
  /// should be an instance of [Store]. This allows the default implementation
  /// of [redrawOn] to automatically subscribe to the store.
  ///
  /// If this component needs data from multiple [Store] instances, then
  /// [StoresT] should be a class that provides access to these multiple stores.
  /// Then, you can explicitly select the [Store] instances that should be
  /// listened to by overriding [_FluxComponentMixin.redrawOn].
  StoresT get store => props[_storePropKey];
  set store(StoresT value) => props[_storePropKey] = value;
}

/// Builds on top of [UiComponent], adding w_flux integration, much like the [FluxComponent] in w_flux.
///
/// * Flux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Flux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react transformer via the `@Component()` ([annotations.Component]) annotation.
abstract class FluxUiComponent<TProps extends FluxUiProps> extends UiComponent<TProps>
    with _FluxComponentMixin<TProps>, BatchedRedraws {}

/// Builds on top of [UiStatefulComponent], adding `w_flux` integration, much like the [FluxComponent] in w_flux.
///
/// * Flux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Flux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react transformer via the `@Component()` ([annotations.Component]) annotation.
abstract class FluxUiStatefulComponent<TProps extends FluxUiProps, TState extends UiState>
    extends UiStatefulComponent<TProps, TState>
    with _FluxComponentMixin<TProps>, BatchedRedraws {}

/// Helper mixin to keep [FluxUiComponent] and [FluxUiStatefulComponent] clean/DRY.
///
/// Private so it will only get used in this file, since having lifecycle methods in a mixin is risky.
abstract class _FluxComponentMixin<TProps extends FluxUiProps> {
  TProps get props;
  bool shouldBatchRedraw;
  redraw([callback()]);

  /// List of store subscriptions created when the component mounts.
  ///
  /// These subscriptions are canceled when the component is unmounted.
  List<StreamSubscription> _subscriptions = [];

  componentWillMount() {
    /// Subscribe to all applicable stores.
    ///
    /// [Store]s returned by [redrawOn] will have their triggers mapped directly to this components
    /// redraw function.
    ///
    /// [Store]s included in the [getStoreHandlers] result will be listened to and wired up to their
    /// respective handlers.
    Map<Store, Function> handlers = new Map.fromIterable(redrawOn(),
        value: (_) => (_) => redraw())..addAll(getStoreHandlers());
    handlers.forEach((store, handler) {
      StreamSubscription subscription = store.listen(handler);
      _subscriptions.add(subscription);
    });
  }

  componentWillUnmount() {
    // Ensure that unmounted components don't batch render
    shouldBatchRedraw = false;

    // Cancel all store subscriptions.
    _subscriptions.forEach((StreamSubscription subscription) {
      if (subscription != null) {
        subscription.cancel();
      }
    });
  }

  /// Define the list of [Store] instances that this component should listen to.
  ///
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
  /// override this method to return a Map of stores to handlers.
  ///
  /// Whenever a store in the returned map triggers, the respective handler will be called.
  ///
  /// Handlers defined here take precedence over the [redrawOn] handling.
  /// If possible, however, [redrawOn] should be used instead of this in order
  /// to avoid keeping additional state within this component and manually
  /// managing redraws.
  Map<Store, Function> getStoreHandlers() {
    return {};
  }

  /// Register a [subscription] that should be canceled when the component unmounts.
  ///
  /// Cancellation will be handled automatically by [componentWillUnmount].
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}
