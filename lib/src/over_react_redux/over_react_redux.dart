// Copyright 2019 Workiva Inc.
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

@JS()
library over_react_redux;

import 'dart:html';
import 'dart:js_util' as js_util;
import 'package:meta/meta.dart';
import 'package:over_react/src/component_declaration/component_base.dart'
    as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart'
    as builder_helpers;
import 'package:collection/collection.dart';
import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:redux/redux.dart';

part 'over_react_redux.over_react.g.dart';

@PropsMixin(keyNamespace: '')
abstract class _$ConnectPropsMixin implements UiProps {
  @override
  Map get props;

  dynamic Function(dynamic action) dispatch;
}

typedef dynamic Dispatcher(dynamic);

/// A wrapper around the JS react-redux `connect` function that supports OverReact components.
///
/// __Example:__
/// ```dart
///     UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
///         mapStateToProps: (state) => (
///           Counter()..intProp = state.count
///         ),
///         mapDispatchToProps: (dispatch) => (
///           Counter()..increment = () => dispatch(INCREMENT_ACTION())
///         ),
///     )(Counter);
/// ```
///
/// - [mapStateToProps] is used for selecting the part of the data from the store that the connected
///  component needs.
///  - It is called every time the store state changes.
///  - It receives the entire store state, and should return an object of data this component needs.
/// If you need access to the props provided to the connected component you can use [mapStateToPropsWithOwnProps],
/// the second argument will be `ownProps`.
/// See: <https://react-redux.js.org/using-react-redux/connect-mapstate#defining-mapstatetoprops>
///
/// - [mapDispatchToProps] will be called with dispatch as the first argument.
/// You will normally make use of this by returning new functions that call dispatch() inside themselves,
/// and either pass in a plain action directly or pass in the result of an action creator.
/// If you need access to the props provided to the connected component you can use [mapDispatchToPropsWithOwnProps],
/// the second argument will be `ownProps`.
/// See: <https://react-redux.js.org/using-react-redux/connect-mapdispatch#defining-mapdispatchtoprops-as-a-function>
///
/// - [mergeProps] if specified, defines how the final props for the wrapped component are determined.
/// If you do not provide [mergeProps], the wrapped component receives {...ownProps, ...stateProps, ...dispatchProps}
/// by default.
///
/// - [areStatesEqual] does a simple `==` check by default.
/// - [areOwnPropsEqual] does a shallow Map equality check by default.
/// - [areStatePropsEqual] does a shallow Map equality check by default.
/// - [areMergedPropsEqual] does a shallow Map equality check by default.
///
/// - [context] can be utilized to provide a custom context object created with `createContext`.
/// [context] is how you can utilize multiple stores. While supported, this is not recommended. :P
/// See: <https://redux.js.org/api/store#a-note-for-flux-users>
/// See: <https://stackoverflow.com/questions/33619775/redux-multiple-stores-why-not>
///
/// __Example:__
/// ```dart
///     Store store1 = new Store<CounterState>(counterStateReducer, initialState: new CounterState(count: 0));
///     Store store2 = new Store<BigCounterState>(bigCounterStateReducer, initialState: new BigCounterState(bigCount: 100));
///
///     UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
///       mapStateToProps: (state) => (Counter()..intProp = state.count)
///     )(Counter);
///
///     UiFactory<CounterProps> ConnectedBigCounter = connect<BigCounterState, CounterProps>(
///       mapStateToProps: (state) => (Counter()..intProp = state.bigCount),
///       context: bigCounterContext,
///     )(Counter);
///
///     react_dom.render(
///       Dom.div()(
///         (ReduxProvider()..store = store1)(
///           (ReduxProvider()
///             ..store = store2
///             ..context = bigCounterContext
///           )(
///             Dom.div()(
///               Dom.h3()('ConnectedBigCounter Store2'),
///               ConnectedBigCounter()(
///                 Dom.h4()('ConnectedCounter Store1'),
///                 ConnectedCounter()(),
///               ),
///             ),
///           ),
///         ),
///       ), querySelector('#content')
///     );
/// ```
///
/// - [pure] if `true` (default), connect performs several equality checks that are used to avoid unnecessary
/// calls to [mapStateToProps], [mapDispatchToProps], [mergeProps], and ultimately to [render]. These include
/// [areStatesEqual], [areOwnPropsEqual], [areStatePropsEqual], and [areMergedPropsEqual].
/// While the defaults are probably appropriate 99% of the time, you may wish to override them with custom
/// implementations for performance or other reasons.
///
/// - [forwardRef] if `true`, the `ref` prop provided to the connected component will be return the wrapped component.
///
/// For more info see: https://react-redux.js.org/api/connect#connect
UiFactory<TProps> Function(UiFactory<TProps>)
    connect<TReduxState, TProps extends UiProps>({
  Map Function(TReduxState state) mapStateToProps,
  Map Function(TReduxState state, TProps ownProps) mapStateToPropsWithOwnProps,
  Map Function(Dispatcher dispatch) mapDispatchToProps,
  Map Function(dynamic Function(dynamic) dispatch, TProps ownProps)
      mapDispatchToPropsWithOwnProps,
  Map Function(TProps stateProps, TProps dispatchProps, TProps ownProps)
      mergeProps,
  bool Function(TReduxState nextState, TReduxState prevState) areStatesEqual,
  bool Function(TProps nextProps, TProps prevProps) areOwnPropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areStatePropsEqual,
  bool Function(TProps nextProps, TProps prevProps) areMergedPropsEqual,
  Context context,
  bool pure = true,
  bool forwardRef = false,
}) {
  areStatesEqual ??= _defaultEquality;
  areOwnPropsEqual ??= _shallowMapEquality;
  areStatePropsEqual ??= _shallowMapEquality;
  areMergedPropsEqual ??= _shallowMapEquality;

  UiFactory<TProps> wrapWithConnect(UiFactory<TProps> factory) {
    final dartComponentClass =
        (factory().componentFactory as ReactDartComponentFactoryProxy)
            .reactClass;

    JsMap jsMapFromProps(Map props) =>
        jsBackingMapOrJsCopy(props is UiProps ? props.props : props);

    TProps jsPropsToTProps(JsMap jsProps) =>
        factory(new JsBackedMap.backedBy(jsProps));

    Function allowInteropWithArgCount(Function dartFunction, int count) {
      var interopFunction = allowInterop(dartFunction);
      js_util
          .callMethod(js_util.getProperty(window, 'Object'), 'defineProperty', [
        interopFunction,
        'length',
        js_util.jsify({'value': count})
      ]);
      return interopFunction;
    }

    JsMap handleMapStateToProps(ReactInteropValue jsState) {
      return jsMapFromProps(
        mapStateToProps(
          unwrapInteropValue(jsState),
        ),
      );
    }

    JsMap handleMapStateToPropsWithOwnProps(
        ReactInteropValue jsState, JsMap jsOwnProps) {
      return jsMapFromProps(
        mapStateToPropsWithOwnProps(
          unwrapInteropValue(jsState),
          jsPropsToTProps(jsOwnProps),
        ),
      );
    }

    JsMap handleMapDispatchToProps(dynamic Function(dynamic) dispatch) {
      return jsMapFromProps(
        mapDispatchToProps(dispatch),
      );
    }

    JsMap handleMapDispatchToPropsWithOwnProps(
        Function dispatch, JsMap jsOwnProps) {
      return jsMapFromProps(mapDispatchToPropsWithOwnProps(
        dispatch,
        jsPropsToTProps(jsOwnProps),
      ));
    }

    JsMap handleMergeProps(
        JsMap jsStateProps, JsMap jsDispatchProps, JsMap jsOwnProps) {
      return jsMapFromProps(mergeProps(jsPropsToTProps(jsStateProps),
          jsPropsToTProps(jsDispatchProps), jsPropsToTProps(jsOwnProps)));
    }

    bool handleAreStatesEqual(
            ReactInteropValue jsNext, ReactInteropValue jsPrev) =>
        areStatesEqual(unwrapInteropValue(jsNext), unwrapInteropValue(jsPrev));

    bool handleAreOwnPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areOwnPropsEqual(jsPropsToTProps(jsNext), jsPropsToTProps(jsPrev));

    bool handleAreStatePropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areStatePropsEqual(jsPropsToTProps(jsNext), jsPropsToTProps(jsPrev));

    bool handleAreMergedPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areMergedPropsEqual(jsPropsToTProps(jsNext), jsPropsToTProps(jsPrev));

    final hoc = mockableJsConnect(
      mapStateToProps != null
          ? allowInteropWithArgCount(handleMapStateToProps, 1)
          : mapDispatchToPropsWithOwnProps != null
              ? allowInteropWithArgCount(handleMapStateToPropsWithOwnProps, 2)
              : null,
      mapDispatchToProps != null
          ? allowInteropWithArgCount(handleMapDispatchToProps, 1)
          : mapDispatchToPropsWithOwnProps != null
              ? allowInteropWithArgCount(
                  handleMapDispatchToPropsWithOwnProps, 2)
              : null,
      mergeProps != null ? allowInterop(handleMergeProps) : null,
      new JsConnectOptions(
        areStatesEqual: allowInterop(handleAreStatesEqual),
        areOwnPropsEqual: allowInterop(handleAreOwnPropsEqual),
        areStatePropsEqual: allowInterop(handleAreStatePropsEqual),
        areMergedPropsEqual: allowInterop(handleAreMergedPropsEqual),
        forwardRef: forwardRef,
        pure: pure,
        context: context?.jsThis ?? JsReactRedux.ReactReduxContext,
      ),
    )(dartComponentClass);

    final hocJsFactoryProxy = new ReactJsComponentFactoryProxy(hoc,
        shouldConvertDomProps: false, alwaysReturnChildrenAsList: true);

    TProps connectedFactory([Map props]) {
      return (factory(props)..componentFactory = hocJsFactoryProxy);
    }

    return connectedFactory;
  }

  return wrapWithConnect;
}

