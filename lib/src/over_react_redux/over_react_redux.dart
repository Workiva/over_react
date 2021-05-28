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

// ignore_for_file: avoid_classes_with_only_static_members
@JS()
library over_react_redux;

import 'dart:html';
import 'dart:js_util' as js_util;

import 'package:js/js.dart';
import 'package:memoize/memoize.dart';
import 'package:meta/meta.dart';
import 'package:over_react/component_base.dart';
import 'package:over_react/src/component_declaration/annotations.dart';
import 'package:over_react/src/component_declaration/builder_helpers.dart' as builder_helpers;
import 'package:over_react/src/component_declaration/component_type_checking.dart';
import 'package:over_react/src/util/context.dart';
import 'package:over_react/src/util/equality.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:redux/redux.dart';

part 'over_react_redux.over_react.g.dart';

/// This class is present:
///
/// 1. to allow for consumers which have used the --backwards-compat flag with over_react_codemod to statically analyze:
///     <https://github.com/Workiva/over_react_codemod/blob/71e5713ec6c256ddaf7c616ff9d6d26d77bb8f25/README.md#dart-1-to-dart-2-codemod>
/// 2. to provide forwards-compatibility and allow this to be mixed into mixin-based component props
abstract class $ConnectPropsMixin {
  @Deprecated('This API is for use only within generated code.'
      ' Do not reference it in your code, as it may change at any time.')
  static const PropsMeta meta = _$metaForConnectPropsMixin;
}

// ignore: deprecated_member_use_from_same_package
@PropsMixin(keyNamespace: '')
abstract class _$ConnectPropsMixin implements UiProps {
  @override
  Map get props;

  dynamic Function(dynamic action) dispatch;
}

// ignore: prefer_generic_function_type_aliases
typedef dynamic Dispatcher(dynamic action);

