// GENERATED CODE - DO NOT MODIFY BY HAND

part of basic.library;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicPartOfLibComponentFactory = registerComponent(
    () => new _$BasicPartOfLibComponent(),
    builderFactory: BasicPartOfLib,
    componentClass: BasicPartOfLibComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'BasicPartOfLib');

abstract class _$BasicPartOfLibPropsAccessorsMixin
    implements _$BasicPartOfLibProps {
  @override
  Map get props;

  /// Go to [_$BasicPartOfLibProps.basicProp] to see the source code for this prop
  @override
  String get basicProp => props['BasicPartOfLibProps.basicProp'];

  /// Go to [_$BasicPartOfLibProps.basicProp] to see the source code for this prop
  @override
  set basicProp(String value) => props['BasicPartOfLibProps.basicProp'] = value;

  /// Go to [_$BasicPartOfLibProps.basic1] to see the source code for this prop
  @override
  String get basic1 => props['BasicPartOfLibProps.basic1'];

  /// Go to [_$BasicPartOfLibProps.basic1] to see the source code for this prop
  @override
  set basic1(String value) => props['BasicPartOfLibProps.basic1'] = value;

  /// Go to [_$BasicPartOfLibProps.basic2] to see the source code for this prop
  @override
  String get basic2 => props['BasicPartOfLibProps.basic2'];

  /// Go to [_$BasicPartOfLibProps.basic2] to see the source code for this prop
  @override
  set basic2(String value) => props['BasicPartOfLibProps.basic2'] = value;

  /// Go to [_$BasicPartOfLibProps.basic3] to see the source code for this prop
  @override
  String get basic3 => props['BasicPartOfLibProps.basic3'];

  /// Go to [_$BasicPartOfLibProps.basic3] to see the source code for this prop
  @override
  set basic3(String value) => props['BasicPartOfLibProps.basic3'] = value;

  /// Go to [_$BasicPartOfLibProps.basic4] to see the source code for this prop
  @override
  String get basic4 => props['BasicPartOfLibProps.basic4'];

  /// Go to [_$BasicPartOfLibProps.basic4] to see the source code for this prop
  @override
  set basic4(String value) => props['BasicPartOfLibProps.basic4'] = value;

  /// Go to [_$BasicPartOfLibProps.basic5] to see the source code for this prop
  @override
  String get basic5 => props['BasicPartOfLibProps.basic5'];

  /// Go to [_$BasicPartOfLibProps.basic5] to see the source code for this prop
  @override
  set basic5(String value) => props['BasicPartOfLibProps.basic5'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('BasicPartOfLibProps.basicProp'),
    const PropDescriptor('BasicPartOfLibProps.basic1'),
    const PropDescriptor('BasicPartOfLibProps.basic2'),
    const PropDescriptor('BasicPartOfLibProps.basic3'),
    const PropDescriptor('BasicPartOfLibProps.basic4'),
    const PropDescriptor('BasicPartOfLibProps.basic5')
  ];
  static const List<String> $propKeys = const [
    'BasicPartOfLibProps.basicProp',
    'BasicPartOfLibProps.basic1',
    'BasicPartOfLibProps.basic2',
    'BasicPartOfLibProps.basic3',
    'BasicPartOfLibProps.basic4',
    'BasicPartOfLibProps.basic5'
  ];
}

const PropsMeta _$metaForBasicPartOfLibProps = const PropsMeta(
  fields: _$BasicPartOfLibPropsAccessorsMixin.$props,
  keys: _$BasicPartOfLibPropsAccessorsMixin.$propKeys,
);

class BasicPartOfLibProps extends _$BasicPartOfLibProps
    with _$BasicPartOfLibPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicPartOfLibProps;
}

_$$BasicPartOfLibProps _$BasicPartOfLib([Map backingProps]) =>
    new _$$BasicPartOfLibProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$BasicPartOfLibProps extends _$BasicPartOfLibProps
    with _$BasicPartOfLibPropsAccessorsMixin
    implements BasicPartOfLibProps {
  _$$BasicPartOfLibProps(Map backingMap) : this._props = backingMap ?? {};

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
      $BasicPartOfLibComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicPartOfLibProps.';
}

