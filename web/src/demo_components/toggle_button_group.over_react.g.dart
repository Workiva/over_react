// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_button_group.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ToggleButtonGroupComponentFactory =
    registerComponent(() => new _$ToggleButtonGroupComponent(),
        builderFactory: ToggleButtonGroup,
        componentClass: ToggleButtonGroupComponent,
        isWrapper: false,
        parentType: $ButtonGroupComponentFactory,
        /* from `subtypeOf: ButtonGroupComponent` */
        displayName: 'ToggleButtonGroup');

abstract class _$ToggleButtonGroupPropsAccessorsMixin
    implements _$ToggleButtonGroupProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForToggleButtonGroupProps = const PropsMeta(
  fields: _$ToggleButtonGroupPropsAccessorsMixin.$props,
  keys: _$ToggleButtonGroupPropsAccessorsMixin.$propKeys,
);

class ToggleButtonGroupProps extends _$ToggleButtonGroupProps
    with _$ToggleButtonGroupPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForToggleButtonGroupProps;
}

_$$ToggleButtonGroupProps _$ToggleButtonGroup([Map backingProps]) =>
    new _$$ToggleButtonGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ToggleButtonGroupProps extends _$ToggleButtonGroupProps
    with _$ToggleButtonGroupPropsAccessorsMixin
    implements ToggleButtonGroupProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ToggleButtonGroupProps(Map backingMap) : this._props = {} {
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
      $ToggleButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ToggleButtonGroupProps.';
}

abstract class _$ToggleButtonGroupStateAccessorsMixin
    implements _$ToggleButtonGroupState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */

  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForToggleButtonGroupState = const StateMeta(
  fields: _$ToggleButtonGroupStateAccessorsMixin.$state,
  keys: _$ToggleButtonGroupStateAccessorsMixin.$stateKeys,
);

class ToggleButtonGroupState extends _$ToggleButtonGroupState
    with _$ToggleButtonGroupStateAccessorsMixin {
  static const StateMeta meta = _$metaForToggleButtonGroupState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$ToggleButtonGroupState extends _$ToggleButtonGroupState
    with _$ToggleButtonGroupStateAccessorsMixin
    implements ToggleButtonGroupState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ToggleButtonGroupState(Map backingMap) : this._state = {} {
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
class _$ToggleButtonGroupComponent extends ToggleButtonGroupComponent {
  @override
  _$$ToggleButtonGroupProps typedPropsFactory(Map backingMap) =>
      new _$$ToggleButtonGroupProps(backingMap);

  @override
  _$$ToggleButtonGroupState typedStateFactory(Map backingMap) =>
      new _$$ToggleButtonGroupState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ToggleButtonGroupProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForToggleButtonGroupProps
  ];
}
