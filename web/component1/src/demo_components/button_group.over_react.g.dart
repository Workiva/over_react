// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'button_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonGroupComponentFactory = registerComponent(
  () => _$ButtonGroupComponent(),
  builderFactory: _$ButtonGroup,
  componentClass: ButtonGroupComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ButtonGroup',
);

abstract class _$ButtonGroupPropsAccessorsMixin implements _$ButtonGroupProps {
  @override
  Map get props;

  /// Apply a button size variation universally to every [Button] within the [ButtonGroup].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#sizing>.
  ///
  /// Default: [ButtonGroupSize.DEFAULT]
  ///
  /// <!-- Generated from [_$ButtonGroupProps.size] -->
  @override
  ButtonGroupSize get size =>
      props[_$key__size___$ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Apply a button size variation universally to every [Button] within the [ButtonGroup].
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#sizing>.
  ///
  /// Default: [ButtonGroupSize.DEFAULT]
  ///
  /// <!-- Generated from [_$ButtonGroupProps.size] -->
  @override
  set size(ButtonGroupSize value) =>
      props[_$key__size___$ButtonGroupProps] = value;

  /// The [ButtonSkin] variation applied to every [Button] within the [ButtonGroup].
  ///
  /// <!-- Generated from [_$ButtonGroupProps.skin] -->
  @override
  ButtonSkin get skin =>
      props[_$key__skin___$ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The [ButtonSkin] variation applied to every [Button] within the [ButtonGroup].
  ///
  /// <!-- Generated from [_$ButtonGroupProps.skin] -->
  @override
  set skin(ButtonSkin value) => props[_$key__skin___$ButtonGroupProps] = value;

  /// Make the [Button]s within a [ButtonGroup] stack vertically.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#vertical-variation>.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonGroupProps.isVertical] -->
  @override
  bool get isVertical =>
      props[_$key__isVertical___$ButtonGroupProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Make the [Button]s within a [ButtonGroup] stack vertically.
  ///
  /// See: <http://v4-alpha.getbootstrap.com/components/button-group/#vertical-variation>.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ButtonGroupProps.isVertical] -->
  @override
  set isVertical(bool value) =>
      props[_$key__isVertical___$ButtonGroupProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__size___$ButtonGroupProps =
      PropDescriptor(_$key__size___$ButtonGroupProps);
  static const PropDescriptor _$prop__skin___$ButtonGroupProps =
      PropDescriptor(_$key__skin___$ButtonGroupProps);
  static const PropDescriptor _$prop__isVertical___$ButtonGroupProps =
      PropDescriptor(_$key__isVertical___$ButtonGroupProps);
  static const String _$key__size___$ButtonGroupProps = 'ButtonGroupProps.size';
  static const String _$key__skin___$ButtonGroupProps = 'ButtonGroupProps.skin';
  static const String _$key__isVertical___$ButtonGroupProps =
      'ButtonGroupProps.isVertical';

  static const List<PropDescriptor> $props = [
    _$prop__size___$ButtonGroupProps,
    _$prop__skin___$ButtonGroupProps,
    _$prop__isVertical___$ButtonGroupProps
  ];
  static const List<String> $propKeys = [
    _$key__size___$ButtonGroupProps,
    _$key__skin___$ButtonGroupProps,
    _$key__isVertical___$ButtonGroupProps
  ];
}

const PropsMeta _$metaForButtonGroupProps = PropsMeta(
  fields: _$ButtonGroupPropsAccessorsMixin.$props,
  keys: _$ButtonGroupPropsAccessorsMixin.$propKeys,
);

class ButtonGroupProps extends _$ButtonGroupProps
    with _$ButtonGroupPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForButtonGroupProps;
}

_$$ButtonGroupProps _$ButtonGroup([Map backingProps]) =>
    _$$ButtonGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ButtonGroupProps extends _$ButtonGroupProps
    with _$ButtonGroupPropsAccessorsMixin
    implements ButtonGroupProps {
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
  String get propKeyNamespace => 'ButtonGroupProps.';
}

abstract class _$ButtonGroupStateAccessorsMixin implements _$ButtonGroupState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = [];
  static const List<String> $stateKeys = [];
}

const StateMeta _$metaForButtonGroupState = StateMeta(
  fields: _$ButtonGroupStateAccessorsMixin.$state,
  keys: _$ButtonGroupStateAccessorsMixin.$stateKeys,
);

class ButtonGroupState extends _$ButtonGroupState
    with _$ButtonGroupStateAccessorsMixin {
  static const StateMeta meta = _$metaForButtonGroupState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$ButtonGroupState extends _$ButtonGroupState
    with _$ButtonGroupStateAccessorsMixin
    implements ButtonGroupState {
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
class _$ButtonGroupComponent extends ButtonGroupComponent {
  @override
  _$$ButtonGroupProps typedPropsFactory(Map backingMap) =>
      _$$ButtonGroupProps(backingMap);

  @override
  _$$ButtonGroupState typedStateFactory(Map backingMap) =>
      _$$ButtonGroupState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ButtonGroupProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForButtonGroupProps
  ];
}
