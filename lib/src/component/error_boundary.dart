import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

part 'error_boundary.over_react.g.dart';

// TODO: Need to type the second argument once react-dart implements bindings for the ReactJS "componentStack".
typedef _ComponentDidCatchCallback(Error error, /*ComponentStack*/dynamic componentStack);

// TODO: Need to type the second argument once react-dart implements bindings for the ReactJS "componentStack".
typedef ReactElement _FallbackUiRenderer(Error error, /*ComponentStack*/dynamic componentStack);

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
  /// An optional callback that will be called with an [Error] and a `ComponentStack`
  /// containing information about which component in the tree threw the error when
  /// the `componentDidCatch` lifecycle method is called.
  ///
  /// This callback can be used to log component errors like so:
  ///
  ///     (ErrorBoundary()
  ///       ..onComponentDidCatch = (error, componentStack) {
  ///         // It is up to you to implement the service / thing that calls the service.
  ///         logComponentStackToAService(error, componentStack);
  ///       }
  ///     )(
  ///       // The rest of your component tree
  ///     )
  ///
  /// > See: <https://reactjs.org/docs/react-component.html#componentdidcatch>
  _ComponentDidCatchCallback onComponentDidCatch;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Default: [ErrorBoundaryComponent._renderDefaultFallbackUI]
  _FallbackUiRenderer fallbackUIRenderer;
}

@State()
class _$ErrorBoundaryState extends UiState {
  /// Whether the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// When `true`, fallback UI will be rendered using [ErrorBoundaryProps.fallbackUIRenderer].
  bool hasError;
}

@Component(isWrapper: true)
class ErrorBoundaryComponent<T extends ErrorBoundaryProps, S extends ErrorBoundaryState>
    extends UiStatefulComponent<T, S> {
  Error _error;
  /*ComponentStack*/dynamic _componentStack;

  @override
  Map getDefaultProps() => (newProps()
    ..fallbackUIRenderer = _renderDefaultFallbackUI
  );

  @override
  Map getInitialState() => (newState()
    ..hasError = false
  );

  @mustCallSuper
  /*@override*/
  S getDerivedStateFromError(_) {
    return newState()..hasError = true;
  }

  @mustCallSuper
  /*@override*/
  void componentDidCatch(Error error, /*ComponentStack*/dynamic componentStack) {
    _error = error;
    _componentStack = componentStack;

    if (props.onComponentDidCatch != null) {
      props.onComponentDidCatch(error, componentStack);
    }
  }

  @override
  render() => state.hasError
      ? props.fallbackUIRenderer(_error, _componentStack)
      : props.children.single;

  ReactElement _renderDefaultFallbackUI(_, __) =>
      throw new UnimplementedError('Fallback UI will not be supported until support for ReactJS 16 is released in version 3.0.0');

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
}