/// A wrapper around the JS react-redux `connect` function that supports OverReact components.
///
/// > __NOTE:__ This should only be used to wrap components that extend from [Component2].
///
/// __Example:__
/// ```dart
/// UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
///   mapStateToProps: (state) => (Counter()
///     ..count = state.count
///   ),
///   mapDispatchToProps: (dispatch) => (Counter()
///     ..increment = (() => dispatch(INCREMENT_ACTION()))
///   ),
/// )(_$Counter);
/// ```
///
/// - [mapStateToProps] is used for selecting the part of the data from the store that the connected
///  component needs.
///  - It is called every time the store state changes.
///  - It receives the entire store state, and should return an object of data this component needs.
///   - If you need access to the props provided to the connected component you can use [mapStateToPropsWithOwnProps],
///     the second argument will be `ownProps`.
///     See: <https://react-redux.js.org/using-react-redux/connect-mapstate#defining-mapstatetoprops>
///   - If you need component-instance-specific initialization, such as to setup instance based selectors with memoization,
///     you can use [makeMapStateToProps] or [makeMapStateToPropsWithOwnProps] as a factory function, they will be called
///     once when the component instantiates, and their returns will be used as the actual [mapStateToProps].
///     See: <https://redux.js.org/recipes/computing-derived-data#sharing-selectors-across-multiple-components>
///     See: <https://react-redux.js.org/api/connect#factory-functions>
/// - [mapDispatchToProps] will be called with dispatch as the first argument.
///   - You will normally make use of this by returning new functions that call dispatch() inside themselves,
///     and either pass in a plain action directly or pass in the result of an action creator.
///   - If you need access to the props provided to the connected component you can use [mapDispatchToPropsWithOwnProps],
///     the second argument will be `ownProps`.
///     See: <https://react-redux.js.org/using-react-redux/connect-mapdispatch#defining-mapdispatchtoprops-as-a-function>
///   - If you need component-instance-specific initialization, such as to setup instance based selectors with memoization,
///     you can use [makeMapDispatchToProps] or [makeMapDispatchToPropsWithOwnProps] as a factory function, they will be
///     called once when the component instantiates, and their returns will be used as the actual [mapDispatchToProps].
///     See: <https://redux.js.org/recipes/computing-derived-data#sharing-selectors-across-multiple-components>
///     See: <https://react-redux.js.org/api/connect#factory-functions>
/// - [mergeProps] if specified, defines how the final props for the wrapped component are determined.
/// If you do not provide [mergeProps], the wrapped component receives {...ownProps, ...stateProps, ...dispatchProps}
/// by default.
///
/// - [areStatesEqual] does an equality check using JS `===` (equivalent to [identical]) by default.
/// - [areOwnPropsEqual] does a shallow Map equality check using [propsOrStateMapsEqual] by default.
/// - [areStatePropsEqual] does a shallow Map equality check using [propsOrStateMapsEqual] by default.
/// - [areMergedPropsEqual] does a shallow Map equality check using [propsOrStateMapsEqual] by default.
///
/// - [context] can be utilized to provide a custom context object created with `createContext`.
/// [context] is how you can utilize multiple stores. While supported, this is not recommended. :P
/// See: <https://redux.js.org/api/store#a-note-for-flux-users>
/// See: <https://stackoverflow.com/questions/33619775/redux-multiple-stores-why-not>
///
/// __Example:__
/// ```dart
///     Store store1 = Store<CounterState>(counterStateReducer, initialState: new CounterState(count: 0));
///     Store store2 = Store<BigCounterState>(bigCounterStateReducer, initialState: new BigCounterState(bigCount: 100));
///
///     UiFactory<CounterProps> Counter = connect<CounterState, CounterProps>(
///       mapStateToProps: (state) => (Counter()..count = state.count)
///     )(_$Counter);
///
///     UiFactory<CounterProps> BigCounter = connect<BigCounterState, CounterProps>(
///       mapStateToProps: (state) => (BigCounter()..count = state.bigCount),
///       context: bigCounterContext,
///     )(_$Counter);
///
///     react_dom.render(
///       Dom.div()(
///         (ReduxProvider()..store = store1)(
///           (ReduxProvider()
///             ..store = store2
///             ..context = bigCounterContext
///           )(
///             Dom.div()(
///               Dom.h3()('BigCounter Store2'),
///               BigCounter()(
///                 Dom.h4()('Counter Store1'),
///                 Counter()(),
///               ),
///             ),
///           ),
///         ),
///       ), querySelector('#content')
///     );
/// ```
///
/// - [pure] if `true` (default), connect performs several equality checks that are used to avoid unnecessary
/// calls to [mapStateToProps], [mapDispatchToProps], [mergeProps], and ultimately to `render`. These include
/// [areStatesEqual], [areOwnPropsEqual], [areStatePropsEqual], and [areMergedPropsEqual].
/// While the defaults are probably appropriate 99% of the time, you may wish to override them with custom
/// implementations for performance or other reasons.
///
/// - [forwardRef] if `true`, the `ref` prop provided to the connected component will be return the wrapped component.
///
/// For more info see: https://react-redux.js.org/api/connect#connect
UiFactory<TProps> Function(UiFactory<TProps>) connect<TReduxState, TProps extends UiProps>({
  Map Function(TReduxState/*!*/ state) mapStateToProps,
  Map Function(TReduxState/*!*/ state, TProps ownProps) mapStateToPropsWithOwnProps,
  Map Function(TReduxState/*!*/ state) Function(TReduxState/*!*/ initialState, TProps initialOwnProps) makeMapStateToProps,
  Map Function(TReduxState/*!*/ state, TProps ownProps) Function(TReduxState/*!*/ initialState, TProps initialOwnProps) makeMapStateToPropsWithOwnProps,
  Map Function(Dispatcher dispatch) mapDispatchToProps,
  Map Function(Dispatcher dispatch, TProps ownProps) mapDispatchToPropsWithOwnProps,
  Map Function(Dispatcher dispatch) Function(Dispatcher dispatch, TProps ownProps) makeMapDispatchToProps,
  Map Function(Dispatcher dispatch, TProps ownProps) Function(Dispatcher dispatch, TProps ownProps) makeMapDispatchToPropsWithOwnProps,
  Map Function(TProps stateProps, TProps dispatchProps, TProps ownProps) mergeProps,
  bool Function(TReduxState/*!*/ nextState, TReduxState/*!*/ prevState) areStatesEqual,
  // Use default parameter values instead of ??= in the function body to allow consumers
  // to specify `null` and fall back to the JS default.
  bool Function(TProps nextProps, TProps prevProps)/*?*/ areOwnPropsEqual = propsOrStateMapsEqual,
  bool Function(TProps nextProps, TProps prevProps)/*?*/ areStatePropsEqual = propsOrStateMapsEqual,
  bool Function(TProps nextProps, TProps prevProps)/*?*/ areMergedPropsEqual = propsOrStateMapsEqual,
  Context context,
  bool pure = true,
  bool forwardRef = false,
}) {
  List<dynamic> mapStateToPropsCheck = [mapStateToProps, mapStateToPropsWithOwnProps, makeMapStateToProps, makeMapStateToPropsWithOwnProps]..removeWhere((x) => x == null);
  List<dynamic> mapDispatchToPropsCheck = [mapDispatchToProps, mapDispatchToPropsWithOwnProps, makeMapDispatchToProps, makeMapDispatchToPropsWithOwnProps]..removeWhere((x) => x == null);

  if (mapStateToPropsCheck.length > 1) {
    throw ArgumentError('Only one of the following arguments can be provided at a time: [mapStateToProps, mapStateToPropsWithOwnProps, makeMapStateToProps, makeMapStateToPropsWithOwnProps]');
  }

  if (mapDispatchToPropsCheck.length > 1) {
    throw ArgumentError('Only one of the following arguments can be provided at a time: [mapDispatchToProps, mapDispatchToPropsWithOwnProps, makeMapDispatchToProps, makeMapDispatchToPropsWithOwnProps]');
  }

  UiFactory<TProps> wrapWithConnect(UiFactory<TProps> factory) {
    final dartComponentFactory = factory().componentFactory;
    final dartComponentClass = dartComponentFactory.type;
    enforceMinimumComponentVersionFor(dartComponentFactory);

    JsMap jsMapFromProps(Map props) => jsBackingMapOrJsCopy(props is UiProps ? props.props : props);

    TProps jsPropsToTProps(JsMap jsProps) => factory(JsBackedMap.backedBy(jsProps));

    T allowInteropWithArgCount<T extends Function>(T dartFunction, int count) {
      var interopFunction = allowInterop(dartFunction);
      js_util.callMethod(js_util.getProperty(window, 'Object'), 'defineProperty', [interopFunction, 'length', js_util.jsify({'value': count})]);
      return interopFunction;
    }

    JsMap handleMapStateToProps(ReactInteropValue jsState) {
      return jsMapFromProps(
        mapStateToProps(
          unwrapInteropValue(jsState) as TReduxState/*!*/,
        ),
      );
    }

    JsMap handleMapStateToPropsWithOwnProps(ReactInteropValue jsState, JsMap jsOwnProps) {
      return jsMapFromProps(
        mapStateToPropsWithOwnProps(
          unwrapInteropValue(jsState) as TReduxState/*!*/,
          jsPropsToTProps(jsOwnProps),
        ),
      );
    }

    JsMap Function(ReactInteropValue jsState) handleMakeMapStateToProps(ReactInteropValue initialJsState, JsMap initialJsOwnProps) {
      var mapToFactory = makeMapStateToProps(
        unwrapInteropValue(initialJsState) as TReduxState,
        jsPropsToTProps(initialJsOwnProps)
      );
      JsMap handleMakeMapStateToPropsFactory(ReactInteropValue jsState) {
        return jsMapFromProps(
          mapToFactory(
            unwrapInteropValue(jsState) as TReduxState/*!*/,
          ),
        );
      }
      return allowInteropWithArgCount(handleMakeMapStateToPropsFactory, 1);
    }

    JsMap Function(ReactInteropValue jsState, JsMap jsOwnProps) handleMakeMapStateToPropsWithOwnProps(ReactInteropValue initialJsState, JsMap initialJsOwnProps) {
      var mapToFactory = makeMapStateToPropsWithOwnProps(
        unwrapInteropValue(initialJsState) as TReduxState,
        jsPropsToTProps(initialJsOwnProps)
      );
      JsMap handleMakeMapStateToPropsWithOwnPropsFactory(ReactInteropValue jsState, JsMap jsOwnProps) {
        return jsMapFromProps(
          mapToFactory(
            unwrapInteropValue(jsState) as TReduxState/*!*/,
            jsPropsToTProps(jsOwnProps),
          ),
        );
      }
      return allowInteropWithArgCount(handleMakeMapStateToPropsWithOwnPropsFactory, 2);
    }

    JsMap handleMapDispatchToProps(Dispatcher dispatch) {
      return jsMapFromProps(
        mapDispatchToProps(dispatch),
      );
    }

    JsMap handleMapDispatchToPropsWithOwnProps(Dispatcher dispatch, JsMap jsOwnProps) {
      return jsMapFromProps(
        mapDispatchToPropsWithOwnProps(
          dispatch,
          jsPropsToTProps(jsOwnProps),
        )
      );
    }

    JsMap Function(Dispatcher dispatch) handleMakeMapDispatchToProps(Dispatcher dispatch, JsMap initialJsOwnProps) {
      var mapToFactory = makeMapDispatchToProps(
        dispatch,
        jsPropsToTProps(initialJsOwnProps)
      );
      JsMap handleMakeMapDispatchToPropsFactory(Dispatcher dispatch) {
        return jsMapFromProps(
          mapToFactory(
            dispatch,
          ),
        );
      }
      return allowInteropWithArgCount(handleMakeMapDispatchToPropsFactory, 1);
    }

    JsMap Function(Dispatcher dispatch, JsMap jsOwnProps) handleMakeMapDispatchToPropsWithOwnProps(Dispatcher dispatch, JsMap initialJsOwnProps) {
      var mapToFactory = makeMapDispatchToPropsWithOwnProps(
        dispatch,
        jsPropsToTProps(initialJsOwnProps)
      );
      JsMap handleMakeMapDispatchToPropsWithOwnPropsFactory(Dispatcher dispatch, JsMap jsOwnProps) {
        return jsMapFromProps(
          mapToFactory(
            dispatch,
            jsPropsToTProps(jsOwnProps),
          ),
        );
      }
      return allowInteropWithArgCount(handleMakeMapDispatchToPropsWithOwnPropsFactory, 2);
    }

    JsMap handleMergeProps(JsMap jsStateProps, JsMap jsDispatchProps, JsMap jsOwnProps) {
      return jsMapFromProps(
        mergeProps(
          jsPropsToTProps(jsStateProps),
          jsPropsToTProps(jsDispatchProps),
          jsPropsToTProps(jsOwnProps)
        )
      );
    }

    bool handleAreStatesEqual(ReactInteropValue jsNext, ReactInteropValue jsPrev) =>
        areStatesEqual(unwrapInteropValue(jsNext) as TReduxState, unwrapInteropValue(jsPrev) as TReduxState);

    bool handleAreOwnPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areOwnPropsEqual(jsPropsToTProps(jsNext), jsPropsToTProps(jsPrev));

    bool handleAreStatePropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areStatePropsEqual(jsPropsToTProps(jsNext), jsPropsToTProps(jsPrev));

    bool handleAreMergedPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areMergedPropsEqual(jsPropsToTProps(jsNext), jsPropsToTProps(jsPrev));

    final connectOptions = JsConnectOptions(
      forwardRef: forwardRef,
      pure: pure,
      context: context?.jsThis ?? JsReactRedux.ReactReduxContext,
    );
    // These can't be `null` in the JS object, so we conditionally define them
    // so they won't exist in the object if we don't want to specify them.
    if (areStatesEqual != null) {
      connectOptions.areStatesEqual = allowInterop(handleAreStatesEqual);
    }
    if (areOwnPropsEqual != null) {
      connectOptions.areOwnPropsEqual = allowInterop(handleAreOwnPropsEqual);
    }
    if (areStatePropsEqual != null) {
      connectOptions.areStatePropsEqual = allowInterop(handleAreStatePropsEqual);
    }
    if (areMergedPropsEqual != null) {
      connectOptions.areMergedPropsEqual = allowInterop(handleAreMergedPropsEqual);
    }

    // return typed as dynamic in case we ever want to allow for the object based syntax
    Function interopMapStateToPropsHandler() {
      if (mapStateToProps != null) {
        return allowInteropWithArgCount(handleMapStateToProps, 1);
      }
      if (mapStateToPropsWithOwnProps != null) {
        return allowInteropWithArgCount(handleMapStateToPropsWithOwnProps, 2);
      }
      if (makeMapStateToProps != null) {
        return allowInteropWithArgCount(handleMakeMapStateToProps, 2);
      }
      if (makeMapStateToPropsWithOwnProps != null) {
        return allowInteropWithArgCount(handleMakeMapStateToPropsWithOwnProps, 2);
      }
      return null;
    }

    // return typed as dynamic in case we ever want to allow for the object based syntax
    Function interopMapDispatchToPropsHandler() {
      if (mapDispatchToProps != null) {
        return allowInteropWithArgCount(handleMapDispatchToProps, 1);
      }
      if (mapDispatchToPropsWithOwnProps != null) {
        return allowInteropWithArgCount(handleMapDispatchToPropsWithOwnProps, 2);
      }
      if (makeMapDispatchToProps != null) {
        return allowInteropWithArgCount(handleMakeMapDispatchToProps, 2);
      }
      if (makeMapDispatchToPropsWithOwnProps != null) {
        return allowInteropWithArgCount(handleMakeMapDispatchToPropsWithOwnProps, 2);
      }
      return null;
    }

    final hoc = mockableJsConnect(
      interopMapStateToPropsHandler(),
      interopMapDispatchToPropsHandler(),
      mergeProps != null ? allowInterop(handleMergeProps) : null,
      connectOptions,
    )(dartComponentClass as ReactClass);

    /// Use a Dart proxy instead of a JS one since we're treating it like a Dart component:
    /// props values should be passed to the underlying component (e.g., those returned by mapStateToProps)
    /// without any conversion needed by JS Components, and props are are fed directly
    /// into Dart code (e.g., those passed into mapStateToPropsWithOwnProps/areOwnPropsEqual)
    /// without needing unwrapping/conversion.
    final hocFactoryProxy = ReactDartComponentFactoryProxy2(hoc);
    setComponentTypeMeta(hocFactoryProxy.type, isHoc: true, parentType: dartComponentFactory.type);

    TProps connectedFactory([Map props]) {
      return (factory(props)..componentFactory = hocFactoryProxy);
    }

    return connectedFactory;
  }

  return wrapWithConnect;
}

