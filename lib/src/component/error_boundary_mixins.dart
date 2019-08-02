import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

part 'error_boundary_mixins.over_react.g.dart';

/// A props mixin you can use to implement / extend from the behaviors of an [ErrorBoundary]
/// within a custom component.
///
/// > See: [ErrorBoundaryMixin] for a usage example.
@PropsMixin()
abstract class _$ErrorBoundaryPropsMixin implements UiProps {
  @override
  Map get props;

  /// An optional callback that will be called with an [Error] and a [ReactErrorInfo]
  /// containing information about which component in the tree threw the error when
  /// the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, info) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, info);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  Function(/*Error*/dynamic error, ReactErrorInfo info) onComponentDidCatch;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ReactElement Function() fallbackUIRenderer;
}

/// A state mixin you can use to implement / extend from the behaviors of an [ErrorBoundary]
/// within a custom component.
///
/// > See: [ErrorBoundaryMixin] for a usage example.
@StateMixin()
abstract class _$ErrorBoundaryStateMixin implements UiState {
  @override
  Map get state;

  /// Whether the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// When `true`, fallback UI will be rendered using [ErrorBoundaryProps.fallbackUIRenderer].
  bool hasError;
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
///       Map getDefaultProps() => newProps()
///         ..fallbackUIRenderer = _renderFallbackUI;
///
///       ReactElement _renderFallbackUI() {
///         return Dom.h3()('Error!');
///       }
///     }
mixin ErrorBoundaryMixin<T extends ErrorBoundaryPropsMixin, S extends ErrorBoundaryStateMixin>
    on UiStatefulComponent2<T, S> {
  @mustCallSuper
  @override
  void init() {
    this.state = (newState()..hasError = false);
  }

  @mustCallSuper
  @override
  Map getDerivedStateFromError(dynamic error) {
    return newState()..hasError = true;
  }

  @mustCallSuper
  @override
  void componentDidCatch(dynamic error, ReactErrorInfo info) {
    if (props.onComponentDidCatch != null) {
      props.onComponentDidCatch(error, info);
    }
  }

  @override
  render() {
    if (state.hasError && props.fallbackUIRenderer != null) {
      return props.fallbackUIRenderer();
    }

    return props.children;
  }
}

/// A MapView with the typed getters/setters for [ErrorBoundaryPropsMixin].
class ErrorBoundaryPropsMapView extends UiPropsMapView
    with ErrorBoundaryPropsMixin {
  /// Create a new instance backed by the specified map.
  ErrorBoundaryPropsMapView(Map map) : super(map);
}
