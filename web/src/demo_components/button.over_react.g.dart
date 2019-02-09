// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonComponentFactory = registerComponent(() => new _$ButtonComponent(),
    builderFactory: Button,
    componentClass: ButtonComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Button');

abstract class _$ButtonPropsAccessorsMixin implements _$ButtonProps {
  @override
  Map get props;

  /// Go to [_$ButtonProps.skin] to see the source code for this prop
  @override
  ButtonSkin get skin => props['ButtonProps.skin'];

  /// Go to [_$ButtonProps.skin] to see the source code for this prop
  @override
  set skin(ButtonSkin value) => props['ButtonProps.skin'] = value;

  /// Go to [_$ButtonProps.size] to see the source code for this prop
  @override
  ButtonSize get size => props['ButtonProps.size'];

  /// Go to [_$ButtonProps.size] to see the source code for this prop
  @override
  set size(ButtonSize value) => props['ButtonProps.size'] = value;

  /// Go to [_$ButtonProps.isActive] to see the source code for this prop
  @override
  bool get isActive => props['ButtonProps.isActive'];

  /// Go to [_$ButtonProps.isActive] to see the source code for this prop
  @override
  set isActive(bool value) => props['ButtonProps.isActive'] = value;

  /// Go to [_$ButtonProps.isDisabled] to see the source code for this prop
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  bool get isDisabled => props['disabled'];

  /// Go to [_$ButtonProps.isDisabled] to see the source code for this prop
  @override
  @Accessor(key: 'disabled', keyNamespace: '')
  set isDisabled(bool value) => props['disabled'] = value;

  /// Go to [_$ButtonProps.isBlock] to see the source code for this prop
  @override
  bool get isBlock => props['ButtonProps.isBlock'];

  /// Go to [_$ButtonProps.isBlock] to see the source code for this prop
  @override
  set isBlock(bool value) => props['ButtonProps.isBlock'] = value;

  /// Go to [_$ButtonProps.href] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  String get href => props['href'];

  /// Go to [_$ButtonProps.href] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  set href(String value) => props['href'] = value;

  /// Go to [_$ButtonProps.target] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  String get target => props['target'];

  /// Go to [_$ButtonProps.target] to see the source code for this prop
  @override
  @Accessor(keyNamespace: '')
  set target(String value) => props['target'] = value;

  /// Go to [_$ButtonProps.type] to see the source code for this prop
  @override
  ButtonType get type => props['ButtonProps.type'];

  /// Go to [_$ButtonProps.type] to see the source code for this prop
  @override
  set type(ButtonType value) => props['ButtonProps.type'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('ButtonProps.skin'),
    const PropDescriptor('ButtonProps.size'),
    const PropDescriptor('ButtonProps.isActive'),
    const PropDescriptor('disabled'),
    const PropDescriptor('ButtonProps.isBlock'),
    const PropDescriptor('href'),
    const PropDescriptor('target'),
    const PropDescriptor('ButtonProps.type')
  ];
  static const List<String> $propKeys = const [
    'ButtonProps.skin',
    'ButtonProps.size',
    'ButtonProps.isActive',
    'disabled',
    'ButtonProps.isBlock',
    'href',
    'target',
    'ButtonProps.type'
  ];
}

const PropsMeta _$metaForButtonProps = const PropsMeta(
  fields: _$ButtonPropsAccessorsMixin.$props,
  keys: _$ButtonPropsAccessorsMixin.$propKeys,
);

class ButtonProps extends _$ButtonProps with _$ButtonPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForButtonProps;
}

_$$ButtonProps _$Button([Map backingProps]) => new _$$ButtonProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ButtonProps extends _$ButtonProps
    with _$ButtonPropsAccessorsMixin
    implements ButtonProps {
  _$$ButtonProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $ButtonComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ButtonProps.';
}

abstract class _$ButtonStateAccessorsMixin implements _$ButtonState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForButtonState = const StateMeta(
  fields: _$ButtonStateAccessorsMixin.$state,
  keys: _$ButtonStateAccessorsMixin.$stateKeys,
);

class ButtonState extends _$ButtonState with _$ButtonStateAccessorsMixin {
  static const StateMeta meta = _$metaForButtonState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$ButtonState extends _$ButtonState
    with _$ButtonStateAccessorsMixin
    implements ButtonState {
  _$$ButtonState(Map backingMap) : this._state = backingMap ?? {};

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  final Map _state;

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ButtonComponent extends ButtonComponent {
  @override
  _$$ButtonProps typedPropsFactory(Map backingMap) =>
      new _$$ButtonProps(backingMap);

  @override
  _$$ButtonState typedStateFactory(Map backingMap) =>
      new _$$ButtonState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ButtonProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForButtonProps
  ];
}
