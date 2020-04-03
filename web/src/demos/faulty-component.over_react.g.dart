// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'faulty-component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $FaultyComponentFactory = registerComponent2(
  () => _$FaultyComponent(),
  builderFactory: _$Faulty,
  componentClass: FaultyComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Faulty',
);

abstract class _$FaultyPropsAccessorsMixin implements _$FaultyProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForFaultyProps = PropsMeta(
  fields: _$FaultyPropsAccessorsMixin.$props,
  keys: _$FaultyPropsAccessorsMixin.$propKeys,
);

_$$FaultyProps _$Faulty([Map backingProps]) => backingProps == null
    ? _$$FaultyProps$JsMap(JsBackedMap())
    : _$$FaultyProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$FaultyProps extends _$FaultyProps
    with _$FaultyPropsAccessorsMixin
    implements FaultyProps {
  _$$FaultyProps._();

  factory _$$FaultyProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FaultyProps$JsMap(backingMap);
    } else {
      return _$$FaultyProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $FaultyComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'FaultyProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$FaultyProps$PlainMap extends _$$FaultyProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FaultyProps$PlainMap(Map backingMap)
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
class _$$FaultyProps$JsMap extends _$$FaultyProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FaultyProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$FaultyStateAccessorsMixin implements _$FaultyState {
  @override
  Map get state;

  /// <!-- Generated from [_$FaultyState.hasErrored] -->
  @override
  bool get hasErrored =>
      state[_$key__hasErrored___$FaultyState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$FaultyState.hasErrored] -->
  @override
  set hasErrored(bool value) => state[_$key__hasErrored___$FaultyState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__hasErrored___$FaultyState =
      StateDescriptor(_$key__hasErrored___$FaultyState);
  static const String _$key__hasErrored___$FaultyState =
      'FaultyState.hasErrored';

  static const List<StateDescriptor> $state = [
    _$prop__hasErrored___$FaultyState
  ];
  static const List<String> $stateKeys = [_$key__hasErrored___$FaultyState];
}

const StateMeta _$metaForFaultyState = StateMeta(
  fields: _$FaultyStateAccessorsMixin.$state,
  keys: _$FaultyStateAccessorsMixin.$stateKeys,
);

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$FaultyState extends _$FaultyState
    with _$FaultyStateAccessorsMixin
    implements FaultyState {
  _$$FaultyState._();

  factory _$$FaultyState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$FaultyState$JsMap(backingMap);
    } else {
      return _$$FaultyState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$FaultyState$PlainMap extends _$$FaultyState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FaultyState$PlainMap(Map backingMap)
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
class _$$FaultyState$JsMap extends _$$FaultyState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$FaultyState$JsMap(JsBackedMap backingMap)
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
class _$FaultyComponent extends FaultyComponent {
  _$$FaultyProps$JsMap _cachedTypedProps;

  @override
  _$$FaultyProps$JsMap get props => _cachedTypedProps;

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
  _$$FaultyProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$FaultyProps$JsMap(backingMap);

  @override
  _$$FaultyProps typedPropsFactory(Map backingMap) =>
      _$$FaultyProps(backingMap);

  _$$FaultyState$JsMap _cachedTypedState;
  @override
  _$$FaultyState$JsMap get state => _cachedTypedState;

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
  _$$FaultyState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$FaultyState$JsMap(backingMap);

  @override
  _$$FaultyState typedStateFactory(Map backingMap) =>
      _$$FaultyState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$FaultyProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForFaultyProps
  ];
}
