// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_button.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ToggleButtonComponentFactory =
    registerComponent(() => new _$ToggleButtonComponent(),
        builderFactory: ToggleButton,
        componentClass: ToggleButtonComponent,
        isWrapper: false,
        parentType: $ButtonComponentFactory,
        /* from `subtypeOf: ButtonComponent` */
        displayName: 'ToggleButton');

abstract class _$ToggleButtonPropsAccessorsMixin
    implements _$ToggleButtonProps {
  @override
  Map get props;

  /// Go to [_$ToggleButtonProps.autoFocus] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  bool get autoFocus => props[_$key__autoFocus___$ToggleButtonProps];

  /// Go to [_$ToggleButtonProps.autoFocus] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  set autoFocus(bool value) =>
      props[_$key__autoFocus___$ToggleButtonProps] = value;

  /// Go to [_$ToggleButtonProps.defaultChecked] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  bool get defaultChecked => props[_$key__defaultChecked___$ToggleButtonProps];

  /// Go to [_$ToggleButtonProps.defaultChecked] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  set defaultChecked(bool value) =>
      props[_$key__defaultChecked___$ToggleButtonProps] = value;

  /// Go to [_$ToggleButtonProps.checked] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  bool get checked => props[_$key__checked___$ToggleButtonProps];

  /// Go to [_$ToggleButtonProps.checked] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  set checked(bool value) => props[_$key__checked___$ToggleButtonProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__autoFocus___$ToggleButtonProps =
      const PropDescriptor(_$key__autoFocus___$ToggleButtonProps);
  static const PropDescriptor _$prop__defaultChecked___$ToggleButtonProps =
      const PropDescriptor(_$key__defaultChecked___$ToggleButtonProps);
  static const PropDescriptor _$prop__checked___$ToggleButtonProps =
      const PropDescriptor(_$key__checked___$ToggleButtonProps);
  static const String _$key__autoFocus___$ToggleButtonProps = 'autoFocus';
  static const String _$key__defaultChecked___$ToggleButtonProps =
      'defaultChecked';
  static const String _$key__checked___$ToggleButtonProps = 'checked';

  static const List<PropDescriptor> $props = const [
    _$prop__autoFocus___$ToggleButtonProps,
    _$prop__defaultChecked___$ToggleButtonProps,
    _$prop__checked___$ToggleButtonProps
  ];
  static const List<String> $propKeys = const [
    _$key__autoFocus___$ToggleButtonProps,
    _$key__defaultChecked___$ToggleButtonProps,
    _$key__checked___$ToggleButtonProps
  ];
}

const PropsMeta _$metaForToggleButtonProps = const PropsMeta(
  fields: _$ToggleButtonPropsAccessorsMixin.$props,
  keys: _$ToggleButtonPropsAccessorsMixin.$propKeys,
);

class ToggleButtonProps extends _$ToggleButtonProps
    with _$ToggleButtonPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForToggleButtonProps;
}

_$$ToggleButtonProps _$ToggleButton([Map backingProps]) =>
    new _$$ToggleButtonProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ToggleButtonProps extends _$ToggleButtonProps
    with _$ToggleButtonPropsAccessorsMixin
    implements ToggleButtonProps {
  _$$ToggleButtonProps(Map backingMap) : this._props = backingMap ?? {} {
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
      $ToggleButtonComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ToggleButtonProps.';
}

abstract class _$ToggleButtonStateAccessorsMixin
    implements _$ToggleButtonState {
  @override
  Map get state;

  /// Go to [_$ToggleButtonState.isFocused] to see the source code for this prop
  @override
  bool get isFocused => state[_$key__isFocused___$ToggleButtonState];

  /// Go to [_$ToggleButtonState.isFocused] to see the source code for this prop
  @override
  set isFocused(bool value) =>
      state[_$key__isFocused___$ToggleButtonState] = value;

  /// Go to [_$ToggleButtonState.isChecked] to see the source code for this prop
  @override
  bool get isChecked => state[_$key__isChecked___$ToggleButtonState];

  /// Go to [_$ToggleButtonState.isChecked] to see the source code for this prop
  @override
  set isChecked(bool value) =>
      state[_$key__isChecked___$ToggleButtonState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__isFocused___$ToggleButtonState =
      const StateDescriptor(_$key__isFocused___$ToggleButtonState);
  static const StateDescriptor _$prop__isChecked___$ToggleButtonState =
      const StateDescriptor(_$key__isChecked___$ToggleButtonState);
  static const String _$key__isFocused___$ToggleButtonState =
      'ToggleButtonState.isFocused';
  static const String _$key__isChecked___$ToggleButtonState =
      'ToggleButtonState.isChecked';

  static const List<StateDescriptor> $state = const [
    _$prop__isFocused___$ToggleButtonState,
    _$prop__isChecked___$ToggleButtonState
  ];
  static const List<String> $stateKeys = const [
    _$key__isFocused___$ToggleButtonState,
    _$key__isChecked___$ToggleButtonState
  ];
}

const StateMeta _$metaForToggleButtonState = const StateMeta(
  fields: _$ToggleButtonStateAccessorsMixin.$state,
  keys: _$ToggleButtonStateAccessorsMixin.$stateKeys,
);

class ToggleButtonState extends _$ToggleButtonState
    with _$ToggleButtonStateAccessorsMixin {
  static const StateMeta meta = _$metaForToggleButtonState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$ToggleButtonState extends _$ToggleButtonState
    with _$ToggleButtonStateAccessorsMixin
    implements ToggleButtonState {
  _$$ToggleButtonState(Map backingMap) : this._state = backingMap ?? {} {
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
class _$ToggleButtonComponent extends ToggleButtonComponent {
  @override
  _$$ToggleButtonProps typedPropsFactory(Map backingMap) =>
      new _$$ToggleButtonProps(backingMap);

  @override
  _$$ToggleButtonState typedStateFactory(Map backingMap) =>
      new _$$ToggleButtonState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ToggleButtonProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForToggleButtonProps
  ];
}
