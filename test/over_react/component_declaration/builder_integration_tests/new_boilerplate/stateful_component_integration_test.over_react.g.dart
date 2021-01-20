// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'stateful_component_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $StatefulComponentTestComponentFactory = registerComponent2(
  () => _$StatefulComponentTestComponent(),
  builderFactory: _$StatefulComponentTest,
  componentClass: StatefulComponentTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'StatefulComponentTest',
);

_$$StatefulComponentTestProps _$StatefulComponentTest([Map backingProps]) =>
    backingProps == null
        ? _$$StatefulComponentTestProps$JsMap(JsBackedMap())
        : _$$StatefulComponentTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$StatefulComponentTestProps extends UiProps
    with
        StatefulComponentTestProps,
        $StatefulComponentTestProps // If this generated mixin is undefined, it's likely because StatefulComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of StatefulComponentTestProps, and check that $StatefulComponentTestProps is exported/imported properly.
{
  _$$StatefulComponentTestProps._();

  factory _$$StatefulComponentTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$StatefulComponentTestProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$StatefulComponentTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $StatefulComponentTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because StatefulComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of StatefulComponentTestProps, and check that $StatefulComponentTestProps is exported/imported properly.
        StatefulComponentTestProps: $StatefulComponentTestProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$StatefulComponentTestProps$JsMap
    extends _$$StatefulComponentTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$StatefulComponentTestState extends UiState
    with
        StatefulComponentTestState,
        $StatefulComponentTestState // If this generated mixin is undefined, it's likely because StatefulComponentTestState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of StatefulComponentTestState, and check that $StatefulComponentTestState is exported/imported properly.
{
  _$$StatefulComponentTestState._();

  factory _$$StatefulComponentTestState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$StatefulComponentTestState$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$StatefulComponentTestState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$StatefulComponentTestState$JsMap
    extends _$$StatefulComponentTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$StatefulComponentTestState$JsMap(JsBackedMap backingMap)
      : this._state = JsBackedMap(),
        super._() {
    this._state = backingMap ?? JsBackedMap();
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$StatefulComponentTestComponent extends StatefulComponentTestComponent {
  _$$StatefulComponentTestProps$JsMap _cachedTypedProps;

  @override
  _$$StatefulComponentTestProps$JsMap get props => _cachedTypedProps;

  @override
  set props(Map value) {
    assert(
        getBackingMap(value) is JsBackedMap,
        'Component2.props should never be set directly in '
        'production. If this is required for testing, the '
        'component should be rendered within the test. If '
        'that does not have the necessary result, the last '
        'resort is to use typedPropsFactoryJs.');
    super.props = value;
    _cachedTypedProps =
        typedPropsFactoryJs(getBackingMap(value) as JsBackedMap);
  }

  @override
  _$$StatefulComponentTestProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$StatefulComponentTestProps$JsMap(backingMap);

  @override
  _$$StatefulComponentTestProps typedPropsFactory(Map backingMap) =>
      _$$StatefulComponentTestProps(backingMap);

  _$$StatefulComponentTestState$JsMap _cachedTypedState;
  @override
  _$$StatefulComponentTestState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value as JsBackedMap);
  }

  @override
  _$$StatefulComponentTestState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$StatefulComponentTestState$JsMap(backingMap);

  @override
  _$$StatefulComponentTestState typedStateFactory(Map backingMap) =>
      _$$StatefulComponentTestState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by StatefulComponentTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because StatefulComponentTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of StatefulComponentTestProps, and check that $StatefulComponentTestProps is exported/imported properly.
        StatefulComponentTestProps: $StatefulComponentTestProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $StatefulComponentTestProps on StatefulComponentTestProps {
  static const PropsMeta meta = _$metaForStatefulComponentTestProps;
  @override
  bool get setStateDirectly =>
      (props[_$key__setStateDirectly__StatefulComponentTestProps] ?? null)
          as bool;
  @override
  set setStateDirectly(bool value) =>
      props[_$key__setStateDirectly__StatefulComponentTestProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__setStateDirectly__StatefulComponentTestProps =
      PropDescriptor(_$key__setStateDirectly__StatefulComponentTestProps);
  static const String _$key__setStateDirectly__StatefulComponentTestProps =
      'StatefulComponentTestProps.setStateDirectly';

  static const List<PropDescriptor> $props = [
    _$prop__setStateDirectly__StatefulComponentTestProps
  ];
  static const List<String> $propKeys = [
    _$key__setStateDirectly__StatefulComponentTestProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForStatefulComponentTestProps = PropsMeta(
  fields: $StatefulComponentTestProps.$props,
  keys: $StatefulComponentTestProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $StatefulComponentTestState on StatefulComponentTestState {
  static const StateMeta meta = _$metaForStatefulComponentTestState;
  @override
  String get stringState =>
      (state[_$key__stringState__StatefulComponentTestState] ?? null) as String;
  @override
  set stringState(String value) =>
      state[_$key__stringState__StatefulComponentTestState] = value;
  @override
  dynamic get dynamicState =>
      (state[_$key__dynamicState__StatefulComponentTestState] ?? null)
          as dynamic;
  @override
  set dynamicState(dynamic value) =>
      state[_$key__dynamicState__StatefulComponentTestState] = value;
  @override
  get untypedState =>
      state[_$key__untypedState__StatefulComponentTestState] ?? null;
  @override
  set untypedState(value) =>
      state[_$key__untypedState__StatefulComponentTestState] = value;
  @override
  @Accessor(key: 'custom key!')
  dynamic get customKeyState =>
      (state[_$key__customKeyState__StatefulComponentTestState] ?? null)
          as dynamic;
  @override
  @Accessor(key: 'custom key!')
  set customKeyState(dynamic value) =>
      state[_$key__customKeyState__StatefulComponentTestState] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic get customNamespaceState =>
      (state[_$key__customNamespaceState__StatefulComponentTestState] ?? null)
          as dynamic;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceState(dynamic value) =>
      state[_$key__customNamespaceState__StatefulComponentTestState] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic get customKeyAndNamespaceState =>
      (state[_$key__customKeyAndNamespaceState__StatefulComponentTestState] ??
          null) as dynamic;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceState(dynamic value) =>
      state[_$key__customKeyAndNamespaceState__StatefulComponentTestState] =
          value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__stringState__StatefulComponentTestState =
      StateDescriptor(_$key__stringState__StatefulComponentTestState);
  static const StateDescriptor
      _$prop__dynamicState__StatefulComponentTestState =
      StateDescriptor(_$key__dynamicState__StatefulComponentTestState);
  static const StateDescriptor
      _$prop__untypedState__StatefulComponentTestState =
      StateDescriptor(_$key__untypedState__StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customKeyState__StatefulComponentTestState =
      StateDescriptor(_$key__customKeyState__StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customNamespaceState__StatefulComponentTestState =
      StateDescriptor(_$key__customNamespaceState__StatefulComponentTestState);
  static const StateDescriptor
      _$prop__customKeyAndNamespaceState__StatefulComponentTestState =
      StateDescriptor(
          _$key__customKeyAndNamespaceState__StatefulComponentTestState);
  static const String _$key__stringState__StatefulComponentTestState =
      'StatefulComponentTestState.stringState';
  static const String _$key__dynamicState__StatefulComponentTestState =
      'StatefulComponentTestState.dynamicState';
  static const String _$key__untypedState__StatefulComponentTestState =
      'StatefulComponentTestState.untypedState';
  static const String _$key__customKeyState__StatefulComponentTestState =
      'StatefulComponentTestState.custom key!';
  static const String _$key__customNamespaceState__StatefulComponentTestState =
      'custom namespace~~customNamespaceState';
  static const String
      _$key__customKeyAndNamespaceState__StatefulComponentTestState =
      'custom namespace~~custom key!';

  static const List<StateDescriptor> $state = [
    _$prop__stringState__StatefulComponentTestState,
    _$prop__dynamicState__StatefulComponentTestState,
    _$prop__untypedState__StatefulComponentTestState,
    _$prop__customKeyState__StatefulComponentTestState,
    _$prop__customNamespaceState__StatefulComponentTestState,
    _$prop__customKeyAndNamespaceState__StatefulComponentTestState
  ];
  static const List<String> $stateKeys = [
    _$key__stringState__StatefulComponentTestState,
    _$key__dynamicState__StatefulComponentTestState,
    _$key__untypedState__StatefulComponentTestState,
    _$key__customKeyState__StatefulComponentTestState,
    _$key__customNamespaceState__StatefulComponentTestState,
    _$key__customKeyAndNamespaceState__StatefulComponentTestState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForStatefulComponentTestState = StateMeta(
  fields: $StatefulComponentTestState.$state,
  keys: $StatefulComponentTestState.$stateKeys,
);
