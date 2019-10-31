// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package, unnecessary_null_in_if_null_operators, prefer_null_aware_operators
part of 'resize_sensor.dart';

// **************************************************************************
// OverReactBuilder (package:over_react/src/builder.dart)
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ResizeSensorComponentFactory = registerComponent(
    () => _$ResizeSensorComponent(),
    builderFactory: ResizeSensor,
    componentClass: ResizeSensorComponent,
    isWrapper: false,
    parentType: null,
    displayName: 'ResizeSensor');

abstract class _$ResizeSensorPropsAccessorsMixin
    implements _$ResizeSensorProps {
  @override
  Map get props;

  /* GENERATED CONSTANTS */

  static const List<PropDescriptor> $props = [];
  static const List<String> $propKeys = [];
}

const PropsMeta _$metaForResizeSensorProps = PropsMeta(
  fields: _$ResizeSensorPropsAccessorsMixin.$props,
  keys: _$ResizeSensorPropsAccessorsMixin.$propKeys,
);

class ResizeSensorProps extends _$ResizeSensorProps
    with _$ResizeSensorPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForResizeSensorProps;
}

_$$ResizeSensorProps _$ResizeSensor([Map backingProps]) =>
    _$$ResizeSensorProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ResizeSensorProps extends _$ResizeSensorProps
    with _$ResizeSensorPropsAccessorsMixin
    implements ResizeSensorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary to work around an unknown ddc issue.
  // See <https://jira.atl.workiva.net/browse/CPLAT-4673> for more details
  _$$ResizeSensorProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let `UiProps` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The `ReactComponentFactory` associated with the component built by this class.
  @override
  ReactComponentFactoryProxy get componentFactory =>
      $ResizeSensorComponentFactory;

  /// The default namespace for the prop getters/setters generated for this class.
  @override
  String get propKeyNamespace => 'ResizeSensorProps.';
}

// Concrete component implementation mixin.
//
// Implements typed props/state factories, defaults `consumedPropKeys` to the keys
// generated for the associated props class.
class _$ResizeSensorComponent extends ResizeSensorComponent {
  @override
  _$$ResizeSensorProps typedPropsFactory(Map backingMap) =>
      _$$ResizeSensorProps(backingMap);

  /// Let `UiComponent` internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ResizeSensorProps.
  /// Used in `ConsumedProps` if [consumedProps] is not overridden.
  @override
  final List<ConsumedProps> $defaultConsumedProps = const [
    _$metaForResizeSensorProps
  ];
}

abstract class ResizeSensorPropsMixin implements _$ResizeSensorPropsMixin {
  @override
  Map get props;

  static const PropsMeta meta = _$metaForResizeSensorPropsMixin;
  static final ResizeSensorPropsMixinMapView defaultProps =
      ResizeSensorPropsMixinMapView({})
        ..isFlexChild = false
        ..isFlexContainer = false
        ..shrink = false
        ..quickMount = false;

