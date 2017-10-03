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

library over_react.component_declaration.redux_component;

import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

/// Builds on top of [UiProps], adding typed props for [Store] in order to integrate with `built_redux`.
///
/// Use with the over_react transformer via the `@Props()` ([annotations.Props]) annotation.
abstract class ReduxUiProps<StoreT> extends UiProps {
  String get _storePropKey => '${propKeyNamespace}store';

  /// The prop defined by [StoresT].
  ///
  /// This object should either be an instance of [Store].
  ///
  /// __Instead of storing state within this component via `setState`, it is recommended that data be
  /// pulled directly from these stores.__ This ensures that the data being used is always up to date
  /// and leaves the state management logic to the stores.
  StoreT get store => props[_storePropKey];
  set store(StoreT value) => props[_storePropKey] = value;
}

/// Builds on top of [UiComponent], adding `built_redux` integration.
///
/// * Redux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Redux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react transformer via the `@Component()` ([annotations.Component]) annotation.
///
/// > Related: [ReduxUiStatefulComponent]
abstract class ReduxUiComponent<T extends ReduxUiProps> extends UiComponent<T> with _ReduxComponentMixin<T> {
  @mustCallSuper
  @override
  void componentWillMount() {
    super.componentWillMount();
    _setUpSubs();
  }

  @mustCallSuper
  @override
  void componentWillReceiveProps(Map nextProps) {
    super.componentWillReceiveProps(nextProps);
    // Unbind store subs so they can be re-bound in componentDidUpdate
    // once the new props are available, ensuring the values returned by [redrawOn]
    // are not outdated.
    _tearDownSubs();
  }

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    // If the subs are not bound at this point, then that means they were unbound by
    // componentWillReceiveProps, and need to be re-bound now that new props are available.
    if (!_areStoreSubsBound) _setUpSubs();
  }

  @mustCallSuper
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();
    _tearDownSubs();
  }
}

/// Builds on top of [UiStatefulComponent], adding `built_redux` integration.
///
/// * Redux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Redux components can use data from one or many [Store] instances to define
///   the resulting component.
///
/// Use with the over_react transformer via the `@Component()` ([annotations.Component]) annotation.
///
/// > Related: [ReduxUiComponent]
abstract class ReduxUiStatefulComponent<T extends ReduxUiProps, S extends UiState> extends UiStatefulComponent<T, S>
    with _ReduxComponentMixin<T> {
  @mustCallSuper
  @override
  void componentWillMount() {
    super.componentWillMount();
    _setUpSubs();
  }

  @mustCallSuper
  @override
  void componentWillReceiveProps(Map nextProps) {
    super.componentWillReceiveProps(nextProps);
    // Unbind store subs so they can be re-bound in componentDidUpdate
    // once the new props are available, ensuring the values returned by [redrawOn]
    // are not outdated.
    _tearDownSubs();
  }

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    // If the subs are not bound at this point, then that means they were unbound by
    // componentWillReceiveProps, and need to be re-bound now that new props are available.
    if (!_areStoreSubsBound) _setUpSubs();
  }

  @mustCallSuper
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();
    _tearDownSubs();
  }
}

abstract class _ReduxComponentMixin<T extends ReduxUiProps> implements UiComponent<T> {
  List<Stream> redrawOn() {
    if (props.store is Store) {
      return <Stream>[props.store.stream];
    } else {
      return <Stream>[];
    }
  }

  bool get _areStoreSubsBound => _storeSubs != null;

  List<StreamSubscription> _storeSubs;

  void _setUpSubs() {
    if (_areStoreSubsBound) {
      throw new StateError('Store subscriptions are already bound.');
    }

    _storeSubs = [];

    for (var stream in redrawOn()) {
      _storeSubs.add(stream.listen((_) => redraw()));
    }
  }

  void _tearDownSubs() {
    if (!_areStoreSubsBound) return;

    for (var sub in _storeSubs) {
      sub.cancel();
    }

    _storeSubs = null;
  }
}
