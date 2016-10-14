/// Utilities for working with CSS `rem` units and detecting changes to the root font size.
library over_react.rem_util;

import 'dart:async';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/css_value_util.dart';
import 'package:react/react_dom.dart' as react_dom;

double _computeRootFontSize() {
  return new CssValue.parse(document.documentElement.getComputedStyle().fontSize).number.toDouble();
}

double _rootFontSize = _computeRootFontSize();

var _changeSensor;
void _initRemChangeSensor() {
  if (_changeSensor != null) return;
  // Force lazy-initialization of this variable if it hasn't happened already.
  _rootFontSize;

  var mountNode = new DivElement()
    ..id = 'rem_change_sensor';

  // Ensure the sensor doesn't interfere with the rest of the page.
  mountNode.style
    ..width = '0'
    ..height = '0'
    ..position = 'absolute'
    ..zIndex = '-1';

  document.body.append(mountNode);

  _changeSensor = react_dom.render((Dom.div()
    ..style = const {
      'position': 'absolute',
      'visibility': 'hidden',
      // ResizeSensor doesn't pick up sub-pixel changes due to its use of offsetWidth/Height,
      // so use 100rem for greater precision.
      'width': '100rem',
      'height': '100rem',
    }
  )(
    (ResizeSensor()..onResize = (ResizeSensorEvent e) {
      recomputeRootFontSize();
    })()
  ), mountNode);
}

final StreamController<double> _remChange = new StreamController.broadcast(onListen: () {
  _initRemChangeSensor();
});

/// The latest component root font size (rem) value, in pixels.
double get rootFontSize => _rootFontSize;

/// A Stream of changes to the root font size (rem) value.
///
/// Stream data is the latest value, in pixels.
final Stream<double> onRemChange = _remChange.stream;

/// Forces re-computation of the root font size. Not necessary when using [onRemChange].
void recomputeRootFontSize() {
  var latestRootFontSize = _computeRootFontSize();

  if (latestRootFontSize != _rootFontSize) {
    _rootFontSize = latestRootFontSize;
    _remChange.add(_rootFontSize);
  }
}

/// Converts a pixel (`px`) value to its `rem` equivalent using the current root font size.
///
/// Example input:
///
/// * `'15px'`
/// * `'15'`
/// * 15
///
/// Example output (assuming 1rem = 10px):
///
/// * `1.5rem`
CssValue toRem(dynamic pxValue) {
  num pxValueNum;

  if (pxValue is num) {
    pxValueNum = pxValue;
  } else {
    var parsedPxValue = pxValue is CssValue ? pxValue : new CssValue.parse(pxValue);
    if (parsedPxValue?.unit != 'px') {
      throw new ArgumentError.value(pxValue, 'pxValue', 'must be a num or a String px value');
    }

    pxValueNum = parsedPxValue.number;
  }

  return new CssValue(pxValueNum / rootFontSize, 'rem');
}

/// Converts a rem value to its pixel (`px`) equivalent using the current root font size.
///
/// Example input:
///
/// * `'1.5rem'`
/// * `'1.5'`
/// * 1.5
///
/// Example output (assuming 1rem = 10px):
///
/// * `15px`
CssValue toPx(dynamic remValue) {
  num remValueNum;

  if (remValue is num) {
    remValueNum = remValue;
  } else {
    var parsedRemValue = remValue is CssValue ? remValue : new CssValue.parse(remValue);
    if (parsedRemValue?.unit != 'rem') {
      throw new ArgumentError.value(remValue, 'remValue', 'must be a num or a String rem value');
    }

    remValueNum = parsedRemValue.number;
  }

  return new CssValue(remValueNum * rootFontSize, 'px');
}
