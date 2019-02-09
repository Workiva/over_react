// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_group.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ButtonGroupComponentFactory = registerComponent(
    () => new _$ButtonGroupComponent(),
    builderFactory: ButtonGroup,
    componentClass: ButtonGroupComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ButtonGroup');

abstract class _$ButtonGroupPropsAccessorsMixin implements _$ButtonGroupProps {
  @override
  Map get props;

  /// Go to [_$ButtonGroupProps.size] to see the source code for this prop
  @override
  ButtonGroupSize get size => props['ButtonGroupProps.size'];

  /// Go to [_$ButtonGroupProps.size] to see the source code for this prop
  @override
  set size(ButtonGroupSize value) => props['ButtonGroupProps.size'] = value;

  /// Go to [_$ButtonGroupProps.skin] to see the source code for this prop
  @override
  ButtonSkin get skin => props['ButtonGroupProps.skin'];

  /// Go to [_$ButtonGroupProps.skin] to see the source code for this prop
  @override
  set skin(ButtonSkin value) => props['ButtonGroupProps.skin'] = value;

  /// Go to [_$ButtonGroupProps.isVertical] to see the source code for this prop
  @override
  bool get isVertical => props['ButtonGroupProps.isVertical'];

  /// Go to [_$ButtonGroupProps.isVertical] to see the source code for this prop
  @override
  set isVertical(bool value) => props['ButtonGroupProps.isVertical'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('ButtonGroupProps.size'),
    const PropDescriptor('ButtonGroupProps.skin'),
    const PropDescriptor('ButtonGroupProps.isVertical')
  ];
  static const List<String> $propKeys = const [
    'ButtonGroupProps.size',
    'ButtonGroupProps.skin',
    'ButtonGroupProps.isVertical'
  ];
}

const PropsMeta _$metaForButtonGroupProps = const PropsMeta(
  fields: _$ButtonGroupPropsAccessorsMixin.$props,
  keys: _$ButtonGroupPropsAccessorsMixin.$propKeys,
);

class ButtonGroupProps extends _$ButtonGroupProps
    with _$ButtonGroupPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForButtonGroupProps;
}

_$$ButtonGroupProps _$ButtonGroup([Map backingProps]) =>
    new _$$ButtonGroupProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ButtonGroupProps extends _$ButtonGroupProps
    with _$ButtonGroupPropsAccessorsMixin
    implements ButtonGroupProps {
  _$$ButtonGroupProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ButtonGroupComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ButtonGroupProps.';
}

abstract class _$ButtonGroupStateAccessorsMixin implements _$ButtonGroupState {
  @override
  Map get state;

  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [];
  static const List<String> $stateKeys = const [];
}

const StateMeta _$metaForButtonGroupState = const StateMeta(
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
  _$$ButtonGroupState(Map backingMap) : this._state = backingMap ?? {};

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
class _$ButtonGroupComponent extends ButtonGroupComponent {
  @override
  _$$ButtonGroupProps typedPropsFactory(Map backingMap) =>
      new _$$ButtonGroupProps(backingMap);

  @override
  _$$ButtonGroupState typedStateFactory(Map backingMap) =>
      new _$$ButtonGroupState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ButtonGroupProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForButtonGroupProps
  ];
}
