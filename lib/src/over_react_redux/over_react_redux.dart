@JS()
library over_react_redux;

import 'package:meta/meta.dart';
////////////////////////////////////////////////////////////////////////////////
//
// over_react_redux
//
////////////////////////////////////////////////////////////////////////////////
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart' as builder_helpers;
import 'package:collection/collection.dart';
import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:redux/redux.dart';



part 'over_react_redux.over_react.g.dart';

@PropsMixin(keyNamespace: '')
abstract class _$ConnectPropsMixin {
  Map get props;
  void Function(dynamic action) dispatch;
}

/// A wrapper around the JS react-redux `connect` function that supports OverReact components.
///
/// __Example:__
///
///     UiFactory<CounterProps> ConnectedCounter = connect<CounterState, CounterProps>(
///         mapStateToProps: (state) => (
///           Counter()..intProp = state.count
///         ),
///         mapDispatchToProps: (dispatch) => (
///           Counter()..increment = () => dispatch(INCREMENT_ACTION())
///         ),
///     )(Counter);
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
/// [context] is how you can utilize multiple stores. If you must, it is not reccomended. :P
///
/// __Example:__
///
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
UiFactory<TProps> Function(UiFactory<TProps>) connect<TReduxState, TProps extends UiProps>({
  Map Function(TReduxState state) mapStateToProps,
  Map Function(TReduxState state, TProps ownProps) mapStateToPropsWithOwnProps,
  Map Function(dynamic Function(dynamic) dispatch) mapDispatchToProps,
  Map Function(dynamic Function(dynamic) dispatch, TProps ownProps) mapDispatchToPropsWithOwnProps,
  Map Function(TProps stateProps, TProps dispatchProps, TProps ownProps) mergeProps,
  bool Function(TReduxState next, TReduxState prev) areStatesEqual,
  bool Function(TProps next, TProps prev) areOwnPropsEqual,
  bool Function(TProps next, TProps prev) areStatePropsEqual,
  bool Function(TProps next, TProps prev) areMergedPropsEqual,
  Context context,
  bool pure: true,
  bool forwardRef: false,
}) {
  areStatesEqual ??= _defaultEquality;
  areOwnPropsEqual ??= _shallowMapEquality;
  areStatePropsEqual ??= _shallowMapEquality;
  areMergedPropsEqual ??= _shallowMapEquality;

  UiFactory<TProps> wrapWithConnect(UiFactory<TProps> factory) {
    final dartComponentClass = (factory().componentFactory as ReactDartComponentFactoryProxy).reactClass;

    JsMap handleMapStateToProps(ReactInteropValue jsState) {
      final state = unwrapInteropValue(jsState);

      var result = mapStateToProps(state);
      // Pull out the underlying backing map to avoid copying where possible
      if (result is UiProps) result = (result as UiProps).props;
      return jsBackingMapOrJsCopy(result);
    }

    JsMap handleMapStateToPropsWithOwnProps(ReactInteropValue jsState, JsMap jsOwnProps) {
      final state = unwrapInteropValue(jsState);
      final ownProps = factory(new JsBackedMap.backedBy(jsOwnProps));

      var result = mapStateToPropsWithOwnProps(state, ownProps);
      // Pull out the underlying backing map to avoid copying where possible
      if (result is UiProps) result = (result as UiProps).props;
      return jsBackingMapOrJsCopy(result);
    }

    JsMap handleMapDispatchToProps(Function dispatch) {
      var result = mapDispatchToProps(dispatch);

      // Pull out the underlying backing map to avoid copying where possible
      if (result is UiProps) result = (result as UiProps).props;
      return jsBackingMapOrJsCopy(result);
    }

    JsMap handleMapDispatchToPropsWithOwnProps(Function dispatch, JsMap jsOwnProps) {
      final ownProps = factory(new JsBackedMap.backedBy(jsOwnProps));
      var result = mapDispatchToPropsWithOwnProps(dispatch, ownProps);

      // Pull out the underlying backing map to avoid copying where possible
      if (result is UiProps) result = (result as UiProps).props;
      return jsBackingMapOrJsCopy(result);
    }

    JsMap handleMergeProps(JsMap jsStateProps, JsMap jsDispatchProps, JsMap jsOwnProps) {
      final stateProps = factory(new JsBackedMap.backedBy(jsStateProps));
      final dispatchProps = factory(new JsBackedMap.backedBy(jsDispatchProps));
      final ownProps = factory(new JsBackedMap.backedBy(jsOwnProps));
      var result = mergeProps(stateProps, dispatchProps, ownProps);

      // Pull out the underlying backing map to avoid copying where possible
      if (result is UiProps) result = (result as UiProps).props;
      return jsBackingMapOrJsCopy(result);
    }

    bool handleAreStatesEqual(ReactInteropValue jsNext, ReactInteropValue jsPrev) =>
        areStatesEqual(unwrapInteropValue(jsNext), unwrapInteropValue(jsPrev));

    bool handleAreOwnPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areOwnPropsEqual(factory(new JsBackedMap.backedBy(jsNext)), factory(new JsBackedMap.backedBy(jsPrev)));

    bool handleAreStatePropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areStatePropsEqual(factory(new JsBackedMap.backedBy(jsNext)), factory(new JsBackedMap.backedBy(jsPrev)));

    bool handleAreMergedPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areMergedPropsEqual(factory(new JsBackedMap.backedBy(jsNext)), factory(new JsBackedMap.backedBy(jsPrev)));

    final hoc = mockableJsConnect(
      mapStateToProps != null ? allowInterop(handleMapStateToProps) : mapStateToPropsWithOwnProps != null ? allowInterop(handleMapStateToPropsWithOwnProps) : null,
      mapDispatchToProps != null ? allowInterop(handleMapDispatchToProps) : mapDispatchToPropsWithOwnProps != null ? allowInterop(handleMapDispatchToPropsWithOwnProps) : null,
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

    final hocJsFactoryProxy = new ReactJsComponentFactoryProxy(hoc, shouldConvertDomProps: false, alwaysReturnChildrenAsList: true);

    TProps connectedFactory([Map props]) {
      return (factory(props)..componentFactory = hocJsFactoryProxy);
    }

    return connectedFactory;
  }

  return wrapWithConnect;
}

bool _defaultEquality(Object a, Object b) => a == b;
bool _shallowMapEquality(Object a, Object b) => const MapEquality().equals(a, b);

@JS('ReactRedux.connect')
external ReactClass Function(ReactClass) _jsConnect(
    [
      Function mapStateToProps,
      dynamic mapDispatchToProps,
      dynamic mergeProps,
      JsConnectOptions options,
    ]
  );

@visibleForTesting
ReactClass Function(ReactClass) Function(
    [
      Function mapStateToProps,
      dynamic mapDispatchToProps,
      dynamic mergeProps,
      JsConnectOptions options,
    ]
  ) mockableJsConnect = _jsConnect;

@JS('ReactRedux')
class JsReactRedux {
  external static ReactClass get Provider;
  external static ReactContext get ReactReduxContext;
}

class ReduxProviderProps extends component_base.UiProps
    with
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  ReduxProviderProps([Map props]) : this.props = props ?? new JsBackedMap();

  @override
  final Map props;

  @override
  ReactComponentFactoryProxy get componentFactory => ReactJsReactReduxComponentFactoryProxy(JsReactRedux.Provider, isProvider: true);

  @override
  String get propKeyNamespace => '';

  Store get store => props['store'];
  set store(Store v) => props['store'] = v;

  dynamic get context => props['context'];
  set context(dynamic v) => props['context'] = v;
}

