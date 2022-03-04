// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'context_provider_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ContextProviderWrapperComponentFactory = registerComponent2(
  () => _$ContextProviderWrapperComponent(),
  builderFactory: _$ContextProviderWrapper,
  componentClass: ContextProviderWrapperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ContextProviderWrapper',
);

abstract class _$ContextProviderWrapperPropsAccessorsMixin
    implements _$ContextProviderWrapperProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForContextProviderWrapperProps = PropsMeta(
  fields: _$ContextProviderWrapperPropsAccessorsMixin.$props,
  keys: _$ContextProviderWrapperPropsAccessorsMixin.$propKeys,
);

class ContextProviderWrapperProps extends _$ContextProviderWrapperProps
    with _$ContextProviderWrapperPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForContextProviderWrapperProps;
}

_$$ContextProviderWrapperProps _$ContextProviderWrapper([Map backingProps]) =>
    backingProps == null
        ? _$$ContextProviderWrapperProps$JsMap(JsBackedMap())
        : _$$ContextProviderWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$ContextProviderWrapperProps
    extends _$ContextProviderWrapperProps
    with _$ContextProviderWrapperPropsAccessorsMixin
    implements ContextProviderWrapperProps {
  _$$ContextProviderWrapperProps._();

  factory _$$ContextProviderWrapperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextProviderWrapperProps$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ContextProviderWrapperProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $ContextProviderWrapperComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ContextProviderWrapperProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$ContextProviderWrapperProps$PlainMap
    extends _$$ContextProviderWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextProviderWrapperProps$PlainMap(Map backingMap)
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
class _$$ContextProviderWrapperProps$JsMap
    extends _$$ContextProviderWrapperProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextProviderWrapperProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$ContextProviderWrapperStateAccessorsMixin
    implements _$ContextProviderWrapperState {
  @override
  Map get state;

  /// <!-- Generated from [_$ContextProviderWrapperState.latestValue] -->
  @override
  int get latestValue =>
      (state[_$key__latestValue___$ContextProviderWrapperState] ?? null) as int;

  /// <!-- Generated from [_$ContextProviderWrapperState.latestValue] -->
  @override
  set latestValue(int value) =>
      state[_$key__latestValue___$ContextProviderWrapperState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__latestValue___$ContextProviderWrapperState =
      StateDescriptor(_$key__latestValue___$ContextProviderWrapperState);
  static const String _$key__latestValue___$ContextProviderWrapperState =
      'ContextProviderWrapperState.latestValue';

  static const List<StateDescriptor> $state = [
    _$prop__latestValue___$ContextProviderWrapperState
  ];
  static const List<String> $stateKeys = [
    _$key__latestValue___$ContextProviderWrapperState
  ];
}

const StateMeta _$metaForContextProviderWrapperState = StateMeta(
  fields: _$ContextProviderWrapperStateAccessorsMixin.$state,
  keys: _$ContextProviderWrapperStateAccessorsMixin.$stateKeys,
);

class ContextProviderWrapperState extends _$ContextProviderWrapperState
    with _$ContextProviderWrapperStateAccessorsMixin {
  static const StateMeta meta = _$metaForContextProviderWrapperState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$ContextProviderWrapperState
    extends _$ContextProviderWrapperState
    with _$ContextProviderWrapperStateAccessorsMixin
    implements ContextProviderWrapperState {
  _$$ContextProviderWrapperState._();

  factory _$$ContextProviderWrapperState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextProviderWrapperState$JsMap(backingMap as JsBackedMap);
    } else {
      return _$$ContextProviderWrapperState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$ContextProviderWrapperState$PlainMap
    extends _$$ContextProviderWrapperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextProviderWrapperState$PlainMap(Map backingMap)
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
class _$$ContextProviderWrapperState$JsMap
    extends _$$ContextProviderWrapperState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ContextProviderWrapperState$JsMap(JsBackedMap backingMap)
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
class _$ContextProviderWrapperComponent
    extends ContextProviderWrapperComponent {
  _$$ContextProviderWrapperProps$JsMap _cachedTypedProps;

  @override
  _$$ContextProviderWrapperProps$JsMap get props => _cachedTypedProps;

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
  _$$ContextProviderWrapperProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$ContextProviderWrapperProps$JsMap(backingMap);

  @override
  _$$ContextProviderWrapperProps typedPropsFactory(Map backingMap) =>
      _$$ContextProviderWrapperProps(backingMap);

  _$$ContextProviderWrapperState$JsMap _cachedTypedState;
  @override
  _$$ContextProviderWrapperState$JsMap get state => _cachedTypedState;

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
  _$$ContextProviderWrapperState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$ContextProviderWrapperState$JsMap(backingMap);

  @override
  _$$ContextProviderWrapperState typedStateFactory(Map backingMap) =>
      _$$ContextProviderWrapperState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ContextProviderWrapperProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForContextProviderWrapperProps
  ];
}
