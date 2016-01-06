library key_constants_test;

import 'package:react/react.dart' as react;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';


/// Main entry point for KeyValue testing
main() {
  group('KeyValue', () {
    KeyValue.values.forEach((String value) {
      test('$value', () {
        bool flag = false;
        var renderedNode = renderAndGetDom(Dom.div()
          ..onKeyDown = (react.SyntheticKeyboardEvent event) {
            if (event.key == value) {
              flag = true;
            }
          }
        );

        react_test_utils.Simulate.keyDown(renderedNode, {'key': value});

        expect(flag, isTrue);
      });
    });
  });
}
