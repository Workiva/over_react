import 'package:over_react/over_react.dart';

badKeys() {
  MyModel modelVar;
  Object objectVar;
  dynamic dynamicVar;

  return (Fragment())(
    (Dom.div()..key = 'a string')(),
    (Dom.div()..key = 122)(),

    // over_react_low_quality_key
    (Dom.div()..key = false)(),
    (Dom.div()..key = null)(),

    // over_react_object_to_string_as_key
    (Dom.div()..key = modelVar)(),
    (Dom.div()..key = modelVar.toString())(),

    // over_react_unknown_key_type
    (Dom.div()..key = objectVar)(),
    (Dom.div()..key = dynamicVar)(),

    // over_react_object_to_string_as_key (Map/Iterable
    (Dom.div()
      ..key = {
        'foo': modelVar,
        'bar': modelVar,
      }
    )(),
    (Dom.div()
      ..key = <dynamic, dynamic>{
        'foo': modelVar,
        'bar': modelVar,
      }
    )(),
  );
}



class MyModel {}
