// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'do_not_generate_accessor_integration_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $DoNotGenerateAccessorTestComponentFactory = registerComponent2(
  () => _$DoNotGenerateAccessorTestComponent(),
  builderFactory: _$DoNotGenerateAccessorTest,
  componentClass: DoNotGenerateAccessorTestComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'DoNotGenerateAccessorTest',
);

abstract class _$DoNotGenerateAccessorTestPropsAccessorsMixin
    implements _$DoNotGenerateAccessorTestProps {
  @override
  Map get props;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestProps.generated1Prop] -->
  @override
  dynamic get generated1Prop =>
      (props[_$key__generated1Prop___$DoNotGenerateAccessorTestProps] ?? null)
          as dynamic;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestProps.generated1Prop] -->
  @override
  set generated1Prop(dynamic value) =>
      props[_$key__generated1Prop___$DoNotGenerateAccessorTestProps] = value;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestProps.generated2Prop] -->
  @override
  dynamic get generated2Prop =>
      (props[_$key__generated2Prop___$DoNotGenerateAccessorTestProps] ?? null)
          as dynamic;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestProps.generated2Prop] -->
  @override
  set generated2Prop(dynamic value) =>
      props[_$key__generated2Prop___$DoNotGenerateAccessorTestProps] = value;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestProps.explicitlyGeneratedProp] -->
  @override
  @Accessor(doNotGenerate: false)
  dynamic get explicitlyGeneratedProp => (props[
          _$key__explicitlyGeneratedProp___$DoNotGenerateAccessorTestProps] ??
      null) as dynamic;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestProps.explicitlyGeneratedProp] -->
  @override
  @Accessor(doNotGenerate: false)
  set explicitlyGeneratedProp(dynamic value) =>
      props[_$key__explicitlyGeneratedProp___$DoNotGenerateAccessorTestProps] =
          value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor
      _$prop__generated1Prop___$DoNotGenerateAccessorTestProps =
      PropDescriptor(_$key__generated1Prop___$DoNotGenerateAccessorTestProps);
  static const PropDescriptor
      _$prop__generated2Prop___$DoNotGenerateAccessorTestProps =
      PropDescriptor(_$key__generated2Prop___$DoNotGenerateAccessorTestProps);
  static const PropDescriptor
      _$prop__explicitlyGeneratedProp___$DoNotGenerateAccessorTestProps =
      PropDescriptor(
          _$key__explicitlyGeneratedProp___$DoNotGenerateAccessorTestProps);
  static const String _$key__generated1Prop___$DoNotGenerateAccessorTestProps =
      'DoNotGenerateAccessorTestProps.generated1Prop';
  static const String _$key__generated2Prop___$DoNotGenerateAccessorTestProps =
      'DoNotGenerateAccessorTestProps.generated2Prop';
  static const String
      _$key__explicitlyGeneratedProp___$DoNotGenerateAccessorTestProps =
      'DoNotGenerateAccessorTestProps.explicitlyGeneratedProp';

  static const List<PropDescriptor> $props = [
    _$prop__generated1Prop___$DoNotGenerateAccessorTestProps,
    _$prop__generated2Prop___$DoNotGenerateAccessorTestProps,
    _$prop__explicitlyGeneratedProp___$DoNotGenerateAccessorTestProps
  ];
  static const List<String> $propKeys = [
    _$key__generated1Prop___$DoNotGenerateAccessorTestProps,
    _$key__generated2Prop___$DoNotGenerateAccessorTestProps,
    _$key__explicitlyGeneratedProp___$DoNotGenerateAccessorTestProps
  ];
}

const PropsMeta _$metaForDoNotGenerateAccessorTestProps = PropsMeta(
  fields: _$DoNotGenerateAccessorTestPropsAccessorsMixin.$props,
  keys: _$DoNotGenerateAccessorTestPropsAccessorsMixin.$propKeys,
);

class DoNotGenerateAccessorTestProps extends _$DoNotGenerateAccessorTestProps
    with _$DoNotGenerateAccessorTestPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForDoNotGenerateAccessorTestProps;
}