bool _defaultEquality(Object a, Object b) => a == b;
bool _shallowMapEquality(Map a, Map b) => const MapEquality().equals(a, b);

@JS('ReactRedux.connect')
external ReactClass Function(ReactClass) _jsConnect([
  /* JsMap Function(dynamic state, [JsMap ownProps]) */ Function
      mapStateToProps,
  /* JsMap Function(dynamic dispatch, [JsMap ownProps]) | JsMap */ dynamic
      mapDispatchToProps,
  /* Function(JsMap stateProps, JsMap dispatchProps, JsMap ownProps) */ Function
      mergeProps,
  JsConnectOptions options,
]);

@visibleForTesting
ReactClass Function(ReactClass) Function([
  Function mapStateToProps,
  dynamic mapDispatchToProps,
  Function mergeProps,
  JsConnectOptions options,
]) mockableJsConnect = _jsConnect;

@JS('ReactRedux')
class JsReactRedux {
  external static ReactClass get Provider;
  external static ReactContext get ReactReduxContext;
}

/// [ReduxProviderProps] is a typed props class for [ReduxProvider].
///
/// Props:
/// [store] (Redux Store) The single Redux store in your application.
/// [context] You may provide a context instance. If you do so, you will need to provide the same context instance to all of your connected components as well.
///
/// See: <https://react-redux.js.org/api/provider>
class ReduxProviderProps extends component_base.UiProps
    with builder_helpers.GeneratedClass
    implements builder_helpers.UiProps {
  ReduxProviderProps([Map props]) : this.props = props ?? new JsBackedMap();

  @override
  final Map props;

  @override
  ReactComponentFactoryProxy get componentFactory =>
      ReactJsReactReduxComponentFactoryProxy(JsReactRedux.Provider,
          isProvider: true);

  @override
  String get propKeyNamespace => '';

  /// The __single__ Redux store in your application.
  Store get store => props['store'];

  /// The __single__ Redux store in your application.
  set store(covariant Store v) => props['store'] = v;

  /// You may provide a context instance. If you do so, you will need to provide the same context
  /// instance to all of your connected components as well.
  dynamic get context => props['context'];

  /// You may provide a context instance. If you do so, you will need to provide the same context
  /// instance to all of your connected components as well.
  set context(covariant dynamic v) => props['context'] = v;
}

