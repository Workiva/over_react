library web_skin_dart.ui_core.rem_util;

import 'dart:async';
import 'dart:html';

import 'package:react/react_dom.dart' as react_dom;
import 'package:web_skin_dart/src/ui_core/util/css_value_util.dart';
import 'package:web_skin_dart/ui_core.dart';

double _computeRootFontSize() {
  return new CssValue.parse(document.documentElement.getComputedStyle().fontSize).number.toDouble();
}

double _rootFontSize = _computeRootFontSize();

void _initRemChangeSensor() {
  var mountNode = new DivElement()
    ..id = 'rem_change_sensor';
  document.body.append(mountNode);

  react_dom.render((Dom.div()
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

double get rootFontSize => _rootFontSize;

final Stream<double> onRemChange = _remChange.stream;

double recomputeRootFontSize() {
  var latestRootFontSize = _computeRootFontSize();

  if (latestRootFontSize != _rootFontSize) {
    _rootFontSize = latestRootFontSize;
    _remChange.add(_rootFontSize);
  }

  return _rootFontSize;
}

String toRem(dynamic pxValue) {
  num pxValueNum;

  if (pxValue is num) {
    pxValueNum = pxValue;
  } else {
    var parsedPxValue = new CssValue.parse(pxValue);
    if (parsedPxValue.unit != 'px') throw new ArgumentError();
    pxValueNum = parsedPxValue.number;
  }

  return new CssValue(pxValueNum / rootFontSize, 'rem').toString();
}

String toPx(dynamic remValue) {
  num remValueNum;

  if (remValue is num) {
    remValueNum = remValue;
  } else {
    var parsedPxValue = new CssValue.parse(remValue);
    if (parsedPxValue.unit != 'rem') throw new ArgumentError();
    remValueNum = parsedPxValue.number;
  }

  return new CssValue(remValueNum * rootFontSize, 'px').toString();
}
