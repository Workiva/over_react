import 'package:react/react_client/js_backed_map.dart';

extension DeepConvert on JsBackedMap {
  bool _isJsMap(dynamic value) => value is JsMap && value is! Function;

  /// Traverses the provided [jsMap] and recursively
  /// converts any nested [JsMap]s to [JsBackedMap]s.
  ///
  /// Inverse of [deepJsObject].
  JsBackedMap deepConvertFromJs(JsMap jsMap) {
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

  /// Traverses the [jsObject] of the current instance and recursively
  /// converts any nested [Map]s to [JsMap]s.
  ///
  /// Inverse of [deepConvertFromJs].
  JsMap get deepJsObject {
    JsMap _createJsMap(Map nestedDartMap) {
      final jsBackedMap = JsBackedMap.from(nestedDartMap);
      jsBackedMap.forEach((key, value) {
        if (value is Map) {
          jsBackedMap[key] = _createJsMap(value);
        }
      });

      return jsBackedMap.jsObject;
    }

    return _createJsMap(JsBackedMap.fromJs(jsObject));
  }
}
