////////////////////////////////////////////////////////////////////////////////
//
// over_react_redux
//
////////////////////////////////////////////////////////////////////////////////

import 'package:collection/collection.dart';
import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';

//@PropsMixin(keyNamespace: '')
//mixin ConnectProps on UiProps {
//  void Function(dynamic action) dispatch;
//}

/// A wrapper around the JS react-redux `connect` function that supports OverReact components.
///
/// [connect]: https://react-redux.js.org/api/connect#connect
UiFactory<TProps> Function(UiFactory<TProps>) connect<TReduxState, TProps extends UiProps>({
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

  UiFactory<TProps> wrapWithConnect(UiFactory<TProps> factory) {
    final dartComponentClass = (factory().componentFactory as ReactDartComponentFactoryProxy2).reactClass;

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

    TProps connectedFactory([Map props]) {
      return hocJsFactoryProxy(props);

      /// TODO: Remove this line if it is not needed.
      /// return factory(props).componentFactory = hocJsFactoryProxy;
    }

    return connectedFactory;
  }

  return wrapWithConnect;
}

bool _defaultEquality(Object a, Object b) => a == b;
bool _shallowMapEquality(Object a, Object b) => const MapEquality().equals(a, b);

@JS('connect')
external ReactClass Function(ReactClass) _jsConnect(
    JsMap Function(ReactInteropValue, JsMap) mapStateToProps,
    [
      dynamic mapDispatchToProps,
      dynamic mergeProps,
      _JsConnectOptions options,
    ]
    );

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
