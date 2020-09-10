// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'private_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $_PrivateComponentFactory = registerComponent2(
  () => _$_PrivateComponent(),
  builderFactory: _$_Private,
  componentClass: _PrivateComponent,
  isWrapper: false,
  parentType: null,
  displayName: '_Private',
);

_$$_PrivateProps _$_Private([Map backingProps]) => backingProps == null
    ? _$$_PrivateProps(JsBackedMap())
    : _$$_PrivateProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$_PrivateProps extends UiProps
    with
        _PrivateProps,
        $_PrivateProps // If this generated mixin is undefined, it's likely because _PrivateProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of _PrivateProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$_PrivateProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $_PrivateComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$_PrivateState extends UiState
    with
        _PrivateState,
        $_PrivateState // If this generated mixin is undefined, it's likely because _PrivateState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of _PrivateState.
{
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$_PrivateState(Map backingMap) : this._state = {} {
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
class _$_PrivateComponent extends _PrivateComponent {
  _$$_PrivateProps _cachedTypedProps;

  @override
  _$$_PrivateProps get props => _cachedTypedProps;

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
  _$$_PrivateProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$_PrivateProps(backingMap);

  @override
  _$$_PrivateProps typedPropsFactory(Map backingMap) =>
      _$$_PrivateProps(backingMap);

  _$$_PrivateState _cachedTypedState;
  @override
  _$$_PrivateState get state => _cachedTypedState;

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
  _$$_PrivateState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$_PrivateState(backingMap);

  @override
  _$$_PrivateState typedStateFactory(Map backingMap) =>
      _$$_PrivateState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by _PrivateProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because _PrivateProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of _PrivateProps.
        _PrivateProps: $_PrivateProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $_PrivateProps on _PrivateProps {
  static const PropsMeta meta = _$metaFor_PrivateProps;
  @override
  bool get prop1 =>
      props[_$key__prop1___PrivateProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set prop1(bool value) => props[_$key__prop1___PrivateProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__prop1___PrivateProps =
      PropDescriptor(_$key__prop1___PrivateProps);
  static const String _$key__prop1___PrivateProps = '_PrivateProps.prop1';

  static const List<PropDescriptor> $props = [_$prop__prop1___PrivateProps];
  static const List<String> $propKeys = [_$key__prop1___PrivateProps];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaFor_PrivateProps = PropsMeta(
  fields: $_PrivateProps.$props,
  keys: $_PrivateProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $_PrivateState on _PrivateState {
  static const StateMeta meta = _$metaFor_PrivateState;
  @override
  bool get state1 =>
      state[_$key__state1___PrivateState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set state1(bool value) => state[_$key__state1___PrivateState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__state1___PrivateState =
      StateDescriptor(_$key__state1___PrivateState);
  static const String _$key__state1___PrivateState = '_PrivateState.state1';

  static const List<StateDescriptor> $state = [_$prop__state1___PrivateState];
  static const List<String> $stateKeys = [_$key__state1___PrivateState];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaFor_PrivateState = StateMeta(
  fields: $_PrivateState.$state,
  keys: $_PrivateState.$stateKeys,
);
