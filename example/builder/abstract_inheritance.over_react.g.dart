// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abstract_inheritance.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SubComponentFactory = registerComponent(() => new _$SubComponent(),
    builderFactory: Sub,
    componentClass: SubComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'Sub');

abstract class _$SubPropsAccessorsMixin implements _$SubProps {
  @override
  Map get props;

  /// Go to [_$SubProps.subProp] to see the source code for this prop
  @override
  String get subProp => props['SubProps.subProp'];

  /// Go to [_$SubProps.subProp] to see the source code for this prop
  @override
  set subProp(String value) => props['SubProps.subProp'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('SubProps.subProp')
  ];
  static const List<String> $propKeys = const ['SubProps.subProp'];
}

const PropsMeta _$metaForSubProps = const PropsMeta(
  fields: _$SubPropsAccessorsMixin.$props,
  keys: _$SubPropsAccessorsMixin.$propKeys,
);

class SubProps extends _$SubProps with _$SubPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSubProps;
}

_$$SubProps _$Sub([Map backingProps]) => new _$$SubProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$SubProps extends _$SubProps
    with _$SubPropsAccessorsMixin
    implements SubProps {
  _$$SubProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory => $SubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SubProps.';
}

abstract class _$SubStateAccessorsMixin implements _$SubState {
  @override
  Map get state;

  /// Go to [_$SubState.subState] to see the source code for this prop
  @override
  String get subState => state['SubState.subState'];

  /// Go to [_$SubState.subState] to see the source code for this prop
  @override
  set subState(String value) => state['SubState.subState'] = value;
  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [
    const StateDescriptor('SubState.subState')
  ];
  static const List<String> $stateKeys = const ['SubState.subState'];
}

const StateMeta _$metaForSubState = const StateMeta(
  fields: _$SubStateAccessorsMixin.$state,
  keys: _$SubStateAccessorsMixin.$stateKeys,
);

class SubState extends _$SubState with _$SubStateAccessorsMixin {
  static const StateMeta meta = _$metaForSubState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$SubState extends _$SubState
    with _$SubStateAccessorsMixin
    implements SubState {
  _$$SubState(Map backingMap) : this._state = backingMap ?? {};

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
class _$SubComponent extends SubComponent {
  @override
  _$$SubProps typedPropsFactory(Map backingMap) => new _$$SubProps(backingMap);

  @override
  _$$SubState typedStateFactory(Map backingMap) => new _$$SubState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SubProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForSubProps];
}

abstract class _$SuperPropsAccessorsMixin implements _$SuperProps {
  @override
  Map get props;

  /// Go to [_$SuperProps.superProp] to see the source code for this prop
  @override
  String get superProp => props['SuperProps.superProp'];

  /// Go to [_$SuperProps.superProp] to see the source code for this prop
  @override
  set superProp(String value) => props['SuperProps.superProp'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('SuperProps.superProp')
  ];
  static const List<String> $propKeys = const ['SuperProps.superProp'];
}

const PropsMeta _$metaForSuperProps = const PropsMeta(
  fields: _$SuperPropsAccessorsMixin.$props,
  keys: _$SuperPropsAccessorsMixin.$propKeys,
);

abstract class SuperProps extends _$SuperProps with _$SuperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSuperProps;
}

abstract class _$SuperStateAccessorsMixin implements _$SuperState {
  @override
  Map get state;

  /// Go to [_$SuperState.superState] to see the source code for this prop
  @override
  String get superState => state['SuperState.superState'];

  /// Go to [_$SuperState.superState] to see the source code for this prop
  @override
  set superState(String value) => state['SuperState.superState'] = value;
  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [
    const StateDescriptor('SuperState.superState')
  ];
  static const List<String> $stateKeys = const ['SuperState.superState'];
}

const StateMeta _$metaForSuperState = const StateMeta(
  fields: _$SuperStateAccessorsMixin.$state,
  keys: _$SuperStateAccessorsMixin.$stateKeys,
);

abstract class SuperState extends _$SuperState with _$SuperStateAccessorsMixin {
  static const StateMeta meta = _$metaForSuperState;
}
