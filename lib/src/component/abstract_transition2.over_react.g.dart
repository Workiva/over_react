// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abstract_transition2.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class _$AbstractTransition2PropsAccessorsMixin
    implements _$AbstractTransition2Props {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForAbstractTransition2Props = const PropsMeta(
  fields: _$AbstractTransition2PropsAccessorsMixin.$props,
  keys: _$AbstractTransition2PropsAccessorsMixin.$propKeys,
);

abstract class AbstractTransition2Props extends _$AbstractTransition2Props
    with _$AbstractTransition2PropsAccessorsMixin {
  static const PropsMeta meta = _$metaForAbstractTransition2Props;
}

abstract class _$AbstractTransition2StateAccessorsMixin
    implements _$AbstractTransition2State {
  @override
  Map get state;

  /// The current phase of transition the [AbstractTransitionComponent] is in.
  ///
  /// Default:  [AbstractTransitionComponent.initiallyShown] ? [TransitionPhase.SHOWN] : [TransitionPhase.HIDDEN]
  ///
  /// <!-- Generated from [_$AbstractTransition2State.transitionPhase] -->
  @override
  TransitionPhase get transitionPhase =>
      state[_$key__transitionPhase___$AbstractTransition2State] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The current phase of transition the [AbstractTransitionComponent] is in.
  ///
  /// Default:  [AbstractTransitionComponent.initiallyShown] ? [TransitionPhase.SHOWN] : [TransitionPhase.HIDDEN]
  ///
  /// <!-- Generated from [_$AbstractTransition2State.transitionPhase] -->
  @override
  set transitionPhase(TransitionPhase value) =>
      state[_$key__transitionPhase___$AbstractTransition2State] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__transitionPhase___$AbstractTransition2State =
      const StateDescriptor(_$key__transitionPhase___$AbstractTransition2State);
  static const String _$key__transitionPhase___$AbstractTransition2State =
      'AbstractTransition2State.transitionPhase';

  static const List<StateDescriptor> $state = const [
    _$prop__transitionPhase___$AbstractTransition2State
  ];
  static const List<String> $stateKeys = const [
    _$key__transitionPhase___$AbstractTransition2State
  ];
}

const StateMeta _$metaForAbstractTransition2State = const StateMeta(
  fields: _$AbstractTransition2StateAccessorsMixin.$state,
  keys: _$AbstractTransition2StateAccessorsMixin.$stateKeys,
);

abstract class AbstractTransition2State extends _$AbstractTransition2State
    with _$AbstractTransition2StateAccessorsMixin {
  static const StateMeta meta = _$metaForAbstractTransition2State;
}
