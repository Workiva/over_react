// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Thanks!
/// https://github.com/marcj/css-element-queries/blob/master/src/ResizeSensor.js
library resize_sensor;

import 'dart:collection';
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:react/react.dart' as react;
import 'package:over_react/over_react.dart';

/// A wrapper component that detects when its parent is resized.
///
/// This component _must_ be put in a relative or absolutely positioned
/// container.
///
///     (ResizeSensor()..onResize = () => print('resized'))(children)
///
/// See: <https://docs.workiva.org/web_skin_dart/latest/components/#resize-sensor>.
@Factory()
UiFactory<ResizeSensorProps> ResizeSensor;

@PropsMixin()
abstract class ResizeSensorPropsMixin {
  static final ResizeSensorPropsMixinMapView defaultProps = new ResizeSensorPropsMixinMapView({})
    ..isFlexChild = false
    ..isFlexContainer = false
    ..shrink = false
    ..quickMount = false;

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
}

@Props()
class ResizeSensorProps extends UiProps with ResizeSensorPropsMixin {}

@Component()
class ResizeSensorComponent extends UiComponent<ResizeSensorProps> with _SafeAnimationFrameMixin {
  // Refs

  Element _expandSensorRef;
  Element _collapseSensorRef;

  @override
  Map getDefaultProps() => (newProps()
    ..addProps(ResizeSensorPropsMixin.defaultProps)
  );

  @mustCallSuper
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    cancelAnimationFrames();
  }

  @mustCallSuper
  @override
  void componentDidMount() {
    if (props.quickMount) {
      assert(props.onInitialize == null || ValidationUtil.warn(
          'props.onInitialize will not be called when props.quickMount is true.',
          this
      ));

      // [1] Initialize/reset the sensor in the next animation frame after mount
      //     so that resulting layouts don't happen synchronously, and are better dispersed.
      //
      // [2] Ignore the first `2` scroll events triggered by resetting the scroll positions
      //     of the expand and collapse sensors.
      //
      // [3] Don't access the dimensions of the sensor to prevent unnecessary layouts.

      requestAnimationFrame(() { // [1]
        _scrollEventsToIgnore = 2; // [2]
        _reset(updateLastDimensions: false); // [3]
      });
    } else {
      _reset();

      if (props.onInitialize != null) {
        var event = new ResizeSensorEvent(_lastWidth, _lastHeight, 0, 0);
        props.onInitialize(event);
      }
    }
  }

  @override
  render() {
    var expandSensor = (Dom.div()
      ..className = 'resize-sensor-expand'
      ..onScroll = _handleSensorScroll
      ..style = props.shrink ? _shrinkBaseStyle : _baseStyle
      ..ref = (ref) { _expandSensorRef = ref; }
    )(
      (Dom.div()..style = _expandSensorChildStyle)()
    );

    var collapseSensor = (Dom.div()
      ..className = 'resize-sensor-collapse'
      ..onScroll = _handleSensorScroll
      ..style = props.shrink ? _shrinkBaseStyle : _baseStyle
      ..ref = (ref) { _collapseSensorRef = ref; }
    )(
      (Dom.div()..style = _collapseSensorChildStyle)()
    );

    var resizeSensor = (Dom.div()
      ..className = 'resize-sensor'
      ..style = props.shrink ? _shrinkBaseStyle : _baseStyle
      ..key = 'resizeSensor'
    )(expandSensor, collapseSensor);

    Map<String, dynamic> wrapperStyles;
    if (props.isFlexChild) {
      wrapperStyles = _wrapperStylesFlexChild;
    } else if (props.isFlexContainer) {
      wrapperStyles = _wrapperStylesFlexContainer;
    } else {
      wrapperStyles = _wrapperStyles;;
    }

    return (Dom.div()
      ..addProps(copyUnconsumedDomProps())
      ..className = forwardingClassNameBuilder().toClassName()
      ..style = wrapperStyles
    )(
      props.children,
      resizeSensor
    );
  }

  /// When the expand or collapse sensors are resized, builds a [ResizeSensorEvent] and calls
  /// props.onResize with it. Then, calls through to [_reset()].
  void _handleSensorScroll(react.SyntheticEvent _) {
    if (_scrollEventsToIgnore > 0) {
      _scrollEventsToIgnore--;
      return;
    }

    var sensor = findDomNode(this);

    var newWidth = sensor.offsetWidth;
    var newHeight = sensor.offsetHeight;

    if (newWidth != _lastWidth || newHeight != _lastHeight) {
      if (props.onResize != null) {
        var event = new ResizeSensorEvent(newWidth, newHeight, _lastWidth, _lastHeight);
        props.onResize(event);
      }

      _reset();
    }
  }

  /// Reset the scroll positions on [_expandSensorRef] and [_collapseSensorRef] so that future
  /// resizes will trigger scroll events.
  ///
  /// Additionally update the state with the new [_lastWidth] and [_lastHeight] when [updateLastDimensions] is true.
  void _reset({bool updateLastDimensions: true}) {
    if (updateLastDimensions) {
      var sensor = findDomNode(this);
      _lastWidth = sensor.offsetWidth;
      _lastHeight = sensor.offsetHeight;
    }

    // Scroll positions are clamped to their maxes; use this behavior to scroll to the end
    // as opposed to scrollWidth/scrollHeight, which trigger reflows immediately.

    _expandSensorRef
      ..scrollLeft = _maxSensorSize
      ..scrollTop = _maxSensorSize;

    _collapseSensorRef
      ..scrollLeft = _maxSensorSize
      ..scrollTop = _maxSensorSize;
  }

  /// The number of future scroll events to ignore.
  ///
  /// Resetting the sensors' scroll positions causes sensor scroll events to fire even though a resize didn't occur,
  /// so this flag is used to ignore those scroll events on mount for performance reasons in quick-mount mode
  /// (since the handler causes a layout by accessing the sensor's dimensions).
  ///
  /// This value is only set for the component's mount and __not__ reinitialized every time [_reset] is called
  /// in order to avoid ignoring scroll events fired by actual resizes at the same time that the reset is taking place.
  int _scrollEventsToIgnore = 0;

  /// The most recently measured value for the height of the sensor.
  int _lastHeight = 0;

  /// The most recently measured value for the width of the sensor.
  int _lastWidth = 0;
}

