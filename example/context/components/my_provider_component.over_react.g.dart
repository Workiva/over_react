// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'my_provider_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $MyProviderComponentFactory = registerComponent2(
  () => _$MyProviderComponent(),
  builderFactory: _$MyProvider,
  componentClass: MyProviderComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'MyProvider',
);

_$$MyProviderProps _$MyProvider([Map backingProps]) => backingProps == null
    ? _$$MyProviderProps$JsMap(JsBackedMap())
    : _$$MyProviderProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$MyProviderProps extends UiProps
    with
        MyProviderProps,
        $MyProviderProps // If this generated mixin is undefined, it's likely because MyProviderProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of MyProviderProps, and check that $MyProviderProps is exported/imported properly.
{
  _$$MyProviderProps._();

  factory _$$MyProviderProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$MyProviderProps$JsMap(backingMap);
    } else {
      return _$$MyProviderProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $MyProviderComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because MyProviderProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of MyProviderProps, and check that $MyProviderProps is exported/imported properly.
        MyProviderProps: $MyProviderProps.meta,
      });
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$MyProviderProps$PlainMap extends _$$MyProviderProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderProps$PlainMap(Map backingMap)
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
class _$$MyProviderProps$JsMap extends _$$MyProviderProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$MyProviderState extends UiState
    with
        MyProviderState,
        $MyProviderState // If this generated mixin is undefined, it's likely because MyProviderState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of MyProviderState, and check that $MyProviderState is exported/imported properly.
{
  _$$MyProviderState._();

  factory _$$MyProviderState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$MyProviderState$JsMap(backingMap);
    } else {
      return _$$MyProviderState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$MyProviderState$PlainMap extends _$$MyProviderState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderState$PlainMap(Map backingMap)
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
class _$$MyProviderState$JsMap extends _$$MyProviderState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$MyProviderState$JsMap(JsBackedMap backingMap)
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
class _$MyProviderComponent extends MyProviderComponent {
  _$$MyProviderProps$JsMap _cachedTypedProps;

  @override
  _$$MyProviderProps$JsMap get props => _cachedTypedProps;

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
  _$$MyProviderProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$MyProviderProps$JsMap(backingMap);

  @override
  _$$MyProviderProps typedPropsFactory(Map backingMap) =>
      _$$MyProviderProps(backingMap);

  _$$MyProviderState$JsMap _cachedTypedState;
  @override
  _$$MyProviderState$JsMap get state => _cachedTypedState;

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
  _$$MyProviderState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$MyProviderState$JsMap(backingMap);

  @override
  _$$MyProviderState typedStateFactory(Map backingMap) =>
      _$$MyProviderState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by MyProviderProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because MyProviderProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of MyProviderProps, and check that $MyProviderProps is exported/imported properly.
        MyProviderProps: $MyProviderProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $MyProviderProps on MyProviderProps {
  static const PropsMeta meta = _$metaForMyProviderProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForMyProviderProps = PropsMeta(
  fields: $MyProviderProps.$props,
  keys: $MyProviderProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $MyProviderState on MyProviderState {
  static const StateMeta meta = _$metaForMyProviderState;
  @override
  String get latestValue =>
      state[_$key__latestValue__MyProviderState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set latestValue(String value) =>
      state[_$key__latestValue__MyProviderState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__latestValue__MyProviderState =
      StateDescriptor(_$key__latestValue__MyProviderState);
  static const String _$key__latestValue__MyProviderState =
      'MyProviderState.latestValue';

  static const List<StateDescriptor> $state = [
    _$prop__latestValue__MyProviderState
  ];
  static const List<String> $stateKeys = [_$key__latestValue__MyProviderState];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForMyProviderState = StateMeta(
  fields: $MyProviderState.$state,
  keys: $MyProviderState.$stateKeys,
);
