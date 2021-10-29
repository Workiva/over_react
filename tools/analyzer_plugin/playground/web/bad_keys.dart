import 'package:over_react/over_react.dart';

badKeys() {
  MyModel modelVar;
  MyModelWithCustomToString modelVarWithCustomToString;

  Object objectVar;
  dynamic dynamicVar;

  return [
    // Good keys
    (Dom.div()..key = 'a string')(),
    (Dom.div()..key = 122)(),
    (Dom.div()..key = modelVar.id)(),
    (Dom.div()..key = modelVarWithCustomToString)(),
    (Dom.div()..key = deriveKeyFrom(modelVar))(),

    // over_react_low_quality_key
    (Dom.div()..key = false)(),
    (Dom.div()..key = null)(),

    // over_react_object_to_string_as_key
    (Dom.div()..key = modelVar)(),
    (Dom.div()..key = modelVar.toString())(),
    (Dom.div()..key = deriveKeyFrom(modelVar.toString()))(),
    (Dom.div()..key = 'interpolated $modelVar')(),
    // over_react_object_to_string_as_key (as Iterable/Map generic arguments)
    (Dom.div()..key = {'foo': modelVar})(),
    (Dom.div()..key = [modelVar])(),

    // over_react_unknown_key_type
    (Dom.div()..key = objectVar)(),
    (Dom.div()..key = dynamicVar)(),
    // over_react_unknown_key_type (as Iterable/Map generic arguments)
    (Dom.div()..key = {'foo': modelVar, 'bar': 1})(),
    (Dom.div()..key = [1, modelVar])(),
  ];
}

// ignore: missing_return
String deriveKeyFrom(Object object) {}

class MyModel {
  int id;
}

class MyModelWithCustomToString {
  int id;

  @override
  toString() => '$id';
}
