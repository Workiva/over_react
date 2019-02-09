// GENERATED CODE - DO NOT MODIFY BY HAND

part of over_react.abstract_transition;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

abstract class _$AbstractTransitionPropsAccessorsMixin
    implements _$AbstractTransitionProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForAbstractTransitionProps = const PropsMeta(
  fields: _$AbstractTransitionPropsAccessorsMixin.$props,
  keys: _$AbstractTransitionPropsAccessorsMixin.$propKeys,
);

abstract class AbstractTransitionProps extends _$AbstractTransitionProps
    with _$AbstractTransitionPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForAbstractTransitionProps;
}

abstract class _$AbstractTransitionStateAccessorsMixin
    implements _$AbstractTransitionState {
  @override
  Map get state;

  /// Go to [_$AbstractTransitionState.transitionPhase] to see the source code for this prop
  @override
  TransitionPhase get transitionPhase =>
      state['AbstractTransitionState.transitionPhase'];

  /// Go to [_$AbstractTransitionState.transitionPhase] to see the source code for this prop
  @override
  set transitionPhase(TransitionPhase value) =>
      state['AbstractTransitionState.transitionPhase'] = value;
  /* GENERATED CONSTANTS */
  static const List<StateDescriptor> $state = const [
    const StateDescriptor('AbstractTransitionState.transitionPhase')
  ];
  static const List<String> $stateKeys = const [
    'AbstractTransitionState.transitionPhase'
  ];
}

const StateMeta _$metaForAbstractTransitionState = const StateMeta(
  fields: _$AbstractTransitionStateAccessorsMixin.$state,
  keys: _$AbstractTransitionStateAccessorsMixin.$stateKeys,
);

abstract class AbstractTransitionState extends _$AbstractTransitionState
    with _$AbstractTransitionStateAccessorsMixin {
  static const StateMeta meta = _$metaForAbstractTransitionState;
}
