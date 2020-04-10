import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/_deprecated/error_boundary_mixins.dart';

part 'error_boundary_recoverable.over_react.g.dart';

/// A higher-order component that will catch "recoverable" ReactJS errors, errors outside of the render/mount cycle,
/// anywhere within the child component tree and display a fallback UI instead of the component tree that crashed.
///
/// __NOTE:__
///   1. This component is not / should never be publicly exported.
///   2. This component should never be used, except as a child of the outer (public) `ErrorBoundary` component.
@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@Factory()
UiFactory<RecoverableErrorBoundaryProps> RecoverableErrorBoundary = _$RecoverableErrorBoundary;

@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@Props()
class _$RecoverableErrorBoundaryProps extends UiProps with ErrorBoundaryPropsMixin {}

@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@State()
class _$RecoverableErrorBoundaryState extends UiState with ErrorBoundaryStateMixin {}

@Deprecated('For internal use with deprecated ErrorBoundary components only. Remove in the 4.0.0 release.')
@Component2(isWrapper: true, isErrorBoundary: true)
class RecoverableErrorBoundaryComponent<T extends RecoverableErrorBoundaryProps, S extends RecoverableErrorBoundaryState>
    extends UiStatefulComponent2<T, S> with ErrorBoundaryMixin<T, S>, LegacyErrorBoundaryApi<T, S> {}
