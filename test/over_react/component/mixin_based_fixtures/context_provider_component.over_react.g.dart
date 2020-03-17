// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'context_provider_component.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $ContextProviderWrapperComponentFactory = registerComponent2(
  () => _$ContextProviderWrapperComponent(),
  builderFactory: ContextProviderWrapper,
  componentClass: ContextProviderWrapperComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'ContextProviderWrapper',
);

_$$ContextProviderWrapperProps _$ContextProviderWrapper([Map backingProps]) =>
    backingProps == null
        ? _$$ContextProviderWrapperProps$JsMap(JsBackedMap())
        : _$$ContextProviderWrapperProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ContextProviderWrapperProps extends UiProps
    with
        ContextProviderWrapperProps,
        $ContextProviderWrapperProps // If this generated mixin is undefined, it's likely because ContextProviderWrapperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ContextProviderWrapperProps.
{
  _$$ContextProviderWrapperProps._();

  factory _$$ContextProviderWrapperProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextProviderWrapperProps$JsMap(backingMap);
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
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$ContextProviderWrapperState extends UiState
    with
        ContextProviderWrapperState,
        $ContextProviderWrapperState // If this generated mixin is undefined, it's likely because ContextProviderWrapperState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not exported. Check the declaration of ContextProviderWrapperState.
{
  _$$ContextProviderWrapperState._();

  factory _$$ContextProviderWrapperState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$ContextProviderWrapperState$JsMap(backingMap);
    } else {
      return _$$ContextProviderWrapperState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
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
    _cachedTypedProps = typedPropsFactoryJs(getBackingMap(value));
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
    _cachedTypedState = typedStateFactoryJs(value);
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

  /// The default consumed props, taken from ContextProviderWrapperProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  List<ConsumedProps> get $defaultConsumedProps =>
      [propsMeta.forMixin(ContextProviderWrapperProps)];

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because ContextProviderWrapperProps is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not exported. Check the declaration of ContextProviderWrapperProps.
        ContextProviderWrapperProps: $ContextProviderWrapperProps.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ContextProviderWrapperProps on ContextProviderWrapperProps {
  static const PropsMeta meta = _$metaForContextProviderWrapperProps;
  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForContextProviderWrapperProps = PropsMeta(
  fields: $ContextProviderWrapperProps.$props,
  keys: $ContextProviderWrapperProps.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $ContextProviderWrapperState on ContextProviderWrapperState {
  static const StateMeta meta = _$metaForContextProviderWrapperState;
  @override
  int get latestValue =>
      state[_$key__latestValue__ContextProviderWrapperState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set latestValue(int value) =>
      state[_$key__latestValue__ContextProviderWrapperState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__latestValue__ContextProviderWrapperState =
      StateDescriptor(_$key__latestValue__ContextProviderWrapperState);
  static const String _$key__latestValue__ContextProviderWrapperState =
      'ContextProviderWrapperState.latestValue';

  static const List<StateDescriptor> $state = [
    _$prop__latestValue__ContextProviderWrapperState
  ];
  static const List<String> $stateKeys = [
    _$key__latestValue__ContextProviderWrapperState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForContextProviderWrapperState = StateMeta(
  fields: $ContextProviderWrapperState.$state,
  keys: $ContextProviderWrapperState.$stateKeys,
);
