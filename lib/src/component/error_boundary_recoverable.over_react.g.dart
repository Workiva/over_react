// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'error_boundary_recoverable.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $RecoverableErrorBoundaryComponentFactory = registerComponent2(
  () => _$RecoverableErrorBoundaryComponent(),
  builderFactory: _$RecoverableErrorBoundary,
  componentClass: RecoverableErrorBoundaryComponent,
  isWrapper: true,
  parentType: null,
  displayName: 'RecoverableErrorBoundary',
  skipMethods: const [],
);

_$$RecoverableErrorBoundaryProps _$RecoverableErrorBoundary(
        [Map backingProps]) =>
    backingProps == null
        ? _$$RecoverableErrorBoundaryProps(JsBackedMap())
        : _$$RecoverableErrorBoundaryProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RecoverableErrorBoundaryProps extends UiProps
    with
        v2.ErrorBoundaryProps,
        v2.$ErrorBoundaryProps // If this generated mixin is undefined, it's likely because v2.ErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of v2.ErrorBoundaryProps.
    implements
        RecoverableErrorBoundaryProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RecoverableErrorBoundaryProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $RecoverableErrorBoundaryComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$RecoverableErrorBoundaryState extends UiState
    with
        v2.ErrorBoundaryState,
        v2.$ErrorBoundaryState // If this generated mixin is undefined, it's likely because v2.ErrorBoundaryState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of v2.ErrorBoundaryState.
    implements
        RecoverableErrorBoundaryState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$RecoverableErrorBoundaryState(Map backingMap) : this._state = {} {
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$RecoverableErrorBoundaryComponent
    extends RecoverableErrorBoundaryComponent {
  _$$RecoverableErrorBoundaryProps _cachedTypedProps;

  @override
  _$$RecoverableErrorBoundaryProps get props => _cachedTypedProps;

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
  _$$RecoverableErrorBoundaryProps typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$RecoverableErrorBoundaryProps(backingMap);

  @override
  _$$RecoverableErrorBoundaryProps typedPropsFactory(Map backingMap) =>
      _$$RecoverableErrorBoundaryProps(backingMap);

  _$$RecoverableErrorBoundaryState _cachedTypedState;
  @override
  _$$RecoverableErrorBoundaryState get state => _cachedTypedState;

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
  _$$RecoverableErrorBoundaryState typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$RecoverableErrorBoundaryState(backingMap);

  @override
  _$$RecoverableErrorBoundaryState typedStateFactory(Map backingMap) =>
      _$$RecoverableErrorBoundaryState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by RecoverableErrorBoundaryProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because v2.ErrorBoundaryProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of v2.ErrorBoundaryProps.
        v2.ErrorBoundaryProps: v2.$ErrorBoundaryProps.meta,
      });
}
