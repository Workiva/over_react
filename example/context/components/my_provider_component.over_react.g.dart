// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'my_provider_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $MyProviderComponentComponentFactory = registerComponent2(
  () => _$MyProviderComponentComponent(),
  builderFactory: MyProviderComponent,
  componentClass: MyProviderComponentComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'MyProviderComponent',
);

abstract class _$MyProviderComponentPropsAccessorsMixin
    implements _$MyProviderComponentProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForMyProviderComponentProps = PropsMeta(
  fields: _$MyProviderComponentPropsAccessorsMixin.$props,
  keys: _$MyProviderComponentPropsAccessorsMixin.$propKeys,
);

class MyProviderComponentProps extends _$MyProviderComponentProps
    with _$MyProviderComponentPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForMyProviderComponentProps;
}

_$$MyProviderComponentProps _$MyProviderComponent([Map backingProps]) =>
    backingProps == null
        ? _$$MyProviderComponentProps$JsMap(JsBackedMap())
        : _$$MyProviderComponentProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
abstract class _$$MyProviderComponentProps extends _$MyProviderComponentProps
    with _$MyProviderComponentPropsAccessorsMixin
    implements MyProviderComponentProps {
  _$$MyProviderComponentProps._();

  factory _$$MyProviderComponentProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$MyProviderComponentProps$JsMap(backingMap);
    } else {
      return _$$MyProviderComponentProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $MyProviderComponentComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'MyProviderComponentProps.';
}

// Concrete props implementation that can be backed by any [Map].
class _$$MyProviderComponentProps$PlainMap extends _$$MyProviderComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderComponentProps$PlainMap(Map backingMap)
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
class _$$MyProviderComponentProps$JsMap extends _$$MyProviderComponentProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderComponentProps$JsMap(JsBackedMap backingMap)
      : this._props = JsBackedMap(),
        super._() {
    this._props = backingMap ?? JsBackedMap();
  }

  /// The backing props map proxied by this class.
  @override
  JsBackedMap get props => _props;
  JsBackedMap _props;
}

abstract class _$MyProviderComponentStateAccessorsMixin
    implements _$MyProviderComponentState {
  @override
  Map get state;

  /// <!-- Generated from [_$MyProviderComponentState.latestValue] -->
  @override
  String get latestValue =>
      state[_$key__latestValue___$MyProviderComponentState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// <!-- Generated from [_$MyProviderComponentState.latestValue] -->
  @override
  set latestValue(String value) =>
      state[_$key__latestValue___$MyProviderComponentState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__latestValue___$MyProviderComponentState =
      StateDescriptor(_$key__latestValue___$MyProviderComponentState);
  static const String _$key__latestValue___$MyProviderComponentState =
      'MyProviderComponentState.latestValue';

  static const List<StateDescriptor> $state = [
    _$prop__latestValue___$MyProviderComponentState
  ];
  static const List<String> $stateKeys = [
    _$key__latestValue___$MyProviderComponentState
  ];
}

const StateMeta _$metaForMyProviderComponentState = StateMeta(
  fields: _$MyProviderComponentStateAccessorsMixin.$state,
  keys: _$MyProviderComponentStateAccessorsMixin.$stateKeys,
);

class MyProviderComponentState extends _$MyProviderComponentState
    with _$MyProviderComponentStateAccessorsMixin {
  static const StateMeta meta = _$metaForMyProviderComponentState;
}

// Concrete state implementation.
//
// Implements constructor and backing map.
abstract class _$$MyProviderComponentState extends _$MyProviderComponentState
    with _$MyProviderComponentStateAccessorsMixin
    implements MyProviderComponentState {
  _$$MyProviderComponentState._();

  factory _$$MyProviderComponentState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$MyProviderComponentState$JsMap(backingMap);
    } else {
      return _$$MyProviderComponentState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
class _$$MyProviderComponentState$PlainMap extends _$$MyProviderComponentState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderComponentState$PlainMap(Map backingMap)
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
class _$$MyProviderComponentState$JsMap extends _$$MyProviderComponentState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderComponentState$JsMap(JsBackedMap backingMap)
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
class _$MyProviderComponentComponent extends MyProviderComponentComponent {
  _$$MyProviderComponentProps$JsMap _cachedTypedProps;

  @override
  _$$MyProviderComponentProps$JsMap get props => _cachedTypedProps;

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
  _$$MyProviderComponentProps$JsMap typedPropsFactoryJs(
          JsBackedMap backingMap) =>
      _$$MyProviderComponentProps$JsMap(backingMap);

  @override
  _$$MyProviderComponentProps typedPropsFactory(Map backingMap) =>
      _$$MyProviderComponentProps(backingMap);

  _$$MyProviderComponentState$JsMap _cachedTypedState;
  @override
  _$$MyProviderComponentState$JsMap get state => _cachedTypedState;

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
  _$$MyProviderComponentState$JsMap typedStateFactoryJs(
          JsBackedMap backingMap) =>
      _$$MyProviderComponentState$JsMap(backingMap);

  @override
  _$$MyProviderComponentState typedStateFactory(Map backingMap) =>
      _$$MyProviderComponentState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$MyProviderComponentProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForMyProviderComponentProps
  ];
}
