// Copyright 2018 Workiva Inc.
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
library over_react.redux_component;

import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

/// Builds on top of [UiProps], adding typed props for [Store] in order to integrate with `built_redux`.
///
/// Use with the over_react builder via the `@Props()` annotation.
///
/// __Warning:__ This will be deprecated in an upcoming release in favor of a different approach to
/// creating a `built_redux` component.
@Deprecated('BuiltRedux usage is deprecated in favor of OverReact Redux. 4.0.0')
abstract class BuiltReduxUiProps<V extends Built<V, B>, B extends Builder<V, B>,
    A extends ReduxActions> extends UiProps {
  String get _storePropKey => '${propKeyNamespace}store';

  /// The [Store] prop defined by [V], [B], and [A].
  Store<V, B, A>? get store => props[_storePropKey] as Store<V, B, A>?;
  set store(Store<V, B, A>? value) => props[_storePropKey] = value;

  /// The [ReduxActions] prop defined by [A].
  A get actions => store!.actions;
}

/// Builds on top of [UiComponent], adding `built_redux` integration.
///
/// * Redux components are responsible for rendering application views and turning
///   user interactions and events into [Action]s.
/// * Redux components can use data from one [Store] instance to define the resulting component.
///
/// Use with the over_react builder via the `@Component()` annotation.
///
/// __Note:__ [Substate] must be a comparable object to avoid unnecessary redraws,
/// it is recommended that [Substate] either be a primitive, built_value, build_collection or an Object
/// that overrides `==`.
///
/// __Warning:__ This will be deprecated in an upcoming release in favor of a different approach to
/// creating a `built_redux` component.
@Deprecated('BuiltRedux usage is deprecated in favor of OverReact Redux. 4.0.0')
abstract class BuiltReduxUiComponent<
        V extends Built<V, B>,
        B extends Builder<V, B>,
        A extends ReduxActions,
        T extends BuiltReduxUiProps<V, B, A>,
        Substate> extends UiComponent<T> {
  @mustCallSuper
  @override
  void componentWillMount() {
    super.componentWillMount();
    _isDirty = false;
    _setUpSub();
  }

  @mustCallSuper
  @override
  void componentWillReceiveProps(Map nextProps) {
    super.componentWillReceiveProps(nextProps);
    T tNextProps = typedPropsFactory(nextProps);

    if (tNextProps.store != props.store) {
      _tearDownSub();
      _setUpSub(nextProps);
    }
  }

  @mustCallSuper
  @override
  bool shouldComponentUpdate(Map nextProps, Map nextState) {
    if (isPure) return _isDirty || typedPropsFactory(nextProps).store != props.store;

    return true;
  }

  @mustCallSuper
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();
    _tearDownSub();
  }

  @mustCallSuper
  @override
  void redraw([Function()? callback]) {
    _isDirty = true;

    // ignore: deprecated_member_use
    super.redraw(() {
      _isDirty = false;

      if (callback != null) callback();
    });
  }

  late bool _isDirty;

  Substate? _connectedState;

  /// The substate values of the redux store that this component subscribes to.
  ///
  /// It is reccommened to use this instead of `props.store.state`;
  /// if you need to access other state values from the store then they should be connected with [connect].
  ///
  /// Related: [connect]
  Substate? get connectedState => _connectedState;

  /// Returns a subset of the values derived from the redux store that this component cares about.
  ///
  /// By default components will redraw based on any value change in the redux store.
  ///
  /// Example where there are three state values but your component should only re-render when two of them update:
  ///
  ///     abstract class MyState implements Built<MyState, MyStateBuilder> {
  ///       factory MyState({
  ///         int foo = 0,
  ///         int bar = 0,
  ///         int baz = 0,
  ///       }) => _$MyState._(
  ///         foo: foo,
  ///         bar: bar,
  ///         baz: baz,
  ///       );
  ///       MyState._();
  ///
  ///       int get foo;
  ///       int get bar;
  ///       int get baz;
  ///     }
  ///
  ///     abstract class DataComponentCaresAbout implements Built<DataComponentCaresAbout, DataComponentCaresAboutBuilder> {
  ///       factory DataComponentCaresAbout({int foo, int bar}) => _$DataComponentCaresAbout._(foo: foo, bar: bar);
  ///       DataComponentCaresAbout._();
  ///
  ///       int get foo;
  ///       int get bar;
  ///     }
  ///
  ///     MyComponent extends BuiltReduxUiComponent<MyState, MyStateBuilder, MyActions, MyProps, DataComponentCaresAbout> {
  ///       @override
  ///       DataComponentCaresAbout connect(state) => new DataComponentCaresAbout(foo: state.foo, bar: state.bar);
  ///
  ///       render() {
  ///         return Dom.div()(
  ///           connectedState.foo,
  ///           connectedState.bar,
  ///         );
  ///       }
  ///     }
  ///
  /// __Note:__ [Substate] must be a comparable object to avoid unnecessary redraws;
  /// it is reccomended that [Substate] either be a primitive, built_value, built_collection or an Object
  /// that overrides `==` and `hashCode`.
  ///
  /// Related: [connectedState]
  Substate connect(V state);

  /// Whether the component should be a "pure" component.
  ///
  /// A "pure" component will only re-render when [connectedState] is updated or [redraw] is called directly.
  /// To enable this functionality, override this getter in a subclass to return `true`. When set to true it
  /// is not recommended to override [redraw] or [shouldComponentUpdate].
  ///
  /// Related: [shouldComponentUpdate], [redraw]
  bool get isPure => false;

  StreamSubscription? _storeSub;

  void _setUpSub([Map? propsMap]) {
    if (_storeSub != null) {
      throw StateError('Store subscription is already set up');
    }

    propsMap ??= props;
    T tPropsMap = typedPropsFactory(propsMap);
    _connectedState = connect(tPropsMap.store!.state);

    _storeSub = tPropsMap.store!.nextSubstate(connect).listen((s) {
      _connectedState = s;
      redraw();
    });
  }

  void _tearDownSub() {
    _storeSub?.cancel();
    _storeSub = null;
  }
}
