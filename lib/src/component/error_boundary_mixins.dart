import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

part 'error_boundary_mixins.over_react.g.dart';

@visibleForTesting
const String defaultErrorBoundaryLoggerName = 'over_react.ErrorBoundary';

/// A props mixin you can use to implement / extend from the behaviors of an [ErrorBoundary]
/// within a custom component.
///
/// > See: [ErrorBoundaryMixin] for a usage example.
@PropsMixin()
abstract class _$ErrorBoundaryPropsMixin implements UiProps {
  @override
  Map get props;

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
  Function(/*Error||Exception*/dynamic error, ReactErrorInfo info) onComponentDidCatch;

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
  Function(/*Error||Exception*/dynamic error, ReactErrorInfo info) onComponentIsUnrecoverable;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ReactElement Function(/*Error||Exception*/dynamic error, ReactErrorInfo info) fallbackUIRenderer;

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

  /// The name to use when the component's logger logs an error via [ErrorBoundaryComponent.componentDidCatch].
  ///
  /// Not used if a custom [logger] is specified.
  ///
  /// > Default: 'over_react.ErrorBoundary'
  String loggerName;

  /// Whether errors caught by this [ErrorBoundary] should be logged using a [Logger].
  ///
  /// > Default: `true`
  bool shouldLogErrors;

  /// An optional custom logger instance that will be used to log errors caught by
  /// this [ErrorBoundary] when [shouldLogErrors] is true.
  Logger logger;
}

/// A state mixin you can use to implement / extend from the behaviors of an [ErrorBoundary]
/// within a custom component.
///
/// > See: [ErrorBoundaryMixin] for a usage example.
@StateMixin()
abstract class _$ErrorBoundaryStateMixin implements UiState {
  @override
  Map get state;

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

/// A component mixin you can use to implement / extend from the behaviors of an [ErrorBoundary]
/// within a custom component:
///
///     @Factory()
///     UiFactory<CustomErrorBoundaryProps> CustomErrorBoundary = _$CustomErrorBoundary;
///
///     @Props()
///     class _$CustomErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}
///
///     @State()
///     class _$CustomErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}
///
///     @Component2(isWrapper: true, isErrorBoundary: true)
///     class CustomErrorBoundaryComponent
///         extends UiStatefulComponent2<CustomErrorBoundaryProps, CustomErrorBoundaryState>
///         with ErrorBoundaryMixin<CustomErrorBoundaryProps, CustomErrorBoundaryState> {
///       // Your custom component implementation, complete with a custom fallback renderer UI
///       @override
///       Map get defaultProps => newProps()
///         ..fallbackUIRenderer = _renderFallbackUI;
///
///       ReactElement _renderFallbackUI() {
///         return Dom.h3()('Error!');
///       }
///     }
mixin ErrorBoundaryMixin<T extends ErrorBoundaryPropsMixin, S extends ErrorBoundaryStateMixin>
    on UiStatefulComponent2<T, S> {
  @override
  Map get defaultProps => (newProps()
    ..identicalErrorFrequencyTolerance = Duration(seconds: 5)
    ..loggerName = defaultErrorBoundaryLoggerName
    ..shouldLogErrors = true
  );

  @override
  Map get initialState => (newState()
    ..hasError = false
    ..showFallbackUIOnError = props.fallbackUIRenderer != null
  );

  @mustCallSuper
  @override
  Map getDerivedStateFromError(/*Error||Exception*/dynamic error) {
    return newState()..hasError = true;
  }

  @mustCallSuper
  @override
  void componentDidCatch(/*Error||Exception*/dynamic error, ReactErrorInfo info) {
    if (props.onComponentDidCatch != null) {
      props.onComponentDidCatch(error, info);
    }

    _handleErrorInComponentTree(error, info);
  }

  @mustCallSuper
  @override
  void componentDidUpdate(Map prevProps, Map prevState, [dynamic snapshot]) {
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
    if (state.hasError && state.showFallbackUIOnError) {
      return (props.fallbackUIRenderer ?? _renderStringDomAfterUnrecoverableErrors)(_lastError, _lastErrorInfo);
    }

    return props.children;
  }

  // TODO: Add PropTypes

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
  // [1] If the consumer has defined a fallback UI, store the error on some instance fields so it can be
  //     passed to the consumer's `fallbackUIRenderer` callback within `render`, and get out of here.
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
  //
  // [3] Log the caught error using a logger if `props.shouldLogErrors` is true.
  // ---------------------------------------------- /\ ----------------------------------------------

  String _domAtTimeOfError;
  /*Error||Exception*/dynamic _lastError;
  ReactErrorInfo _lastErrorInfo;
  Timer _identicalErrorTimer;

  /// Called by [componentDidCatch].
  void _handleErrorInComponentTree(/*Error||Exception*/dynamic error, ReactErrorInfo info) {
    // ----- [1] ----- //
    if (props.fallbackUIRenderer != null) {
      _lastError = error;
      _lastErrorInfo = info;
      _logErrorCaughtByErrorBoundary(error, info); // [3]
      return;
    }
    // ----- [2] ----- //
    else {
      bool sameErrorWasThrownTwiceConsecutively =
          error.toString() == _lastError?.toString() && info.componentStack == _lastErrorInfo.componentStack;

      if (sameErrorWasThrownTwiceConsecutively) { // [2.1]
        try { // [2.2.2]
          _domAtTimeOfError = findDomNode(this)?.innerHtml; // [2.2]
        } catch (_) {}

        if (props.onComponentIsUnrecoverable != null) { // [2.2.1]
          props.onComponentIsUnrecoverable(error, info);
        }

        _logErrorCaughtByErrorBoundary(error, info, isRecoverable: false); // [3]
      } else {
        _lastError = error;
        _lastErrorInfo = info;
        _logErrorCaughtByErrorBoundary(error, info); // [3]
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
      ..['dangerouslySetInnerHTML'] = {'__html': _domAtTimeOfError ?? ''}
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

  String get _loggerName {
    if (props.logger != null) return props.logger.name;

    return props.loggerName ?? defaultErrorBoundaryLoggerName;
  }

  // ----- [3] ----- //
  void _logErrorCaughtByErrorBoundary(
    /*Error|Exception*/ dynamic error,
    ReactErrorInfo info, {
    bool isRecoverable = true,
  }) {
    if (!props.shouldLogErrors) return;

    String message = isRecoverable
        ? 'An error was caught by an ErrorBoundary: \nInfo: ${info.componentStack}'
        : 'An unrecoverable error was caught by an ErrorBoundary (attempting to remount it was unsuccessful): \nInfo: ${info.componentStack}';

    (props.logger ?? Logger(_loggerName)).severe(message, error, info.dartStackTrace);
  }
}

/// A MapView with the typed getters/setters for [ErrorBoundaryPropsMixin].
class ErrorBoundaryPropsMapView extends UiPropsMapView
    with ErrorBoundaryPropsMixin {
  /// Create a new instance backed by the specified map.
  ErrorBoundaryPropsMapView(Map map) : super(map);
}
