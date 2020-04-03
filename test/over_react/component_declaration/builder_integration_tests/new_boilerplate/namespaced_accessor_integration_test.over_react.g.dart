// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'namespaced_accessor_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $NamespacedAccessorTestComponentFactory = registerComponent2(
  () => _$NamespacedAccessorTestComponent(),
  builderFactory: _$NamespacedAccessorTest,
  componentClass: NamespacedAccessorTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'NamespacedAccessorTest',
);

_$$NamespacedAccessorTestProps _$NamespacedAccessorTest([Map backingProps]) =>
    backingProps == null
        ? _$$NamespacedAccessorTestProps$JsMap(JsBackedMap())
        : _$$NamespacedAccessorTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$NamespacedAccessorTestProps extends UiProps
    with
        NamespacedAccessorTestProps,
        $NamespacedAccessorTestProps // If this generated mixin is undefined, it's likely because NamespacedAccessorTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of NamespacedAccessorTestProps.
{
  _$$NamespacedAccessorTestProps._();

  factory _$$NamespacedAccessorTestProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$NamespacedAccessorTestProps$JsMap(backingMap);
    } else {
      return _$$NamespacedAccessorTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $NamespacedAccessorTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$NamespacedAccessorTestProps$PlainMap
    extends _$$NamespacedAccessorTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$NamespacedAccessorTestProps$PlainMap(Map backingMap)
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
class _$$NamespacedAccessorTestProps$JsMap
    extends _$$NamespacedAccessorTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$NamespacedAccessorTestProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$NamespacedAccessorTestState extends UiState
    with
        NamespacedAccessorTestState,
        $NamespacedAccessorTestState // If this generated mixin is undefined, it's likely because NamespacedAccessorTestState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of NamespacedAccessorTestState.
{
  _$$NamespacedAccessorTestState._();

  factory _$$NamespacedAccessorTestState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$NamespacedAccessorTestState$JsMap(backingMap);
    } else {
      return _$$NamespacedAccessorTestState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$NamespacedAccessorTestState$PlainMap
    extends _$$NamespacedAccessorTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$NamespacedAccessorTestState$PlainMap(Map backingMap)
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
class _$$NamespacedAccessorTestState$JsMap
    extends _$$NamespacedAccessorTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$NamespacedAccessorTestState$JsMap(JsBackedMap backingMap)
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
class _$NamespacedAccessorTestComponent
    extends NamespacedAccessorTestComponent {
  _$$NamespacedAccessorTestProps$JsMap _cachedTypedProps;

  @override
  _$$NamespacedAccessorTestProps$JsMap get props => _cachedTypedProps;

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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
  }

  @override
  _$$NamespacedAccessorTestProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$NamespacedAccessorTestProps$JsMap(backingMap);

  @override
  _$$NamespacedAccessorTestProps typedPropsFactory(Map backingMap) =>
      _$$NamespacedAccessorTestProps(backingMap);

  _$$NamespacedAccessorTestState$JsMap _cachedTypedState;
  @override
  _$$NamespacedAccessorTestState$JsMap get state => _cachedTypedState;

  @override
  set state(Map value) {
    assert(
        value is JsBackedMap,
        'Component2.state should only be set via '
        'initialState or setState.');
    super.state = value;
    _cachedTypedState = typedStateFactoryJs(value);
  }

  @override
  _$$NamespacedAccessorTestState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$NamespacedAccessorTestState$JsMap(backingMap);

  @override
  _$$NamespacedAccessorTestState typedStateFactory(Map backingMap) =>
      _$$NamespacedAccessorTestState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from NamespacedAccessorTestProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(NamespacedAccessorTestProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because NamespacedAccessorTestProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of NamespacedAccessorTestProps.
        NamespacedAccessorTestProps: $NamespacedAccessorTestProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $NamespacedAccessorTestProps on NamespacedAccessorTestProps {
  static const PropsMeta meta = _$metaForNamespacedAccessorTestProps;
  @override
  String get stringProp =>
      props[_$key__stringProp__NamespacedAccessorTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set stringProp(String value) =>
      props[_$key__stringProp__NamespacedAccessorTestProps] = value;
  @override
  dynamic get dynamicProp =>
      props[_$key__dynamicProp__NamespacedAccessorTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set dynamicProp(dynamic value) =>
      props[_$key__dynamicProp__NamespacedAccessorTestProps] = value;
  @override
  get untypedProp =>
      props[_$key__untypedProp__NamespacedAccessorTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set untypedProp(value) =>
      props[_$key__untypedProp__NamespacedAccessorTestProps] = value;
  @override
  @Accessor(key: 'custom key!')
  dynamic get customKeyProp =>
      props[_$key__customKeyProp__NamespacedAccessorTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(key: 'custom key!')
  set customKeyProp(dynamic value) =>
      props[_$key__customKeyProp__NamespacedAccessorTestProps] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic get customNamespaceProp =>
      props[_$key__customNamespaceProp__NamespacedAccessorTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceProp(dynamic value) =>
      props[_$key__customNamespaceProp__NamespacedAccessorTestProps] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic get customKeyAndNamespaceProp =>
      props[_$key__customKeyAndNamespaceProp__NamespacedAccessorTestProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceProp(dynamic value) =>
      props[_$key__customKeyAndNamespaceProp__NamespacedAccessorTestProps] =
          value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__stringProp__NamespacedAccessorTestProps =
      PropDescriptor(_$key__stringProp__NamespacedAccessorTestProps);
  static const PropDescriptor _$prop__dynamicProp__NamespacedAccessorTestProps =
      PropDescriptor(_$key__dynamicProp__NamespacedAccessorTestProps);
  static const PropDescriptor _$prop__untypedProp__NamespacedAccessorTestProps =
      PropDescriptor(_$key__untypedProp__NamespacedAccessorTestProps);
  static const PropDescriptor
      _$prop__customKeyProp__NamespacedAccessorTestProps =
      PropDescriptor(_$key__customKeyProp__NamespacedAccessorTestProps);
  static const PropDescriptor
      _$prop__customNamespaceProp__NamespacedAccessorTestProps =
      PropDescriptor(_$key__customNamespaceProp__NamespacedAccessorTestProps);
  static const PropDescriptor
      _$prop__customKeyAndNamespaceProp__NamespacedAccessorTestProps =
      PropDescriptor(
          _$key__customKeyAndNamespaceProp__NamespacedAccessorTestProps);
  static const String _$key__stringProp__NamespacedAccessorTestProps =
      'custom props class namespace**stringProp';
  static const String _$key__dynamicProp__NamespacedAccessorTestProps =
      'custom props class namespace**dynamicProp';
  static const String _$key__untypedProp__NamespacedAccessorTestProps =
      'custom props class namespace**untypedProp';
  static const String _$key__customKeyProp__NamespacedAccessorTestProps =
      'custom props class namespace**custom key!';
  static const String _$key__customNamespaceProp__NamespacedAccessorTestProps =
      'custom namespace~~customNamespaceProp';
  static const String
      _$key__customKeyAndNamespaceProp__NamespacedAccessorTestProps =
      'custom namespace~~custom key!';

  static const List<PropDescriptor> $props = [
    _$prop__stringProp__NamespacedAccessorTestProps,
    _$prop__dynamicProp__NamespacedAccessorTestProps,
    _$prop__untypedProp__NamespacedAccessorTestProps,
    _$prop__customKeyProp__NamespacedAccessorTestProps,
    _$prop__customNamespaceProp__NamespacedAccessorTestProps,
    _$prop__customKeyAndNamespaceProp__NamespacedAccessorTestProps
  ];
  static const List<String> $propKeys = [
    _$key__stringProp__NamespacedAccessorTestProps,
    _$key__dynamicProp__NamespacedAccessorTestProps,
    _$key__untypedProp__NamespacedAccessorTestProps,
    _$key__customKeyProp__NamespacedAccessorTestProps,
    _$key__customNamespaceProp__NamespacedAccessorTestProps,
    _$key__customKeyAndNamespaceProp__NamespacedAccessorTestProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForNamespacedAccessorTestProps = PropsMeta(
  fields: $NamespacedAccessorTestProps.$props,
  keys: $NamespacedAccessorTestProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $NamespacedAccessorTestState on NamespacedAccessorTestState {
  static const StateMeta meta = _$metaForNamespacedAccessorTestState;
  @override
  String get stringState =>
      state[_$key__stringState__NamespacedAccessorTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set stringState(String value) =>
      state[_$key__stringState__NamespacedAccessorTestState] = value;
  @override
  dynamic get dynamicState =>
      state[_$key__dynamicState__NamespacedAccessorTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set dynamicState(dynamic value) =>
      state[_$key__dynamicState__NamespacedAccessorTestState] = value;
  @override
  get untypedState =>
      state[_$key__untypedState__NamespacedAccessorTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set untypedState(value) =>
      state[_$key__untypedState__NamespacedAccessorTestState] = value;
  @override
  @Accessor(key: 'custom key!')
  dynamic get customKeyState =>
      state[_$key__customKeyState__NamespacedAccessorTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(key: 'custom key!')
  set customKeyState(dynamic value) =>
      state[_$key__customKeyState__NamespacedAccessorTestState] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  dynamic get customNamespaceState =>
      state[_$key__customNamespaceState__NamespacedAccessorTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: 'custom namespace~~')
  set customNamespaceState(dynamic value) =>
      state[_$key__customNamespaceState__NamespacedAccessorTestState] = value;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  dynamic get customKeyAndNamespaceState =>
      state[_$key__customKeyAndNamespaceState__NamespacedAccessorTestState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @Accessor(keyNamespace: 'custom namespace~~', key: 'custom key!')
  set customKeyAndNamespaceState(dynamic value) =>
      state[_$key__customKeyAndNamespaceState__NamespacedAccessorTestState] =
          value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__stringState__NamespacedAccessorTestState =
      StateDescriptor(_$key__stringState__NamespacedAccessorTestState);
  static const StateDescriptor
      _$prop__dynamicState__NamespacedAccessorTestState =
      StateDescriptor(_$key__dynamicState__NamespacedAccessorTestState);
  static const StateDescriptor
      _$prop__untypedState__NamespacedAccessorTestState =
      StateDescriptor(_$key__untypedState__NamespacedAccessorTestState);
  static const StateDescriptor
      _$prop__customKeyState__NamespacedAccessorTestState =
      StateDescriptor(_$key__customKeyState__NamespacedAccessorTestState);
  static const StateDescriptor
      _$prop__customNamespaceState__NamespacedAccessorTestState =
      StateDescriptor(_$key__customNamespaceState__NamespacedAccessorTestState);
  static const StateDescriptor
      _$prop__customKeyAndNamespaceState__NamespacedAccessorTestState =
      StateDescriptor(
          _$key__customKeyAndNamespaceState__NamespacedAccessorTestState);
  static const String _$key__stringState__NamespacedAccessorTestState =
      'custom state class namespace**stringState';
  static const String _$key__dynamicState__NamespacedAccessorTestState =
      'custom state class namespace**dynamicState';
  static const String _$key__untypedState__NamespacedAccessorTestState =
      'custom state class namespace**untypedState';
  static const String _$key__customKeyState__NamespacedAccessorTestState =
      'custom state class namespace**custom key!';
  static const String _$key__customNamespaceState__NamespacedAccessorTestState =
      'custom namespace~~customNamespaceState';
  static const String
      _$key__customKeyAndNamespaceState__NamespacedAccessorTestState =
      'custom namespace~~custom key!';

  static const List<StateDescriptor> $state = [
    _$prop__stringState__NamespacedAccessorTestState,
    _$prop__dynamicState__NamespacedAccessorTestState,
    _$prop__untypedState__NamespacedAccessorTestState,
    _$prop__customKeyState__NamespacedAccessorTestState,
    _$prop__customNamespaceState__NamespacedAccessorTestState,
    _$prop__customKeyAndNamespaceState__NamespacedAccessorTestState
  ];
  static const List<String> $stateKeys = [
    _$key__stringState__NamespacedAccessorTestState,
    _$key__dynamicState__NamespacedAccessorTestState,
    _$key__untypedState__NamespacedAccessorTestState,
    _$key__customKeyState__NamespacedAccessorTestState,
    _$key__customNamespaceState__NamespacedAccessorTestState,
    _$key__customKeyAndNamespaceState__NamespacedAccessorTestState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForNamespacedAccessorTestState = StateMeta(
  fields: $NamespacedAccessorTestState.$state,
  keys: $NamespacedAccessorTestState.$stateKeys,
);
