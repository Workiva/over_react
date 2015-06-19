import 'dart:mirrors';
import 'package:test/test.dart';
import 'package:w_ui_platform/ui_core.dart';



void testProp (Symbol name, dynamic expectedKey, instance, testValue) {
  InstanceMirror mirror = reflect(instance);

  mirror.setField(name, testValue);
  expect(instance[expectedKey], equals(testValue));
  expect(mirror.getField(name).reflectee, equals(testValue));
}

//void testKeys (testClass, instance) {
//  ClassMirror classMirror = reflectClass(testClass);
//
//  for (var element in classMirror.declarations.values) {
//    test('', (){
//      var name = MirrorSystem.getName(element.simpleName);
//      if (!name.contains('=')) {
//        testProp(element.simpleName, name, testClass, null);
//      }
//    });
//
//  }
//}

List getKeys (testClass) {
  List keys = [];

  ClassMirror classMirror = reflectClass(testClass);
  for (var element in classMirror.declarations.values) {
    var name = MirrorSystem.getName(element.simpleName);
    if (!name.contains('=') && !name.toLowerCase().contains('props')) {
      keys.add(name);
    }
  }

  return keys;
}

void testKeys (testClass, dynamic instanceBuilder()) {
  List keys = getKeys(testClass);

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