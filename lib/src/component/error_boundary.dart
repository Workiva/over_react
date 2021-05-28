// Copyright 2020 Workiva Inc.
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

import 'package:logging/logging.dart';
import 'package:over_react/over_react.dart' hide ErrorBoundary, ErrorBoundaryProps, ErrorBoundaryState;
import 'package:over_react/src/component/error_boundary_api.dart';
import 'package:over_react/src/component/error_boundary_recoverable.dart';

part 'error_boundary.over_react.g.dart';

/// A higher-order component that will catch ReactJS errors anywhere within the child component tree and
/// display a fallback UI instead of the component tree that crashed.
UiFactory<ErrorBoundaryProps> ErrorBoundary = castUiFactory(_$ErrorBoundary);

mixin ErrorBoundaryProps on UiProps {
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
  Function(/*Error||Exception*/dynamic error, ReactErrorInfo info)? onComponentDidCatch;

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
  Function(/*Error||Exception*/dynamic error, ReactErrorInfo info)? onComponentIsUnrecoverable;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Related: [onComponentIsUnrecoverable], [onComponentDidCatch]
  ReactElement? Function(/*Error||Exception*/dynamic error, ReactErrorInfo? info)? fallbackUIRenderer;

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
  Duration? identicalErrorFrequencyTolerance;

  /// The name to use when the component's logger logs an error via [ErrorBoundaryComponent.componentDidCatch].
  ///
  /// Not used if a custom [logger] is specified.
  ///
  /// > Default: 'over_react.ErrorBoundary'
  String? loggerName;

  /// Whether errors caught by this [ErrorBoundary] should be logged using a [Logger].
  ///
  /// > Default: `true`
  bool? shouldLogErrors;

  /// An optional custom logger instance that will be used to log errors caught by
  /// this [ErrorBoundary] when [shouldLogErrors] is true.
  Logger? logger;
}

mixin ErrorBoundaryState on UiState {
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
  bool? hasError;

  /// Whether to show "fallback" UI when [hasError] is true.
  ///
  /// This value will always be true if [ErrorBoundaryProps.fallbackUIRenderer] is non-null.
  bool? showFallbackUIOnError;
}

@Component2(isWrapper: true, isErrorBoundary: true)
class ErrorBoundaryComponent
    extends UiStatefulComponent2<ErrorBoundaryProps, ErrorBoundaryState>
    with ErrorBoundaryApi<ErrorBoundaryProps, ErrorBoundaryState> {

  // ---------------------------------------------- \/ ----------------------------------------------
  // How This ErrorBoundary Works:
  //
  //   Background Info:
  //     React gives each Error Boundary one chance to handle or recover when an error is throws, if
  //     the Error Boundary's children throw again on its next render after React calls
  //     `getDerivedStateFromError` and `componentDidCatch`, React will ascend the tree to the next
  //     Error Boundary above it and rerender offering it a chance to handle the error. If none of
  //     the parent Error Boundaries have a successful render cycle, React unmounts the entire tree.
  //       __Note:__ When an Error Boundary remounts its children React clears all child components
  //       previous state, including child ErrorBoundaries meaning they lose all previous knowledge
  //       of any errors thrown.
  //
  //   Solution:
  //     To prevent unmounting the entire tree when React cannot find an Error Boundary that is able
  //     to handle the error we wrap an Error Boundary with another Error Boundary (this one!). The
  //     child Error Boundary will handle errors that are "recoverable", so if an error gets to this
  //     Error Boundary we know it is "unrecoverable" and can present a fallback.
  //
  // -----------------------------------------------------------------------------------------------
  // Implementation:
  //
  // [1] Renders a child Error Boundary that is able to handle Errors thrown outside of the initial
  //     render cycle, allowing it a chance to "recover".
  //
  // [2] If we catch an error in this Error Boundary that indicates that the child Error Boundary was
  //     unable to handle or recover from the error, so we know that it was "unrecoverable" and we
  //     haven't had a successful render there is never any DOM created that can used to display,
  //     so we present an empty div instead.
  //
  // ---------------------------------------------- /\ ----------------------------------------------

  /// Forward all the props from [ErrorBoundaryProps] to the child [RecoverableErrorBoundary] by
  /// explicitly setting `consumedProps` to an empty list.
  @override
  get consumedProps => [];

  @override
  get defaultProps => (newProps()
    ..identicalErrorFrequencyTolerance = Duration(seconds: 5)
    ..loggerName = defaultErrorBoundaryLoggerName
    ..shouldLogErrors = true
  );

  @override
  get initialState => (newState()
    ..hasError = false
    ..showFallbackUIOnError = true
  );

  @override
  Map getDerivedStateFromError(error) => (newState()
    ..hasError = true
    ..showFallbackUIOnError = true
  );

  @override
  void componentDidCatch(error, ReactErrorInfo info) {
    if (props.onComponentDidCatch != null) {
      props.onComponentDidCatch!(error, info);
    }

    _logErrorCaughtByErrorBoundary(error, info);

    if (props.onComponentIsUnrecoverable != null) {
      props.onComponentIsUnrecoverable!(error, info);
    }
  }

  @override
  render() {
    if (state.hasError!) { // [2]
      return (Dom.div()
        ..key = 'ohnoes'
        ..addTestId('ErrorBoundary.unrecoverableErrorInnerHtmlContainerNode')
      )();
    }
    return (RecoverableErrorBoundary()
      ..addTestId('RecoverableErrorBoundary')
      ..modifyProps(addUnconsumedProps)
    )(props.children); // [1]
  }

  @override
  void componentDidUpdate(Map prevProps, Map prevState, [dynamic snapshot]) {
    // If the child is different, and the error boundary is currently in an error state,
    // give the children a chance to mount.
    if (state.hasError!) {
      final childThatCausedError = typedPropsFactory(prevProps).children!.single;
      if (childThatCausedError != props.children!.single) {
        reset();
      }
    }
  }

  /// Resets the [ErrorBoundary] to a non-error state.
  ///
  /// This can be called manually on the component instance using a `ref` -
  /// or by passing in a new child instance after a child has thrown an error.
  @override
  void reset() {
    setState(initialState);
  }

  String get _loggerName {
    if (props.logger != null) return props.logger!.name;

    return props.loggerName ?? defaultErrorBoundaryLoggerName;
  }

  void _logErrorCaughtByErrorBoundary(
    /*Error|Exception*/ dynamic error,
    ReactErrorInfo info, {
    bool isRecoverable = true,
  }) {
    if (!props.shouldLogErrors!) return;

    final message = 'An unrecoverable error was caught by an ErrorBoundary (attempting to remount it was unsuccessful): \nInfo: ${info.componentStack}';

    (props.logger ?? Logger(_loggerName)).severe(message, error, info.dartStackTrace);
  }
}
