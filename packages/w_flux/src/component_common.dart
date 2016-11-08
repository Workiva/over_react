// Copyright 2015 Workiva Inc.
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

library w_flux.src.component_common;

import 'dart:async';

import 'package:react/react.dart' as react;

import 'package:w_flux/src/store.dart';

/// FluxComponents are responsible for rendering application views and turning
/// user interactions and events into [Action]s. FluxComponents can use data
/// from one or many [Store] instances to define the resulting component.
abstract class FluxComponentCommon<ActionsT, StoresT> extends react.Component {
  /// The class instance defined by [ActionsT] that holds all [Action]s that
  /// this component needs access to.
  ///
  /// There is no strict rule on the [ActionsT] type. Depending on application
  /// structure, there may be [Action]s available directly on this object, or
  /// this object may represent a hierarchy of actions.
  ActionsT get actions => this.props['actions'] as ActionsT;

  /// The class instance defined by [StoresT]. This object should either be an
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
  StoresT get store => this.props['store'] as StoresT;

  /// List of store subscriptions created when the component mounts. These
  /// subscriptions are canceled when the component is unmounted.
  List<StreamSubscription> _subscriptions = [];

  componentWillMount() {
    // Subscribe to all applicable stores. Stores returned by `redrawOn()` will
    // have their triggers mapped directly to this components redraw function.
    // Stores included in the `getStoreHandlers()` result will be listened to
    // and wired up to their respective handlers.
    Map<Store, StoreHandler> handlers =
        new Map<Store, StoreHandler>.fromIterable(redrawOn(),
            value: (_) => (_) => redraw())..addAll(getStoreHandlers());
    handlers.forEach((store, handler) {
      StreamSubscription subscription = store.listen(handler);
      _subscriptions.add(subscription);
    });
  }

  componentWillUnmount() {
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
    if (store is Store) {
      return [store as Store];
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
  Map<Store, StoreHandler> getStoreHandlers() {
    return {};
  }

  /// Register a [subscription] that should be canceled when the component
  /// unmounts. Cancellation will be handled automatically by
  /// [componentWillUnmount].
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}
