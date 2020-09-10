// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'faulty-component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $FaultyComponentFactory = registerComponent2(
  () => _$FaultyComponent(),
  builderFactory: _$Faulty,
  componentClass: FaultyComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Faulty',
);

_$$FaultyProps _$Faulty([Map backingProps]) => backingProps == null
    ? _$$FaultyProps(JsBackedMap())
    : _$$FaultyProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FaultyProps extends UiProps
    with
        FaultyProps,
        $FaultyProps // If this generated mixin is undefined, it's likely because FaultyProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FaultyProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FaultyProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $FaultyComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FaultyState extends UiState
    with
        FaultyState,
        $FaultyState // If this generated mixin is undefined, it's likely because FaultyState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of FaultyState.
{
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FaultyState(Map backingMap) : this._state = {} {
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
class _$FaultyComponent extends FaultyComponent {
  _$$FaultyProps _cachedTypedProps;

  @override
  _$$FaultyProps get props => _cachedTypedProps;

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
  _$$FaultyProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FaultyProps(backingMap);

  @override
  _$$FaultyProps typedPropsFactory(Map backingMap) =>
      _$$FaultyProps(backingMap);

  _$$FaultyState _cachedTypedState;
  @override
  _$$FaultyState get state => _cachedTypedState;

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
  _$$FaultyState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$FaultyState(backingMap);

  @override
  _$$FaultyState typedStateFactory(Map backingMap) =>
      _$$FaultyState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by FaultyProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because FaultyProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FaultyProps.
        FaultyProps: $FaultyProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FaultyProps on FaultyProps {
  static const PropsMeta meta = _$metaForFaultyProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFaultyProps = PropsMeta(
  fields: $FaultyProps.$props,
  keys: $FaultyProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FaultyState on FaultyState {
  static const StateMeta meta = _$metaForFaultyState;
  @override
  bool get hasErrored =>
      state[_$key__hasErrored__FaultyState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set hasErrored(bool value) => state[_$key__hasErrored__FaultyState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasErrored__FaultyState =
      StateDescriptor(_$key__hasErrored__FaultyState);
  static const String _$key__hasErrored__FaultyState = 'FaultyState.hasErrored';

  static const List<StateDescriptor> $state = [_$prop__hasErrored__FaultyState];
  static const List<String> $stateKeys = [_$key__hasErrored__FaultyState];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForFaultyState = StateMeta(
  fields: $FaultyState.$state,
  keys: $FaultyState.$stateKeys,
);
