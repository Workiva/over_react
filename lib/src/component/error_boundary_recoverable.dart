import 'package:over_react/over_react.dart';

part 'error_boundary_recoverable.over_react.g.dart';

/// A higher-order component that will catch "recoverable" ReactJS errors, errors outside of the render/mount cycle,
/// anywhere within the child component tree and display a fallback UI instead of the component tree that crashed.
///
/// __NOTE:__
///   1. This component is not / should never be publicly exported.
///   2. This component should never be used, except as a child of the outer (public) `ErrorBoundary` component.
@Factory()
UiFactory<RecoverableErrorBoundaryProps> RecoverableErrorBoundary = _$RecoverableErrorBoundary;

@Props()
class _$RecoverableErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

@State()
class _$RecoverableErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

@Component2(isWrapper: true, isErrorBoundary: true)
class RecoverableErrorBoundaryComponent<T extends RecoverableErrorBoundaryProps, S extends RecoverableErrorBoundaryState>
    extends UiStatefulComponent2<T, S> with ErrorBoundaryMixin<T, S> {}
