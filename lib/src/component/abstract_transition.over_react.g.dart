// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abstract_transition.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
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

  /// The current phase of transition the [AbstractTransitionComponent] is in.
  ///
  /// Default:  [AbstractTransitionComponent.initiallyShown] ? [TransitionPhase.SHOWN] : [TransitionPhase.HIDDEN]
  ///
  /// <!-- Generated from [_$AbstractTransitionState.transitionPhase] -->
  @override
  TransitionPhase get transitionPhase =>
      state[_$key__transitionPhase___$AbstractTransitionState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The current phase of transition the [AbstractTransitionComponent] is in.
  ///
  /// Default:  [AbstractTransitionComponent.initiallyShown] ? [TransitionPhase.SHOWN] : [TransitionPhase.HIDDEN]
  ///
  /// <!-- Generated from [_$AbstractTransitionState.transitionPhase] -->
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
