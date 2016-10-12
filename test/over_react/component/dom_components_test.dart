library dom_components_test;

// Tell dart2js that this library only needs to reflect the specified types.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(targets: const [
  'over_react.Dom'
])
import 'dart:mirrors';

import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:over_react/over_react.dart';


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
      test('Dom.$name generates the correct type', () {
        DomProps builder = domClassMirror.invoke(element.simpleName, []).reflectee;
        ReactElement component = builder();
        expect(component.type, equalsIgnoringCase(expectedTagName));
      });
    }
  });
}
