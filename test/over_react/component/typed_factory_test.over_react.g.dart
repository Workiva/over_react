// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typed_factory_test.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $TypedFactoryTesterComponentFactory = registerComponent2(
  () => new _$TypedFactoryTesterComponent(),
  builderFactory: TypedFactoryTester,
  componentClass: TypedFactoryTesterComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'TypedFactoryTester',
);

abstract class _$TypedFactoryTesterPropsAccessorsMixin
    implements _$TypedFactoryTesterProps {
  @override
  Map get props;

  /// <!-- Generated from [_$TypedFactoryTesterProps.testProp] -->
  @override
  bool get testProp =>
      props[_$key__testProp___$TypedFactoryTesterProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TypedFactoryTesterProps.testProp] -->
  @override
  set testProp(bool value) =>
      props[_$key__testProp___$TypedFactoryTesterProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__testProp___$TypedFactoryTesterProps =
      const PropDescriptor(_$key__testProp___$TypedFactoryTesterProps);
  static const String _$key__testProp___$TypedFactoryTesterProps =
      'TypedFactoryTesterProps.testProp';

  static const List<PropDescriptor> $props = const [
    _$prop__testProp___$TypedFactoryTesterProps
  ];
  static const List<String> $propKeys = const [
    _$key__testProp___$TypedFactoryTesterProps
  ];
}

const PropsMeta _$metaForTypedFactoryTesterProps = const PropsMeta(
  fields: _$TypedFactoryTesterPropsAccessorsMixin.$props,
  keys: _$TypedFactoryTesterPropsAccessorsMixin.$propKeys,
);

class TypedFactoryTesterProps extends _$TypedFactoryTesterProps
    with _$TypedFactoryTesterPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForTypedFactoryTesterProps;
}

_$$TypedFactoryTesterProps _$TypedFactoryTester([Map backingProps]) =>
    backingProps == null
        ? new _$$TypedFactoryTesterProps$JsMap(new JsBackedMap())
        : new _$$TypedFactoryTesterProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$TypedFactoryTesterProps extends _$TypedFactoryTesterProps
    with _$TypedFactoryTesterPropsAccessorsMixin
    implements TypedFactoryTesterProps {
  _$$TypedFactoryTesterProps._();

  factory _$$TypedFactoryTesterProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$TypedFactoryTesterProps$JsMap(backingMap);
    } else {
      return new _$$TypedFactoryTesterProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $TypedFactoryTesterComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'TypedFactoryTesterProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$TypedFactoryTesterProps$PlainMap extends _$$TypedFactoryTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TypedFactoryTesterProps$PlainMap(Map backingMap)
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
class _$$TypedFactoryTesterProps$JsMap extends _$$TypedFactoryTesterProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TypedFactoryTesterProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$TypedFactoryTesterStateAccessorsMixin
    implements _$TypedFactoryTesterState {
  @override
  Map get state;

  /// <!-- Generated from [_$TypedFactoryTesterState.testState] -->
  @override
  bool get testState =>
      state[_$key__testState___$TypedFactoryTesterState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$TypedFactoryTesterState.testState] -->
  @override
  set testState(bool value) =>
      state[_$key__testState___$TypedFactoryTesterState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__testState___$TypedFactoryTesterState =
      const StateDescriptor(_$key__testState___$TypedFactoryTesterState);
  static const String _$key__testState___$TypedFactoryTesterState =
      'TypedFactoryTesterState.testState';

  static const List<StateDescriptor> $state = const [
    _$prop__testState___$TypedFactoryTesterState
  ];
  static const List<String> $stateKeys = const [
    _$key__testState___$TypedFactoryTesterState
  ];
}

const StateMeta _$metaForTypedFactoryTesterState = const StateMeta(
  fields: _$TypedFactoryTesterStateAccessorsMixin.$state,
  keys: _$TypedFactoryTesterStateAccessorsMixin.$stateKeys,
);

class TypedFactoryTesterState extends _$TypedFactoryTesterState
    with _$TypedFactoryTesterStateAccessorsMixin {
  static const StateMeta meta = _$metaForTypedFactoryTesterState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$TypedFactoryTesterState extends _$TypedFactoryTesterState
    with _$TypedFactoryTesterStateAccessorsMixin
    implements TypedFactoryTesterState {
  _$$TypedFactoryTesterState._();

  factory _$$TypedFactoryTesterState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$TypedFactoryTesterState$JsMap(backingMap);
    } else {
      return new _$$TypedFactoryTesterState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$TypedFactoryTesterState$PlainMap extends _$$TypedFactoryTesterState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TypedFactoryTesterState$PlainMap(Map backingMap)
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
class _$$TypedFactoryTesterState$JsMap extends _$$TypedFactoryTesterState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$TypedFactoryTesterState$JsMap(JsBackedMap backingMap)
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
class _$TypedFactoryTesterComponent extends TypedFactoryTesterComponent {
  _$$TypedFactoryTesterProps$JsMap _cachedTypedProps;

  @override
  _$$TypedFactoryTesterProps$JsMap get props => _cachedTypedProps;

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
  _$$TypedFactoryTesterProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TypedFactoryTesterProps$JsMap(backingMap);

  @override
  _$$TypedFactoryTesterProps typedPropsFactory(Map backingMap) =>
      new _$$TypedFactoryTesterProps(backingMap);

  _$$TypedFactoryTesterState$JsMap _cachedTypedState;
  @override
  _$$TypedFactoryTesterState$JsMap get state => _cachedTypedState;

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
  _$$TypedFactoryTesterState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      new _$$TypedFactoryTesterState$JsMap(backingMap);

  @override
  _$$TypedFactoryTesterState typedStateFactory(Map backingMap) =>
      new _$$TypedFactoryTesterState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$TypedFactoryTesterProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForTypedFactoryTesterProps
  ];
}