@JS('ReactRedux.connect')
external ReactClass Function(ReactClass/*!*/) _jsConnect(
    [
      /* JsMap Function(dynamic state, [JsMap ownProps]) | JsMap Function(dynamic state, [JsMap ownProps]) Function(dynamic state, [JsMap ownProps]) */ Function mapStateToProps,
      /* JsMap Function(dynamic dispatch, [JsMap ownProps]) | JsMap */ dynamic mapDispatchToProps,
      /* Function(JsMap stateProps, JsMap dispatchProps, JsMap ownProps) */ Function mergeProps,
      JsConnectOptions options,
    ]
  );

@visibleForTesting
ReactClass Function(ReactClass/*!*/) Function(
    [
      Function mapStateToProps,
      dynamic mapDispatchToProps,
      Function mergeProps,
      JsConnectOptions options,
    ]
  ) mockableJsConnect = _jsConnect;

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
class ReduxProviderProps extends builder_helpers.UiProps {
  ReduxProviderProps([Map props]) : this.props = props ?? JsBackedMap();

  @override
  final Map props;

  @override
  ReactComponentFactoryProxy get componentFactory => ReactJsReactReduxComponentFactoryProxy(JsReactRedux.Provider, isProvider: true);

  @override
  String get propKeyNamespace => '';

