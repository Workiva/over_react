/// Thanks!
/// https://github.com/marcj/css-element-queries/blob/master/src/ResizeSensor.js
library resize_sensor;

import 'dart:collection';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:web_skin_dart/ui_core.dart';

/// A wrapper component that detects when its parent is resized.
///
/// This component _must_ be put in a relative or absolutely positioned
/// container.
///
///     (ResizeSensor()..onResize = () => print('resized'))(children)
///
@Factory()
UiFactory<ResizeSensorProps> ResizeSensor;

@Props()
class ResizeSensorProps extends UiProps {
  /// A function invoked when the parent element is resized.
  ResizeHandler onResize;

  /// Whether the [ResizeSensor] is a child of a flex item. Necessary to apply the correct styling.
  ///
  /// See this issue for details: <https://code.google.com/p/chromium/issues/detail?id=346275>
  ///
  /// Default: false
  bool isFlexChild;
}

@Component()
class ResizeSensorComponent extends UiComponent<ResizeSensorProps> {
  @override
  Map getDefaultProps() => (newProps()
    ..isFlexChild = false
  );

  @override
  void componentDidMount(rootNode) {
    _reset();
  }

  @override
  render() {
    var expandSensorChild = (Dom.div()
      ..ref = 'expandSensorChild'
      ..style = _expandSensorChildStyle
    )();

    var expandSensor = (Dom.div()
      ..key = 'expandSensor'
      ..ref = 'expandSensor'
      ..className = 'resize-sensor-expand'
      ..onScroll = _handleSensorScroll
      ..style = _baseStyle
    )(expandSensorChild);

    var collapseSensorChild = (Dom.div()
      ..ref = 'collapseSensorChild'
      ..style = _collapseSensorChildStyle
    )();

    var collapseSensor = (Dom.div()
      ..key = 'collapseSensor'
      ..ref = 'collapseSensor'
      ..className = 'resize-sensor-collapse'
      ..onScroll = _handleSensorScroll
      ..style = _baseStyle
    )(collapseSensorChild);

    var children = new List.from(tProps.children)
      ..add(
          (Dom.div()
            ..className = 'resize-sensor'
            ..style = _baseStyle
          )(expandSensor, collapseSensor)
    );

    var wrapperStyles;

    if (tProps.isFlexChild) {
      wrapperStyles = {
        'position': 'relative',
        'flex': '1 1 0%',
        '-ms-flex': '1 1 0%',
        'display': 'block'
      };
    } else {
      wrapperStyles = {
        'position': 'relative',
        'height': '100%',
        'width': '100%'
      };
    }

    return (Dom.div()
      ..addProps(copyUnconsumedProps())
      ..className = forwardingClassNameBuilder().toClassName()
      ..style = wrapperStyles
    )(children);
  }

  /// When the expand or collapse sensors are resized, builds a [ResizeSensorEvent] and calls
  /// tProps.onResize with it. Then, calls through to [_reset()].
  void _handleSensorScroll(react.SyntheticEvent event) {
    Element sensor = getDOMNode();

    if (sensor.offsetWidth != _lastWidth || sensor.offsetHeight != _lastHeight) {
      var event = new ResizeSensorEvent(sensor.offsetWidth, sensor.offsetHeight, _lastWidth, _lastHeight);

      if (tProps.onResize != null) {
        tProps.onResize(event);
      }

      _reset();
    }
  }

  /// Update the width and height on [expandSensorChild], and the scroll position on
  /// [expandSensorChild] and [collapseSensor].
  ///
  /// Additionally update the state with the new [_lastWidth] and [_lastHeight].
  void _reset() {
    Element expand = findDomNode(ref('expandSensor'));
    Element expandChild = findDomNode(ref('expandSensorChild'));
    Element collapse = findDomNode(ref('collapseSensor'));
    Element sensor = getDOMNode();

    expandChild.style.width = '${expand.offsetWidth + 10}px';
    expandChild.style.height = '${expand.offsetHeight + 10}px';

    expand.scrollLeft = expand.scrollWidth;
    expand.scrollTop = expand.scrollHeight;

    collapse.scrollLeft = collapse.scrollWidth;
    collapse.scrollTop = collapse.scrollHeight;


    _lastWidth = sensor.offsetWidth;
    _lastHeight = sensor.offsetHeight;
  }

  /// The most recently measured value for the height of the sensor.
  int _lastHeight = 0;

  /// The most recently measured value for the width of the sensor.
  int _lastWidth = 0;
}

final Map<String, dynamic> _baseStyle = const {
  'position': 'absolute',
  'top': '0',
  'right': '0',
  'bottom': '0',
  'left': '0',
  'overflow': 'scroll',
  'zIndex': '-1',
  'visibility': 'hidden'
};

final Map<String, dynamic> _expandSensorChildStyle = const {
  'position': 'absolute',
  'top': '0',
  'left': '0'
};

final Map<String, dynamic> _collapseSensorChildStyle = const {
  'position': 'absolute',
  'top': '0',
  'left': '0',
  'width': '200%',
  'height': '200%'
};

/// Used with [ResizeHandler] to provide information about a resize.
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

typedef void ResizeHandler(ResizeSensorEvent event);
