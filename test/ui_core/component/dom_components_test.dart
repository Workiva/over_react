library dom_components_test;

import 'dart:js';
// Tell dart2js that this library only needs to reflect the specified types.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(targets: const [
  'web_skin_dart.ui_core.Dom'
])
import 'dart:mirrors';

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';


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
      if (expectedTagName == 'variable') {
        expectedTagName = 'var';
      }
      test('Dom.$name generates the correct tagName', () {
        var domComponent = domClassMirror.invoke(element.simpleName, []).reflectee;
        JsObject component = render(domComponent());
        expect(component['tagName'], equalsIgnoringCase(expectedTagName));
      });
    }
  });
}
