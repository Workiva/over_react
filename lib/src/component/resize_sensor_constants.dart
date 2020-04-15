// Copyright 2020 Workiva Inc.
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

import 'package:platform_detect/platform_detect.dart';

/// The maximum size, in `px`, the sensor can be: 100,000.
///
/// We want to use absolute values to avoid accessing element dimensions when possible,
/// and relative units like `%` don't work since they don't cause scroll events when sensor size changes.
///
/// We could use `rem` or `vh`/`vw`, but that opens us up to more edge cases.
const int maxSensorSize = 100 * 1000;

const baseStyle = <String, dynamic>{
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

const shrinkBaseStyle = <String, dynamic>{
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

const expandSensorChildStyle = <String, dynamic>{
  'position': 'absolute',
  'top': '0',
  'left': '0',
  'visibility': 'hidden',
  // Use a width/height that will always be larger than the expandSensor.
  // We'd ideally want to do something like calc(100% + 10px), but that doesn't
  // trigger scroll events the same way a fixed dimension does.
  'width': maxSensorSize,
  'height': maxSensorSize,
  // Set opacity in addition to visibility to work around Safari scrollbar bug.
  'opacity': '0',
};

const collapseSensorChildStyle = <String, dynamic>{
  'position': 'absolute',
  'top': '0',
  'left': '0',
  'width': '200%',
  'height': '200%',
  'visibility': 'hidden',
  // Set opacity in addition to visibility to work around Safari scrollbar bug.
  'opacity': '0',
};


const defaultWrapperStyles = <String, dynamic>{
  'position': 'relative',
  'height': '100%',
  'width': '100%',
};

const wrapperStylesFlexChild = <String, dynamic>{
  'position': 'relative',
  'flex': '1 1 0%',
  'msFlex': '1 1 0%',
  'display': 'block',
  // Fix ResizeSensor not shrinking properly: https://www.chromestatus.com/feature/6736527476391936
  'minHeight': '0',
};

final wrapperStylesFlexContainer = <String, dynamic>{
  'position': 'relative',
  'flex': '1 1 0%',
  'msFlex': '1 1 0%',
  'display': displayFlex,
  // Fix ResizeSensor not shrinking properly: https://www.chromestatus.com/feature/6736527476391936
  'minHeight': '0',
};

/// The browser-prefixed value for the CSS `display` property that enables flexbox.
final String displayFlex = (() {
  if (browser.isInternetExplorer && browser.version.major <= 10) return '-ms-flexbox';
  return 'flex';
})();
