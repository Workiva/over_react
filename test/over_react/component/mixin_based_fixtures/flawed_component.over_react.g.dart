// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'flawed_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $FlawedComponentFactory = registerComponent2(
  () => _$FlawedComponent(),
  builderFactory: Flawed,
  componentClass: FlawedComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Flawed',
);

_$$FlawedProps _$Flawed([Map backingProps]) => backingProps == null
    ? _$$FlawedProps$JsMap(JsBackedMap())
    : _$$FlawedProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$FlawedProps extends UiProps
    with
        FlawedProps,
        $FlawedProps // If this generated mixin is undefined, it's likely because FlawedProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FlawedProps.
{
  _$$FlawedProps._();

  factory _$$FlawedProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FlawedProps$JsMap(backingMap);
    } else {
      return _$$FlawedProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FlawedComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FlawedProps$PlainMap extends _$$FlawedProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedProps$PlainMap(Map backingMap)
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
class _$$FlawedProps$JsMap extends _$$FlawedProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$FlawedState extends UiState
    with
        FlawedState,
        $FlawedState // If this generated mixin is undefined, it's likely because FlawedState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of FlawedState.
{
  _$$FlawedState._();

  factory _$$FlawedState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FlawedState$JsMap(backingMap);
    } else {
      return _$$FlawedState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$FlawedState$PlainMap extends _$$FlawedState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedState$PlainMap(Map backingMap)
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
class _$$FlawedState$JsMap extends _$$FlawedState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FlawedState$JsMap(JsBackedMap backingMap)
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
class _$FlawedComponent extends FlawedComponent {
  _$$FlawedProps$JsMap _cachedTypedProps;

  @override
  _$$FlawedProps$JsMap get props => _cachedTypedProps;

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
  _$$FlawedProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FlawedProps$JsMap(backingMap);

  @override
  _$$FlawedProps typedPropsFactory(Map backingMap) =>
      _$$FlawedProps(backingMap);

  _$$FlawedState$JsMap _cachedTypedState;
  @override
  _$$FlawedState$JsMap get state => _cachedTypedState;

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
  _$$FlawedState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$FlawedState$JsMap(backingMap);

  @override
  _$$FlawedState typedStateFactory(Map backingMap) =>
      _$$FlawedState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from FlawedProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(FlawedProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because FlawedProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of FlawedProps.
        FlawedProps: $FlawedProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FlawedProps on FlawedProps {
  static const PropsMeta meta = _$metaForFlawedProps;
  @override
  String get buttonTestIdPrefix =>
      props[_$key__buttonTestIdPrefix__FlawedProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set buttonTestIdPrefix(String value) =>
      props[_$key__buttonTestIdPrefix__FlawedProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__buttonTestIdPrefix__FlawedProps =
      PropDescriptor(_$key__buttonTestIdPrefix__FlawedProps);
  static const String _$key__buttonTestIdPrefix__FlawedProps =
      'FlawedProps.buttonTestIdPrefix';

  static const List<PropDescriptor> $props = [
    _$prop__buttonTestIdPrefix__FlawedProps
  ];
  static const List<String> $propKeys = [
    _$key__buttonTestIdPrefix__FlawedProps
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForFlawedProps = PropsMeta(
  fields: $FlawedProps.$props,
  keys: $FlawedProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $FlawedState on FlawedState {
  static const StateMeta meta = _$metaForFlawedState;
  @override
  int get errorCount =>
      state[_$key__errorCount__FlawedState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set errorCount(int value) => state[_$key__errorCount__FlawedState] = value;
  @override
  int get differentTypeOfErrorCount =>
      state[_$key__differentTypeOfErrorCount__FlawedState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set differentTypeOfErrorCount(int value) =>
      state[_$key__differentTypeOfErrorCount__FlawedState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__errorCount__FlawedState =
      StateDescriptor(_$key__errorCount__FlawedState);
  static const StateDescriptor _$prop__differentTypeOfErrorCount__FlawedState =
      StateDescriptor(_$key__differentTypeOfErrorCount__FlawedState);
  static const String _$key__errorCount__FlawedState = 'FlawedState.errorCount';
  static const String _$key__differentTypeOfErrorCount__FlawedState =
      'FlawedState.differentTypeOfErrorCount';

  static const List<StateDescriptor> $state = [
    _$prop__errorCount__FlawedState,
    _$prop__differentTypeOfErrorCount__FlawedState
  ];
  static const List<String> $stateKeys = [
    _$key__errorCount__FlawedState,
    _$key__differentTypeOfErrorCount__FlawedState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForFlawedState = StateMeta(
  fields: $FlawedState.$state,
  keys: $FlawedState.$stateKeys,
);
