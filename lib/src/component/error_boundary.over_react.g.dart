// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_boundary.dart';

// **************************************************************************
// OverReactGenerator
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

  /// Go to [_$ErrorBoundaryProps.onComponentDidCatch] to see the source code for this prop
  @override
  _ComponentDidCatchCallback get onComponentDidCatch =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ErrorBoundaryProps.onComponentDidCatch] to see the source code for this prop
  @override
  set onComponentDidCatch(_ComponentDidCatchCallback value) =>
      props[_$key__onComponentDidCatch___$ErrorBoundaryProps] = value;

  /// Go to [_$ErrorBoundaryProps.fallbackUIRenderer] to see the source code for this prop
  @override
  _FallbackUiRenderer get fallbackUIRenderer =>
      props[_$key__fallbackUIRenderer___$ErrorBoundaryProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ErrorBoundaryProps.fallbackUIRenderer] to see the source code for this prop
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
  _$$ErrorBoundaryProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

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

  /// Go to [_$ErrorBoundaryState.hasError] to see the source code for this prop
  @override
  bool get hasError =>
      state[_$key__hasError___$ErrorBoundaryState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ErrorBoundaryState.hasError] to see the source code for this prop
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
  _$$ErrorBoundaryState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

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
