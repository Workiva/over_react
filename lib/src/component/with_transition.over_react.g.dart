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
    _$$WithTransitionProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$WithTransitionProps extends WithTransitionProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionProps(Map backingMap) : this.props = backingMap ?? ({});

  /// The backing props map proxied by this class.
  @override
  final Map props;

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

  @override
  PropsMetaCollection get staticMeta => const PropsMetaCollection({
        // If this generated mixin is undefined, it's likely because v2.TransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of v2.TransitionPropsMixin, and check that v2.$TransitionPropsMixin is exported/imported properly.
        v2.TransitionPropsMixin: v2.$TransitionPropsMixin.meta,
        // If this generated mixin is undefined, it's likely because WithTransitionPropsMixin is not a valid `mixin`-based props mixin, or because it is but the generated mixin was not imported. Check the declaration of WithTransitionPropsMixin, and check that $WithTransitionPropsMixin is exported/imported properly.
        WithTransitionPropsMixin: $WithTransitionPropsMixin.meta,
      });
}

// Concrete state implementation.
//
// Implements constructor and backing map.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$$WithTransitionState extends UiState with WithTransitionState {
  // This initializer of `_state` to an empty map, as well as the reassignment
  // of `_state` in the constructor body is necessary to work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$WithTransitionState(Map backingMap) : this.state = backingMap ?? ({});

  /// The backing state map proxied by this class.
  @override
  final Map state;

  /// Let `UiState` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
class _$WithTransitionComponent extends WithTransitionComponent {
  _$$WithTransitionProps _cachedTypedProps;

  @override
  _$$WithTransitionProps get props => _cachedTypedProps;

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
  _$$WithTransitionProps typedPropsFactoryJs(JsBackedMap backingMap) =>
      _$$WithTransitionProps(backingMap);

  @override
  _$$WithTransitionProps typedPropsFactory(Map backingMap) =>
      _$$WithTransitionProps(backingMap);

  _$$WithTransitionState _cachedTypedState;
  @override
  _$$WithTransitionState get state => _cachedTypedState;

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
  _$$WithTransitionState typedStateFactoryJs(JsBackedMap backingMap) =>
      _$$WithTransitionState(backingMap);

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
      (props[_$key__isShown__WithTransitionPropsMixin] ?? null) as bool;
  @override
  set isShown(bool value) =>
      props[_$key__isShown__WithTransitionPropsMixin] = value;
  @override
  Map<TransitionPhase, Map> get childPropsByPhase =>
      (props[_$key__childPropsByPhase__WithTransitionPropsMixin] ?? null)
          as Map<TransitionPhase, Map>;
  @override
  set childPropsByPhase(Map<TransitionPhase, Map> value) =>
      props[_$key__childPropsByPhase__WithTransitionPropsMixin] = value;
  @override
  Duration get transitionTimeout =>
      (props[_$key__transitionTimeout__WithTransitionPropsMixin] ?? null)
          as Duration;
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
      (state[_$key__$transitionPhase__WithTransitionState] ?? null)
          as TransitionPhase;
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
