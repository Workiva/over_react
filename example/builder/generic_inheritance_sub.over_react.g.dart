// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_inheritance_sub.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $GenericSubComponentFactory = registerComponent2(
  () => new _$GenericSubComponent(),
  builderFactory: GenericSub,
  componentClass: GenericSubComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'GenericSub',
);

abstract class _$GenericSubPropsAccessorsMixin implements _$GenericSubProps {
  @override
  Map get props;

  /// <!-- Generated from [_$GenericSubProps.subProp] -->
  @override
  String get subProp => props[_$key__subProp___$GenericSubProps];

  /// <!-- Generated from [_$GenericSubProps.subProp] -->
  @override
  set subProp(String value) => props[_$key__subProp___$GenericSubProps] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__subProp___$GenericSubProps =
      const PropDescriptor(_$key__subProp___$GenericSubProps);
  static const String _$key__subProp___$GenericSubProps =
      'GenericSubProps.subProp';

  static const List<PropDescriptor> $props = const [
    _$prop__subProp___$GenericSubProps
  ];
  static const List<String> $propKeys = const [
    _$key__subProp___$GenericSubProps
  ];
}

const PropsMeta _$metaForGenericSubProps = const PropsMeta(
  fields: _$GenericSubPropsAccessorsMixin.$props,
  keys: _$GenericSubPropsAccessorsMixin.$propKeys,
);

class GenericSubProps extends _$GenericSubProps
    with _$GenericSubPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForGenericSubProps;
}

_$$GenericSubProps _$GenericSub([Map backingProps]) => backingProps == null
    ? new _$$GenericSubProps$JsMap(new JsBackedMap())
    : new _$$GenericSubProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$GenericSubProps extends _$GenericSubProps
    with _$GenericSubPropsAccessorsMixin
    implements GenericSubProps {
  _$$GenericSubProps._();

  factory _$$GenericSubProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$GenericSubProps$JsMap(backingMap);
    } else {
      return new _$$GenericSubProps$PlainMap(backingMap);
    }
  }

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $GenericSubComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'GenericSubProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$GenericSubProps$PlainMap extends _$$GenericSubProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSubProps$PlainMap(Map backingMap)
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
class _$$GenericSubProps$JsMap extends _$$GenericSubProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSubProps$JsMap(JsBackedMap backingMap)
      : this._props = new JsBackedMap(),
        super._() {
    this._props = backingMap ?? new JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$GenericSubStateAccessorsMixin implements _$GenericSubState {
  @override
  Map get state;

  /// <!-- Generated from [_$GenericSubState.subState] -->
  @override
  String get subState => state[_$key__subState___$GenericSubState];

  /// <!-- Generated from [_$GenericSubState.subState] -->
  @override
  set subState(String value) =>
      state[_$key__subState___$GenericSubState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__subState___$GenericSubState =
      const StateDescriptor(_$key__subState___$GenericSubState);
  static const String _$key__subState___$GenericSubState =
      'GenericSubState.subState';

  static const List<StateDescriptor> $state = const [
    _$prop__subState___$GenericSubState
  ];
  static const List<String> $stateKeys = const [
    _$key__subState___$GenericSubState
  ];
}

const StateMeta _$metaForGenericSubState = const StateMeta(
  fields: _$GenericSubStateAccessorsMixin.$state,
  keys: _$GenericSubStateAccessorsMixin.$stateKeys,
);

class GenericSubState extends _$GenericSubState
    with _$GenericSubStateAccessorsMixin {
  static const StateMeta meta = _$metaForGenericSubState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$GenericSubState extends _$GenericSubState
    with _$GenericSubStateAccessorsMixin
    implements GenericSubState {
  _$$GenericSubState._();

  factory _$$GenericSubState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return new _$$GenericSubState$JsMap(backingMap);
    } else {
      return new _$$GenericSubState$PlainMap(backingMap);
    }
  }

  /// Let [UiState] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$GenericSubState$PlainMap extends _$$GenericSubState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSubState$PlainMap(Map backingMap)
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
class _$$GenericSubState$JsMap extends _$$GenericSubState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$GenericSubState$JsMap(JsBackedMap backingMap)
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
class _$GenericSubComponent extends GenericSubComponent {
  _$$GenericSubProps$JsMap _cachedTypedProps;

  @override
  _$$GenericSubProps$JsMap get props => _cachedTypedProps;

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
  _$$GenericSubProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      new _$$GenericSubProps$JsMap(backingMap);

  @override
  _$$GenericSubProps typedPropsFactory(Map backingMap) =>
      new _$$GenericSubProps(backingMap);

  _$$GenericSubState$JsMap _cachedTypedState;
  @override
  _$$GenericSubState$JsMap get state => _cachedTypedState;

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
  _$$GenericSubState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      new _$$GenericSubState$JsMap(backingMap);

  @override
  _$$GenericSubState typedStateFactory(Map backingMap) =>
      new _$$GenericSubState(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$GenericSubProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForGenericSubProps
  ];
}
