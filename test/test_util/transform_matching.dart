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

/// Parsing and matching of CSS `transform` values with built-in tolerances and cross-browser normalization.
library transform_matching;

import 'package:test/test.dart';

class TransformMatcher extends CustomMatcher {
  TransformMatcher(dynamic matcher) : super('Transform that', 'parsed value', matcher);

  @override
  featureValueOf(transform) => parseCssTransform(transform as String);
}

/// Parses a CSS transform into nested [List]s for easy matching.
///
/// Example:
///
/// * Input:
///
///         'translate(12.5px, 0) rotateY(5deg)'
///
/// * Output:
///
///         [
///           ['translate', [
///             [12.5, 'px'],
///             [0, '']
///           ]],
///           ['rotateY', [
///             [5, 'deg']
///           ]]
///         ]
List parseCssTransform(String transformString) {
  return RegExp(r'\w+(\([^\)]+\))?').allMatches(transformString).map((match) {
    var transform = match[0];

    var transformParts = RegExp(r'(\w+)\s*\(\s*(.+)\s*\)').firstMatch(transform);

    String name = transformParts[1];
    List arguments = transformParts[2].split(RegExp(r',\s*')).map((argument) {
      var valueMatch = RegExp(r'^([\d\.\-]+)(.*)').firstMatch(argument);

      var number = double.parse(valueMatch[1]);
      var unit = valueMatch[2];

      return [number, unit];
    }).toList();

    return [name, arguments];

  }).toList();
}

/// Returns a matcher that matches CSS transform values equivalent to [transformString], with numbers values within
/// [tolerance] (not applied to zero values). Also normalizes unitless zeros.
///
/// Example:
///
/// * `matchesTransform('translate(0, 5px) rotate(90deg)')` will match `'translate(0px, 5.001px) rotate(89.999deg)'`
Matcher matchesTransform(String transformString, {double tolerance = .01}) {
  var matcher = parseCssTransform(transformString).map((transformPartTuple) {
    var name = transformPartTuple[0];
    var arguments = transformPartTuple[1];

    var argumentMatcher = arguments.map((argumentTuple) {
      var number = argumentTuple[0];
      var unit = argumentTuple[1];

      // IE10 adds on `px` to unitless zero, so accept any unit.
      // Also, don't apply tolerance to zero.
      if (number == 0) return [0, anything];

      return [closeTo(number as num, tolerance), anyOf(unit, '')];
    }).toList();

    return [name, argumentMatcher];
  }).toList();

  return TransformMatcher(matcher);
}
