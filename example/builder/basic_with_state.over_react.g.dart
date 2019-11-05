// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'basic_with_state.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $BasicComponentFactory = registerComponent2(
  () => _$BasicComponent(),
  builderFactory: Basic,
  componentClass: BasicComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'Basic',
);

abstract class _$BasicPropsAccessorsMixin implements _$BasicProps {
  @override
  Map get props;

  /// <!-- Generated from [_$BasicProps.basicProp] -->
  @override
  String get basicProp =>
      props[_$key__basicProp___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basicProp] -->
  @override
  set basicProp(String value) => props[_$key__basicProp___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic1] -->
  @override
  String get basic1 =>
      props[_$key__basic1___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic1] -->
  @override
  set basic1(String value) => props[_$key__basic1___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic2] -->
  @override
  String get basic2 =>
      props[_$key__basic2___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic2] -->
  @override
  set basic2(String value) => props[_$key__basic2___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic3] -->
  @override
  String get basic3 =>
      props[_$key__basic3___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic3] -->
  @override
  set basic3(String value) => props[_$key__basic3___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic4] -->
  @override
  String get basic4 =>
      props[_$key__basic4___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic4] -->
  @override
  set basic4(String value) => props[_$key__basic4___$BasicProps] = value;

  /// <!-- Generated from [_$BasicProps.basic5] -->
  @override
  String get basic5 =>
      props[_$key__basic5___$BasicProps] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicProps.basic5] -->
  @override
  set basic5(String value) => props[_$key__basic5___$BasicProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__basicProp___$BasicProps =
      PropDescriptor(_$key__basicProp___$BasicProps);
  static const PropDescriptor _$prop__basic1___$BasicProps =
      PropDescriptor(_$key__basic1___$BasicProps);
  static const PropDescriptor _$prop__basic2___$BasicProps =
      PropDescriptor(_$key__basic2___$BasicProps);
  static const PropDescriptor _$prop__basic3___$BasicProps =
      PropDescriptor(_$key__basic3___$BasicProps);
  static const PropDescriptor _$prop__basic4___$BasicProps =
      PropDescriptor(_$key__basic4___$BasicProps);
  static const PropDescriptor _$prop__basic5___$BasicProps =
      PropDescriptor(_$key__basic5___$BasicProps);
  static const String _$key__basicProp___$BasicProps = 'BasicProps.basicProp';
  static const String _$key__basic1___$BasicProps = 'BasicProps.basic1';
  static const String _$key__basic2___$BasicProps = 'BasicProps.basic2';
  static const String _$key__basic3___$BasicProps = 'BasicProps.basic3';
  static const String _$key__basic4___$BasicProps = 'BasicProps.basic4';
  static const String _$key__basic5___$BasicProps = 'BasicProps.basic5';

  static const List<PropDescriptor> $props = [
    _$prop__basicProp___$BasicProps,
    _$prop__basic1___$BasicProps,
    _$prop__basic2___$BasicProps,
    _$prop__basic3___$BasicProps,
    _$prop__basic4___$BasicProps,
    _$prop__basic5___$BasicProps
  ];
  static const List<String> $propKeys = [
    _$key__basicProp___$BasicProps,
    _$key__basic1___$BasicProps,
    _$key__basic2___$BasicProps,
    _$key__basic3___$BasicProps,
    _$key__basic4___$BasicProps,
    _$key__basic5___$BasicProps
  ];
}

const PropsMeta _$metaForBasicProps = PropsMeta(
  fields: _$BasicPropsAccessorsMixin.$props,
  keys: _$BasicPropsAccessorsMixin.$propKeys,
);

class BasicProps extends _$BasicProps with _$BasicPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForBasicProps;
}

_$$BasicProps _$Basic([Map backingProps]) => backingProps == null
    ? _$$BasicProps$JsMap(JsBackedMap())
    : _$$BasicProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$BasicProps extends _$BasicProps
    with _$BasicPropsAccessorsMixin
    implements BasicProps {
  _$$BasicProps._();

  factory _$$BasicProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicProps$JsMap(backingMap);
    } else {
      return _$$BasicProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $BasicComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'BasicProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$BasicProps$PlainMap extends _$$BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$PlainMap(Map backingMap)
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
class _$$BasicProps$JsMap extends _$$BasicProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$BasicStateAccessorsMixin implements _$BasicState {
  @override
  Map get state;

  /// <!-- Generated from [_$BasicState.basicState] -->
  @override
  String get basicState =>
      state[_$key__basicState___$BasicState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$BasicState.basicState] -->
  @override
  set basicState(String value) =>
      state[_$key__basicState___$BasicState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__basicState___$BasicState =
      StateDescriptor(_$key__basicState___$BasicState);
  static const String _$key__basicState___$BasicState = 'BasicState.basicState';

  static const List<StateDescriptor> $state = [
    _$prop__basicState___$BasicState
  ];
  static const List<String> $stateKeys = [_$key__basicState___$BasicState];
}

const StateMeta _$metaForBasicState = StateMeta(
  fields: _$BasicStateAccessorsMixin.$state,
  keys: _$BasicStateAccessorsMixin.$stateKeys,
);

class BasicState extends _$BasicState with _$BasicStateAccessorsMixin {
  static const StateMeta meta = _$metaForBasicState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$BasicState extends _$BasicState
    with _$BasicStateAccessorsMixin
    implements BasicState {
  _$$BasicState._();

  factory _$$BasicState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$BasicState$JsMap(backingMap);
    } else {
      return _$$BasicState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$BasicState$PlainMap extends _$$BasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicState$PlainMap(Map backingMap)
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
class _$$BasicState$JsMap extends _$$BasicState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$BasicState$JsMap(JsBackedMap backingMap)
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
class _$BasicComponent extends BasicComponent {
  _$$BasicProps$JsMap _cachedTypedProps;

  @override
  _$$BasicProps$JsMap get props => _cachedTypedProps;

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
  _$$BasicProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$BasicProps$JsMap(backingMap);

  @override
  _$$BasicProps typedPropsFactory(Map backingMap) => _$$BasicProps(backingMap);

  _$$BasicState$JsMap _cachedTypedState;
  @override
  _$$BasicState$JsMap get state => _cachedTypedState;

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
  _$$BasicState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$BasicState$JsMap(backingMap);

  @override
  _$$BasicState typedStateFactory(Map backingMap) => _$$BasicState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$BasicProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [_$metaForBasicProps];
}
