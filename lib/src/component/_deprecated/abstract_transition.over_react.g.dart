// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'abstract_transition.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated(
    'Use the `AbstractTransitionProps` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release.')
abstract class _$AbstractTransitionPropsAccessorsMixin
    implements _$AbstractTransitionProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForAbstractTransitionProps = PropsMeta(
  fields: _$AbstractTransitionPropsAccessorsMixin.$props,
  keys: _$AbstractTransitionPropsAccessorsMixin.$propKeys,
);

@Deprecated(
    'Use the `AbstractTransitionProps` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release.')
abstract class AbstractTransitionProps extends _$AbstractTransitionProps
    with _$AbstractTransitionPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForAbstractTransitionProps;
}

@Deprecated(
    'Use the `AbstractTransitionState` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release.')
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
      (state[_$key__transitionPhase___$AbstractTransitionState] ?? null)
          as TransitionPhase;

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
      StateDescriptor(_$key__transitionPhase___$AbstractTransitionState);
  static const String _$key__transitionPhase___$AbstractTransitionState =
      'AbstractTransitionState.transitionPhase';

  static const List<StateDescriptor> $state = [
    _$prop__transitionPhase___$AbstractTransitionState
  ];
  static const List<String> $stateKeys = [
    _$key__transitionPhase___$AbstractTransitionState
  ];
}

const StateMeta _$metaForAbstractTransitionState = StateMeta(
  fields: _$AbstractTransitionStateAccessorsMixin.$state,
  keys: _$AbstractTransitionStateAccessorsMixin.$stateKeys,
);

@Deprecated(
    'Use the `AbstractTransitionState` mixin exported from `package:over_react/components.dart` instead. Will be removed in the 4.0.0 release.')
abstract class AbstractTransitionState extends _$AbstractTransitionState
    with _$AbstractTransitionStateAccessorsMixin {
  static const StateMeta meta = _$metaForAbstractTransitionState;
}
