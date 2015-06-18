library dom_components_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';


import '../../test_util/react_util.dart';

import 'dart:js';
import 'dart:mirrors';

main() {
  group('Dom Components', () {
    ClassMirror domClassMirror = reflectClass(Dom);

    Iterable<MethodMirror> methods = domClassMirror.staticMembers.values;

    for (var element in methods) {
      String name = MirrorSystem.getName(element.simpleName);
      String expectedTagName = name;
      if (expectedTagName == 'variable') {
        expectedTagName = 'var';
      }
      test('Dom.$name', () {
        var domComponent = domClassMirror.invoke(element.simpleName, []).reflectee;
        JsObject component = render(domComponent());
        expect(component['tagName'], equalsIgnoringCase(expectedTagName));
      });
    }
  });
}