  /// A function invoked with a `ResizeSensorEvent` argument when the resize sensor is initialized.
  ///
  /// > Will never be called if [quickMount] is `true`.
  ///
  /// Related: [onResize]
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onInitialize] -->
  @override
  ResizeSensorHandler get onInitialize =>
      props[_$key__onInitialize___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// A function invoked with a `ResizeSensorEvent` argument when the resize sensor is initialized.
  ///
  /// > Will never be called if [quickMount] is `true`.
  ///
  /// Related: [onResize]
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onInitialize] -->
  @override
  set onInitialize(ResizeSensorHandler value) =>
      props[_$key__onInitialize___$ResizeSensorPropsMixin] = value;

  /// A function invoked with a `ResizeSensorEvent` argument when the [ResizeSensor]
  /// resizes, either due to its parent or children resizing.
  ///
  /// > __If this callback is not firing when you expect it to__,
  ///   check out [onDetachedMountCheck] for a possible workaround.
  ///
  /// Related: [onInitialize]
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onResize] -->
  @override
  ResizeSensorHandler get onResize =>
      props[_$key__onResize___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// A function invoked with a `ResizeSensorEvent` argument when the [ResizeSensor]
  /// resizes, either due to its parent or children resizing.
  ///
  /// > __If this callback is not firing when you expect it to__,
  ///   check out [onDetachedMountCheck] for a possible workaround.
  ///
  /// Related: [onInitialize]
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onResize] -->
  @override
  set onResize(ResizeSensorHandler value) =>
      props[_$key__onResize___$ResizeSensorPropsMixin] = value;

  /// Whether the [ResizeSensor] is a child of a flex item. Necessary to apply the correct styling.
  ///
  /// See this issue for details: <https://code.google.com/p/chromium/issues/detail?id=346275>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.isFlexChild] -->
  @override
  bool get isFlexChild =>
      props[_$key__isFlexChild___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [ResizeSensor] is a child of a flex item. Necessary to apply the correct styling.
  ///
  /// See this issue for details: <https://code.google.com/p/chromium/issues/detail?id=346275>
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.isFlexChild] -->
  @override
  set isFlexChild(bool value) =>
      props[_$key__isFlexChild___$ResizeSensorPropsMixin] = value;

  /// Whether the [ResizeSensor] is a flex container. Necessary to apply the correct styling.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.isFlexContainer] -->
  @override
  bool get isFlexContainer =>
      props[_$key__isFlexContainer___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [ResizeSensor] is a flex container. Necessary to apply the correct styling.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.isFlexContainer] -->
  @override
  set isFlexContainer(bool value) =>
      props[_$key__isFlexContainer___$ResizeSensorPropsMixin] = value;

  /// Whether the [ResizeSensor] should shrink to the size of its child.
  ///
  /// __WARNING:__ If set to true there is a possibility that the [ResizeSensor] will not work due to it being too
  /// small.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.shrink] -->
  @override
  bool get shrink =>
      props[_$key__shrink___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether the [ResizeSensor] should shrink to the size of its child.
  ///
  /// __WARNING:__ If set to true there is a possibility that the [ResizeSensor] will not work due to it being too
  /// small.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.shrink] -->
  @override
  set shrink(bool value) =>
      props[_$key__shrink___$ResizeSensorPropsMixin] = value;

  /// Whether quick-mount mode is enabled, which minimizes layouts caused by accessing element dimensions
  /// during initialization, allowing the component to mount faster.
  ///
  /// When enabled:
  ///
  /// * The initial dimensions will not be retrieved, so the first [onResize]
  ///   event will contain `0` for the previous dimensions.
  ///
  ///     * [onInitialize] will never be called.
  ///
  /// * The sensors will be initialized/reset in the next animation frame after mount, as opposed to synchronously,
  ///   helping to break up resulting layouts.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.quickMount] -->
  @override
  bool get quickMount =>
      props[_$key__quickMount___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Whether quick-mount mode is enabled, which minimizes layouts caused by accessing element dimensions
  /// during initialization, allowing the component to mount faster.
  ///
  /// When enabled:
  ///
  /// * The initial dimensions will not be retrieved, so the first [onResize]
  ///   event will contain `0` for the previous dimensions.
  ///
  ///     * [onInitialize] will never be called.
  ///
  /// * The sensors will be initialized/reset in the next animation frame after mount, as opposed to synchronously,
  ///   helping to break up resulting layouts.
  ///
  /// Default: false
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.quickMount] -->
  @override
  set quickMount(bool value) =>
      props[_$key__quickMount___$ResizeSensorPropsMixin] = value;

  /// A callback that returns a `bool` that indicates whether the [ResizeSensor] was detached from the DOM
  /// when it first mounted.
  ///
  /// ### Why would I need to set this callback? ###
  ///
  /// If you have a [ResizeSensor] that is not emitting its [onResize] events, then the sensor was most likely
  /// mounted detached from the DOM. In that situation, the use of this callback is the recommended way to
  /// repair the resize behavior via a call to [ResizeSensorComponent.forceResetDetachedSensor] at a time
  /// when you are sure that the sensor has become attached to the DOM.
  ///
  /// ### What does the bool argument indicate? ###
  ///
  /// * A `true` argument indicates that __the [ResizeSensor] was mounted detached from the DOM__,
  ///   and a call to [ResizeSensorComponent.forceResetDetachedSensor] will be necessary to re-initialize the sensor.
  ///
  ///   > __NOTE:__ The re-initialization comes at the expense of force-clamping the `scrollLeft` / `scrollTop`
  ///     values of the expand / collapse sensor nodes to the maximum possible value - which is what forces the
  ///     reflow / paint that makes the [onResize] callbacks begin firing when expected again.
  ///
  /// * A `false` argument indicates that __the [ResizeSensor] was mounted attached to the DOM__.
  ///
  ///   > __NOTE:__ If this happens - you most likely do not need to set this callback. If for some reason the callback
  ///     sometimes returns `true`, and sometimes returns `false` _(unexpected)_,
  ///     you may have other underlying issues in your implementation that should be addressed separately.
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onDetachedMountCheck] -->
  @override
  BoolCallback get onDetachedMountCheck =>
      props[_$key__onDetachedMountCheck___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// A callback that returns a `bool` that indicates whether the [ResizeSensor] was detached from the DOM
  /// when it first mounted.
  ///
  /// ### Why would I need to set this callback? ###
  ///
  /// If you have a [ResizeSensor] that is not emitting its [onResize] events, then the sensor was most likely
  /// mounted detached from the DOM. In that situation, the use of this callback is the recommended way to
  /// repair the resize behavior via a call to [ResizeSensorComponent.forceResetDetachedSensor] at a time
  /// when you are sure that the sensor has become attached to the DOM.
  ///
  /// ### What does the bool argument indicate? ###
  ///
  /// * A `true` argument indicates that __the [ResizeSensor] was mounted detached from the DOM__,
  ///   and a call to [ResizeSensorComponent.forceResetDetachedSensor] will be necessary to re-initialize the sensor.
  ///
  ///   > __NOTE:__ The re-initialization comes at the expense of force-clamping the `scrollLeft` / `scrollTop`
  ///     values of the expand / collapse sensor nodes to the maximum possible value - which is what forces the
  ///     reflow / paint that makes the [onResize] callbacks begin firing when expected again.
  ///
  /// * A `false` argument indicates that __the [ResizeSensor] was mounted attached to the DOM__.
  ///
  ///   > __NOTE:__ If this happens - you most likely do not need to set this callback. If for some reason the callback
  ///     sometimes returns `true`, and sometimes returns `false` _(unexpected)_,
  ///     you may have other underlying issues in your implementation that should be addressed separately.
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onDetachedMountCheck] -->
  @override
  set onDetachedMountCheck(BoolCallback value) =>
      props[_$key__onDetachedMountCheck___$ResizeSensorPropsMixin] = value;

  /// A callback intended for use only within internal unit tests that is called when [ResizeSensorComponent._reset]
  /// is called.
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onDidReset] -->
  @override
  @visibleForTesting
  Callback get onDidReset =>
      props[_$key__onDidReset___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// A callback intended for use only within internal unit tests that is called when [ResizeSensorComponent._reset]
  /// is called.
  ///
  /// <!-- Generated from [_$ResizeSensorPropsMixin.onDidReset] -->
  @override
  @visibleForTesting
  set onDidReset(Callback value) =>
      props[_$key__onDidReset___$ResizeSensorPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onInitialize___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__onInitialize___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__onResize___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__onResize___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__isFlexChild___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__isFlexChild___$ResizeSensorPropsMixin);
  static const PropDescriptor
      _$prop__isFlexContainer___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__isFlexContainer___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__shrink___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__shrink___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__quickMount___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__quickMount___$ResizeSensorPropsMixin);
  static const PropDescriptor
      _$prop__onDetachedMountCheck___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__onDetachedMountCheck___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__onDidReset___$ResizeSensorPropsMixin =
      PropDescriptor(_$key__onDidReset___$ResizeSensorPropsMixin);
  static const String _$key__onInitialize___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onInitialize';
  static const String _$key__onResize___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onResize';
  static const String _$key__isFlexChild___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.isFlexChild';
  static const String _$key__isFlexContainer___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.isFlexContainer';
  static const String _$key__shrink___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.shrink';
  static const String _$key__quickMount___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.quickMount';
  static const String _$key__onDetachedMountCheck___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onDetachedMountCheck';
  static const String _$key__onDidReset___$ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onDidReset';

  static const List<PropDescriptor> $props = [
    _$prop__onInitialize___$ResizeSensorPropsMixin,
    _$prop__onResize___$ResizeSensorPropsMixin,
    _$prop__isFlexChild___$ResizeSensorPropsMixin,
    _$prop__isFlexContainer___$ResizeSensorPropsMixin,
    _$prop__shrink___$ResizeSensorPropsMixin,
    _$prop__quickMount___$ResizeSensorPropsMixin,
    _$prop__onDetachedMountCheck___$ResizeSensorPropsMixin,
    _$prop__onDidReset___$ResizeSensorPropsMixin
  ];
  static const List<String> $propKeys = [
    _$key__onInitialize___$ResizeSensorPropsMixin,
    _$key__onResize___$ResizeSensorPropsMixin,
    _$key__isFlexChild___$ResizeSensorPropsMixin,
    _$key__isFlexContainer___$ResizeSensorPropsMixin,
    _$key__shrink___$ResizeSensorPropsMixin,
    _$key__quickMount___$ResizeSensorPropsMixin,
    _$key__onDetachedMountCheck___$ResizeSensorPropsMixin,
    _$key__onDidReset___$ResizeSensorPropsMixin
  ];
}

const PropsMeta _$metaForResizeSensorPropsMixin = PropsMeta(
  fields: ResizeSensorPropsMixin.$props,
  keys: ResizeSensorPropsMixin.$propKeys,
);
