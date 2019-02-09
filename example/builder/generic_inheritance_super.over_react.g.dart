// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_inheritance_super.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $GenericSuperComponentFactory = registerComponent(
    () => new _$GenericSuperComponent(),
    builderFactory: GenericSuper,
    componentClass: GenericSuperComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'GenericSuper');

abstract class _$GenericSuperPropsAccessorsMixin
    implements _$GenericSuperProps {
  @override
  Map get props;

  /// Go to [_$GenericSuperProps.otherSuperProp] to see the source code for this prop
  @override
  String get otherSuperProp => props['GenericSuperProps.otherSuperProp'];

  /// Go to [_$GenericSuperProps.otherSuperProp] to see the source code for this prop
  @override
  set otherSuperProp(String value) =>
      props['GenericSuperProps.otherSuperProp'] = value;

  /// Go to [_$GenericSuperProps.superProp] to see the source code for this prop
  @override
  String get superProp => props['GenericSuperProps.superProp'];

  /// Go to [_$GenericSuperProps.superProp] to see the source code for this prop
  @override
  set superProp(String value) => props['GenericSuperProps.superProp'] = value;

  /// Go to [_$GenericSuperProps.superProp1] to see the source code for this prop
  @override
  String get superProp1 => props['GenericSuperProps.superProp1'];

  /// Go to [_$GenericSuperProps.superProp1] to see the source code for this prop
  @override
  set superProp1(String value) => props['GenericSuperProps.superProp1'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('GenericSuperProps.otherSuperProp'),
    const PropDescriptor('GenericSuperProps.superProp'),
    const PropDescriptor('GenericSuperProps.superProp1')
  ];
  static const List<String> $propKeys = const [
    'GenericSuperProps.otherSuperProp',
    'GenericSuperProps.superProp',
    'GenericSuperProps.superProp1'
  ];
}

const PropsMeta _$metaForGenericSuperProps = const PropsMeta(
  fields: _$GenericSuperPropsAccessorsMixin.$props,
  keys: _$GenericSuperPropsAccessorsMixin.$propKeys,
);

class GenericSuperProps extends _$GenericSuperProps
    with _$GenericSuperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForGenericSuperProps;
}

_$$GenericSuperProps _$GenericSuper([Map backingProps]) =>
    new _$$GenericSuperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$GenericSuperProps extends _$GenericSuperProps
    with _$GenericSuperPropsAccessorsMixin
    implements GenericSuperProps {
  _$$GenericSuperProps(Map backingMap) : this._props = backingMap ?? {};

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
      $GenericSuperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'GenericSuperProps.';
}

abstract class _$GenericSuperStateAccessorsMixin
    implements _$GenericSuperState {
  @override
  Map get state;

  /// Go to [_$GenericSuperState.superState] to see the source code for this prop
  @override
  String get superState => state['GenericSuperState.superState'];

  /// Go to [_$GenericSuperState.superState] to see the source code for this prop
  @override
  set superState(String value) => state['GenericSuperState.superState'] = value;
  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [
    const StateDescriptor('GenericSuperState.superState')
  ];
  static const List<String> $stateKeys = const ['GenericSuperState.superState'];
}

const StateMeta _$metaForGenericSuperState = const StateMeta(
  fields: _$GenericSuperStateAccessorsMixin.$state,
  keys: _$GenericSuperStateAccessorsMixin.$stateKeys,
);

class GenericSuperState extends _$GenericSuperState
    with _$GenericSuperStateAccessorsMixin {
  static const StateMeta meta = _$metaForGenericSuperState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$GenericSuperState extends _$GenericSuperState
    with _$GenericSuperStateAccessorsMixin
    implements GenericSuperState {
  _$$GenericSuperState(Map backingMap) : this._state = backingMap ?? {};

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
class _$GenericSuperComponent extends GenericSuperComponent {
  @override
  _$$GenericSuperProps typedPropsFactory(Map backingMap) =>
      new _$$GenericSuperProps(backingMap);

  @override
  _$$GenericSuperState typedStateFactory(Map backingMap) =>
      new _$$GenericSuperState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$GenericSuperProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForGenericSuperProps
  ];
}
