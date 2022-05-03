// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'stateful_component_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $StatefulComponentTestComponentFactory = registerComponent(
  () => _$StatefulComponentTestComponent(),
  builderFactory: _$StatefulComponentTest,
  componentClass: StatefulComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'StatefulComponentTest',
);

abstract class _$StatefulComponentTestPropsAccessorsMixin
    implements _$StatefulComponentTestProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForStatefulComponentTestProps = PropsMeta(
  fields: _$StatefulComponentTestPropsAccessorsMixin.$props,
  keys: _$StatefulComponentTestPropsAccessorsMixin.$propKeys,
);

class StatefulComponentTestProps extends _$StatefulComponentTestProps
    with _$StatefulComponentTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForStatefulComponentTestProps;
}

_$$StatefulComponentTestProps _$StatefulComponentTest([Map backingProps]) =>
    _$$StatefulComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$StatefulComponentTestProps extends _$StatefulComponentTestProps
    with _$StatefulComponentTestPropsAccessorsMixin
    implements StatefulComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestProps(Map backingMap)
      : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $StatefulComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'StatefulComponentTestProps.';
}

abstract class _$StatefulComponentTestStateAccessorsMixin
    implements _$StatefulComponentTestState {
  @override
  Map get state;

  /// <!-- Generated from [_$StatefulComponentTestState.stringState] -->
  @override
  String get stringState =>
      (state[_$key__stringState___$StatefulComponentTestState] ?? null)
          as String;

  /// <!-- Generated from [_$StatefulComponentTestState.stringState] -->
  @override
  set stringState(String value) =>
      state[_$key__stringState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.dynamicState] -->
  @override
  dynamic get dynamicState =>
      (state[_$key__dynamicState___$StatefulComponentTestState] ?? null)
          as dynamic;

  /// <!-- Generated from [_$StatefulComponentTestState.dynamicState] -->
  @override
  set dynamicState(dynamic value) =>
      state[_$key__dynamicState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.untypedState] -->
  @override
  get untypedState =>
      state[_$key__untypedState___$StatefulComponentTestState] ?? null;

  /// <!-- Generated from [_$StatefulComponentTestState.untypedState] -->
  @override
  set untypedState(value) =>
      state[_$key__untypedState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.customKeyState] -->
  @override
  @Accessor(key: 'custom key!')
  dynamic get customKeyState =>
      (state[_$key__customKeyState___$StatefulComponentTestState] ?? null)
          as dynamic;

  /// <!-- Generated from [_$StatefulComponentTestState.customKeyState] -->
  @override
  @Accessor(key: 'custom key!')
  set customKeyState(dynamic value) =>
      state[_$key__customKeyState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.customNamespaceState] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic get customNamespaceState =>
      (state[_$key__customNamespaceState___$StatefulComponentTestState] ?? null)
          as dynamic;

  /// <!-- Generated from [_$StatefulComponentTestState.customNamespaceState] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceState(dynamic value) =>
      state[_$key__customNamespaceState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.customKeyAndNamespaceState] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic get customKeyAndNamespaceState =>
      (state[_$key__customKeyAndNamespaceState___$StatefulComponentTestState] ??
          null) as dynamic;

  /// <!-- Generated from [_$StatefulComponentTestState.customKeyAndNamespaceState] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceState(dynamic value) =>
      state[_$key__customKeyAndNamespaceState___$StatefulComponentTestState] =
          value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__stringState___$StatefulComponentTestState =
      StateDescriptor(_$key__stringState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__dynamicState___$StatefulComponentTestState =
      StateDescriptor(_$key__dynamicState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__untypedState___$StatefulComponentTestState =
      StateDescriptor(_$key__untypedState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customKeyState___$StatefulComponentTestState =
      StateDescriptor(_$key__customKeyState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customNamespaceState___$StatefulComponentTestState =
      StateDescriptor(
          _$key__customNamespaceState___$StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customKeyAndNamespaceState___$StatefulComponentTestState =
      StateDescriptor(
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

  static const List<StateDescriptor> $state = [
    _$prop__stringState___$StatefulComponentTestState,
    _$prop__dynamicState___$StatefulComponentTestState,
    _$prop__untypedState___$StatefulComponentTestState,
    _$prop__customKeyState___$StatefulComponentTestState,
    _$prop__customNamespaceState___$StatefulComponentTestState,
    _$prop__customKeyAndNamespaceState___$StatefulComponentTestState
  ];
  static const List<String> $stateKeys = [
    _$key__stringState___$StatefulComponentTestState,
    _$key__dynamicState___$StatefulComponentTestState,
    _$key__untypedState___$StatefulComponentTestState,
    _$key__customKeyState___$StatefulComponentTestState,
    _$key__customNamespaceState___$StatefulComponentTestState,
    _$key__customKeyAndNamespaceState___$StatefulComponentTestState
  ];
}

const StateMeta _$metaForStatefulComponentTestState = StateMeta(
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
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestState(Map backingMap)
      : this.state = backingMap ?? ({});

  /// The backing state map proxied by this class.
  @override
  final Map state;

  /// Let `UiState` internals know that this class has been generated.
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
      _$$StatefulComponentTestProps(backingMap);

  @override
  _$$StatefulComponentTestState typedStateFactory(Map backingMap) =>
      _$$StatefulComponentTestState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$StatefulComponentTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForStatefulComponentTestProps
  ];
}
