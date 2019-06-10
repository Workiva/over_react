@JS()
library over_react_redux;

import 'dart:developer';

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
import 'package:redux/redux.dart';

part 'over_react_redux.over_react.g.dart';

@PropsMixin(keyNamespace: '')
abstract class _$ConnectPropsMixin {
  Map get props;
  void Function(dynamic action) dispatch;
}

/// A wrapper around the JS react-redux `connect` function that supports OverReact components.
///
/// [connect]: https://react-redux.js.org/api/connect#connect
UiFactory<TProps> Function(UiFactory<TProps>) connect<TReduxState, TProps extends UiProps>({
  Map Function(TReduxState state, Map ownProps) mapStateToProps,
  Map Function(Function dispatch, Map ownProps) mapDispatchToProps,
  bool Function(TReduxState next, TReduxState prev) areStatesEqual,
  bool Function(Map next, Map prev) areOwnPropsEqual,
  bool Function(Map next, Map prev) areStatePropsEqual,
  bool Function(Map next, Map prev) areMergedPropsEqual,
  ReactContext context,
  // Might not be able to support this
  //bool pure,
  bool forwardRef: false,
}) {
  areStatesEqual ??= _defaultEquality;
  areOwnPropsEqual ??= _shallowMapEquality;
  areStatePropsEqual ??= _shallowMapEquality;
  areMergedPropsEqual ??= _shallowMapEquality;

  UiFactory<TProps> wrapWithConnect(UiFactory<TProps> factory) {
    final dartComponentClass = (factory().componentFactory as ReactDartComponentFactoryProxy).reactClass;

    JsMap handleMapStateToProps(ReactInteropValue jsState, JsMap jsOwnProps) {
      final state = unwrapInteropValue(jsState);
      final ownProps = new JsBackedMap.backedBy(jsOwnProps);

      var result = mapStateToProps(state, ownProps);
      // Pull out the underlying backing map to avoid copying where possible
      if (result is UiProps) result = (result as UiProps).props;
      return jsBackingMapOrJsCopy(result);
    }

    JsMap handleMapDispatchToProps(Function dispatch, JsMap jsOwnProps) {
      final ownProps = new JsBackedMap.backedBy(jsOwnProps);

      var result = mapDispatchToProps(dispatch, ownProps);

      // Pull out the underlying backing map to avoid copying where possible
      if (result is UiProps) result = (result as UiProps).props;
      return jsBackingMapOrJsCopy(result);
    }

    bool handleAreStatesEqual(ReactInteropValue jsNext, ReactInteropValue jsPrev) =>
        areStatesEqual(unwrapInteropValue(jsNext), unwrapInteropValue(jsPrev));

    bool handleAreOwnPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areOwnPropsEqual(new JsBackedMap.backedBy(jsNext), new JsBackedMap.backedBy(jsPrev));

    bool handleAreStatePropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areStatePropsEqual(new JsBackedMap.backedBy(jsNext), new JsBackedMap.backedBy(jsPrev));

    bool handleAreMergedPropsEqual(JsMap jsNext, JsMap jsPrev) =>
        areMergedPropsEqual(new JsBackedMap.backedBy(jsNext), new JsBackedMap.backedBy(jsPrev));

    final hoc = _jsConnect(
      mapStateToProps != null ? allowInterop(handleMapStateToProps) : null,
      mapDispatchToProps != null ? allowInterop(handleMapDispatchToProps) : allowInterop((dispatch, _) { var val = new JsBackedMap(); val['dispatch'] = dispatch; return val.jsObject; }),
      null,
      new _JsConnectOptions(
        areStatesEqual: allowInterop(handleAreStatesEqual),
        areOwnPropsEqual: allowInterop(handleAreOwnPropsEqual),
        areStatePropsEqual: allowInterop(handleAreStatePropsEqual),
        areMergedPropsEqual: allowInterop(handleAreMergedPropsEqual),
        // If these are null, will connect use its own defaults? If not, need to default these above.
        forwardRef: forwardRef,
        // If these are null, will connect use its own defaults? If not, need to default these above.
        context: context ?? JsReactRedux.ReactReduxContext,
      ),
    )(dartComponentClass);

    final hocJsFactoryProxy = new ReactJsComponentFactoryProxy(hoc, shouldConvertDomProps: false);

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
    JsMap Function(ReactInteropValue, JsMap) mapStateToProps,
    [
      dynamic mapDispatchToProps,
      dynamic mergeProps,
      _JsConnectOptions options,
    ]
    );

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
  ReduxProviderProps(this.componentFactory, [Map props]) : this.props = props ?? new JsBackedMap();

  @override
  final ReactJsReactReduxComponentFactoryProxy componentFactory;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';

  Store get store => props['store'];
  set store(Store v) => props['store'] = v;
}

ReduxProvider() => new ReduxProviderProps(ReactJsReactReduxComponentFactoryProxy(JsReactRedux.Provider));

class ReactJsReactReduxComponentFactoryProxy extends ReactJsComponentFactoryProxy {
  /// The JS class used by this factory.
  @override
  final ReactClass type;
  final Function factory;
  final bool shouldConvertDomProps;

  ReactJsReactReduxComponentFactoryProxy(
    ReactClass jsClass, {
    this.shouldConvertDomProps: true,
  })  : this.type = jsClass,
        this.factory = React.createFactory(jsClass),
        super(jsClass, shouldConvertDomProps: shouldConvertDomProps);

  @override
  ReactElement build(Map props, [List childrenArgs]) {
    dynamic children = _convertArgsToChildren(childrenArgs);

    return factory(_generateReduxJsProps(props), children);
  }

  /// Returns a JavaScript version of the specified [props], preprocessed for consumption by ReactJS and prepared for
  /// consumption by the [react] library internals.
  JsMap _generateReduxJsProps(Map props) {
    JsBackedMap propsForJs = new JsBackedMap.from(props);

    propsForJs['store'] = _reduxifyStore(propsForJs['store']);

    return propsForJs.jsObject;
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
  JsReactReduxStore({
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

@JS()
@anonymous
class _JsConnectOptions {
  external factory _JsConnectOptions({
    bool Function(ReactInteropValue, ReactInteropValue) areStatesEqual,
    bool Function(JsMap, JsMap) areOwnPropsEqual,
    bool Function(JsMap, JsMap) areStatePropsEqual,
    bool Function(JsMap, JsMap) areMergedPropsEqual,
    bool forwardRef,
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


// TODO wrap ReactReduxContext or whatever it is

