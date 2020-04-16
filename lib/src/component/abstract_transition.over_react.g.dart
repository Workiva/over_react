// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'abstract_transition.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.'
    ' EXCEPTION: this may be used in legacy boilerplate until'
    ' it is transitioned to the new mixin-based boilerplate.')
mixin $AbstractTransitionState on AbstractTransitionState {
  static const StateMeta meta = _$metaForAbstractTransitionState;
  @override
  TransitionPhase get transitionPhase =>
      state[_$key__transitionPhase__AbstractTransitionState] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  @override
  set transitionPhase(TransitionPhase value) =>
      state[_$key__transitionPhase__AbstractTransitionState] = value;
  /* GENERATED CONSTANTS */
  static const StateDescriptor
      _$prop__transitionPhase__AbstractTransitionState =
      StateDescriptor(_$key__transitionPhase__AbstractTransitionState);
  static const String _$key__transitionPhase__AbstractTransitionState =
      'AbstractTransitionState.transitionPhase';

  static const List<StateDescriptor> $state = [
    _$prop__transitionPhase__AbstractTransitionState
  ];
  static const List<String> $stateKeys = [
    _$key__transitionPhase__AbstractTransitionState
  ];
}

@Deprecated('This API is for use only within generated code.'
    ' Do not reference it in your code, as it may change at any time.')
const StateMeta _$metaForAbstractTransitionState = StateMeta(
  fields: $AbstractTransitionState.$state,
  keys: $AbstractTransitionState.$stateKeys,
);
