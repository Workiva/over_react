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

_$$ResizeSensorProps _$ResizeSensor([Map backingProps]) =>
    new _$$ResizeSensorProps(backingProps);

// Concrete props implementation.
//
// Implements constructor and backing map, and links up to generated component factory.
class _$$ResizeSensorProps extends _$ResizeSensorProps
    with _$ResizeSensorPropsAccessorsMixin
    implements ResizeSensorProps {
  _$$ResizeSensorProps(Map backingMap) : this._props = backingMap ?? {};

  /// The backing props map proxied by this class.
  @override
  Map get props => _props;
  final Map _props;

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
  typedPropsFactory(Map backingMap) => new _$$ResizeSensorProps(backingMap);

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

abstract class $ResizeSensorPropsMixin implements ResizeSensorPropsMixin {
  @override
  Map get props;

  /// Go to [ResizeSensorPropsMixin.onInitialize] to see the source code for this prop
  @override
  ResizeSensorHandler get onInitialize =>
      props[_$key__onInitialize__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.onInitialize] to see the source code for this prop
  @override
  set onInitialize(ResizeSensorHandler value) =>
      props[_$key__onInitialize__ResizeSensorPropsMixin] = value;

  /// Go to [ResizeSensorPropsMixin.onResize] to see the source code for this prop
  @override
  ResizeSensorHandler get onResize =>
      props[_$key__onResize__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.onResize] to see the source code for this prop
  @override
  set onResize(ResizeSensorHandler value) =>
      props[_$key__onResize__ResizeSensorPropsMixin] = value;

  /// Go to [ResizeSensorPropsMixin.isFlexChild] to see the source code for this prop
  @override
  bool get isFlexChild => props[_$key__isFlexChild__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.isFlexChild] to see the source code for this prop
  @override
  set isFlexChild(bool value) =>
      props[_$key__isFlexChild__ResizeSensorPropsMixin] = value;

  /// Go to [ResizeSensorPropsMixin.isFlexContainer] to see the source code for this prop
  @override
  bool get isFlexContainer =>
      props[_$key__isFlexContainer__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.isFlexContainer] to see the source code for this prop
  @override
  set isFlexContainer(bool value) =>
      props[_$key__isFlexContainer__ResizeSensorPropsMixin] = value;

  /// Go to [ResizeSensorPropsMixin.shrink] to see the source code for this prop
  @override
  bool get shrink => props[_$key__shrink__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.shrink] to see the source code for this prop
  @override
  set shrink(bool value) =>
      props[_$key__shrink__ResizeSensorPropsMixin] = value;

  /// Go to [ResizeSensorPropsMixin.quickMount] to see the source code for this prop
  @override
  bool get quickMount => props[_$key__quickMount__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.quickMount] to see the source code for this prop
  @override
  set quickMount(bool value) =>
      props[_$key__quickMount__ResizeSensorPropsMixin] = value;

  /// Go to [ResizeSensorPropsMixin.onDetachedMountCheck] to see the source code for this prop
  @override
  BoolCallback get onDetachedMountCheck =>
      props[_$key__onDetachedMountCheck__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.onDetachedMountCheck] to see the source code for this prop
  @override
  set onDetachedMountCheck(BoolCallback value) =>
      props[_$key__onDetachedMountCheck__ResizeSensorPropsMixin] = value;

  /// Go to [ResizeSensorPropsMixin.onDidReset] to see the source code for this prop
  @override
  @visibleForTesting
  Callback get onDidReset => props[_$key__onDidReset__ResizeSensorPropsMixin];

  /// Go to [ResizeSensorPropsMixin.onDidReset] to see the source code for this prop
  @override
  @visibleForTesting
  set onDidReset(Callback value) =>
      props[_$key__onDidReset__ResizeSensorPropsMixin] = value;
  /* GENERATED CONSTANTS */
  static const PropDescriptor _$prop__onInitialize__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__onInitialize__ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__onResize__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__onResize__ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__isFlexChild__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__isFlexChild__ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__isFlexContainer__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__isFlexContainer__ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__shrink__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__shrink__ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__quickMount__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__quickMount__ResizeSensorPropsMixin);
  static const PropDescriptor
      _$prop__onDetachedMountCheck__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__onDetachedMountCheck__ResizeSensorPropsMixin);
  static const PropDescriptor _$prop__onDidReset__ResizeSensorPropsMixin =
      const PropDescriptor(_$key__onDidReset__ResizeSensorPropsMixin);
  static const String _$key__onInitialize__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onInitialize';
  static const String _$key__onResize__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onResize';
  static const String _$key__isFlexChild__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.isFlexChild';
  static const String _$key__isFlexContainer__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.isFlexContainer';
  static const String _$key__shrink__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.shrink';
  static const String _$key__quickMount__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.quickMount';
  static const String _$key__onDetachedMountCheck__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onDetachedMountCheck';
  static const String _$key__onDidReset__ResizeSensorPropsMixin =
      'ResizeSensorPropsMixin.onDidReset';

  static const List<PropDescriptor> $props = const [
    _$prop__onInitialize__ResizeSensorPropsMixin,
    _$prop__onResize__ResizeSensorPropsMixin,
    _$prop__isFlexChild__ResizeSensorPropsMixin,
    _$prop__isFlexContainer__ResizeSensorPropsMixin,
    _$prop__shrink__ResizeSensorPropsMixin,
    _$prop__quickMount__ResizeSensorPropsMixin,
    _$prop__onDetachedMountCheck__ResizeSensorPropsMixin,
    _$prop__onDidReset__ResizeSensorPropsMixin
  ];
  static const List<String> $propKeys = const [
    _$key__onInitialize__ResizeSensorPropsMixin,
    _$key__onResize__ResizeSensorPropsMixin,
    _$key__isFlexChild__ResizeSensorPropsMixin,
    _$key__isFlexContainer__ResizeSensorPropsMixin,
    _$key__shrink__ResizeSensorPropsMixin,
    _$key__quickMount__ResizeSensorPropsMixin,
    _$key__onDetachedMountCheck__ResizeSensorPropsMixin,
    _$key__onDidReset__ResizeSensorPropsMixin
  ];
}

const PropsMeta _$metaForResizeSensorPropsMixin = const PropsMeta(
  fields: $ResizeSensorPropsMixin.$props,
  keys: $ResizeSensorPropsMixin.$propKeys,
);
