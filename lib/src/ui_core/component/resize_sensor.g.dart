// GENERATED CODE - DO NOT MODIFY BY HAND

part of resize_sensor;

// **************************************************************************
// Generator: PropsGenerator
// Target: class ResizeSensorDefinition
// **************************************************************************

/// Typed props for [ResizeSensor].
abstract class ResizeSensorProps {
  Map get props;

  /// A function invoked when the parent element is resized.
  ResizeHandler get onResize => props[Z_$KEY__ON_RESIZE];
  set onResize(ResizeHandler value) => props[Z_$KEY__ON_RESIZE] = value;

  /// Whether the [ResizeSensor] is a child of a flex item. Necessary to apply the correct styling.
  ///
  /// See this issue for details: <https://code.google.com/p/chromium/issues/detail?id=346275>
  ///
  /// Default: false
  bool get isFlexChild => props[Z_$KEY__IS_FLEX_CHILD];
  set isFlexChild(bool value) => props[Z_$KEY__IS_FLEX_CHILD] = value;

  /// Key used in the getter/setter for the [ResizeSensorProps.onResize] prop.
  static const String Z_$KEY__ON_RESIZE = 'uip_ResizeSensor.onResize';

  /// Key used in the getter/setter for the [ResizeSensorProps.isFlexChild] prop.
  static const String Z_$KEY__IS_FLEX_CHILD = 'uip_ResizeSensor.isFlexChild';

  /// All the keys used for props in [ResizeSensorProps].
  ///
  /// The key-related fields are currently prefixed with "Z_" so they are sorted lower on the autocompletion list.
  /// This improves [ComponentDefinition] usage, since these static fields are incorrectly autocompleted due to [Web Storm issue WEB-17002](https://youtrack.jetbrains.com/issue/WEB-17002).
  static const List<String> Z_$propKeys = const [
    Z_$KEY__ON_RESIZE,
    Z_$KEY__IS_FLEX_CHILD,
  ];
}
