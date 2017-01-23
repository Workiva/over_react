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

library dom_components_test;

// Tell dart2js that this library only needs to reflect the specified types.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(targets: const [
  'over_react.dom_components.Dom'
])
import 'dart:mirrors';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';


main() {
  group('Dom component:', () {
    ClassMirror domClassMirror = reflectClass(Dom);

    List<MethodMirror> methods = domClassMirror.staticMembers.values.toList();

    setUpAll(() {
      expect(methods, isNotEmpty, reason: 'should have properly reflected the static members.');
    });

    for (var element in methods) {
      String name = MirrorSystem.getName(element.simpleName);
      String expectedTagName = name;
      if (expectedTagName == 'variable') expectedTagName = 'var';
      if (expectedTagName == 'svgSet') expectedTagName = 'set';
      if (expectedTagName == 'svgSwitch') expectedTagName = 'switch';
      if (expectedTagName == 'colorProfile') expectedTagName = 'color-profile';
      if (expectedTagName == 'fontFace') expectedTagName = 'font-face';
      if (expectedTagName == 'fontFaceFormat') expectedTagName = 'font-face-format';
      if (expectedTagName == 'fontFaceName') expectedTagName = 'font-face-name';
      if (expectedTagName == 'fontFaceSrc') expectedTagName = 'font-face-src';
      if (expectedTagName == 'fontFaceUri') expectedTagName = 'font-face-uri';
      if (expectedTagName == 'missingGlyph') expectedTagName = 'missing-glyph';
      if (expectedTagName.startsWith(new RegExp('svg.'))) expectedTagName = expectedTagName.substring(3);

      test('Dom.$name generates the correct type', () {
        DomProps builder = domClassMirror.invoke(element.simpleName, []).reflectee;
        ReactElement component = builder();
        expect(component.type, equalsIgnoringCase(expectedTagName));
      });
    }
  });
}
