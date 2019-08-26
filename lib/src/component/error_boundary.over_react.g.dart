// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_boundary.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ErrorBoundaryComponentFactory = registerComponent(
    () => new _$ErrorBoundaryComponent(),
    builderFactory: ErrorBoundary,
    componentClass: ErrorBoundaryComponent,
    isWrapper: true,
    parentType: null,
    displayName: 'ErrorBoundary');

abstract class _$ErrorBoundaryPropsAccessorsMixin
    implements _$ErrorBoundaryProps {
  @override
  Map get props;

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
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.onComponentDidCatch] -->
  @override
  _ComponentDidCatchCallback get onComponentDidCatch =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryProps];

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
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.onComponentDidCatch] -->
  @override
  set onComponentDidCatch(_ComponentDidCatchCallback value) =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryProps] = value;

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Default: [ErrorBoundaryComponent._renderDefaultFallbackUI]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.fallbackUIRenderer] -->
  @override
  _FallbackUiRenderer get fallbackUIRenderer =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryProps];

  /// A renderer that will be used to render "fallback" UI instead of the child
  /// component tree that crashed.
  ///
  /// > Default: [ErrorBoundaryComponent._renderDefaultFallbackUI]
  ///
  /// <!-- Generated from [_$ErrorBoundaryProps.fallbackUIRenderer] -->
  @override
  set fallbackUIRenderer(_FallbackUiRenderer value) =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__onComponentDidCatch___$ErrorBoundaryProps =
      const PropDescriptor(_$key__onComponentDidCatch___$ErrorBoundaryProps);
  static const PropDescriptor _$prop__fallbackUIRenderer___$ErrorBoundaryProps =
      const PropDescriptor(_$key__fallbackUIRenderer___$ErrorBoundaryProps);
  static const String _$key__onComponentDidCatch___$ErrorBoundaryProps =
      'ErrorBoundaryProps.onComponentDidCatch';
  static const String _$key__fallbackUIRenderer___$ErrorBoundaryProps =
      'ErrorBoundaryProps.fallbackUIRenderer';

  static const List<PropDescriptor> $props = const [
    _$prop__onComponentDidCatch___$ErrorBoundaryProps,
    _$prop__fallbackUIRenderer___$ErrorBoundaryProps
  ];
  static const List<String> $propKeys = const [
    _$key__onComponentDidCatch___$ErrorBoundaryProps,
    _$key__fallbackUIRenderer___$ErrorBoundaryProps
  ];
}

const PropsMeta _$metaForErrorBoundaryProps = const PropsMeta(
  fields: _$ErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$ErrorBoundaryPropsAccessorsMixin.$propKeys,
);

class ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForErrorBoundaryProps;
}

_$$ErrorBoundaryProps _$ErrorBoundary([Map backingProps]) =>
    new _$$ErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ErrorBoundaryProps extends _$ErrorBoundaryProps
    with _$ErrorBoundaryPropsAccessorsMixin
    implements ErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ErrorBoundaryProps(Map backingMap) : this.props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ErrorBoundaryProps.';
}

abstract class _$ErrorBoundaryStateAccessorsMixin
    implements _$ErrorBoundaryState {
  @override
  Map get state;

  /// Whether the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// When `true`, fallback UI will be rendered using [ErrorBoundaryProps.fallbackUIRenderer].
  ///
  /// <!-- Generated from [_$ErrorBoundaryState.hasError] -->
  @override
  bool get hasError => state[_$key__hasError___$ErrorBoundaryState];

  /// Whether the tree that the [ErrorBoundary] is wrapping around threw an error.
  ///
  /// When `true`, fallback UI will be rendered using [ErrorBoundaryProps.fallbackUIRenderer].
  ///
  /// <!-- Generated from [_$ErrorBoundaryState.hasError] -->
  @override
  set hasError(bool value) =>
      state[_$key__hasError___$ErrorBoundaryState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasError___$ErrorBoundaryState =
      const StateDescriptor(_$key__hasError___$ErrorBoundaryState);
  static const String _$key__hasError___$ErrorBoundaryState =
      'ErrorBoundaryState.hasError';

  static const List<StateDescriptor> $state = const [
    _$prop__hasError___$ErrorBoundaryState
  ];
  static const List<String> $stateKeys = const [
    _$key__hasError___$ErrorBoundaryState
  ];
}

const StateMeta _$metaForErrorBoundaryState = const StateMeta(
  fields: _$ErrorBoundaryStateAccessorsMixin.$state,
  keys: _$ErrorBoundaryStateAccessorsMixin.$stateKeys,
);

class ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin {
  static const StateMeta meta = _$metaForErrorBoundaryState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$ErrorBoundaryState extends _$ErrorBoundaryState
    with _$ErrorBoundaryStateAccessorsMixin
    implements ErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ErrorBoundaryState(Map backingMap) : this.state = backingMap ?? {};

  /// The backing state map proxied by this class.
  @override
  final Map state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ErrorBoundaryComponent extends ErrorBoundaryComponent {
  @override
  _$$ErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      new _$$ErrorBoundaryProps(backingMap);

  @override
  _$$ErrorBoundaryState typedStateFactory(Map backingMap) =>
      new _$$ErrorBoundaryState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ErrorBoundaryProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForErrorBoundaryProps
  ];
}
