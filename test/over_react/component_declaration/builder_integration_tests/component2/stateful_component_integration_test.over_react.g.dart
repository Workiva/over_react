// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stateful_component_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $StatefulComponentTestComponentFactory = registerComponent2(
  () => new _$StatefulComponentTestComponent(),
  builderFactory: StatefulComponentTest,
  componentClass: StatefulComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'StatefulComponentTest',
);

abstract class _$StatefulComponentTestPropsAccessorsMixin
    implements _$StatefulComponentTestProps {
  @override
  Map get props;

  /// Used to test if a component has the capability to set state via this.setState.
  ///
  /// <!-- Generated from [_$StatefulComponentTestProps.setStateDirectly] -->
  @override
  bool get setStateDirectly =>
      props[_$key__setStateDirectly___$StatefulComponentTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Used to test if a component has the capability to set state via this.setState.
  ///
  /// <!-- Generated from [_$StatefulComponentTestProps.setStateDirectly] -->
  @override
  set setStateDirectly(bool value) =>
      props[_$key__setStateDirectly___$StatefulComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__setStateDirectly___$StatefulComponentTestProps =
      const PropDescriptor(
          _$key__setStateDirectly___$StatefulComponentTestProps);
  static const String _$key__setStateDirectly___$StatefulComponentTestProps =
      'StatefulComponentTestProps.setStateDirectly';

  static const List<PropDescriptor> $props = const [
    _$prop__setStateDirectly___$StatefulComponentTestProps
  ];
  static const List<String> $propKeys = const [
    _$key__setStateDirectly___$StatefulComponentTestProps
  ];
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
    backingProps == null
        ? new _$$StatefulComponentTestProps$JsMap(new JsBackedMap())
        : new _$$StatefulComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$StatefulComponentTestProps
    extends _$StatefulComponentTestProps
    with _$StatefulComponentTestPropsAccessorsMixin
    implements StatefulComponentTestProps {
  _$$StatefulComponentTestProps._();

  factory _$$StatefulComponentTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$StatefulComponentTestProps$JsMap(backingMap);
    } else {
      return new _$$StatefulComponentTestProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $StatefulComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'StatefulComponentTestProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$StatefulComponentTestProps$PlainMap
    extends _$$StatefulComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestProps$PlainMap(Map backingMap)
      : this._props = {},
        super._() {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;
}

// Concrete props implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$StatefulComponentTestProps$JsMap
    extends _$$StatefulComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$StatefulComponentTestStateAccessorsMixin
    implements _$StatefulComponentTestState {
  @override
  Map get state;

  /// <!-- Generated from [_$StatefulComponentTestState.stringState] -->
  @override
  String get stringState =>
      state[_$key__stringState___$StatefulComponentTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$StatefulComponentTestState.stringState] -->
  @override
  set stringState(String value) =>
      state[_$key__stringState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.dynamicState] -->
  @override
  dynamic get dynamicState =>
      state[_$key__dynamicState___$StatefulComponentTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$StatefulComponentTestState.dynamicState] -->
  @override
  set dynamicState(dynamic value) =>
      state[_$key__dynamicState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.untypedState] -->
  @override
  get untypedState =>
      state[_$key__untypedState___$StatefulComponentTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$StatefulComponentTestState.untypedState] -->
  @override
  set untypedState(value) =>
      state[_$key__untypedState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.customKeyState] -->
  @override
  @Accessor(key: 'custom key!')
  get customKeyState =>
      state[_$key__customKeyState___$StatefulComponentTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$StatefulComponentTestState.customKeyState] -->
  @override
  @Accessor(key: 'custom key!')
  set customKeyState(value) =>
      state[_$key__customKeyState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.customNamespaceState] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  get customNamespaceState =>
      state[_$key__customNamespaceState___$StatefulComponentTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$StatefulComponentTestState.customNamespaceState] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceState(value) =>
      state[_$key__customNamespaceState___$StatefulComponentTestState] = value;

  /// <!-- Generated from [_$StatefulComponentTestState.customKeyAndNamespaceState] -->
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  get customKeyAndNamespaceState =>
      state[_$key__customKeyAndNamespaceState___$StatefulComponentTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$StatefulComponentTestState.customKeyAndNamespaceState] -->
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

class StatefulComponentTestState extends _$StatefulComponentTestState
    with _$StatefulComponentTestStateAccessorsMixin {
  static const StateMeta meta = _$metaForStatefulComponentTestState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$StatefulComponentTestState
    extends _$StatefulComponentTestState
    with _$StatefulComponentTestStateAccessorsMixin
    implements StatefulComponentTestState {
  _$$StatefulComponentTestState._();

  factory _$$StatefulComponentTestState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$StatefulComponentTestState$JsMap(backingMap);
    } else {
      return new _$$StatefulComponentTestState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$StatefulComponentTestState$PlainMap
    extends _$$StatefulComponentTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestState$PlainMap(Map backingMap)
      : this._state = {},
        super._() {
    this._state = backingMap ?? {};
  }

  /// The backing state map proxied by this class.
  @override
  Map get state => _state;
  Map _state;
}

// Concrete state implementation that can only be backed by [JsMap],
// allowing dart2js to compile more optimal code for key-value pair reads/writes.
class _$$StatefulComponentTestState$JsMap
    extends _$$StatefulComponentTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestState$JsMap(JsBackedMap backingMap)
      : this._state = new JsBackedMap(),
        super._() {
    this._state = backingMap ?? new JsBackedMap();
  }

  /// The backing state map proxied by this class.
  @override
  JsBackedMap get state => _state;
  JsBackedMap _state;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$StatefulComponentTestComponent extends StatefulComponentTestComponent {
  _$$StatefulComponentTestProps$JsMap _cachedTypedProps;

  @override
  _$$StatefulComponentTestProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    super.props = value;
    _cachedTypedProps = typedPropsFactoryJs(value);
  }

  @override
  _$$StatefulComponentTestProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$StatefulComponentTestProps$JsMap(backingMap);

  @override
  _$$StatefulComponentTestProps typedPropsFactory(Map backingMap) =>
      new _$$StatefulComponentTestProps(backingMap);

  _$$StatefulComponentTestState$JsMap _cachedTypedState;
  @override
  _$$StatefulComponentTestState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initializeState (within the init lifecycle method) or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value);
  }

  @override
  _$$StatefulComponentTestState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      new _$$StatefulComponentTestState$JsMap(backingMap);

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