UiFactory<ReduxProviderProps> ReduxProvider = ([Map map]) => new ReduxProviderProps(map);

class ReactJsReactReduxComponentFactoryProxy extends ReactJsContextComponentFactoryProxy {
  /// The JS class used by this factory.
  @override
  final ReactClass type;

  @override
  final Function factory;

  @override
  final bool shouldConvertDomProps;

  @override
  final bool isConsumer;

  @override
  final bool isProvider;

  ReactJsReactReduxComponentFactoryProxy(
    ReactClass jsClass, {
    this.shouldConvertDomProps: true,
    this.isConsumer: false,
    this.isProvider: false,
  }) : this.type = jsClass,
        this.factory = React.createFactory(jsClass),
        super(jsClass, isProvider: isProvider, isConsumer: isConsumer, shouldConvertDomProps: shouldConvertDomProps);

  @override
  ReactElement build(Map props, [List childrenArgs]) {
    return super.build(_generateReduxJsProps(props), childrenArgs);
  }

  /// Returns a JavaScript version of the specified [props], preprocessed for consumption by ReactJS and prepared for
  /// consumption by the [react] library internals.
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

_reduxifyStore(Store store){
  return JsReactReduxStore(
    getState: allowInterop(() {
      return wrapInteropValue(store.state);
    }),
    subscribe: allowInterop((cb) {
        return allowInterop(store.onChange.listen((_){cb();}).cancel);
    }),
    dispatch: allowInterop((action) {
      store.dispatch(action);
    })
  );
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

dynamic _convertArgsToChildren(List childrenArgs) {
  if (childrenArgs.isEmpty) {
    return null;
  } else if (childrenArgs.length == 1) {
    return childrenArgs.single;
  } else {
    markChildrenValidated(childrenArgs);
    return childrenArgs;
  }
}

@visibleForTesting
@JS()
@anonymous
class JsConnectOptions {
    bool Function(ReactInteropValue, ReactInteropValue) areStatesEqual;
    bool Function(JsMap, JsMap) areOwnPropsEqual;
    bool Function(JsMap, JsMap) areStatePropsEqual;
    bool Function(JsMap, JsMap) areMergedPropsEqual;
    bool forwardRef;
    bool pure;
    ReactContext context;
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

class ReactInteropValue {
  var value;
}

T unwrapInteropValue<T>(ReactInteropValue value) {
  return value.value;
}

ReactInteropValue wrapInteropValue(dynamic value) {
  return new ReactInteropValue()..value = value;
}
