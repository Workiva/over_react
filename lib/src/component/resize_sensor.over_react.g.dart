// GENERATED CODE - DO NOT MODIFY BY HAND

part of over_react.resize_sensor;

// **************************************************************************
// OverReactGenerator
// **************************************************************************

// React component factory implementation.
//
// Registers component implementation and links type meta to builder factory.
final $ResizeSensorComponentFactory = registerComponent(
    () => new _$ResizeSensorComponent(),
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

  static const List<PropDescriptor> $props = const [];
  static const List<String> $propKeys = const [];
}

const PropsMeta _$metaForResizeSensorProps = const PropsMeta(
  fields: _$ResizeSensorPropsAccessorsMixin.$props,
  keys: _$ResizeSensorPropsAccessorsMixin.$propKeys,
);

class ResizeSensorProps extends _$ResizeSensorProps
    with _$ResizeSensorPropsAccessorsMixin {
  static const PropsMeta meta = _$metaForResizeSensorProps;
}

_$$ResizeSensorProps _$ResizeSensor([Map backingProps]) =>
    new _$$ResizeSensorProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ResizeSensorProps extends _$ResizeSensorProps
    with _$ResizeSensorPropsAccessorsMixin
    implements ResizeSensorProps {
  // This initializer of `_props` to an empty map, as well as the reassignment
  // of `_props` in the constructor body is necessary work around a DDC bug: https://github.com/dart-lang/sdk/issues/36217
  _$$ResizeSensorProps(Map backingMap) : this._props = {} {
    this._props = backingMap ?? {};
  }

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  Map _props;

  /// Let [UiProps] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The [ReactComponentFactory] associated with the component built by this class.
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
      new _$$ResizeSensorProps(backingMap);

  /// Let [UiComponent] internals know that this class has been generated.
  @override
  bool get $isClassGenerated => true;

  /// The default consumed props, taken from _$ResizeSensorProps.
  /// Used in [UiProps.consumedProps] if [consumedProps] is not overridden.
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
      new ResizeSensorPropsMixinMapView({})
        ..isFlexChild = false
        ..isFlexContainer = false
        ..shrink = false
        ..quickMount = false;

  /// Go to [_$ResizeSensorPropsMixin.onInitialize] to see the source code for this prop
  @override
  ResizeSensorHandler get onInitialize =>
      props[_$key__onInitialize___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.onInitialize] to see the source code for this prop
  @override
  set onInitialize(ResizeSensorHandler value) =>
      props[_$key__onInitialize___$ResizeSensorPropsMixin] = value;

  /// Go to [_$ResizeSensorPropsMixin.onResize] to see the source code for this prop
  @override
  ResizeSensorHandler get onResize =>
      props[_$key__onResize___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.onResize] to see the source code for this prop
  @override
  set onResize(ResizeSensorHandler value) =>
      props[_$key__onResize___$ResizeSensorPropsMixin] = value;

  /// Go to [_$ResizeSensorPropsMixin.isFlexChild] to see the source code for this prop
  @override
  bool get isFlexChild =>
      props[_$key__isFlexChild___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.isFlexChild] to see the source code for this prop
  @override
  set isFlexChild(bool value) =>
      props[_$key__isFlexChild___$ResizeSensorPropsMixin] = value;

  /// Go to [_$ResizeSensorPropsMixin.isFlexContainer] to see the source code for this prop
  @override
  bool get isFlexContainer =>
      props[_$key__isFlexContainer___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.isFlexContainer] to see the source code for this prop
  @override
  set isFlexContainer(bool value) =>
      props[_$key__isFlexContainer___$ResizeSensorPropsMixin] = value;

  /// Go to [_$ResizeSensorPropsMixin.shrink] to see the source code for this prop
  @override
  bool get shrink =>
      props[_$key__shrink___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.shrink] to see the source code for this prop
  @override
  set shrink(bool value) =>
      props[_$key__shrink___$ResizeSensorPropsMixin] = value;

  /// Go to [_$ResizeSensorPropsMixin.quickMount] to see the source code for this prop
  @override
  bool get quickMount =>
      props[_$key__quickMount___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.quickMount] to see the source code for this prop
  @override
  set quickMount(bool value) =>
      props[_$key__quickMount___$ResizeSensorPropsMixin] = value;

  /// Go to [_$ResizeSensorPropsMixin.onDetachedMountCheck] to see the source code for this prop
  @override
  BoolCallback get onDetachedMountCheck =>
      props[_$key__onDetachedMountCheck___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.onDetachedMountCheck] to see the source code for this prop
  @override
  set onDetachedMountCheck(BoolCallback value) =>
      props[_$key__onDetachedMountCheck___$ResizeSensorPropsMixin] = value;

  /// Go to [_$ResizeSensorPropsMixin.onDidReset] to see the source code for this prop
  @override
  @visibleForTesting
  Callback get onDidReset =>
      props[_$key__onDidReset___$ResizeSensorPropsMixin] ??
      null; // Add ` ?? null` to workaround DDC bug: <https://github.com/dart-lang/sdk/issues/36052>;
  /// Go to [_$ResizeSensorPropsMixin.onDidReset] to see the source code for this prop
  @override
  @visibleForTesting
  set onDidReset(Callback value) =>
      props[_$key__onDidReset___$ResizeSensorPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onInitialize___$ResizeSensorPropsMixin =
      const PropDescriptor(_$key__onInitialize___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__onResize___$ResizeSensorPropsMixin =
      const PropDescriptor(_$key__onResize___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__isFlexChild___$ResizeSensorPropsMixin =
      const PropDescriptor(_$key__isFlexChild___$ResizeSensorPropsMixin);
  static const PropDescriptor
      _$prop__isFlexContainer___$ResizeSensorPropsMixin =
      const PropDescriptor(_$key__isFlexContainer___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__shrink___$ResizeSensorPropsMixin =
      const PropDescriptor(_$key__shrink___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__quickMount___$ResizeSensorPropsMixin =
      const PropDescriptor(_$key__quickMount___$ResizeSensorPropsMixin);
  static const PropDescriptor
      _$prop__onDetachedMountCheck___$ResizeSensorPropsMixin =
      const PropDescriptor(
          _$key__onDetachedMountCheck___$ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__onDidReset___$ResizeSensorPropsMixin =
      const PropDescriptor(_$key__onDidReset___$ResizeSensorPropsMixin);
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

  static const List<PropDescriptor> $props = const [
    _$prop__onInitialize___$ResizeSensorPropsMixin,
    _$prop__onResize___$ResizeSensorPropsMixin,
    _$prop__isFlexChild___$ResizeSensorPropsMixin,
    _$prop__isFlexContainer___$ResizeSensorPropsMixin,
    _$prop__shrink___$ResizeSensorPropsMixin,
    _$prop__quickMount___$ResizeSensorPropsMixin,
    _$prop__onDetachedMountCheck___$ResizeSensorPropsMixin,
    _$prop__onDidReset___$ResizeSensorPropsMixin
  ];
  static const List<String> $propKeys = const [
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

const PropsMeta _$metaForResizeSensorPropsMixin = const PropsMeta(
  fields: ResizeSensorPropsMixin.$props,
  keys: ResizeSensorPropsMixin.$propKeys,
);
