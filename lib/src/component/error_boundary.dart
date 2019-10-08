import 'dart:async';
import 'dart:js_util' as js_util;
import 'dart:js_util';

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

// TODO: Need to type the second argument once react-dart implements bindings for the ReactJS "errorInfo".
typedef _ComponentDidCatchCallback(/*Error||Exception*/dynamic error, /*ComponentStack*/dynamic errorInfo);

// TODO: Need to type the second argument once react-dart implements bindings for the ReactJS "errorInfo".
typedef ReactElement _FallbackUiRenderer(/*Error||Exception*/dynamic error, /*ComponentStack*/dynamic errorInfo);

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
  /// An optional callback that will be called with an [Error] _(or [Exception])_
  /// and `errorInfo` containing information about which component in the tree
  /// threw when the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, errorInfo) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, errorInfo);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  ///
  /// > Related: [onComponentIsUnrecoverable]
  _ComponentDidCatchCallback onComponentDidCatch;

  /// An optional callback that will be called _(when [fallbackUIRenderer] is not set)_
  /// with an [Error] _(or [Exception])_ and `errorInfo` containing information about which component in
  /// the tree threw multiple consecutive errors/exceptions frequently enough that it has the potential
  /// to lock the main thread.
  ///
  /// The locking of the main thread is possible in this scenario because when [fallbackUIRenderer]
  /// is not set, the [ErrorBoundary] simply re-mounts the child when an error occurs to try to "recover" automatically.
  /// However, if multiple identical errors are thrown from the exact same component in the tree - every time
  /// the [ErrorBoundary] re-mounts the tree, a sort of "infinite loop" will occur.
  ///
  /// When this callback is called, the tree wrapped by this [ErrorBoundary] has "crashed" - and is completely
  /// non-functional. Instead of re-mounting the component tree, the [ErrorBoundary] will simply render a
  /// static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// Once this happens, regaining interactivity within the tree wrapped by this [ErrorBoundary] is possible by:
  ///
  /// 1. Passing in a new child
  ///   _(preferably one that will not repeatedly throw errors when the [ErrorBoundary] mounts it)_.
  /// 2. Calling [ErrorBoundaryComponent.reset].
  ///
  /// > Will never be called when [fallbackUIRenderer] is set.
  ///
  /// > Related: [identicalErrorFrequencyTolerance]
  _ComponentDidCatchCallback onComponentIsUnrecoverable;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  _FallbackUiRenderer fallbackUIRenderer;

  /// The amount of time that is "acceptable" between consecutive identical errors thrown from a component
  /// within the tree wrapped by this [ErrorBoundary].
  ///
  /// If [fallbackUIRenderer] is not set, and more than one identical error is thrown consecutively by
  /// the exact same component anywhere within the tree wrapped by this [ErrorBoundary] -- more often than
  /// the specified duration -- the [ErrorBoundary] will:
  ///
  ///   1. Call [onComponentIsUnrecoverable].
  ///   2. Stop attempting to re-mount the tree (to protect the main thread from being locked up).
  ///   3. Render a static copy of the render tree's HTML that was captured at the time of the error.
  ///
  /// When this happens, recovery can only occur by passing in a new child to
  /// the [ErrorBoundary], or by calling [ErrorBoundaryComponent.reset].
  ///
  /// __DO NOT MODIFY THIS VALUE UNLESS YOU KNOW WHAT YOU ARE DOING.__
  ///
  /// > Default: `const Duration(seconds: 5)`
  Duration identicalErrorFrequencyTolerance;
}

@State()
class _$ErrorBoundaryState extends UiState {
  /// Whether a component within the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is set, the return value of that callback
  ///   will be rendered instead.
  /// * When `true`, and [ErrorBoundaryProps.fallbackUIRenderer] is not set, the [ErrorBoundary] will re-mount
  ///   the tree to attempt to automatically recover from the error.
  ///
  ///   If an identical error is thrown from an identical component within the tree consecutively
  ///   more frequently than [ErrorBoundaryProps.identicalErrorFrequencyTolerance], a static copy of
  ///   the render tree's HTML that was captured at the time of the error will be rendered.
  ///   See: [ErrorBoundaryProps.onComponentIsUnrecoverable] for more information about this scenario.
  bool hasError;

  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryProps.fallbackUIRenderer] is non-null.
  bool showFallbackUIOnError;
}

