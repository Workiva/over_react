library handler_chain_util_test;

import 'package:test/test.dart';
import 'package:w_ui_platform/ui_components.dart';
import 'package:w_ui_platform/ui_core.dart';

import '../../test_util/react_util.dart';
import '../../test_util/custom_matchers.dart';
import '../../test_util/common_component_tests.dart';

/// Main entry point for HandlerChainUtil testing
main() {
  group('HandlerChainUtil', () {
    group('createChainedEventKeyCallback', () {
      test('should return an EventKeyCallback that calls the two provided functions', () {
        bool calledA = false, calledB = false;
        EventKeyCallback a = (event, key) => calledA = true;
        EventKeyCallback b = (event, key) => calledB = true;

        var chainedCallback = createChainedEventKeyCallback(a, b);
        var result = chainedCallback(null, null);

        expect(calledA, isTrue);
        expect(calledB, isTrue);

        expect(result, isNull);
      });

      test('should return an EventKeyCallback that returns false if either of the provided functions returns false', () {
        bool calledA = false, calledB = false;
        EventKeyCallback a = (event, key) {
          calledA = true;
          return false;
        };
        EventKeyCallback b = (event, key) => calledB = true;

        var chainedCallback = createChainedEventKeyCallback(a, b);
        var result = chainedCallback(null, null);
        expect(result, isFalse);
      });

      test('should gracefully handle one provided function being null', () {
        bool calledA = false;
        EventKeyCallback a = (event, key) => calledA = true;

        var chainedCallback = createChainedEventKeyCallback(a, null);
        chainedCallback(null, null);

        expect(calledA, isTrue);
      });

      test('should gracefully handle both provided functions being null', () {
        var chainedCallback = createChainedEventKeyCallback(null, null);
        var result = chainedCallback(null, null);

        expect(result, isNull);
      });
    });
  });
}
