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

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/error_boundary.dart' as v2;
import 'package:over_react/src/component/error_boundary_api.dart';

part 'error_boundary_recoverable.over_react.g.dart';

/// A higher-order component that will catch "recoverable" ReactJS errors, errors outside of the render/mount cycle,
/// anywhere within the child component tree and display a fallback UI instead of the component tree that crashed.
///
/// __NOTE:__
///   1. This component is not / should never be publicly exported.
///   2. This component should never be used, except as a child of the outer (public) `ErrorBoundary` component.
UiFactory<RecoverableErrorBoundaryProps> RecoverableErrorBoundary = _$RecoverableErrorBoundary;

class RecoverableErrorBoundaryProps = UiProps with v2.ErrorBoundaryProps;

class RecoverableErrorBoundaryState = UiState with v2.ErrorBoundaryState;

@Component2(isWrapper: true, isErrorBoundary: true)
class RecoverableErrorBoundaryComponent<T extends RecoverableErrorBoundaryProps, S extends RecoverableErrorBoundaryState>
    extends UiStatefulComponent2<T, S> with ErrorBoundaryApi<T, S> {
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
      return (props.fallbackUIRenderer ?? _renderStringDomAfterUnrecoverableErrors)(
          _errorLog.isNotEmpty ? _errorLog.last : null,
          _callStackLog.isNotEmpty ? _callStackLog.last : null,
      );
    }

    return props.children;
  }

  // TODO: Add PropTypes

  /// Resets the [v2.ErrorBoundary] to a non-error state.
  ///
  /// This can be called manually on the component instance using a `ref` -
  /// or by passing in a new child instance after a child has thrown an error.
  @override
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
  List<String> _errorLog = [];
  List<ReactErrorInfo> _callStackLog = [];
  Timer _identicalErrorTimer;

  /// Called by [componentDidCatch].
  void _handleErrorInComponentTree(/*Error||Exception*/dynamic error, ReactErrorInfo info) {
    // ----- [1] ----- //
    if (props.fallbackUIRenderer != null) {
      _errorLog.add(error.toString());
      _callStackLog.add(info);
      _logErrorCaughtByErrorBoundary(error, info); // [3]
      return;
    }
    // ----- [2] ----- //
    else {
      bool sameErrorWasThrownTwiceConsecutively = false;
      final errorString = error.toString();

      for (var i = 0; i < _errorLog.length; i++) {
        if (_errorLog[i] == errorString && _callStackLog[i].componentStack == info.componentStack) {
          sameErrorWasThrownTwiceConsecutively = true;
          break;
        }
      }

      if (sameErrorWasThrownTwiceConsecutively) { // [2.1]
        try { // [2.2.2]
          _domAtTimeOfError = findDomNode(this)?.innerHtml; // [2.2]
        } catch (_) {}

        if (props.onComponentIsUnrecoverable != null) { // [2.2.1]
          props.onComponentIsUnrecoverable(error, info);
        }

        _logErrorCaughtByErrorBoundary(error, info, isRecoverable: false); // [3]
      } else {
        _errorLog.add(error.toString());
        _callStackLog.add(info);
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
  /// > Not used when [ErrorBoundaryPropsMixin.fallbackUIRenderer] is set.
  void _startIdenticalErrorTimer() {
    if (_identicalErrorTimer != null) return;

    _identicalErrorTimer = getManagedTimer(props.identicalErrorFrequencyTolerance, _resetInternalErrorTracking);
  }

  /// Resets all the internal fields used by [_handleErrorInComponentTree], and cancels
  /// any pending [_identicalErrorTimer] callbacks that would put the component
  /// into an "unrecoverable" error state.
  void _resetInternalErrorTracking() {
    _domAtTimeOfError = null;
    _errorLog = [];
    _callStackLog = [];
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
