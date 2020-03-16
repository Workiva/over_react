// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'prop_validation_wrap.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $PropTypesWrapComponentFactory = registerComponent2(
  () => _$PropTypesWrapComponent(),
  builderFactory: PropTypesWrap,
  componentClass: PropTypesWrapComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'PropTypesWrap',
);

abstract class _$PropTypesWrapPropsAccessorsMixin
    implements _$PropTypesWrapProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForPropTypesWrapProps = PropsMeta(
  fields: _$PropTypesWrapPropsAccessorsMixin.$props,
  keys: _$PropTypesWrapPropsAccessorsMixin.$propKeys,
);

class PropTypesWrapProps extends _$PropTypesWrapProps
    with _$PropTypesWrapPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForPropTypesWrapProps;
}

_$$PropTypesWrapProps _$PropTypesWrap([Map backingProps]) =>
    backingProps == null
        ? _$$PropTypesWrapProps$JsMap(JsBackedMap())
        : _$$PropTypesWrapProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$PropTypesWrapProps extends _$PropTypesWrapProps
    with _$PropTypesWrapPropsAccessorsMixin
    implements PropTypesWrapProps {
  _$$PropTypesWrapProps._();

  factory _$$PropTypesWrapProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PropTypesWrapProps$JsMap(backingMap);
    } else {
      return _$$PropTypesWrapProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $PropTypesWrapComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'PropTypesWrapProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$PropTypesWrapProps$PlainMap extends _$$PropTypesWrapProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PropTypesWrapProps$PlainMap(Map backingMap)
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
class _$$PropTypesWrapProps$JsMap extends _$$PropTypesWrapProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PropTypesWrapProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$PropTypesWrapStateAccessorsMixin
    implements _$PropTypesWrapState {
  @override
  Map get state;

  /// <!-- Generated from [_$PropTypesWrapState.twoObjects] -->
  @override
  List get twoObjects =>
      state[_$key__twoObjects___$PropTypesWrapState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$PropTypesWrapState.twoObjects] -->
  @override
  set twoObjects(List value) =>
      state[_$key__twoObjects___$PropTypesWrapState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__twoObjects___$PropTypesWrapState =
      StateDescriptor(_$key__twoObjects___$PropTypesWrapState);
  static const String _$key__twoObjects___$PropTypesWrapState =
      'PropTypesWrapState.twoObjects';

  static const List<StateDescriptor> $state = [
    _$prop__twoObjects___$PropTypesWrapState
  ];
  static const List<String> $stateKeys = [
    _$key__twoObjects___$PropTypesWrapState
  ];
}

const StateMeta _$metaForPropTypesWrapState = StateMeta(
  fields: _$PropTypesWrapStateAccessorsMixin.$state,
  keys: _$PropTypesWrapStateAccessorsMixin.$stateKeys,
);

class PropTypesWrapState extends _$PropTypesWrapState
    with _$PropTypesWrapStateAccessorsMixin {
  static const StateMeta meta = _$metaForPropTypesWrapState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$PropTypesWrapState extends _$PropTypesWrapState
    with _$PropTypesWrapStateAccessorsMixin
    implements PropTypesWrapState {
  _$$PropTypesWrapState._();

  factory _$$PropTypesWrapState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$PropTypesWrapState$JsMap(backingMap);
    } else {
      return _$$PropTypesWrapState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$PropTypesWrapState$PlainMap extends _$$PropTypesWrapState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PropTypesWrapState$PlainMap(Map backingMap)
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
class _$$PropTypesWrapState$JsMap extends _$$PropTypesWrapState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$PropTypesWrapState$JsMap(JsBackedMap backingMap)
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
class _$PropTypesWrapComponent extends PropTypesWrapComponent {
  _$$PropTypesWrapProps$JsMap _cachedTypedProps;

  @override
  _$$PropTypesWrapProps$JsMap get props => _cachedTypedProps;

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
  _$$PropTypesWrapProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$PropTypesWrapProps$JsMap(backingMap);

  @override
  _$$PropTypesWrapProps typedPropsFactory(Map backingMap) =>
      _$$PropTypesWrapProps(backingMap);

  _$$PropTypesWrapState$JsMap _cachedTypedState;
  @override
  _$$PropTypesWrapState$JsMap get state => _cachedTypedState;

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
  _$$PropTypesWrapState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$PropTypesWrapState$JsMap(backingMap);

  @override
  _$$PropTypesWrapState typedStateFactory(Map backingMap) =>
      _$$PropTypesWrapState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$PropTypesWrapProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      const [_$metaForPropTypesWrapProps];
}
