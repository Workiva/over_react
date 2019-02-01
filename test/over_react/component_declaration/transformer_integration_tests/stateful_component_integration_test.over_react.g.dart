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
  String get stringState =>
      state[_$key__stringState___$StatefulComponentTestState];

  /// Go to [_$StatefulComponentTestState.stringState] to see the source code for this prop
  @override
  set stringState(String value) =>
      state[_$key__stringState___$StatefulComponentTestState] = value;

  /// Go to [_$StatefulComponentTestState.dynamicState] to see the source code for this prop
  @override
  dynamic get dynamicState =>
      state[_$key__dynamicState___$StatefulComponentTestState];

  /// Go to [_$StatefulComponentTestState.dynamicState] to see the source code for this prop
  @override
  set dynamicState(dynamic value) =>
      state[_$key__dynamicState___$StatefulComponentTestState] = value;

  /// Go to [_$StatefulComponentTestState.untypedState] to see the source code for this prop
  @override
  get untypedState => state[_$key__untypedState___$StatefulComponentTestState];

  /// Go to [_$StatefulComponentTestState.untypedState] to see the source code for this prop
  @override
  set untypedState(value) =>
      state[_$key__untypedState___$StatefulComponentTestState] = value;

  /// Go to [_$StatefulComponentTestState.customKeyState] to see the source code for this prop
  @override
  @Accessor(key: 'custom key!')
  get customKeyState =>
      state[_$key__customKeyState___$StatefulComponentTestState];

  /// Go to [_$StatefulComponentTestState.customKeyState] to see the source code for this prop
  @override
  @Accessor(key: 'custom key!')
  set customKeyState(value) =>
      state[_$key__customKeyState___$StatefulComponentTestState] = value;

  /// Go to [_$StatefulComponentTestState.customNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  get customNamespaceState =>
      state[_$key__customNamespaceState___$StatefulComponentTestState];

  /// Go to [_$StatefulComponentTestState.customNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceState(value) =>
      state[_$key__customNamespaceState___$StatefulComponentTestState] = value;

  /// Go to [_$StatefulComponentTestState.customKeyAndNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  get customKeyAndNamespaceState =>
      state[_$key__customKeyAndNamespaceState___$StatefulComponentTestState];

  /// Go to [_$StatefulComponentTestState.customKeyAndNamespaceState] to see the source code for this prop
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceState(value) =>
      state[_$key__customKeyAndNamespaceState___$StatefulComponentTestState] =
          value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__stringState___$StatefulComponentTestState =
      const StateDescriptor(_$key__stringState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__dynamicState___$StatefulComponentTestState =
      const StateDescriptor(_$key__dynamicState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__untypedState___$StatefulComponentTestState =
      const StateDescriptor(_$key__untypedState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customKeyState___$StatefulComponentTestState =
      const StateDescriptor(
          _$key__customKeyState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customNamespaceState___$StatefulComponentTestState =
      const StateDescriptor(
          _$key__customNamespaceState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customKeyAndNamespaceState___$StatefulComponentTestState =
      const StateDescriptor(
          _$key__customKeyAndNamespaceState___$StatefulComponentTestState);
  static const String _$key__stringState___$StatefulComponentTestState =
      'StatefulComponentTestState.stringState';
  static const String _$key__dynamicState___$StatefulComponentTestState =
      'StatefulComponentTestState.dynamicState';
  static const String _$key__untypedState___$StatefulComponentTestState =
      'StatefulComponentTestState.untypedState';
  static const String _$key__customKeyState___$StatefulComponentTestState =
      'StatefulComponentTestState.custom key!';
  static const String
      _$key__customNamespaceState___$StatefulComponentTestState =
      'custom namespace~~customNamespaceState';
  static const String
      _$key__customKeyAndNamespaceState___$StatefulComponentTestState =
      'custom namespace~~custom key!';

  static const List<StateDescriptor> $state = const [
    _$prop__stringState___$StatefulComponentTestState,
    _$prop__dynamicState___$StatefulComponentTestState,
    _$prop__untypedState___$StatefulComponentTestState,
    _$prop__customKeyState___$StatefulComponentTestState,
    _$prop__customNamespaceState___$StatefulComponentTestState,
    _$prop__customKeyAndNamespaceState___$StatefulComponentTestState
  ];
  static const List<String> $stateKeys = const [
    _$key__stringState___$StatefulComponentTestState,
    _$key__dynamicState___$StatefulComponentTestState,
    _$key__untypedState___$StatefulComponentTestState,
    _$key__customKeyState___$StatefulComponentTestState,
    _$key__customNamespaceState___$StatefulComponentTestState,
    _$key__customKeyAndNamespaceState___$StatefulComponentTestState
  ];
}

const StateMeta _$metaForStatefulComponentTestState = const StateMeta(
  fields: _$StatefulComponentTestStateAccessorsMixin.$state,
  keys: _$StatefulComponentTestStateAccessorsMixin.$stateKeys,
);

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
  typedPropsFactory(Map backingMap) =>
      new _$$StatefulComponentTestProps(backingMap);

  @override
  typedStateFactory(Map backingMap) =>
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
