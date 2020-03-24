import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as v2;

@visibleForTesting
const String defaultErrorBoundaryLoggerName = 'over_react.ErrorBoundary';

/// An API mixin used for shared APIs in ErrorBoundary Components.
mixin ErrorBoundaryApi<T extends v2.ErrorBoundaryProps, S extends v2.ErrorBoundaryState> on UiStatefulComponent2<T, S> {
  /// Resets the [v2.ErrorBoundary] to a non-error state.
  ///
  /// This can be called manually on the component instance using a `ref` -
  /// or by passing in a new child instance after a child has thrown an error.
  void reset() {
    setState(initialState);
  }
}