  @override
  bool get $isClassGenerated => true;

  /// The __single__ Redux store in your application.
  Store get store => props['store'] as Store;

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
UiFactory<ReduxProviderProps> ReduxProvider = ([map]) => ReduxProviderProps(map); // ignore: prefer_function_declarations_over_variables

class ReactJsReactReduxComponentFactoryProxy extends ReactJsContextComponentFactoryProxy {
  ReactJsReactReduxComponentFactoryProxy(
    ReactClass jsClass, {
    bool shouldConvertDomProps = true,
    bool isConsumer = false,
    bool isProvider = false,
  }) : super(jsClass, isProvider: isProvider, isConsumer: isConsumer, shouldConvertDomProps: shouldConvertDomProps);

  @override
  ReactElement build(Map props, [List childrenArgs = const []]) {
    return super.build(_generateReduxJsProps(props), childrenArgs);
  }

  /// Returns a JsBackedMap version of the specified [props], preprocessed for consumption by react-redux.
  Map _generateReduxJsProps(Map props) {
    JsBackedMap propsForJs = JsBackedMap.from(props);

    if (propsForJs['store'] != null) {
      propsForJs['store'] = _reduxifyStore(propsForJs['store'] as Store);
    }

    if (propsForJs['context'] != null) {
      propsForJs['context'] = propsForJs['context'].jsThis;
    }

    return propsForJs;
  }
}

/// Converts a Redux.dart [Store] into a Javascript object formatted for consumption by react-redux.
JsReactReduxStore _reduxifyStore(Store/*!*/ store) {
  // Memoize this so that the same ReactInteropValue instances will be used
  // for a given state, allowing JS `===` checks to not fail when the same
  // state object is passed.
  final memoizedWrapInteropValue = imemo1(wrapInteropValue);

  return JsReactReduxStore(
    getState: allowInterop(() {
      return memoizedWrapInteropValue(store.state);
    }),
    subscribe: allowInterop((cb) {
      return allowInterop(store.onChange.listen((_){cb();}).cancel);
    }),
    dispatch: allowInterop((action) {
      store.dispatch(action);
    }),
    dartStore: store,
  );
}

@JS()
@anonymous
class JsReactReduxStore {
  /// The Dart Redux `Store` instance.
  ///
  /// Set once within [_reduxifyStore], and should only be used internally.
  ///
  /// > See: `createStoreHook` / `useStore`.
  external Store get dartStore;

