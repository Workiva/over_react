// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'custom_error_boundary_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $CustomErrorBoundaryComponentFactory = registerComponent2(
  () => _$CustomErrorBoundaryComponent(),
  builderFactory: _$CustomErrorBoundary,
  componentClass: CustomErrorBoundaryComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'CustomErrorBoundary',
  skipMethods: const [],
);

abstract class _$CustomErrorBoundaryPropsAccessorsMixin
    implements _$CustomErrorBoundaryProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForCustomErrorBoundaryProps = PropsMeta(
  fields: _$CustomErrorBoundaryPropsAccessorsMixin.$props,
  keys: _$CustomErrorBoundaryPropsAccessorsMixin.$propKeys,
);

class CustomErrorBoundaryProps extends _$CustomErrorBoundaryProps
    with _$CustomErrorBoundaryPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForCustomErrorBoundaryProps;
}

_$$CustomErrorBoundaryProps _$CustomErrorBoundary([Map backingProps]) =>
    backingProps == null
        ? _$$CustomErrorBoundaryProps(JsBackedMap())
        : _$$CustomErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$CustomErrorBoundaryProps extends _$CustomErrorBoundaryProps
    with _$CustomErrorBoundaryPropsAccessorsMixin
    implements CustomErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomErrorBoundaryProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $CustomErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'CustomErrorBoundaryProps.';
}

abstract class _$CustomErrorBoundaryStateAccessorsMixin
    implements _$CustomErrorBoundaryState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForCustomErrorBoundaryState = StateMeta(
  fields: _$CustomErrorBoundaryStateAccessorsMixin.$state,
  keys: _$CustomErrorBoundaryStateAccessorsMixin.$stateKeys,
);

class CustomErrorBoundaryState extends _$CustomErrorBoundaryState
    with _$CustomErrorBoundaryStateAccessorsMixin {
  static const StateMeta meta = _$metaForCustomErrorBoundaryState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$CustomErrorBoundaryState extends _$CustomErrorBoundaryState
    with _$CustomErrorBoundaryStateAccessorsMixin
    implements CustomErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$CustomErrorBoundaryState(Map backingMap) : this._state = {} {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$CustomErrorBoundaryComponent extends CustomErrorBoundaryComponent {
  _$$CustomErrorBoundaryProps _cachedTypedProps;

  @override
  _$$CustomErrorBoundaryProps get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$CustomErrorBoundaryProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$CustomErrorBoundaryProps(backingMap);

  @override
  _$$CustomErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      _$$CustomErrorBoundaryProps(backingMap);

  _$$CustomErrorBoundaryState _cachedTypedState;
  @override
  _$$CustomErrorBoundaryState get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value);
  }

  @override
  _$$CustomErrorBoundaryState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$CustomErrorBoundaryState(backingMap);

  @override
  _$$CustomErrorBoundaryState typedStateFactory(Map backingMap) =>
      _$$CustomErrorBoundaryState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$CustomErrorBoundaryProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForCustomErrorBoundaryProps
  ];
}
