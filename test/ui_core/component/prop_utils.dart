import 'dart:mirrors';
import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';



void testProp (Symbol name, dynamic expectedKey, instance, testValue) {
  InstanceMirror mirror = reflect(instance);

  mirror.setField(name, testValue);
  expect(instance[expectedKey], equals(testValue));
  expect(mirror.getField(name).reflectee, equals(testValue));
}

void testKeys (List<String> keys, dynamic instanceBuilder()) {
  test('set up', () {
    var instance = instanceBuilder();
    expect(() {instance['notThere'];}, throws);
  });
  for (var propKey in keys) {
    test('prop: $propKey', () {
      var instance = instanceBuilder();
      testProp(new Symbol(propKey), propKey, instance, null);
    });
  }
  keys = [];
}