  external factory JsReactReduxStore({
    ReactInteropValue Function()/*!*/ getState,
    Dispatcher/*!*/ dispatch,
    Function Function(Function)/*!*/ subscribe,
    Store/*!*/ dartStore,
  });
}

@visibleForTesting
@JS()
@anonymous
class JsConnectOptions {
    external set areStatesEqual(bool Function(ReactInteropValue, ReactInteropValue) value);
    external set areOwnPropsEqual(bool Function(JsMap, JsMap) value);
    external set areStatePropsEqual(bool Function(JsMap, JsMap) value);
    external set areMergedPropsEqual(bool Function(JsMap, JsMap) value);
    external set forwardRef(bool value);
    external set pure(bool value);
    external set context(ReactContext value);
    external bool Function(ReactInteropValue, ReactInteropValue)/*?*/ get areStatesEqual;
    external bool Function(JsMap, JsMap)/*?*/ get areOwnPropsEqual;
    external bool Function(JsMap, JsMap)/*?*/ get areStatePropsEqual;
    external bool Function(JsMap, JsMap)/*?*/ get areMergedPropsEqual;
    external bool/*?*/ get forwardRef;
    external bool/*?*/ get pure;
    external ReactContext/*?*/ get context;
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
// TODO null-safety note: I removed the cast here so the null-safety tool could infer things better
dynamic unwrapInteropValue(ReactInteropValue value) {
  return value.value;
}

/// A helper function that wraps a [value] in a [ReactInteropValue].
ReactInteropValue wrapInteropValue(dynamic value) {
  return ReactInteropValue()..value = value;
}
