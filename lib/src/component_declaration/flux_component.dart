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

// ignore_for_file: deprecated_member_use_from_same_package

library over_react.component_declaration.flux_component;

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:over_react/component_base.dart' as component_base;
import 'package:over_react/src/util/component_debug_name.dart';
import 'package:w_flux/w_flux.dart';

import 'annotations.dart' as annotations;
import 'builder_helpers.dart';
import 'component_base_2.dart';

part 'flux_component.over_react.g.dart';

/// Builds on top of [UiProps], adding typed [Action] and [Store] props for use with [FluxUiComponent2].
///
/// __Example:__
///
/// ```dart
/// class YourComponentProps = UiProps 
///     with FluxUiPropsMixin<YourFluxActionsClass, YourFluxStoreClass>;
/// ```
///
/// __Example (legacy boilerplate):__
///
/// ```dart
/// class YourComponentProps extends UiProps with FluxUiPropsMixin<YourFluxActionsClass, YourFluxStoreClass>, $FluxUiPropsMixin {
///   // Additional arbitrary props for your component can go here
/// }
/// ```
mixin FluxUiPropsMixin<ActionsT, StoresT> on UiProps implements FluxUiProps<ActionsT, StoresT> {
  /// The prop defined by [ActionsT] that holds all [Action]s that
  /// this component needs access to.
  ///
  /// There is no strict rule on the [ActionsT] type. Depending on application
  /// structure, there may be [Action]s available directly on this object, or
  /// this object may represent a hierarchy of actions.
  @override
  ActionsT actions;

  /// The flux [Store] instance(s) to be used by a [FluxUiComponent2] instance, or a reference to one.
  ///
  /// __Instead of storing state within this component via `setState`, it is recommended that data be
  /// pulled directly from these stores.__ This ensures that the data being used is always up to date
  /// and leaves the state management logic to the stores.
  ///
  /// If this component only needs data from a single [Store], then [StoresT]
  /// should be an instance of [Store]. This allows the default implementation
  /// of `redrawOn` to automatically subscribe to the store.
  ///
  /// If this component needs data from multiple [Store] instances, then
  /// [StoresT] should be a class that provides access to these multiple stores.
  /// Then, you can explicitly select the [Store] instances that should be
  /// listened to by overriding [_FluxComponentMixin.redrawOn].
  @override
  StoresT store;

  @override
  String get _actionsPropKey {
    assert(false, 'this should never be used');
    return '';
  }

  @override
  String get _storePropKey {
    assert(false, 'this should never be used');
    return '';
  }
}

/// __Deprecated.__ Use [FluxUiPropsMixin] instead.
///
///  The latest over_react component boilerplate does not allow props classes to extend from anything except UiProps.
///  You can upgrade your usage automatically by running:
///
///  ```
///  pub global activate over_react_codemod
///  pub global run over_react_codemod:boilerplate_upgrade
///  ```
@Deprecated('Use FluxUiPropsMixin instead. See the documentation for this class for detailed migration instructions.')
abstract class FluxUiProps<ActionsT, StoresT> extends UiProps {
  String get _actionsPropKey => '${propKeyNamespace}actions';
  String get _storePropKey => '${propKeyNamespace}store';

  /// The prop defined by [ActionsT] that holds all [Action]s that
  /// this component needs access to.
  ///
  /// There is no strict rule on the [ActionsT] type. Depending on application
  /// structure, there may be [Action]s available directly on this object, or
  /// this object may represent a hierarchy of actions.
  ActionsT get actions => props[_actionsPropKey] as ActionsT;
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
  /// of `redrawOn` to automatically subscribe to the store.
  ///
  /// If this component needs data from multiple [Store] instances, then
  /// [StoresT] should be a class that provides access to these multiple stores.
  /// Then, you can explicitly select the [Store] instances that should be
  /// listened to by overriding [_FluxComponentMixin.redrawOn].
  StoresT get store => props[_storePropKey] as StoresT;
  set store(StoresT value) => props[_storePropKey] = value;
}

/// Builds on top of [UiComponent], adding w_flux integration, much like the [FluxComponent] in w_flux.
///
/// * Flux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Flux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react builder via the `@Component()` ([annotations.Component]) annotation.
///
/// > Related: [FluxUiStatefulComponent]
///
/// __Deprecated.__ Use [FluxUiComponent2] instead.
@Deprecated('4.0.0')
abstract class FluxUiComponent<TProps extends FluxUiProps> extends UiComponent<TProps>
    with BatchedRedraws, _FluxComponentMixin<TProps> {
  @mustCallSuper
  @override
  void componentWillMount() {
    super.componentWillMount();
    _setUpStoreListeners();
  }

  @mustCallSuper
  @override
  void componentWillReceiveProps(Map nextProps);

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState);
}

/// Builds on top of [UiStatefulComponent], adding `w_flux` integration, much like the [FluxComponent] in w_flux.
///
/// * Flux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Flux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react builder via the `@Component()` ([annotations.Component]) annotation.
///
/// > Related: [FluxUiComponent]
///
///
/// __Deprecated.__ Use [FluxUiStatefulComponent2] instead.
@Deprecated('4.0.0')
abstract class FluxUiStatefulComponent<TProps extends FluxUiProps, TState extends UiState>
    extends UiStatefulComponent<TProps, TState>
    with BatchedRedraws, _FluxComponentMixin<TProps> {
  @mustCallSuper
  @override
  void componentWillMount() {
    super.componentWillMount();
    _setUpStoreListeners();
  }

  @mustCallSuper
  @override
  void componentWillReceiveProps(Map nextProps);

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState);
}

