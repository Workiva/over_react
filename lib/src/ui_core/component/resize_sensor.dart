/// Thanks!
/// https://github.com/marcj/css-element-queries/blob/master/src/ResizeSensor.js
library resize_sensor;

import 'dart:collection';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:web_skin_dart/code_generation/annotations.dart';
import 'package:web_skin_dart/ui_core.dart';

part 'resize_sensor.g.dart';

/// A wrapper component that detects when its parent is resized.
///
/// This component _must_ be put in a relative or absolutely positioned
/// container.
///
///     (ResizeSensor()..onResize = () => print('resized'))(children)
///
ResizeSensorDefinition ResizeSensor() => new ResizeSensorDefinition({});

@GenerateProps(#ResizeSensorProps)
class ResizeSensorDefinition extends BaseComponentDefinition with ResizeSensorProps {
  ResizeSensorDefinition(Map backingMap) : super(_resizeSensorComponentFactory, backingMap);

  /// A function invoked when the parent element is resized.
  ResizeHandler get onResize;
}

@GenerateState(#ResizeSensorStateMixin)
class ResizeSensorState extends MapView with ResizeSensorStateMixin {
  /// Create a new instance backed by the specified map.
  ResizeSensorState(Map backingMap) : super(backingMap);

  /// The most recently measured value for the height of the sensor.
  ///
  /// Initial value: 0
  int get lastHeight;

  /// The most recently measured value for the width of the sensor.
  ///
  /// Initial value: 0
  int get lastWidth;
}

var _resizeSensorComponentFactory = react.registerComponent(() => new _ResizeSensor());

class _ResizeSensor extends BaseComponentWithState<ResizeSensorDefinition, ResizeSensorState> {
  Map getDefaultProps() => newProps();

  @override
  Map getInitialState() => newState()
    ..lastHeight = 0
    ..lastWidth = 0;

  @override
  void componentDidMount(rootNode) {
    _reset();
  }

  // This component will update whenever a resize is detected.
  @override
  bool shouldComponentUpdate(nextProps, nextState) {
    return false;
  }

  @override
  render() {
    var expandSensorChild = (Dom.div()
      ..ref = 'expandChild'
      ..style = _expandSensorChildStyle
    )();

    var expandSensor = (Dom.div()
      ..key = 'expandSensor'
      ..ref = 'expandSensor'
      ..className = 'resize-sensor-expand'
      ..style = _style
      ..onScroll = _handleSensorScroll
    )(expandSensorChild);

    var collapseSensorChild = (Dom.div()
      ..ref = 'collapseChild'
      ..style = _collapseSensorChildStyle
    )();

    var collapseSensor = (Dom.div()
      ..key = 'collapse'
      ..ref = 'collapse'
      ..className = 'resize-sensor-collapse'
      ..style = _style
      ..onScroll = _handleSensorScroll
    )(collapseSensorChild);

    return (Dom.div()..style = {
        'position': 'relative',
        'height': '100%',
        'width': '100%'
    })(
      tProps.children
        ..add(
            (Dom.div()
              ..className = 'resize-sensor'
              ..style = _style
            )(expandSensor, collapseSensor)
        )
    );
  }

  /// When the expand or collapse sensors are resized, builds a [ResizeSensorEvent] and calls
  /// tProps.onResize with it. Then, calls through to [_reset()].
  void _handleSensorScroll(react.SyntheticEvent e) {
    Element sensor = getDOMNode();
    if (sensor.offsetWidth != tState.lastWidth || sensor.offsetHeight != tState.lastHeight) {
      var event = new ResizeSensorEvent(
          sensor.offsetWidth, sensor.offsetHeight, tState.lastWidth, tState.lastHeight);

      if (tProps.onResize != null) {
        tProps.onResize(event);
      }

      _reset();
    }
  }

  /// Update the css on [expandSensor], [expandSensorChild], and [collapseSensor].
  ///
  /// Additionally update [_lastWidth] and [_lastHeight].
  void _reset() {
    Element expand = react.findDOMNode(ref('expand'));
    Element expandChild = react.findDOMNode(ref('expandChild'));

    expandChild.style.width = '${expand.offsetWidth + 10}px';
    expandChild.style.height = '${expand.offsetHeight + 10}px';
    expand.scrollLeft = expand.scrollWidth;
    expand.scrollTop = expand.scrollHeight;

    Element collapse = react.findDOMNode(ref('collapse'));
    collapse.scrollLeft = collapse.scrollWidth;
    collapse.scrollTop = collapse.scrollHeight;

    Element sensor = getDOMNode();

    setState(newState()
      ..lastWidth = sensor.offsetWidth
      ..lastHeight = sensor.offsetHeight
    );
  }

  @override
  ResizeSensorDefinition typedPropsFactory(Map propsMap) => new ResizeSensorDefinition(propsMap);

  @override
  ResizeSensorState typedStateFactory(Map stateMap) => new ResizeSensorState(stateMap);
}

final Map<String, dynamic> _style = {
  'position': 'absolute',
  'top': '0',
  'right': '0',
  'bottom': '0',
  'left': '0',
  'overflow': 'scroll',
  'zIndex': '-1',
  'visibility': 'hidden'
};

final Map<String, dynamic> _expandSensorChildStyle = {
  'position': 'absolute',
  'top': '0',
  'left': '0'
};

final Map<String, dynamic> _collapseSensorChildStyle = {
  'position': 'absolute',
  'top': '0',
  'left': '0',
  'width': '200%',
  'height': '200%'
};

class ResizeSensorEvent {
  final int newWidth;
  final int newHeight;
  final int prevWidth;
  final int prevHeight;

  ResizeSensorEvent(this.newWidth, this.newHeight, this.prevWidth, this.prevHeight);
}

typedef void ResizeHandler(ResizeSensorEvent e);
