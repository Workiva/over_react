@JS()
library over_react_redux;
////////////////////////////////////////////////////////////////////////////////
//
// over_react_redux
//
////////////////////////////////////////////////////////////////////////////////
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart' as builder_helpers;
import 'package:collection/collection.dart';
import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:redux/redux.dart';

mixin ConnectProps {
  void Function(dynamic action) dispatch;
}

/// A wrapper around the JS react-redux `connect` function that supports OverReact components.
///
/// [connect]: https://react-redux.js.org/api/connect#connect
Function(UiFactory<TProps>) connect<TReduxState, TProps extends UiProps>({
  @required Map Function(TReduxState state, Map ownProps) mapStateToProps,
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

  wrapWithConnect(UiFactory<TProps> factory) {
    final dartComponentClass = (factory().componentFactory as ReactDartComponentFactoryProxy).reactClass;

    JsMap handleMapStateToProps(ReactInteropValue jsState, JsMap jsOwnProps) {
      final state = unwrapInteropValue(jsState);
      final ownProps = new JsBackedMap.backedBy(jsOwnProps);

      var result = mapStateToProps(state, ownProps);
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
      allowInterop(handleMapStateToProps),
      // TODO mapDispatchToProps needs unwrapping?
      null,
      null,
      new _JsConnectOptions(
        areStatesEqual: allowInterop(handleAreStatesEqual),
        areOwnPropsEqual: allowInterop(handleAreOwnPropsEqual),
        areStatePropsEqual: allowInterop(handleAreStatePropsEqual),
        areMergedPropsEqual: allowInterop(handleAreMergedPropsEqual),
        // If these are null, will connect use its own defaults? If not, need to default these above.
        forwardRef: forwardRef,
        // If these are null, will connect use its own defaults? If not, need to default these above.
        context: context,
      ),
    )(dartComponentClass);

    final hocJsFactoryProxy = new ReactJsComponentFactoryProxy(hoc, shouldConvertDomProps: false);

    ReduxProps connectedFactory([Map props]) {


      return ReduxProps(hocJsFactoryProxy, props);

      /// TODO: Remove this line if it is not needed.
      /// return factory(props).componentFactory = hocJsFactoryProxy;
    }

    return connectedFactory;
  }

  return wrapWithConnect;
}

bool _defaultEquality(Object a, Object b) => a == b;
bool _shallowMapEquality(Object a, Object b) => const MapEquality().equals(a, b);

class ReduxProps extends component_base.UiProps
    with
        ConnectProps,
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  ReduxProps(this.componentFactory, [Map props]) : this.props = props ?? new JsBackedMap();

  @override
  final ReactComponentFactoryProxy componentFactory;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';
}


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
class JsRedux {
  external static ReactClass get Provider;
}

var ReduxProvider = ReactJsReactReduxComponentFactoryProxy(JsRedux.Provider);

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

  return store;
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

class ReactInteropValue {}
T unwrapInteropValue<T>(ReactInteropValue value) { /* ... */ }
ReactInteropValue wrapInteropValue(dynamic value) { /* ... */ }

// TODO wrap ReactReduxContext or whatever it is

