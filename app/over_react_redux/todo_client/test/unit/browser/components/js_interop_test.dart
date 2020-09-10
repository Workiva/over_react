@TestOn('browser')
@JS()
library js_interop_test;

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:test/test.dart';

import 'package:todo_client/src/utils.dart';

@JS()
external JsMap get mockJsMap;

main() {
  JsBackedMap mockJsBackedMap;

  setUpAll(() async {
    expect(mockJsMap, isNotNull, reason: 'test setup sanity check');
    mockJsBackedMap = JsBackedMap.backedBy(mockJsMap);
  });

  test('jsBackedMapDeepFromJs() converts deeply nested JS objects into JsBackedMaps', () {
    expect(jsBackedMapDeepFromJs(mockJsBackedMap.jsObject), isA<JsBackedMap>());
    expect(jsBackedMapDeepFromJs(mockJsBackedMap['nested']), isA<JsBackedMap>());
    expect(jsBackedMapDeepFromJs(mockJsBackedMap['nested'])['nested'], isA<JsBackedMap>());
  });
}