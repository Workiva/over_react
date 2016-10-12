/// Thanks!
/// https://github.com/marcj/css-element-queries/blob/master/src/ResizeSensor.js
library resize_sensor;

import 'dart:collection';
import 'dart:html';

import 'package:browser_detect/browser_detect.dart';
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
    ..shrink = false;

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
}

@Props()
class ResizeSensorProps extends UiProps with ResizeSensorPropsMixin {}

@Component()
class ResizeSensorComponent extends UiComponent<ResizeSensorProps> {
  // Refs

  Element _expandSensorChildRef;
  Element _expandSensorRef;
  Element _collapseSensorChildRef;
  Element _collapseSensorRef;

  @override
  Map getDefaultProps() => (newProps()
    ..addProps(ResizeSensorPropsMixin.defaultProps)
  );

  @override
  void componentDidMount() {
    _reset();

    if (props.onInitialize != null) {
      var event = new ResizeSensorEvent(_lastWidth, _lastHeight, 0, 0);
      props.onInitialize(event);
    }
  }

  @override
  render() {
    var expandSensorChild = (Dom.div()
      ..ref = (ref) { _expandSensorChildRef = ref; }
      ..style = _expandSensorChildStyle
    )();

    var expandSensor = (Dom.div()
      ..className = 'resize-sensor-expand'
      ..onScroll = _handleSensorScroll
      ..style = props.shrink ? _shrinkBaseStyle : _baseStyle
      ..ref = (ref) { _expandSensorRef = ref; }
      ..key = 'expandSensor'
    )(expandSensorChild);

    var collapseSensorChild = (Dom.div()
      ..ref = (ref) { _collapseSensorChildRef = ref; }
      ..style = _collapseSensorChildStyle
    )();

    var collapseSensor = (Dom.div()
      ..className = 'resize-sensor-collapse'
      ..onScroll = _handleSensorScroll
      ..style = props.shrink ? _shrinkBaseStyle : _baseStyle
      ..ref = (ref) { _collapseSensorRef = ref; }
      ..key = 'collapseSensor'
    )(collapseSensorChild);

    var children = new List.from(props.children)
      ..add(
          (Dom.div()
            ..className = 'resize-sensor'
            ..style = props.shrink ? _shrinkBaseStyle : _baseStyle
            ..key = 'resizeSensor'
          )(expandSensor, collapseSensor)
    );

    var wrapperStyles;

    if (props.isFlexChild) {
      wrapperStyles = {
        'position': 'relative',
        'flex': '1 1 0%',
        'WebkitFlex': '1 1 0%',
        'msFlex': '1 1 0%',
        'display': 'block'
      };
    } else if (props.isFlexContainer) {
      wrapperStyles = {
        'position': 'relative',
        'flex': '1 1 0%',
        'WebkitFlex': '1 1 0%',
        'msFlex': '1 1 0%'
      };

      // IE 10 and Safari 8 need 'special' value prefixes for 'display:flex'.
      if (browser.isIe && browser.version <= '10') {
        wrapperStyles['display'] = '-ms-flexbox';
      } else if (browser.isSafari && browser.version < '9') {
        wrapperStyles['display'] = '-webkit-flex';
      } else {
        wrapperStyles['display'] = 'flex';
      }

    } else {
      wrapperStyles = {
        'position': 'relative',
        'height': '100%',
        'width': '100%'
      };
    }

    return (Dom.div()
      ..addProps(copyUnconsumedDomProps())
      ..className = forwardingClassNameBuilder().toClassName()
      ..style = wrapperStyles
    )(children);
  }

  /// When the expand or collapse sensors are resized, builds a [ResizeSensorEvent] and calls
  /// props.onResize with it. Then, calls through to [_reset()].
  void _handleSensorScroll(react.SyntheticEvent _) {
    Element sensor = findDomNode(this);

    if (sensor.offsetWidth != _lastWidth || sensor.offsetHeight != _lastHeight) {
      var event = new ResizeSensorEvent(sensor.offsetWidth, sensor.offsetHeight, _lastWidth, _lastHeight);

      if (props.onResize != null) {
        props.onResize(event);
      }

      _reset();
    }
  }

  /// Update the width and height on [expandSensorChild], and the scroll position on
  /// [expandSensorChild] and [collapseSensor].
  ///
  /// Additionally update the state with the new [_lastWidth] and [_lastHeight].
  void _reset() {
    Element expand = _expandSensorRef;
    Element expandChild = _expandSensorChildRef;
    Element collapse = _collapseSensorRef;
    Element sensor = findDomNode(this);

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