/// [ReduxProvider] makes the store available to any nested components that have been wrapped in the `connect()` function.
///
/// You cannot use a connected component unless it is nested inside of a ReduxProvider.
///
/// See: <https://react-redux.js.org/api/provider>
UiFactory<ReduxProviderProps> ReduxProvider =
    ([Map map]) => new ReduxProviderProps(map);

class ReactJsReactReduxComponentFactoryProxy
    extends ReactJsContextComponentFactoryProxy {
  ReactJsReactReduxComponentFactoryProxy(
    ReactClass jsClass, {
    shouldConvertDomProps: true,
    isConsumer: false,
    isProvider: false,
  }) : super(jsClass,
            isProvider: isProvider,
            isConsumer: isConsumer,
            shouldConvertDomProps: shouldConvertDomProps);

  @override
  ReactElement build(Map props, [List childrenArgs]) {
    return super.build(_generateReduxJsProps(props), childrenArgs);
  }

  /// Returns a JsBackedMap version of the specified [props], preprocessed for consumption by react-redux.
  Map _generateReduxJsProps(Map props) {
    JsBackedMap propsForJs = new JsBackedMap.from(props);

    if (propsForJs['store'] != null) {
      propsForJs['store'] = _reduxifyStore(propsForJs['store']);
    }

    if (propsForJs['context'] != null) {
      propsForJs['context'] = propsForJs['context'].jsThis;
    }

    return propsForJs;
  }
}

