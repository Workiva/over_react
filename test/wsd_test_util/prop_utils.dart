library test_util.prop_utils;

// Tell dart2js that this library only needs to reflect types annotated with `Props`/`PropsMixin`.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(metaTargets: const [
  'over_react.component_declaration.annotations.Props',
  'over_react.component_declaration.annotations.PropsMixin',
])
import 'dart:mirrors';

import 'package:test/test.dart';

void testProp (Symbol name, dynamic expectedKey, instance, testValue) {
  InstanceMirror mirror = reflect(instance);

  mirror.setField(name, testValue);
  expect(instance[expectedKey], equals(testValue));
  expect(mirror.getField(name).reflectee, equals(testValue));
}

void testKeys (List<String> keys, dynamic instanceBuilder()) {
  test('cannot set / read values that are not its prop map', () {
    var instance = instanceBuilder();
    expect(() {instance['notThere'];}, throws);
  });
  for (var propKey in keys) {
    test('prop: $propKey can have its value set / read', () {
      var instance = instanceBuilder();
      testProp(new Symbol(propKey), propKey, instance, null);
    });
  }
}