/// Builds on top of [UiComponent2], adding w_flux integration, much like the [FluxComponent] in w_flux.
///
/// * Flux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Flux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react builder via the `@Component2()` ([annotations.Component2]) annotation.
///
/// > Related: [FluxUiStatefulComponent2]
abstract class FluxUiComponent2<TProps extends FluxUiProps> extends UiComponent2<TProps>
    with BatchedRedraws, _FluxComponentMixin<TProps> {
  @mustCallSuper
  @override
  void componentDidMount() {
    _setUpStoreListeners();
  }
}

/// Builds on top of [UiStatefulComponent2], adding `w_flux` integration, much like the [FluxComponent] in w_flux.
///
/// * Flux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Flux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react builder via the `@Component2()` ([annotations.Component2]) annotation.
///
/// > Related: [FluxUiComponent2]
abstract class FluxUiStatefulComponent2<TProps extends FluxUiProps, TState extends UiState>
    extends FluxUiComponent2<TProps> with UiStatefulMixin2<TProps, TState> {}

/// Helper mixin to keep [FluxUiComponent] and [FluxUiStatefulComponent] clean/DRY.
///
/// Private so it will only get used in this file, since having lifecycle methods in a mixin is risky.
mixin _FluxComponentMixin<TProps extends FluxUiProps> on component_base.UiComponent<TProps>, BatchedRedraws {
  /// List of store subscriptions created when the component mounts.
  ///
  /// These subscriptions are canceled when the component is unmounted.
  List<StreamSubscription> _subscriptions = [];

  void _validateStoreDisposalState(Store store) {
    if (store.isOrWillBeDisposed) {
      final componentName = getDebugNameForDartComponent(this);

      // Include the component name in the logger name so that:
      // 1. it's included in the log somewhere
      // 2. logs from the same component can be easily grouped together
      final logger = Logger('over_react._FluxComponentMixin.$componentName');

      var storeNameOrType = store.disposableTypeName;
      // Detect if they don't override disposableTypeName by checking for the default name.
      if (storeNameOrType == 'Store') {
        storeNameOrType = store.runtimeType.toString();
      }

      final message = 'Cannot listen to a disposed/disposing Store.'
          ' (storeNameOrType: $storeNameOrType, shouldBatchRedraw: $shouldBatchRedraw)';

      // Throw in dev mode, warn in prod.
      assert(
          false,
          '$message This can be caused by BatchedRedraws '
          'mounting the component asynchronously after the store has been disposed. If you are '
          'in a test environment, try adding an `await window.animationFrame;` before disposing your '
          'store.');

      // Include a stack trace explicitly since it's not added by default.
      logger.warning(message, null, StackTrace.current);
    }
  }

  void _setUpStoreListeners() {
    // Subscribe to all applicable stores.
    //
    // Stores returned by `redrawOn()` will have their triggers mapped directly
    // to `handleRedrawOn`, which invokes this component's redraw function.
    //
    // Stores included in the `getStoreHandlers()` result will be listened to
    // and wired up to their respective handlers.
    final customStoreHandlers = getStoreHandlers();
    final storesWithoutCustomHandlers = redrawOn().where((store) => !customStoreHandlers.containsKey(store));

    customStoreHandlers.forEach((store, handler) {
      _validateStoreDisposalState(store);
      StreamSubscription subscription = store.listen(handler);
      _subscriptions.add(subscription);
    });
    storesWithoutCustomHandlers.forEach(listenToStoreForRedraw);
  }

  /// Used to register [handleRedrawOn] as a listener for the given [store].
  ///
  /// Called for each of the stores returned by [redrawOn] that don't have custom
  /// store handlers (defined in [getStoreHandlers]).
  ///
  /// Override to set up custom listener behavior.
  @protected
  void listenToStoreForRedraw(Store store) {
    _validateStoreDisposalState(store);
    _subscriptions.add(store.listen(handleRedrawOn));
  }

  /// Redraws the component for a given [store].
  ///
  /// Called whenever an event is emitted by one of the stores returned by
  /// [redrawOn] that don't have custom store handlers (defined in
  /// [getStoreHandlers]).
  ///
  /// Override and call super to add custom behavior.
  @mustCallSuper
  @protected
  void handleRedrawOn(Store store) {
    redraw();
  }

  // This is private and called by classes to work around super-calls not being supported in mixins
  @override
  @mustCallSuper
  void componentWillUnmount() {
    super.componentWillUnmount();

    // Ensure that unmounted components don't batch render
    shouldBatchRedraw = false;

    // Cancel all store subscriptions.
    _subscriptions.forEach((subscription) {
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
  List<Store> redrawOn() {
    final store = props.store;
    return store is Store ? [store] : [];
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
  /// Cancellation will be handled automatically by `componentWillUnmount`.
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}
