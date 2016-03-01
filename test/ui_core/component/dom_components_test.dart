library dom_components_test;

import 'dart:js';
import 'dart:mirrors';

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';


main() {
  group('Dom component:', () {
    ClassMirror domClassMirror = reflectClass(Dom);

    Iterable<MethodMirror> methods = domClassMirror.staticMembers.values;

    for (var element in methods) {
      String name = MirrorSystem.getName(element.simpleName);
      String expectedTagName = name;
      if (expectedTagName == 'variable') {
        expectedTagName = 'var';
      }
      test('Dom.$name generates the correct type', () {
        var domComponent = domClassMirror.invoke(element.simpleName, []).reflectee;
        JsObject component = domComponent();
        expect(component['type'], equalsIgnoringCase(expectedTagName));
      });
    }
  });
}