_$$DoNotGenerateAccessorTestProps _$DoNotGenerateAccessorTest(
        [Map? backingProps]) =>
    backingProps == null
        ? _$$DoNotGenerateAccessorTestProps$JsMap(JsBackedMap())
        : _$$DoNotGenerateAccessorTestProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$DoNotGenerateAccessorTestProps
    extends _$DoNotGenerateAccessorTestProps
    with _$DoNotGenerateAccessorTestPropsAccessorsMixin
    implements DoNotGenerateAccessorTestProps {
  _$$DoNotGenerateAccessorTestProps._();

  factory _$$DoNotGenerateAccessorTestProps(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DoNotGenerateAccessorTestProps$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$DoNotGenerateAccessorTestProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $DoNotGenerateAccessorTestComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'DoNotGenerateAccessorTestProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$DoNotGenerateAccessorTestProps$PlainMap
    extends _$$DoNotGenerateAccessorTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DoNotGenerateAccessorTestProps$PlainMap(Map? backingMap)
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
class _$$DoNotGenerateAccessorTestProps$JsMap
    extends _$$DoNotGenerateAccessorTestProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DoNotGenerateAccessorTestProps$JsMap(JsBackedMap? backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$DoNotGenerateAccessorTestStateAccessorsMixin
    implements _$DoNotGenerateAccessorTestState {
  @override
  Map get state;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestState.generated1State] -->
  @override
  dynamic get generated1State =>
      (state[_$key__generated1State___$DoNotGenerateAccessorTestState] ?? null)
          as dynamic;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestState.generated1State] -->
  @override
  set generated1State(dynamic value) =>
      state[_$key__generated1State___$DoNotGenerateAccessorTestState] = value;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestState.generated2State] -->
  @override
  dynamic get generated2State =>
      (state[_$key__generated2State___$DoNotGenerateAccessorTestState] ?? null)
          as dynamic;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestState.generated2State] -->
  @override
  set generated2State(dynamic value) =>
      state[_$key__generated2State___$DoNotGenerateAccessorTestState] = value;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestState.explicitlyGeneratedState] -->
  @override
  @Accessor(doNotGenerate: false)
  dynamic get explicitlyGeneratedState => (state[
          _$key__explicitlyGeneratedState___$DoNotGenerateAccessorTestState] ??
      null) as dynamic;

  /// <!-- Generated from [_$DoNotGenerateAccessorTestState.explicitlyGeneratedState] -->
  @override
  @Accessor(doNotGenerate: false)
  set explicitlyGeneratedState(dynamic value) =>
      state[_$key__explicitlyGeneratedState___$DoNotGenerateAccessorTestState] =
          value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__generated1State___$DoNotGenerateAccessorTestState =
      StateDescriptor(_$key__generated1State___$DoNotGenerateAccessorTestState);
  static const StateDescriptor
      _$prop__generated2State___$DoNotGenerateAccessorTestState =
      StateDescriptor(_$key__generated2State___$DoNotGenerateAccessorTestState);
  static const StateDescriptor
      _$prop__explicitlyGeneratedState___$DoNotGenerateAccessorTestState =
      StateDescriptor(
          _$key__explicitlyGeneratedState___$DoNotGenerateAccessorTestState);
  static const String _$key__generated1State___$DoNotGenerateAccessorTestState =
      'DoNotGenerateAccessorTestState.generated1State';
  static const String _$key__generated2State___$DoNotGenerateAccessorTestState =
      'DoNotGenerateAccessorTestState.generated2State';
  static const String
      _$key__explicitlyGeneratedState___$DoNotGenerateAccessorTestState =
      'DoNotGenerateAccessorTestState.explicitlyGeneratedState';

  static const List<StateDescriptor> $state = [
    _$prop__generated1State___$DoNotGenerateAccessorTestState,
    _$prop__generated2State___$DoNotGenerateAccessorTestState,
    _$prop__explicitlyGeneratedState___$DoNotGenerateAccessorTestState
  ];
  static const List<String> $stateKeys = [
    _$key__generated1State___$DoNotGenerateAccessorTestState,
    _$key__generated2State___$DoNotGenerateAccessorTestState,
    _$key__explicitlyGeneratedState___$DoNotGenerateAccessorTestState
  ];
}

const StateMeta _$metaForDoNotGenerateAccessorTestState = StateMeta(
  fields: _$DoNotGenerateAccessorTestStateAccessorsMixin.$state,
  keys: _$DoNotGenerateAccessorTestStateAccessorsMixin.$stateKeys,
);

class DoNotGenerateAccessorTestState extends _$DoNotGenerateAccessorTestState
    with _$DoNotGenerateAccessorTestStateAccessorsMixin {
  static const StateMeta meta = _$metaForDoNotGenerateAccessorTestState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$DoNotGenerateAccessorTestState
    extends _$DoNotGenerateAccessorTestState
    with _$DoNotGenerateAccessorTestStateAccessorsMixin
    implements DoNotGenerateAccessorTestState {
  _$$DoNotGenerateAccessorTestState._();

  factory _$$DoNotGenerateAccessorTestState(Map? backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$DoNotGenerateAccessorTestState$JsMap(
          backingMap as JsBackedMap?);
    } else {
      return _$$DoNotGenerateAccessorTestState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$DoNotGenerateAccessorTestState$PlainMap
    extends _$$DoNotGenerateAccessorTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DoNotGenerateAccessorTestState$PlainMap(Map? backingMap)
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
class _$$DoNotGenerateAccessorTestState$JsMap
    extends _$$DoNotGenerateAccessorTestState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$DoNotGenerateAccessorTestState$JsMap(JsBackedMap? backingMap)
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
class _$DoNotGenerateAccessorTestComponent
    extends DoNotGenerateAccessorTestComponent {
  late _$$DoNotGenerateAccessorTestProps$JsMap _cachedTypedProps;

  @override
  _$$DoNotGenerateAccessorTestProps$JsMap get props => _cachedTypedProps;

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
  _$$DoNotGenerateAccessorTestProps$JsMap typedPropsFactoryJs(
          JsBackedMap? backingMap) =>
      _$$DoNotGenerateAccessorTestProps$JsMap(backingMap);

  @override
  _$$DoNotGenerateAccessorTestProps typedPropsFactory(Map? backingMap) =>
      _$$DoNotGenerateAccessorTestProps(backingMap);

  late _$$DoNotGenerateAccessorTestState$JsMap _cachedTypedState;
  @override
  _$$DoNotGenerateAccessorTestState$JsMap get state => _cachedTypedState;

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
  _$$DoNotGenerateAccessorTestState$JsMap typedStateFactoryJs(
          JsBackedMap? backingMap) =>
      _$$DoNotGenerateAccessorTestState$JsMap(backingMap);

  @override
  _$$DoNotGenerateAccessorTestState typedStateFactory(Map? backingMap) =>
      _$$DoNotGenerateAccessorTestState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$DoNotGenerateAccessorTestProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForDoNotGenerateAccessorTestProps
  ];
}
