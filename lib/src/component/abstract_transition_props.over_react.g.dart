// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abstract_transition_props.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

abstract class TransitionPropsMixin implements _$TransitionPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForTransitionPropsMixin;
  static final TransitionPropsMapView defaultProps =
      new TransitionPropsMapView({})..transitionCount = 1;

  /// The number of `transitionend` event that occur when the transition node is shown/hidden.
  ///
  /// Serves as the default for [transitionInCount]/[transitionOutCount] when they are not specified.
  ///
  /// Default: `1`
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.transitionCount] -->
  @override
  int get transitionCount =>
      props[_$key__transitionCount___$TransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The number of `transitionend` event that occur when the transition node is shown/hidden.
  ///
  /// Serves as the default for [transitionInCount]/[transitionOutCount] when they are not specified.
  ///
  /// Default: `1`
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.transitionCount] -->
  @override
  set transitionCount(int value) =>
      props[_$key__transitionCount___$TransitionPropsMixin] = value;

  /// The number of `transitionend` event that occur when the transition node is shown.
  ///
  /// Default: [transitionCount]
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.transitionInCount] -->
  @override
  int get transitionInCount =>
      props[_$key__transitionInCount___$TransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The number of `transitionend` event that occur when the transition node is shown.
  ///
  /// Default: [transitionCount]
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.transitionInCount] -->
  @override
  set transitionInCount(int value) =>
      props[_$key__transitionInCount___$TransitionPropsMixin] = value;

  /// The number of `transitionend` event that occur when the transition node is hidden.
  ///
  /// Default: [transitionCount]
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.transitionOutCount] -->
  @override
  int get transitionOutCount =>
      props[_$key__transitionOutCount___$TransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// The number of `transitionend` event that occur when the transition node is hidden.
  ///
  /// Default: [transitionCount]
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.transitionOutCount] -->
  @override
  set transitionOutCount(int value) =>
      props[_$key__transitionOutCount___$TransitionPropsMixin] = value;

  /// Optional callback that fires before the [AbstractTransitionComponent] is hidden.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will remain visible.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onWillHide] -->
  @override
  Callback get onWillHide =>
      props[_$key__onWillHide___$TransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Optional callback that fires before the [AbstractTransitionComponent] is hidden.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will remain visible.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onWillHide] -->
  @override
  set onWillHide(Callback value) =>
      props[_$key__onWillHide___$TransitionPropsMixin] = value;

  /// Optional callback that fires after the [AbstractTransitionComponent] is hidden.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onDidHide] -->
  @override
  Callback get onDidHide =>
      props[_$key__onDidHide___$TransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Optional callback that fires after the [AbstractTransitionComponent] is hidden.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onDidHide] -->
  @override
  set onDidHide(Callback value) =>
      props[_$key__onDidHide___$TransitionPropsMixin] = value;

  /// Optional callback that fires before the [AbstractTransitionComponent] appears.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will not appear.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onWillShow] -->
  @override
  Callback get onWillShow =>
      props[_$key__onWillShow___$TransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Optional callback that fires before the [AbstractTransitionComponent] appears.
  ///
  /// Returning `false` will cancel default behavior, and the [AbstractTransitionComponent] will not appear.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onWillShow] -->
  @override
  set onWillShow(Callback value) =>
      props[_$key__onWillShow___$TransitionPropsMixin] = value;

  /// Optional callback that fires after the [AbstractTransitionComponent] appears.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onDidShow] -->
  @override
  Callback get onDidShow =>
      props[_$key__onDidShow___$TransitionPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Optional callback that fires after the [AbstractTransitionComponent] appears.
  ///
  /// <!-- Generated from [_$TransitionPropsMixin.onDidShow] -->
  @override
  set onDidShow(Callback value) =>
      props[_$key__onDidShow___$TransitionPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__transitionCount___$TransitionPropsMixin =
      const PropDescriptor(_$key__transitionCount___$TransitionPropsMixin);
  static const PropDescriptor
      _$prop__transitionInCount___$TransitionPropsMixin =
      const PropDescriptor(_$key__transitionInCount___$TransitionPropsMixin);
  static const PropDescriptor
      _$prop__transitionOutCount___$TransitionPropsMixin =
      const PropDescriptor(_$key__transitionOutCount___$TransitionPropsMixin);
  static const PropDescriptor _$prop__onWillHide___$TransitionPropsMixin =
      const PropDescriptor(_$key__onWillHide___$TransitionPropsMixin);
  static const PropDescriptor _$prop__onDidHide___$TransitionPropsMixin =
      const PropDescriptor(_$key__onDidHide___$TransitionPropsMixin);
  static const PropDescriptor _$prop__onWillShow___$TransitionPropsMixin =
      const PropDescriptor(_$key__onWillShow___$TransitionPropsMixin);
  static const PropDescriptor _$prop__onDidShow___$TransitionPropsMixin =
      const PropDescriptor(_$key__onDidShow___$TransitionPropsMixin);
  static const String _$key__transitionCount___$TransitionPropsMixin =
      'TransitionPropsMixin.transitionCount';
  static const String _$key__transitionInCount___$TransitionPropsMixin =
      'TransitionPropsMixin.transitionInCount';
  static const String _$key__transitionOutCount___$TransitionPropsMixin =
      'TransitionPropsMixin.transitionOutCount';
  static const String _$key__onWillHide___$TransitionPropsMixin =
      'TransitionPropsMixin.onWillHide';
  static const String _$key__onDidHide___$TransitionPropsMixin =
      'TransitionPropsMixin.onDidHide';
  static const String _$key__onWillShow___$TransitionPropsMixin =
      'TransitionPropsMixin.onWillShow';
  static const String _$key__onDidShow___$TransitionPropsMixin =
      'TransitionPropsMixin.onDidShow';

  static const List<PropDescriptor> $props = const [
    _$prop__transitionCount___$TransitionPropsMixin,
    _$prop__transitionInCount___$TransitionPropsMixin,
    _$prop__transitionOutCount___$TransitionPropsMixin,
    _$prop__onWillHide___$TransitionPropsMixin,
    _$prop__onDidHide___$TransitionPropsMixin,
    _$prop__onWillShow___$TransitionPropsMixin,
    _$prop__onDidShow___$TransitionPropsMixin
  ];
  static const List<String> $propKeys = const [
    _$key__transitionCount___$TransitionPropsMixin,
    _$key__transitionInCount___$TransitionPropsMixin,
    _$key__transitionOutCount___$TransitionPropsMixin,
    _$key__onWillHide___$TransitionPropsMixin,
    _$key__onDidHide___$TransitionPropsMixin,
    _$key__onWillShow___$TransitionPropsMixin,
    _$key__onDidShow___$TransitionPropsMixin
  ];
}

const PropsMeta _$metaForTransitionPropsMixin = const PropsMeta(
  fields: TransitionPropsMixin.$props,
  keys: TransitionPropsMixin.$propKeys,
);
