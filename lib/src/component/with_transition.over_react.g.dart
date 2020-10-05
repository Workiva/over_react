// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'with_transition.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
final $WithTransitionComponentFactory = registerComponent2(
  () => _$WithTransitionComponent(),
  builderFactory: _$WithTransition,
  componentClass: WithTransitionComponent,
  isWrapper: false,
  parentType: null,
  displayName: 'WithTransition',
);

_$$WithTransitionProps _$WithTransition([Map backingProps]) =>
    backingProps == null
        ? _$$WithTransitionProps$JsMap(JsBackedMap())
        : _$$WithTransitionProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
abstract class _$$WithTransitionProps extends UiProps
    with
        v2.TransitionPropsMixin,
        v2.$TransitionPropsMixin, // If this generated mixin is undefined, it's likely because v2.TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of v2.TransitionPropsMixin, and check that v2.$TransitionPropsMixin is exported/imported properly.
        WithTransitionPropsMixin,
        $WithTransitionPropsMixin // If this generated mixin is undefined, it's likely because WithTransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of WithTransitionPropsMixin, and check that $WithTransitionPropsMixin is exported/imported properly.
    implements
        WithTransitionProps {
  _$$WithTransitionProps._();

  factory _$$WithTransitionProps(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$WithTransitionProps$JsMap(backingMap);
    } else {
      return _$$WithTransitionProps$PlainMap(backingMap);
    }
  }

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      super.componentFactory ?? $WithTransitionComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => '';
}

// Concrete props implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$WithTransitionProps$PlainMap extends _$$WithTransitionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionProps$PlainMap(Map backingMap)
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
class _$$WithTransitionProps$JsMap extends _$$WithTransitionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionProps$JsMap(JsBackedMap backingMap)
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
abstract class _$$WithTransitionState extends UiState
    with
        WithTransitionState,
        $WithTransitionState // If this generated mixin is undefined, it's likely because WithTransitionState is not a valid `mixin`-based state mixin, or because it is but the generated mixin was not imported. Check the declaration of WithTransitionState, and check that $WithTransitionState is exported/imported properly.
{
  _$$WithTransitionState._();

  factory _$$WithTransitionState(Map backingMap) {
    if (backingMap == null || backingMap is JsBackedMap) {
      return _$$WithTransitionState$JsMap(backingMap);
    } else {
      return _$$WithTransitionState$PlainMap(backingMap);
    }
  }

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete state implementation that can be backed by any [Map].
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$WithTransitionState$PlainMap extends _$$WithTransitionState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionState$PlainMap(Map backingMap)
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
class _$$WithTransitionState$JsMap extends _$$WithTransitionState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionState$JsMap(JsBackedMap backingMap)
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
class _$WithTransitionComponent extends WithTransitionComponent {
  _$$WithTransitionProps$JsMap _cachedTypedProps;

  @override
  _$$WithTransitionProps$JsMap get props => _cachedTypedProps;

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
  _$$WithTransitionProps$JsMap typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$WithTransitionProps$JsMap(backingMap);

  @override
  _$$WithTransitionProps typedPropsFactory(Map backingMap) =>
      _$$WithTransitionProps(backingMap);

  _$$WithTransitionState$JsMap _cachedTypedState;
  @override
  _$$WithTransitionState$JsMap get state => _cachedTypedState;

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
  _$$WithTransitionState$JsMap typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$WithTransitionState$JsMap(backingMap);

  @override
  _$$WithTransitionState typedStateFactory(Map backingMap) =>
      _$$WithTransitionState(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, comprising all props mixins used by WithTransitionProps.
  /// Used in `*ConsumedProps` methods if [consumedProps] is not overridden.
  @override
  get $defaultConsumedProps => propsMeta.all;

  @override
  PropsMetaCollection get propsMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because v2.TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of v2.TransitionPropsMixin, and check that v2.$TransitionPropsMixin is exported/imported properly.
        v2.TransitionPropsMixin: v2.$TransitionPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because WithTransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of WithTransitionPropsMixin, and check that $WithTransitionPropsMixin is exported/imported properly.
        WithTransitionPropsMixin: $WithTransitionPropsMixin.meta,
      });
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $WithTransitionPropsMixin on WithTransitionPropsMixin {
  static const PropsMeta meta = _$metaForWithTransitionPropsMixin;
  @override
  bool get isShown =>
      props[_$key__isShown__WithTransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set isShown(bool value) =>
      props[_$key__isShown__WithTransitionPropsMixin] = value;
  @override
  Map<TransitionPhase, Map> get childPropsByPhase =>
      props[_$key__childPropsByPhase__WithTransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set childPropsByPhase(Map<TransitionPhase, Map> value) =>
      props[_$key__childPropsByPhase__WithTransitionPropsMixin] = value;
  @override
  Duration get transitionTimeout =>
      props[_$key__transitionTimeout__WithTransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set transitionTimeout(Duration value) =>
      props[_$key__transitionTimeout__WithTransitionPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__isShown__WithTransitionPropsMixin =
      PropDescriptor(_$key__isShown__WithTransitionPropsMixin);
  static const PropDescriptor
      _$prop__childPropsByPhase__WithTransitionPropsMixin =
      PropDescriptor(_$key__childPropsByPhase__WithTransitionPropsMixin);
  static const PropDescriptor
      _$prop__transitionTimeout__WithTransitionPropsMixin =
      PropDescriptor(_$key__transitionTimeout__WithTransitionPropsMixin);
  static const String _$key__isShown__WithTransitionPropsMixin =
      'WithTransitionPropsMixin.isShown';
  static const String _$key__childPropsByPhase__WithTransitionPropsMixin =
      'WithTransitionPropsMixin.childPropsByPhase';
  static const String _$key__transitionTimeout__WithTransitionPropsMixin =
      'WithTransitionPropsMixin.transitionTimeout';

  static const List<PropDescriptor> $props = [
    _$prop__isShown__WithTransitionPropsMixin,
    _$prop__childPropsByPhase__WithTransitionPropsMixin,
    _$prop__transitionTimeout__WithTransitionPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__isShown__WithTransitionPropsMixin,
    _$key__childPropsByPhase__WithTransitionPropsMixin,
    _$key__transitionTimeout__WithTransitionPropsMixin
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const PropsMeta _$metaForWithTransitionPropsMixin = PropsMeta(
  fields: $WithTransitionPropsMixin.$props,
  keys: $WithTransitionPropsMixin.$propKeys,
);

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $WithTransitionState on WithTransitionState {
  static const StateMeta meta = _$metaForWithTransitionState;
  @override
  @protected
  TransitionPhase get $transitionPhase =>
      state[_$key__$transitionPhase__WithTransitionState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  @protected
  set $transitionPhase(TransitionPhase value) =>
      state[_$key__$transitionPhase__WithTransitionState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor _$prop__$transitionPhase__WithTransitionState =
      StateDescriptor(_$key__$transitionPhase__WithTransitionState);
  static const String _$key__$transitionPhase__WithTransitionState =
      'WithTransitionState.\$transitionPhase';

  static const List<StateDescriptor> $state = [
    _$prop__$transitionPhase__WithTransitionState
  ];
  static const List<String> $stateKeys = [
    _$key__$transitionPhase__WithTransitionState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForWithTransitionState = StateMeta(
  fields: $WithTransitionState.$state,
  keys: $WithTransitionState.$stateKeys,
);
