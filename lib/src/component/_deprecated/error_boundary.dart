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
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/_deprecated/error_boundary_mixins.dart';
import 'package:over_react/src/component/_deprecated/error_boundary_recoverable.dart';

part 'error_boundary.over_react.g.dart';

/// A higher-order component that will catch ReactJS errors anywhere within the child component tree and
/// display a fallback UI instead of the component tree that crashed.
///
/// __Deprecated.__ Use the `ErrorBoundary` component exported from `package:over_react/components.dart` instead:
///
/// ```dart
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/components.dart' as c;
///
/// // Then use `c.ErrorBoundary` instead of `ErrorBoundary`:
/// main() {
///   final errorBoundary = c.ErrorBoundary()(
///     // The tree you're wrapping around
///   );
/// }
/// ```
@Deprecated('Use the `ErrorBoundary` component exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release of over_react.')
@Factory()
UiFactory<ErrorBoundaryProps> ErrorBoundary = _$ErrorBoundary;

@Deprecated('Use the `ErrorBoundaryProps` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release of over_react.')
@Props()
class _$ErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

@Deprecated('Use the `ErrorBoundaryState` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release of over_react.')
@State()
class _$ErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

@Deprecated('Do not extend from this class. Instead, create a HOC by rendering an `ErrorBoundary` component exported from `package:over_react/components.dart` within your custom component. Will be removed in the 4.0.0 release of over_react.')
@Component2(isWrapper: true, isErrorBoundary: true)
class ErrorBoundaryComponent<T extends ErrorBoundaryProps, S extends ErrorBoundaryState>
    extends UiStatefulComponent2<T, S> with LegacyErrorBoundaryApi<T, S> {

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
