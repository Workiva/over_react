// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stateful_component_integration_test.dart';

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $StatefulComponentTestComponentFactory = registerComponent(
    () => new _$StatefulComponentTestComponent(),
    builderFactory: StatefulComponentTest,
    componentClass: StatefulComponentTestComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'StatefulComponentTest');

abstract class _$StatefulComponentTestPropsAccessorsMixin
    implements _$StatefulComponentTestProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForStatefulComponentTestProps = const PropsMeta(
  fields: _$StatefulComponentTestPropsAccessorsMixin.$props,
  keys: _$StatefulComponentTestPropsAccessorsMixin.$propKeys,
);

class StatefulComponentTestProps extends _$StatefulComponentTestProps
    with _$StatefulComponentTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForStatefulComponentTestProps;
}

_$$StatefulComponentTestProps _$StatefulComponentTest([Map backingProps]) =>
    new _$$StatefulComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$StatefulComponentTestProps extends _$StatefulComponentTestProps
    with _$StatefulComponentTestPropsAccessorsMixin
    implements StatefulComponentTestProps {
  _$$StatefulComponentTestProps(Map backingMap)
      : this._props = backingMap ?? {};

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
      $StatefulComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'StatefulComponentTestProps.';
}

abstract class _$StatefulComponentTestStateAccessorsMixin
    implements _$StatefulComponentTestState {
  @override
  Map get state;

  /// Go to [_$StatefulComponentTestState.stringState] to see the source code for this prop
  @override
  String get stringState => state['StatefulComponentTestState.stringState'];

  /// Go to [_$StatefulComponentTestState.stringState] to see the source code for this prop
  @override
  set stringState(String value) =>
      state['StatefulComponentTestState.stringState'] = value;

  /// Go to [_$StatefulComponentTestState.dynamicState] to see the source code for this prop
  @override
  dynamic get dynamicState => state['StatefulComponentTestState.dynamicState'];

  /// Go to [_$StatefulComponentTestState.dynamicState] to see the source code for this prop
  @override
  set dynamicState(dynamic value) =>
      state['StatefulComponentTestState.dynamicState'] = value;

  /// Go to [_$StatefulComponentTestState.untypedState] to see the source code for this prop
  @override
  get untypedState => state['StatefulComponentTestState.untypedState'];

  /// Go to [_$StatefulComponentTestState.untypedState] to see the source code for this prop
  @override
  set untypedState(value) =>
      state['StatefulComponentTestState.untypedState'] = value;

  /// Go to [_$StatefulComponentTestState.customKeyState] to see the source code for this prop
  @override
  @Accessor(key: 'custom key!')
  get customKeyState => state['StatefulComponentTestState.custom key!'];

  /// Go to [_$StatefulComponentTestState.customKeyState] to see the source code for this prop
  @override
  @Accessor(key: 'custom key!')
  set customKeyState(value) =>
      state['StatefulComponentTestState.custom key!'] = value;

  /// Go to [_$StatefulComponentTestState.customNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  get customNamespaceState => state['custom namespace~~customNamespaceState'];

  /// Go to [_$StatefulComponentTestState.customNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceState(value) =>
      state['custom namespace~~customNamespaceState'] = value;

  /// Go to [_$StatefulComponentTestState.customKeyAndNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  get customKeyAndNamespaceState => state['custom namespace~~custom key!'];

  /// Go to [_$StatefulComponentTestState.customKeyAndNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceState(value) =>
      state['custom namespace~~custom key!'] = value;
  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [
    const StateDescriptor('StatefulComponentTestState.stringState'),
    const StateDescriptor('StatefulComponentTestState.dynamicState'),
    const StateDescriptor('StatefulComponentTestState.untypedState'),
    const StateDescriptor('StatefulComponentTestState.custom key!'),
    const StateDescriptor('custom namespace~~customNamespaceState'),
    const StateDescriptor('custom namespace~~custom key!')
  ];
  static const List<String> $stateKeys = const [
    'StatefulComponentTestState.stringState',
    'StatefulComponentTestState.dynamicState',
    'StatefulComponentTestState.untypedState',
    'StatefulComponentTestState.custom key!',
    'custom namespace~~customNamespaceState',
    'custom namespace~~custom key!'
  ];
}

const StateMeta _$metaForStatefulComponentTestState = const StateMeta(
  fields: _$StatefulComponentTestStateAccessorsMixin.$state,
  keys: _$StatefulComponentTestStateAccessorsMixin.$stateKeys,
);

class StatefulComponentTestState extends _$StatefulComponentTestState
    with _$StatefulComponentTestStateAccessorsMixin {
  static const StateMeta meta = _$metaForStatefulComponentTestState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
class _$$StatefulComponentTestState extends _$StatefulComponentTestState
    with _$StatefulComponentTestStateAccessorsMixin
    implements StatefulComponentTestState {
  _$$StatefulComponentTestState(Map backingMap)
      : this._state = backingMap ?? {};

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
class _$StatefulComponentTestComponent extends StatefulComponentTestComponent {
  @override
  _$$StatefulComponentTestProps typedPropsFactory(Map backingMap) =>
      new _$$StatefulComponentTestProps(backingMap);

  @override
  _$$StatefulComponentTestState typedStateFactory(Map backingMap) =>
      new _$$StatefulComponentTestState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$StatefulComponentTestProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForStatefulComponentTestProps
  ];
}