@Component(isWrapper: true)
class ErrorBoundaryComponent<T extends ErrorBoundaryProps, S extends ErrorBoundaryState>
    extends UiStatefulComponent<T, S> {
  @override
  Map getDefaultProps() => (newProps()
    ..identicalErrorFrequencyTolerance = Duration(seconds: 5)
  );

  @override
  Map getInitialState() => (newState()
    ..hasError = false
    ..showFallbackUIOnError = props.fallbackUIRenderer != null
  );

  @mustCallSuper
  /*@override*/
  S getDerivedStateFromError(_) {
    return newState()..hasError = true;
  }

  @mustCallSuper
  /*@override*/
  void componentDidCatch(/*Error||Exception*/dynamic error, /*NativeJavascriptObject*/dynamic jsErrorInfo) {
    if (props.onComponentDidCatch != null) {
      props.onComponentDidCatch(error, _getReadableErrorInfo(jsErrorInfo));
    }

    _handleErrorInComponentTree(error, jsErrorInfo);
  }

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState) {
    // If the child is different, and the error boundary is currently in an error state,
    // give the child a chance to remount itself and "recover" from the previous error.
    if (state.hasError) {
      final childThatCausedError = typedPropsFactory(prevProps).children.single;
      if (childThatCausedError != props.children.single) {
        reset();
      }
    }
  }

  @override
  render() {
    // TODO: 3.1.0 - Remove the `_jsErrorBoundaryComponentFactory`, and restore just the children of it once this component is extending from `UiStatefulComponent2`.
    return _jsErrorBoundaryComponentFactory({
      'onComponentDidCatch': componentDidCatch,
    },
      state.hasError && state.showFallbackUIOnError
          ? [(props.fallbackUIRenderer ?? _renderStringDomAfterUnrecoverableErrors)(_lastError, _lastErrorInfo)]
          : props.children
    );
  }

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

  /// Resets the [ErrorBoundary] to a non-error state.
  ///
  /// This can be called manually on the component instance using a `ref` -
  /// or by passing in a new child instance after a child has thrown an error.
  void reset() {
    _resetInternalErrorTracking();

    setState(newState()
      ..hasError = false
      ..showFallbackUIOnError = props.fallbackUIRenderer != null
    );
  }

  // ---------------------------------------------- \/ ----------------------------------------------
  // Wrapped Component Error Handling
  //
  // [1] If the consumer has defined a fallback UI, put the boundary into an error state and move on
  //     since their fallbackUI renderer will take care of the visuals.
  //
  //     [1.1] Store the error on some instance fields so it can be
  //           passed to the consumer's `fallbackUIRenderer` callback within `render`.
  //
  // [2] Otherwise, we can't currently make any assumptions about what the consumer would like to have
  //     rendered as a fallback when a component throws - so we just remount the children
  //     as a result of keeping `state.showFallbackUIOnError` set to false.
  //
  //     [2.1] However, as a way to handle the edge case where the exact same component wrapped by an
  //           `ErrorBoundary` throws the exact same error more than once before the `_identicalErrorTimer`
  //           "times out", we should not just keep remounting since the component
  //           should - at that point - be considered "unrecoverable",
  //           and the repeated errors will most likely lock up the main thread.
  //
  //     [2.2] So we'll set `state.showFallbackUIOnError` to true, which will cause our default fallback UI
  //           to be rendered - which is simply a String snapshot of the DOM (`_domAtTimeOfError`).
  //
  //           [2.2.1] We will also fire `props.onComponentIsUnrecoverable` if set - to give the
  //                   consumer the ability to have knowledge of the unrecoverable error state - and
  //                   to optionally manually recover from the error by:
  //
  //                   1. Passing in a new child (see: componentDidUpdate)
  //                   2. Calling the `reset()` instance method
  //
  //           [2.2.2] Since we should __never__ throw an error from our... uh... error boundary,
  //                   wrap in a try catch just in case `findDomNode` throws as a result of the
  //                   wrapped react tree rendering a string instead of a composite or dom component.
  // ---------------------------------------------- /\ ----------------------------------------------

  String _domAtTimeOfError;
  /*Error||Exception*/dynamic _lastError;
  String _lastErrorInfo;
  Timer _identicalErrorTimer;

  /// Called by [componentDidCatch].
  void _handleErrorInComponentTree(/*Error||Exception*/dynamic error, /*NativeJavascriptObject*/dynamic jsErrorInfo) {
    // ----- [1] ----- //
    if (props.fallbackUIRenderer != null) {
      _lastError = error; // [1.1]
      _lastErrorInfo = _getReadableErrorInfo(jsErrorInfo); // [1.1]

      setState(newState()..hasError = true); // [1]
      return;
    }
    // ----- [2] ----- //
    else {
      bool sameErrorWasThrownTwiceConsecutively =
          error.toString() == _lastError?.toString() && _getReadableErrorInfo(jsErrorInfo) == _lastErrorInfo;

      if (sameErrorWasThrownTwiceConsecutively) { // [2.1]
        try { // [2.2.2]
          _domAtTimeOfError = findDomNode(this)?.innerHtml; // [2.2]
        } catch (_) {}

        if (props.onComponentIsUnrecoverable != null) { // [2.2.1]
          props.onComponentIsUnrecoverable(error, _getReadableErrorInfo(jsErrorInfo));
        }
      } else {
        _lastError = error;
        _lastErrorInfo = _getReadableErrorInfo(jsErrorInfo);
      }

      setState(newState()
        ..hasError = true
        ..showFallbackUIOnError = sameErrorWasThrownTwiceConsecutively // [2.2]
      );

      _startIdenticalErrorTimer();
    }
  }

  // [2.2]
  ReactElement _renderStringDomAfterUnrecoverableErrors(_, __) {
    return (Dom.div()
      ..key = 'ohnoes'
      ..addTestId('ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode')
      ..['dangerouslySetInnerHTML'] = {'__html': _domAtTimeOfError} ?? ''
    )();
  }

  /// Called via [componentDidCatch] to start a `Timer` that will nullify the [_lastError] and [_lastErrorInfo]
  /// internal fields that keep track of the last error thrown.
  ///
  /// If an identical error is thrown by an identical child component twice in a row:
  ///
  /// * __Before the timer's callback fires__ - internal component logic will treat the second error
  ///   as an unrecoverable one that has the potential to lock the main thread.
  /// * __After the timer's callback fires__ - internal component logic will NOT treat the second error
  ///   as an unrecoverable one.
  ///
  /// > Not used when [ErrorBoundaryProps.fallbackUIRenderer] is set.
  void _startIdenticalErrorTimer() {
    if (_identicalErrorTimer != null) return;

    _identicalErrorTimer = getManagedTimer(props.identicalErrorFrequencyTolerance, _resetInternalErrorTracking);
  }

  /// Resets all the internal fields used by [_handleErrorInComponentTree], and cancels
  /// any pending [_identicalErrorTimer] callbacks that would put the component
  /// into an "unrecoverable" error state.
  void _resetInternalErrorTracking() {
    _domAtTimeOfError = null;
    _lastError = null;
    _lastErrorInfo = null;
    _identicalErrorTimer?.cancel();
    _identicalErrorTimer = null;
  }

  /// Returns the single `componentStack` key value within the `errorInfo` passed from ReactJS
  /// so that its readable for Dart consumers instead of being `[Object object]`.
  ///
  /// Also used to determine if multiple consecutive identical errors
  /// were thrown by the exact same component within the tree.
  String _getReadableErrorInfo(/*NativeJavascriptObject*/dynamic jsErrorInfo) =>
      getProperty(jsErrorInfo, 'componentStack');
}
