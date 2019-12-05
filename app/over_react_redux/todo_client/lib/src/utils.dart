import 'package:react/react_client/js_backed_map.dart';

JsBackedMap createJsBackedMapRecursively(JsMap jsMap) {
  JsBackedMap _createJsBackedMap(JsMap nestedJsMap) {
    final map = JsBackedMap.fromJs(nestedJsMap);
    map.forEach((key, value) {
      if (value is JsMap) {
        map[key] = _createJsBackedMap(value);
      }
    });

    return map;
  }

  final topLevelJsBackedMap = JsBackedMap.fromJs(jsMap);
  topLevelJsBackedMap.forEach((key, value) {
    if (value is JsMap) {
      topLevelJsBackedMap[key] = _createJsBackedMap(value);
    }
  });

  return topLevelJsBackedMap;
}
