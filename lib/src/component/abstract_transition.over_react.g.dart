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
      state[_$key__transitionPhase___$AbstractTransitionState];

  /// Go to [_$AbstractTransitionState.transitionPhase] to see the source code for this prop
  @override
  set transitionPhase(TransitionPhase value) =>
      state[_$key__transitionPhase___$AbstractTransitionState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__transitionPhase___$AbstractTransitionState =
      const StateDescriptor(_$key__transitionPhase___$AbstractTransitionState);
  static const String _$key__transitionPhase___$AbstractTransitionState =
      'AbstractTransitionState.transitionPhase';

  static const List<StateDescriptor> $state = const [
    _$prop__transitionPhase___$AbstractTransitionState
  ];
  static const List<String> $stateKeys = const [
    _$key__transitionPhase___$AbstractTransitionState
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
