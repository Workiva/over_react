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
      props['ResizeSensorPropsMixin.onInitialize'];

  /// Go to [_$ResizeSensorPropsMixin.onInitialize] to see the source code for this prop
  @override
  set onInitialize(ResizeSensorHandler value) =>
      props['ResizeSensorPropsMixin.onInitialize'] = value;

  /// Go to [_$ResizeSensorPropsMixin.onResize] to see the source code for this prop
  @override
  ResizeSensorHandler get onResize => props['ResizeSensorPropsMixin.onResize'];

  /// Go to [_$ResizeSensorPropsMixin.onResize] to see the source code for this prop
  @override
  set onResize(ResizeSensorHandler value) =>
      props['ResizeSensorPropsMixin.onResize'] = value;

  /// Go to [_$ResizeSensorPropsMixin.isFlexChild] to see the source code for this prop
  @override
  bool get isFlexChild => props['ResizeSensorPropsMixin.isFlexChild'];

  /// Go to [_$ResizeSensorPropsMixin.isFlexChild] to see the source code for this prop
  @override
  set isFlexChild(bool value) =>
      props['ResizeSensorPropsMixin.isFlexChild'] = value;

  /// Go to [_$ResizeSensorPropsMixin.isFlexContainer] to see the source code for this prop
  @override
  bool get isFlexContainer => props['ResizeSensorPropsMixin.isFlexContainer'];

  /// Go to [_$ResizeSensorPropsMixin.isFlexContainer] to see the source code for this prop
  @override
  set isFlexContainer(bool value) =>
      props['ResizeSensorPropsMixin.isFlexContainer'] = value;

  /// Go to [_$ResizeSensorPropsMixin.shrink] to see the source code for this prop
  @override
  bool get shrink => props['ResizeSensorPropsMixin.shrink'];

  /// Go to [_$ResizeSensorPropsMixin.shrink] to see the source code for this prop
  @override
  set shrink(bool value) => props['ResizeSensorPropsMixin.shrink'] = value;

  /// Go to [_$ResizeSensorPropsMixin.quickMount] to see the source code for this prop
  @override
  bool get quickMount => props['ResizeSensorPropsMixin.quickMount'];

  /// Go to [_$ResizeSensorPropsMixin.quickMount] to see the source code for this prop
  @override
  set quickMount(bool value) =>
      props['ResizeSensorPropsMixin.quickMount'] = value;

  /// Go to [_$ResizeSensorPropsMixin.onDetachedMountCheck] to see the source code for this prop
  @override
  BoolCallback get onDetachedMountCheck =>
      props['ResizeSensorPropsMixin.onDetachedMountCheck'];

  /// Go to [_$ResizeSensorPropsMixin.onDetachedMountCheck] to see the source code for this prop
  @override
  set onDetachedMountCheck(BoolCallback value) =>
      props['ResizeSensorPropsMixin.onDetachedMountCheck'] = value;

  /// Go to [_$ResizeSensorPropsMixin.onDidReset] to see the source code for this prop
  @override
  @visibleForTesting
  Callback get onDidReset => props['ResizeSensorPropsMixin.onDidReset'];

  /// Go to [_$ResizeSensorPropsMixin.onDidReset] to see the source code for this prop
  @override
  @visibleForTesting
  set onDidReset(Callback value) =>
      props['ResizeSensorPropsMixin.onDidReset'] = value;
  /* GENERATED CONSTANTS */
  static const List<PropDescriptor> $props = const [
    const PropDescriptor('ResizeSensorPropsMixin.onInitialize'),
    const PropDescriptor('ResizeSensorPropsMixin.onResize'),
    const PropDescriptor('ResizeSensorPropsMixin.isFlexChild'),
    const PropDescriptor('ResizeSensorPropsMixin.isFlexContainer'),
    const PropDescriptor('ResizeSensorPropsMixin.shrink'),
    const PropDescriptor('ResizeSensorPropsMixin.quickMount'),
    const PropDescriptor('ResizeSensorPropsMixin.onDetachedMountCheck'),
    const PropDescriptor('ResizeSensorPropsMixin.onDidReset')
  ];
  static const List<String> $propKeys = const [
    'ResizeSensorPropsMixin.onInitialize',
    'ResizeSensorPropsMixin.onResize',
    'ResizeSensorPropsMixin.isFlexChild',
    'ResizeSensorPropsMixin.isFlexContainer',
    'ResizeSensorPropsMixin.shrink',
    'ResizeSensorPropsMixin.quickMount',
    'ResizeSensorPropsMixin.onDetachedMountCheck',
    'ResizeSensorPropsMixin.onDidReset'
  ];
}

const PropsMeta _$metaForResizeSensorPropsMixin = const PropsMeta(
  fields: ResizeSensorPropsMixin.$props,
  keys: ResizeSensorPropsMixin.$propKeys,
);
