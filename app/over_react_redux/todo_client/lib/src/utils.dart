import 'package:react/react_client/js_backed_map.dart';

/// Traverses the provided [jsMap] and recursively
/// converts any nested [JsMap]s to [JsBackedMap]s.
JsBackedMap jsBackedMapDeepFromJs(JsMap jsMap) {
  bool _isJsMap(dynamic value) => value is JsMap && value is! Function;

  JsBackedMap _createJsBackedMap(JsMap nestedJsMap) {
    final map = JsBackedMap.fromJs(nestedJsMap);
    map.forEach((key, value) {
      if (_isJsMap(value)) {
        map[key] = _createJsBackedMap(value);
      }
    });

    return map;
  }

  return _createJsBackedMap(jsMap);
}