abstract class _$BasicPartOfLibStateAccessorsMixin
    implements _$BasicPartOfLibState {
  @override
  Map get state;

  /// Go to [_$BasicPartOfLibState.basicState] to see the source code for this prop
  @override
  String get basicState => state['BasicPartOfLibState.basicState'];

  /// Go to [_$BasicPartOfLibState.basicState] to see the source code for this prop
  @override
  set basicState(String value) =>
      state['BasicPartOfLibState.basicState'] = value;
  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [
    const StateDescriptor('BasicPartOfLibState.basicState')
  ];
  static const List<String> $stateKeys = const [
    'BasicPartOfLibState.basicState'
  ];
}

const StateMeta _$metaForBasicPartOfLibState = const StateMeta(
  fields: _$BasicPartOfLibStateAccessorsMixin.$state,
  keys: _$BasicPartOfLibStateAccessorsMixin.$stateKeys,
);

class BasicPartOfLibState extends _$BasicPartOfLibState
    with _$BasicPartOfLibStateAccessorsMixin {
  static const StateMeta meta = _$metaForBasicPartOfLibState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$BasicPartOfLibState extends _$BasicPartOfLibState
    with _$BasicPartOfLibStateAccessorsMixin
    implements BasicPartOfLibState {
  _$$BasicPartOfLibState(Map backingMap) : this._state = backingMap ?? {};

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
class _$BasicPartOfLibComponent extends BasicPartOfLibComponent {
  @override
  _$$BasicPartOfLibProps typedPropsFactory(Map backingMap) =>
      new _$$BasicPartOfLibProps(backingMap);

  @override
  _$$BasicPartOfLibState typedStateFactory(Map backingMap) =>
      new _$$BasicPartOfLibState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicPartOfLibProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForBasicPartOfLibProps
  ];
}

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $SubPartOfLibComponentFactory = registerComponent(
    () => new _$SubPartOfLibComponent(),
    builderFactory: SubPartOfLib,
    componentClass: SubPartOfLibComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'SubPartOfLib');

abstract class _$SubPartOfLibPropsAccessorsMixin
    implements _$SubPartOfLibProps {
  @override
  Map get props;

  /// Go to [_$SubPartOfLibProps.subProp] to see the source code for this prop
  @override
  String get subProp => props['SubPartOfLibProps.subProp'];

  /// Go to [_$SubPartOfLibProps.subProp] to see the source code for this prop
  @override
  set subProp(String value) => props['SubPartOfLibProps.subProp'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('SubPartOfLibProps.subProp')
  ];
  static const List<String> $propKeys = const ['SubPartOfLibProps.subProp'];
}

const PropsMeta _$metaForSubPartOfLibProps = const PropsMeta(
  fields: _$SubPartOfLibPropsAccessorsMixin.$props,
  keys: _$SubPartOfLibPropsAccessorsMixin.$propKeys,
);

class SubPartOfLibProps extends _$SubPartOfLibProps
    with _$SubPartOfLibPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSubPartOfLibProps;
}

_$$SubPartOfLibProps _$SubPartOfLib([Map backingProps]) =>
    new _$$SubPartOfLibProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$SubPartOfLibProps extends _$SubPartOfLibProps
    with _$SubPartOfLibPropsAccessorsMixin
    implements SubPartOfLibProps {
  _$$SubPartOfLibProps(Map backingMap) : this._props = backingMap ?? {};

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
      $SubPartOfLibComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'SubPartOfLibProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$SubPartOfLibComponent extends SubPartOfLibComponent {
  @override
  _$$SubPartOfLibProps typedPropsFactory(Map backingMap) =>
      new _$$SubPartOfLibProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$SubPartOfLibProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForSubPartOfLibProps
  ];
}

abstract class _$SuperPartOfLibPropsAccessorsMixin
    implements _$SuperPartOfLibProps {
  @override
  Map get props;

  /// Go to [_$SuperPartOfLibProps.superProp] to see the source code for this prop
  @override
  String get superProp => props['SuperPartOfLibProps.superProp'];

  /// Go to [_$SuperPartOfLibProps.superProp] to see the source code for this prop
  @override
  set superProp(String value) => props['SuperPartOfLibProps.superProp'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('SuperPartOfLibProps.superProp')
  ];
  static const List<String> $propKeys = const ['SuperPartOfLibProps.superProp'];
}

const PropsMeta _$metaForSuperPartOfLibProps = const PropsMeta(
  fields: _$SuperPartOfLibPropsAccessorsMixin.$props,
  keys: _$SuperPartOfLibPropsAccessorsMixin.$propKeys,
);

abstract class SuperPartOfLibProps extends _$SuperPartOfLibProps
    with _$SuperPartOfLibPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForSuperPartOfLibProps;
}
