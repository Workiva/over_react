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

/// Utilities for working with CSS `rem` units and detecting changes to the font size
/// of the [HtmlDocument].
library over_react.rem_util;

import 'dart:async';
import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/css_value_util.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:platform_detect/platform_detect.dart';

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

/// Forces re-computation of the font size of the [HtmlDocument].
///
/// Not necessary when using [onRemChange].
void recomputeRootFontSize() {
  var latestRootFontSize = _computeRootFontSize();

  if (latestRootFontSize != _rootFontSize) {
    _rootFontSize = latestRootFontSize;
    _remChange.add(_rootFontSize);
  }
}

/// Converts a pixel (`px`) [value] to its `rem` equivalent using the current font size
/// found on the [HtmlDocument].
///
/// * If [value] is a [String] or [CssValue]:
///   * And [value] already has the correct unit, it will not be converted.
///   * And [CssValue.unit] is not `'px'` or `'rem'`, an error will be thrown unless
///   [passThroughUnsupportedUnits] is `true`, in which case no conversion will take place.
/// * If [value] is a [num], it will be treated as a `px` and converted, unless [treatNumAsRem] is `true`.
/// * If [value] is `null`, `null` will be returned.
///
/// Examples _(all will output `1.5rem` assuming `1rem == 10px`)_:
///
///     toRem('15px');
///     toRem(new CssValue(15, 'px'));
///     toRem(15);
///     toRem(1.5, treatNumAsRem: true);
///     toRem('1.5rem');
///     new CssValue(1.5, 'rem');
///
/// > Related: [toPx]
CssValue toRem(dynamic value, {bool treatNumAsRem: false, bool passThroughUnsupportedUnits: false}) {
  // Because Chrome changes the value of its root font size when zoomed out lower than 90%, we need
  // to automatically wire up the rem change sensor so that any calls to `toRem` when the viewport is
  // zoomed return an accurate value.
  //
  // See: https://jira.atl.workiva.net/browse/AF-1048 / https://bugs.chromium.org/p/chromium/issues/detail?id=429140
  if (browser.isChrome) {
    Zone.ROOT.run(_initRemChangeSensor);
  }

  if (value == null) return null;

  num remValueNum;

  if (value is num) {
    remValueNum = treatNumAsRem ? value : value / rootFontSize;
  } else {
    var parsedValue = value is CssValue ? value : new CssValue.parse(value);

    if (parsedValue?.unit == 'rem') {
      remValueNum = parsedValue.number;
    } else if (parsedValue?.unit == 'px') {
      remValueNum = parsedValue.number / rootFontSize;
    } else {
      if (passThroughUnsupportedUnits) return parsedValue;

      throw new ArgumentError.value(value, 'value', 'must be a px num or a String px/rem value');
    }
  }

  return new CssValue(remValueNum, 'rem');
}

/// Converts a rem [value] to its pixel (`px`) equivalent using the current font size
/// found on the [HtmlDocument].
///
/// * If [value] is a [String] or [CssValue]:
///   * And [value] already has the correct unit, it will not be converted.
///   * And [CssValue.unit] is not `'px'` or `'rem'`, an error will be thrown unless
///   [passThroughUnsupportedUnits] is `true`, in which case no conversion will take place.
/// * If [value] is a [num], it will be treated as a `rem` and converted, unless [treatNumAsPx] is `true`.
/// * If [value] is `null`, `null` will be returned.
///
/// Examples _(all will output `15px` assuming `1rem == 10px`)_:
///
///     toPx('1.5rem');
///     toPx(new CssValue(1.5, 'rem'));
///     toPx(1.5);
///     toPx(15, treatNumAsPx: true);
///     toPx(15px);
///     toPx(new CssValue(15, 'px'));
///
/// > Related: [toRem]
CssValue toPx(dynamic value, {bool treatNumAsPx: false, bool passThroughUnsupportedUnits: false}) {
  if (value == null) return null;

  num pxValueNum;

  if (value is num) {
    pxValueNum = treatNumAsPx ? value : value * rootFontSize;
  } else {
    var parsedValue = value is CssValue ? value : new CssValue.parse(value);

    if (parsedValue?.unit == 'px') {
      pxValueNum = parsedValue.number;
    } else if (parsedValue?.unit == 'rem') {
      pxValueNum = parsedValue.number * rootFontSize;
    } else {
      if (passThroughUnsupportedUnits) return parsedValue;

      throw new ArgumentError.value(value, 'value', 'must be a rem num or a String px/rem value');
    }
  }

  return new CssValue(pxValueNum, 'px');
}
