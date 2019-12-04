import 'package:over_react/over_react.dart';

part 'error_boundary_recoverable.over_react.g.dart';

/// A higher-order component that will catch ReactJS errors anywhere within the child component tree and
/// display a fallback UI instead of the component tree that crashed.
///
/// Optionally, use the [ErrorBoundaryProps.onComponentDidCatch]
/// to send error / stack trace information to a logging endpoint for your application.
///
/// To make your own custom error boundaries, you can utilize the [ErrorBoundaryPropsMixin],
/// [ErrorBoundaryStateMixin] and [ErrorBoundaryMixin]s on any component that is annotated
/// using `@Component2(isErrorBoundary: true)`. See the [ErrorBoundaryMixin] for an example implementation.
@Factory()
UiFactory<RecoverableErrorBoundaryProps> RecoverableErrorBoundary = _$RecoverableErrorBoundary;

@Props()
class _$RecoverableErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

@State()
class _$RecoverableErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

@Component2(isWrapper: true, isErrorBoundary: true)
class RecoverableErrorBoundaryComponent<T extends RecoverableErrorBoundaryProps, S extends RecoverableErrorBoundaryState>
    extends UiStatefulComponent2<T, S> with ErrorBoundaryMixin<T, S> {}
