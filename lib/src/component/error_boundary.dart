import 'dart:html';
import 'dart:js_util' as js_util;

import 'package:js/js.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart' show React, ReactClassConfig, throwErrorFromJS;

part 'error_boundary.over_react.g.dart';

/// A __temporary, private JS component for use only by [ErrorBoundary]__ that utilizes its own lightweight
/// JS interop to make use of the ReactJS 16 `componentDidCatch` lifecycle method to prevent consumer
/// react component trees from unmounting as a result of child component errors being "uncaught".
///
/// > __Why this is here__
/// >
/// > In order to release react-dart 5.0.0 _(which upgrades to ReactJS 16)_
///   without depending on Dart 2 / `Component2` (coming in react-dart 5.1.0) / `UiComponent2` (coming in over_react 3.1.0) -
///   and all the new lifecycle methods that those expose, we need to ensure that - at a minimum - the `componentDidCatch`
///   lifecycle method is handled by components wrapped in our [ErrorBoundary] component so that the behavior of
///   an application when a component within a tree throws - is the same as it was when using ReactJS 15.
/// >
/// > Otherwise, the update to react-dart 5.0.0 / over_react 3.0.0 will result in consumer apps rendering completely
///   "blank" screens when their trees unmount as a result of a child component throwing an error.
///   This would be unexpected, unwanted - and since we will not add a Dart js-interop layer around `componentDidCatch`
///   until react-dart 5.1.0 / over_react 3.1.0 - unmanageable for consumers.
///
/// __This will be removed in over_react 3.1.0__ once [ErrorBoundaryComponent] is extending from `UiStatefulComponent2`
/// which will ensure that the [ErrorBoundaryComponent.componentDidCatch] lifecycle method has real js-interop bindings
/// via react-dart 5.1.0's `Component2` base class.
///
/// TODO: Remove in 3.1.0
final ReactElement Function([Map props, List children]) _jsErrorBoundaryComponentFactory = (() {
  var componentClass = React.createClass(jsifyAndAllowInterop({
    'displayName': 'JsErrorBoundary',
    'render': allowInteropCaptureThis((jsThis) {
      final jsProps = js_util.getProperty(jsThis, 'props');
      return js_util.getProperty(jsProps, 'children');
    }),
    'componentDidCatch': allowInteropCaptureThis((jsThis, error, info) {
      final jsProps = js_util.getProperty(jsThis, 'props');
      // Due to the error object being passed in from ReactJS it is a javascript object that does not get dartified.
      // To fix this we throw the error again from Dart to the JS side and catch it Dart side which re-dartifies it.
      try {
        throwErrorFromJS(error);
      } catch (error, stack) {
        final callback = js_util.getProperty(jsProps, 'onComponentDidCatch');

        if (callback != null) {
          callback(error, info);
        }
      }
    }),
  }));

  // Despite what the ReactJS docs say about only needing _either_ componentDidCatch or getDerivedStateFromError
  // in order to define an "error boundary" component, that is not actually the case.
  //
  // The tree will never get re-rendered after an error is caught unless both are defined.
  // ignore: argument_type_not_assignable
  js_util.setProperty(componentClass, 'getDerivedStateFromError', allowInterop((_) => js_util.newObject()));

  var reactFactory = React.createFactory(componentClass);

  return ([Map props = const {}, List children = const []]) {
    return reactFactory(jsifyAndAllowInterop(props), listifyChildren(children));
  };
})();

// TODO: Need to type the second argument once react-dart implements bindings for the ReactJS "componentStack".
typedef _ComponentDidCatchCallback(/*Error*/dynamic error, /*ComponentStack*/dynamic componentStack);

// TODO: Need to type the second argument once react-dart implements bindings for the ReactJS "componentStack".
typedef ReactElement _FallbackUiRenderer(/*Error*/dynamic error, /*ComponentStack*/dynamic componentStack);

/// A higher-order component that will catch ReactJS errors anywhere within the child component tree and
/// display a fallback UI instead of the component tree that crashed.
///
/// Optionally, use the [ErrorBoundaryProps.onComponentDidCatch]
/// to send error / stack trace information to a logging endpoint for your application.
///
/// > __NOTE: This component does not yet do any of this__.
/// >
/// > It will begin providing the boundary / fallback UI behavior once support
///   for ReactJS 16 is released in over_react version 3.0.0
@Factory()
UiFactory<ErrorBoundaryProps> ErrorBoundary = _$ErrorBoundary;

@Props()
class _$ErrorBoundaryProps extends UiProps {
  /// An optional callback that will be called with an [Error] and a `ComponentStack`
  /// containing information about which component in the tree threw the error when
  /// the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, componentStack) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, componentStack);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  _ComponentDidCatchCallback onComponentDidCatch;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Default: [ErrorBoundaryComponent._renderDefaultFallbackUI]
  _FallbackUiRenderer fallbackUIRenderer;
}

@State()
class _$ErrorBoundaryState extends UiState {
  /// Whether the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// When `true`, fallback UI will be rendered using [ErrorBoundaryProps.fallbackUIRenderer].
  bool hasError;
}

@Component(isWrapper: true)
class ErrorBoundaryComponent<T extends ErrorBoundaryProps, S extends ErrorBoundaryState>
    extends UiStatefulComponent<T, S> {
  Error _error;
  /*ComponentStack*/dynamic _componentStack;

  @override
  Map getDefaultProps() => (newProps()
    ..fallbackUIRenderer = _renderDefaultFallbackUI
  );

  @override
  Map getInitialState() => (newState()
    ..hasError = false
  );

  @mustCallSuper
  /*@override*/
  S getDerivedStateFromError(_) {
    return newState()..hasError = true;
  }

  @mustCallSuper
  /*@override*/
  void componentDidCatch(Error error, /*ComponentStack*/dynamic componentStack) {
    _error = error;
    _componentStack = componentStack;

    if (props.onComponentDidCatch != null) {
      props.onComponentDidCatch(error, componentStack);
    }
  }

  @override
  render() {
    // TODO: 3.1.0 - Remove the `_jsErrorBoundaryComponentFactory`, and restore just the children of it once this component is extending from `UiStatefulComponent2`.
    return _jsErrorBoundaryComponentFactory({
      'onComponentDidCatch': props.onComponentDidCatch
    },
      state.hasError
          ? [props.fallbackUIRenderer(_error, _componentStack)]
          : props.children
    );
  }

  ReactElement _renderDefaultFallbackUI(_, __) =>
      throw new UnimplementedError('Fallback UI will not be supported until support for ReactJS 16 lifecycle methods is released in version 3.1.0');

  @mustCallSuper
  @override
  void validateProps([Map appliedProps]) {
    super.validateProps(appliedProps);
    final children = domProps(appliedProps).children;

    if (children.length != 1) {
      throw new PropError.value(children, 'children', 'ErrorBoundary accepts only a single child.');
    } else if (!isValidElement(children.single)) {
      throw new PropError.value(children, 'children', 'ErrorBoundary accepts only a single ReactComponent child.');
    }
  }
}