/// The maximum size, in `px`, the sensor can be: 100,000.
///
/// We want to use absolute values to avoid accessing element dimensions when possible,
/// and relative units like `%` don't work since they don't cause scroll events when sensor size changes.
///
/// We could use `rem` or `vh`/`vw`, but that opens us up to more edge cases.
const int _maxSensorSize = 100 * 1000;

final Map<String, dynamic> _baseStyle = const {
  'position': 'absolute',
  // Have this element reach "outside" its containing element in such a way to ensure its width/height are always at
  // least 2x the scrollbar width (e.g., 32px on Chrome OS X).
  'top': '-100px',
  'right': '-100px',
  'bottom': '-100px',
  'left': '-100px',
  'overflow': 'scroll',
  'zIndex': '-1',
  'visibility': 'hidden',
  // Set opacity in addition to visibility to work around Safari scrollbar bug.
  'opacity': '0',
};

final Map<String, dynamic> _shrinkBaseStyle = const {
  'position': 'absolute',
  'top': '0',
  'right': '0',
  'bottom': '0',
  'left': '0',
  'overflow': 'scroll',
  'zIndex': '-1',
  'visibility': 'hidden',
  // Set opacity in addition to visibility to work around Safari scrollbar bug.
  'opacity': '0',
};

final Map<String, dynamic> _expandSensorChildStyle = const {
  'position': 'absolute',
  'top': '0',
  'left': '0',
  'visibility': 'hidden',
  // Use a width/height that will always be larger than the expandSensor.
  // We'd ideally want to do something like calc(100% + 10px), but that doesn't
  // trigger scroll events the same way a fixed dimension does.
  'width': _maxSensorSize,
  'height': _maxSensorSize,
  // Set opacity in addition to visibility to work around Safari scrollbar bug.
  'opacity': '0',
};

final Map<String, dynamic> _collapseSensorChildStyle = const {
  'position': 'absolute',
  'top': '0',
  'left': '0',
  'width': '200%',
  'height': '200%',
  'visibility': 'hidden',
  // Set opacity in addition to visibility to work around Safari scrollbar bug.
  'opacity': '0',
};


const Map<String, dynamic> _wrapperStyles = const {
  'position': 'relative',
  'height': '100%',
  'width': '100%',
};

const Map<String, dynamic> _wrapperStylesFlexChild = const {
  'position': 'relative',
  'flex': '1 1 0%',
  'msFlex': '1 1 0%',
  'display': 'block',
};

final Map<String, dynamic> _wrapperStylesFlexContainer = {
  'position': 'relative',
  'flex': '1 1 0%',
  'msFlex': '1 1 0%',
  'display': _displayFlex,
};

/// The browser-prefixed value for the CSS `display` property that enables flexbox.
final String _displayFlex = (() {
  if (browser.isInternetExplorer && browser.version.major <= 10) return '-ms-flexbox';
  return 'flex';
})();

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

/// A mixin that makes it easier to manage animation frames within a React component lifecycle.
class _SafeAnimationFrameMixin {
  /// The ids of the pending animation frames.
  final _animationFrameIds = <int>[];

  /// Calls [Window.requestAnimationFrame] with the specified [callback], and keeps track of the
  /// request ID so that it can be cancelled in [cancelAnimationFrames].
  void requestAnimationFrame(callback()) {
    int queuedId;
    queuedId = window.requestAnimationFrame((_) {
      callback();
      _animationFrameIds.remove(queuedId);
    });

    _animationFrameIds.add(queuedId);
  }

  /// Cancels all pending animation frames requested by [requestAnimationFrame].
  ///
  /// Should be called in [react.Component.componentWillUnmount].
  void cancelAnimationFrames() {
    _animationFrameIds.forEach(window.cancelAnimationFrame);
  }
}