/// Converts a Redux.dart [Store] into a Javascript object formatted for consumption by react-redux.
JsReactReduxStore _reduxifyStore(Store store) {
  return JsReactReduxStore(getState: allowInterop(() {
    return wrapInteropValue(store.state);
  }), subscribe: allowInterop((cb) {
    return allowInterop(store.onChange.listen((_) {
      cb();
    }).cancel);
  }), dispatch: allowInterop((action) {
    store.dispatch(action);
  }));
}

@JS()
@anonymous
class JsReactReduxStore {
  external factory JsReactReduxStore({
    ReactInteropValue Function() getState,
    void Function(dynamic) dispatch,
    void Function(Function) subscribe,
  });
}

@visibleForTesting
@JS()
@anonymous
class JsConnectOptions {
  external set areStatesEqual(
      bool Function(ReactInteropValue, ReactInteropValue) value);
  external set areOwnPropsEqual(bool Function(JsMap, JsMap) value);
  external set areStatePropsEqual(bool Function(JsMap, JsMap) value);
  external set areMergedPropsEqual(bool Function(JsMap, JsMap) value);
  external set forwardRef(bool value);
  external set pure(bool value);
  external set context(ReactContext value);
  external bool Function(ReactInteropValue, ReactInteropValue)
      get areStatesEqual;
  external bool Function(JsMap, JsMap) get areOwnPropsEqual;
  external bool Function(JsMap, JsMap) get areStatePropsEqual;
  external bool Function(JsMap, JsMap) get areMergedPropsEqual;
  external bool get forwardRef;
  external bool get pure;
  external ReactContext get context;
  external factory JsConnectOptions({
    bool Function(ReactInteropValue, ReactInteropValue) areStatesEqual,
    bool Function(JsMap, JsMap) areOwnPropsEqual,
    bool Function(JsMap, JsMap) areStatePropsEqual,
    bool Function(JsMap, JsMap) areMergedPropsEqual,
    bool forwardRef,
    bool pure,
    ReactContext context,
  });
}

/// A wrapper class that prevents dart2js from jsifying [value].
class ReactInteropValue {
  dynamic value;
}

/// A helper function that retrieves the [value] from a [ReactInteropValue].
T unwrapInteropValue<T>(ReactInteropValue value) {
  return value.value;
}

/// A helper function that wraps a [value] in a [ReactInteropValue].
ReactInteropValue wrapInteropValue(dynamic value) {
  return new ReactInteropValue()..value = value;
}
