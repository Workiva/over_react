/// Thanks!
/// https://github.com/marcj/css-element-queries/blob/master/src/ResizeSensor.js
library resize_sensor;

import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:web_skin_dart/code_generation/annotations.dart';
import 'package:web_skin_dart/ui_core.dart';

part 'resize_sensor.g.dart';

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

/// A component that detects when its parent is resized.
///
/// This component _must_ be put in a relative or absolutely positioned
/// container.
///
///     var sensor = (ResizeSensor()
///         ..onResize = () => print('resized')
///     )();
///     var container = react.div({'position': 'relative'},
///         [/* otherChildren, */ sensor]);
///
ResizeSensorDefinition ResizeSensor() => new ResizeSensorDefinition({});

@GenerateProps(#ResizeSensorProps)
class ResizeSensorDefinition extends BaseComponentDefinition with ResizeSensorProps {
  ResizeSensorDefinition(Map backingMap) : super(_resizeSensorComponentFactory, backingMap);

  /// A function invoked when the parent element is resized.
  ResizeHandler get onResize;
}

var _resizeSensorComponentFactory = react.registerComponent(() => new _ResizeSensor());

class _ResizeSensor extends BaseComponent<ResizeSensorDefinition> {
  int _lastHeight = 0;
  int _lastWidth = 0;

  ResizeSensorDefinition typedPropsFactory(Map propsMap) => new ResizeSensorDefinition(propsMap);

  Map getDefaultProps() => newProps()..onResize = (_) {};

  void componentDidMount(rootNode) {
    _reset();
  }

  // This component will update the DOM manually whenever a resize is detected.
  bool shouldComponentUpdate(nextProps, nextState) => false;

  render() {
    var expandSensorChild = (Dom.div()
      ..ref = 'expandChild'
      ..style = _expandSensorChildStyle
    )();
    var expandSensor = (Dom.div()
      ..key = 'expand'
      ..ref = 'expand'
      ..className = 'resize-sensor-expand'
      ..style = _style
      ..onScroll = _handleSensorScroll
    )([expandSensorChild]);

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
    )([collapseSensorChild]);

    return (Dom.div()
      ..className = 'resize-sensor'
      ..style = _style
    )([expandSensor, collapseSensor]);
  }

  void _handleSensorScroll(react.SyntheticEvent e) {
    Element sensor = getDOMNode();
    if (sensor.offsetWidth != _lastWidth || sensor.offsetHeight != _lastHeight) {
      var event = new ResizeSensorEvent(
          sensor.offsetWidth, sensor.offsetHeight, _lastWidth, _lastHeight);
      tProps.onResize(event);
      _reset();
    }
  }

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
    _lastWidth = sensor.offsetWidth;
    _lastHeight = sensor.offsetHeight;
  }
}
