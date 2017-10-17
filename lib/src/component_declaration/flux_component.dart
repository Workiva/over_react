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

library over_react.component_declaration.flux_component;

import 'dart:async';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
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
  ActionsT get actions => props[_actionsPropKey] as ActionsT; // ignore: avoid_as
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
  StoresT get store => props[_storePropKey] as StoresT; // ignore: avoid_as
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
///
/// > Related: [FluxUiStatefulComponent]
abstract class FluxUiComponent<TProps extends FluxUiProps> extends UiComponent<TProps>
    with _FluxComponentMixin<TProps>, BatchedRedraws {
  // Redeclare these lifecycle methods with `mustCallSuper`, since `mustCallSuper` added to methods within
  // mixins doesn't work. See https://github.com/dart-lang/sdk/issues/29861

  @mustCallSuper
  @override
  // Ignore this warning to work around https://github.com/dart-lang/sdk/issues/29860
  // ignore: must_call_super
  void componentWillMount();

  @mustCallSuper
  @override
  // Ignore this warning to work around https://github.com/dart-lang/sdk/issues/29860
  // ignore: must_call_super
  void componentWillReceiveProps(Map nextProps);

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState);

  @mustCallSuper
  @override
  // Ignore this warning to work around https://github.com/dart-lang/sdk/issues/29860
  // ignore: must_call_super
  void componentWillUnmount();
}

/// Builds on top of [UiStatefulComponent], adding `w_flux` integration, much like the [FluxComponent] in w_flux.
///
/// * Flux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Flux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react transformer via the `@Component()` ([annotations.Component]) annotation.
///
/// > Related: [FluxUiComponent]
abstract class FluxUiStatefulComponent<TProps extends FluxUiProps, TState extends UiState>
    extends UiStatefulComponent<TProps, TState>
    with _FluxComponentMixin<TProps>, BatchedRedraws {
  // Redeclare these lifecycle methods with `mustCallSuper`, since `mustCallSuper` added to methods within
  // mixins doesn't work. See https://github.com/dart-lang/sdk/issues/29861

  @mustCallSuper
  @override
  // Ignore this warning to work around https://github.com/dart-lang/sdk/issues/29860
  // ignore: must_call_super
  void componentWillMount();

  @mustCallSuper
  @override
  // Ignore this warning to work around https://github.com/dart-lang/sdk/issues/29860
  // ignore: must_call_super
  void componentWillReceiveProps(Map nextProps);

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState);

  @mustCallSuper
  @override
  // Ignore this warning to work around https://github.com/dart-lang/sdk/issues/29860
  // ignore: must_call_super
  void componentWillUnmount();
}

/// Helper mixin to keep [FluxUiComponent] and [FluxUiStatefulComponent] clean/DRY.
///
/// Private so it will only get used in this file, since having lifecycle methods in a mixin is risky.
abstract class _FluxComponentMixin<TProps extends FluxUiProps> implements BatchedRedraws {
  static final Logger _logger = new Logger('_FluxComponentMixin');
  TProps get props;

  /// List of store subscriptions created when the component mounts.
  ///
  /// These subscriptions are canceled when the component is unmounted.
  List<StreamSubscription> _subscriptions = [];

  void componentWillMount() {
    /// Subscribe to all applicable stores.
    ///
    /// [Store]s returned by [redrawOn] will have their triggers mapped directly to this components
    /// redraw function.
    ///
    /// [Store]s included in the [getStoreHandlers] result will be listened to and wired up to their
    /// respective handlers.
    Map<Store, StoreHandler> handlers = new Map.fromIterable(redrawOn(),
        value: (_) => (_) => redraw())..addAll(getStoreHandlers());

    handlers.forEach((store, handler) {
      String message = 'Cannot listen to a disposed/disposing Store.';

      var isDisposedOrDisposing = store.isDisposedOrDisposing ?? false;

      assert(!isDisposedOrDisposing, '$message This can be caused by BatchedRedraws '
        'mounting the component asynchronously after the store has been disposed. If you are '
        'in a test environment, try adding an `await window.animationFrame;` before disposing your '
        'store.');

      if (isDisposedOrDisposing) {
        _logger.warning(message);
        return;
      }

      StreamSubscription subscription = store.listen(handler);
      _subscriptions.add(subscription);
    });
  }

  void componentWillUnmount() {
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
      return <Store>[props.store];
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
  Map<Store, StoreHandler> getStoreHandlers() {
    return {};
  }

  /// Register a [subscription] that should be canceled when the component unmounts.
  ///
  /// Cancellation will be handled automatically by [componentWillUnmount].
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}
