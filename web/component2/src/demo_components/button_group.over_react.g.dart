// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'button_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ButtonGroupComponentFactory = registerComponent2(
  () => _$ButtonGroupComponent(),
  builderFactory: _$ButtonGroup,
  componentClass: ButtonGroupComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ButtonGroup',
);

_$$ButtonGroupProps _$ButtonGroup([Map backingProps]) => backingProps == null
    ? _$$ButtonGroupProps(JsBackedMap())
    : _$$ButtonGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ButtonGroupProps extends UiProps
    with
        ButtonGroupProps,
        $ButtonGroupProps // If this generated mixin is undefined, it's likely because ButtonGroupProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonGroupProps.
{
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonGroupProps(Map backingMap) : this._props = {} {
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
      super.componentFactory ?? $ButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$ButtonGroupState extends UiState
    with
        ButtonGroupState,
        $ButtonGroupState // If this generated mixin is undefined, it's likely because ButtonGroupState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonGroupState.
{
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ButtonGroupState(Map backingMap) : this._state = {} {
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
class _$ButtonGroupComponent extends ButtonGroupComponent {
  _$$ButtonGroupProps _cachedTypedProps;

  @override
  _$$ButtonGroupProps get props => _cachedTypedProps;

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
  _$$ButtonGroupProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$ButtonGroupProps(backingMap);

  @override
  _$$ButtonGroupProps typedPropsFactory(Map backingMap) =>
      _$$ButtonGroupProps(backingMap);

  _$$ButtonGroupState _cachedTypedState;
  @override
  _$$ButtonGroupState get state => _cachedTypedState;

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
  _$$ButtonGroupState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$ButtonGroupState(backingMap);

  @override
  _$$ButtonGroupState typedStateFactory(Map backingMap) =>
      _$$ButtonGroupState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by ButtonGroupProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ButtonGroupProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ButtonGroupProps.
        ButtonGroupProps: $ButtonGroupProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ButtonGroupProps on ButtonGroupProps {
  static const PropsMeta meta = _$metaForButtonGroupProps;
  @override
  ButtonGroupSize get size =>
      props[_$key__size__ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set size(ButtonGroupSize value) =>
      props[_$key__size__ButtonGroupProps] = value;
  @override
  ButtonSkin get skin =>
      props[_$key__skin__ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set skin(ButtonSkin value) => props[_$key__skin__ButtonGroupProps] = value;
  @override
  bool get isVertical =>
      props[_$key__isVertical__ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isVertical(bool value) =>
      props[_$key__isVertical__ButtonGroupProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__size__ButtonGroupProps =
      PropDescriptor(_$key__size__ButtonGroupProps);
  static const PropDescriptor _$prop__skin__ButtonGroupProps =
      PropDescriptor(_$key__skin__ButtonGroupProps);
  static const PropDescriptor _$prop__isVertical__ButtonGroupProps =
      PropDescriptor(_$key__isVertical__ButtonGroupProps);
  static const String _$key__size__ButtonGroupProps = 'ButtonGroupProps.size';
  static const String _$key__skin__ButtonGroupProps = 'ButtonGroupProps.skin';
  static const String _$key__isVertical__ButtonGroupProps =
      'ButtonGroupProps.isVertical';

  static const List<PropDescriptor> $props = [
    _$prop__size__ButtonGroupProps,
    _$prop__skin__ButtonGroupProps,
    _$prop__isVertical__ButtonGroupProps
  ];
  static const List<String> $propKeys = [
    _$key__size__ButtonGroupProps,
    _$key__skin__ButtonGroupProps,
    _$key__isVertical__ButtonGroupProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForButtonGroupProps = PropsMeta(
  fields: $ButtonGroupProps.$props,
  keys: $ButtonGroupProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ButtonGroupState on ButtonGroupState {
  static const StateMeta meta = _$metaForButtonGroupState;
  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForButtonGroupState = StateMeta(
  fields: $ButtonGroupState.$state,
  keys: $ButtonGroupState.$stateKeys,
);
