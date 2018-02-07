import 'dart:collection';

import 'package:over_react/over_react.dart';

@PropsMixin()
abstract class ResizeSensorPropsMixin {
  static final ResizeSensorPropsMixinMapView defaultProps = new ResizeSensorPropsMixinMapView({})
    ..isFlexChild = false
    ..isFlexContainer = false
    ..shrink = false
    ..quickMount = false
    ..useResizeObserver = false;

  Map get props;

  /// A function invoked when the resize sensor is initialized.
  ResizeSensorHandler onInitialize;

  /// A function invoked when the parent element is resized.
  ResizeSensorHandler onResize;

  /// Whether the [ResizeSensor] is a child of a flex item. Necessary to apply the correct styling.
  ///
  /// See this issue for details: <https://code.google.com/p/chromium/issues/detail?id=346275>
  ///
  /// Default: false
  bool isFlexChild;

  /// Whether the [ResizeSensor] is a flex container. Necessary to apply the correct styling.
  ///
  /// Default: false
  bool isFlexContainer;

  /// Whether the [ResizeSensor] should shrink to the size of its child.
  ///
  /// __WARNING:__ If set to true there is a possibility that the [ResizeSensor] will not work due to it being too
  /// small.
  ///
  /// Default: false
  bool shrink;

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
  bool quickMount;

  /// Whether to use a polyfilled `ResizeObserver`.
  ///
  /// Default: false
  bool useResizeObserver;
}

/// Used with [ResizeSensorHandler] to provide information about a resize.
class ResizeSensorEvent {
  /// The new width, in pixels.
  final int newWidth;
  /// The new height, in pixels.
  final int newHeight;
  /// The previous width, in pixels.
  final int prevWidth;
  /// The previous height, in pixels.
  final int prevHeight;

  ResizeSensorEvent(this.newWidth, this.newHeight, this.prevWidth, this.prevHeight);
}

/// A MapView with the typed getters/setters for all HitArea display variation props.
class ResizeSensorPropsMixinMapView extends MapView with ResizeSensorPropsMixin {
  /// Create a new instance backed by the specified map.
  ResizeSensorPropsMixinMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}
