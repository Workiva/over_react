library handler_chain_util_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../../test_util/react_util.dart';
import '../../test_util/custom_matchers.dart';
import '../../test_util/common_component_tests.dart';
import '../../test_util/zone.dart';

/// Main entry point for HandlerChainUtil testing
main() {
  group('HandlerChainUtil', () {
    group('React DOM event callback creation utility function', () {
      callsBothFunctions(Function creator) {
        bool calledA = false, calledB = false;
        Function a = (event) => calledA = true;
        Function b = (event) => calledB = true;

        var chainedCallback = creator(a, b);
        var result = chainedCallback(null);

        expect(calledA, isTrue);
        expect(calledB, isTrue);

        expect(result, isNull);
      }

      callsFunctionsInOrder(Function creator) {
        int counter = 1;
        bool calledA = false, calledB = false;
        Function a = (event) {
          calledA = true;
          zonedExpect(counter, equals(1));
          counter++;
        };
        Function b = (event) {
          calledB = true;
          zonedExpect(counter, equals(2));
        };

        var chainedCallback = creator(a, b);
        chainedCallback(null);

        expect(calledA, isTrue);
        expect(calledB, isTrue);
      }

      returnsFalseWhenAReturnsFalse(Function creator) {
        Function a = (event) => false;
        Function b = (event) => true;

        var chainedCallback = creator(a, b);
        var result = chainedCallback(null);

        expect(result, isFalse);
      }

      returnsFalseWhenBReturnsFalse(Function creator) {
        Function a = (event) => true;
        Function b = (event) => false;

        var chainedCallback = creator(a, b);
        var result = chainedCallback(null);

        expect(result, isFalse);
      }

      returnsFalseWhenBothReturnFalse(Function creator) {
        Function a = (event) => false;
        Function b = (event) => false;

        var chainedCallback = creator(a, b);
        var result = chainedCallback(null);

        expect(result, isFalse);
      }

      returnsNullWhenNeitherReturnFalse(Function creator) {
        Function a = (event) => true;
        Function b = (event) => true;

        var chainedCallback = creator(a, b);
        var result = chainedCallback(null);

        expect(result, isNull);
      }

      handlesNullParameters(Function creator) {
        bool flag = false;
        Function callback = (event) => flag = true;
        var chainedCallback, result;

        chainedCallback = creator(callback, null);
        chainedCallback(null);
        expect(flag, isTrue, reason: 'The first callback should be called when the second callback is null');

        flag = false;

        chainedCallback = creator(null, callback);
        chainedCallback(null);
        expect(flag, isTrue, reason: 'The second callback should be called when the first callback is null');

        chainedCallback = creator(null, null);
        try {
          result = chainedCallback(null);
          expect(result, isNull);
        } catch (exception) {
          fail(exception);
        }
      }

      test('createChainedDomEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedDomEventCallback);
        callsFunctionsInOrder(createChainedDomEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedDomEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedDomEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedDomEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedDomEventCallback);
        handlesNullParameters(createChainedDomEventCallback);
      });

      test('createChainedClipboardEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedClipboardEventCallback);
        callsFunctionsInOrder(createChainedClipboardEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedClipboardEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedClipboardEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedClipboardEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedClipboardEventCallback);
        handlesNullParameters(createChainedClipboardEventCallback);
      });

      test('createChainedKeyboardEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedKeyboardEventCallback);
        callsFunctionsInOrder(createChainedKeyboardEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedKeyboardEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedKeyboardEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedKeyboardEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedKeyboardEventCallback);
        handlesNullParameters(createChainedKeyboardEventCallback);
      });

      test('createChainedFocusEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedFocusEventCallback);
        callsFunctionsInOrder(createChainedFocusEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedFocusEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedFocusEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedFocusEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedFocusEventCallback);
        handlesNullParameters(createChainedFocusEventCallback);
      });

      test('createChainedFormEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedFormEventCallback);
        callsFunctionsInOrder(createChainedFormEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedFormEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedFormEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedFormEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedFormEventCallback);
        handlesNullParameters(createChainedFormEventCallback);
      });

      test('createChainedMouseEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedMouseEventCallback);
        callsFunctionsInOrder(createChainedMouseEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedMouseEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedMouseEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedMouseEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedMouseEventCallback);
        handlesNullParameters(createChainedMouseEventCallback);
      });

      test('createChainedTouchEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedTouchEventCallback);
        callsFunctionsInOrder(createChainedTouchEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedTouchEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedTouchEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedTouchEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedTouchEventCallback);
        handlesNullParameters(createChainedTouchEventCallback);
      });

      test('createChainedUIEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedUIEventCallback);
        callsFunctionsInOrder(createChainedUIEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedUIEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedUIEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedUIEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedUIEventCallback);
        handlesNullParameters(createChainedUIEventCallback);
      });

      test('createChainedWheelEventCallback returns a callback that behaves correctly', () {
        callsBothFunctions(createChainedWheelEventCallback);
        callsFunctionsInOrder(createChainedWheelEventCallback);
        returnsFalseWhenAReturnsFalse(createChainedWheelEventCallback);
        returnsFalseWhenBReturnsFalse(createChainedWheelEventCallback);
        returnsFalseWhenBothReturnFalse(createChainedWheelEventCallback);
        returnsNullWhenNeitherReturnFalse(createChainedWheelEventCallback);
        handlesNullParameters(createChainedWheelEventCallback);
      });
    });

    group('web_skin_dart callback creation utility function', () {
      group('createChainedEventKeyCallback', () {
        test('should return an EventKeyCallback that calls the two provided functions', () {
          bool calledA = false,
            calledB = false;
          EventKeyCallback a = (event, key) => calledA = true;
          EventKeyCallback b = (event, key) => calledB = true;

          var chainedCallback = createChainedEventKeyCallback(a, b);
          var result = chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);

          expect(result, isNull);
        });

        test('should return an EventKeyCallback that calls the two provided functions in order', () {
          int counter = 1;
          bool calledA = false,
            calledB = false;
          EventKeyCallback a = (event, key) {
            calledA = true;
            zonedExpect(counter, equals(1));
            counter++;
          };
          EventKeyCallback b = (event, key) {
            calledB = true;
            zonedExpect(counter, equals(2));
          };

          var chainedCallback = createChainedEventKeyCallback(a, b);
          chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);
        });

        group('should return an EventKeyCallback that calls the two provided functions and returns', () {
          test('false if the first provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            EventKeyCallback a = (event, key) {
              calledA = true;
              return false;
            };
            EventKeyCallback b = (event, key) => calledB = true;

            var chainedCallback = createChainedEventKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            bool calledA = false, calledB = false;
            EventKeyCallback a = (event, key) => calledA = true;
            EventKeyCallback b = (event, key) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedEventKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if both provided functions return false', () {
            bool calledA = false, calledB = false;
            EventKeyCallback a = (event, key) {
              calledA = true;
              return false;
            };
            EventKeyCallback b = (event, key) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedEventKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            bool calledA = false, calledB = false;
            EventKeyCallback a = (event, key) {
              calledA = true;
              return true;
            };
            EventKeyCallback b = (event, key) {
              calledB = true;
              return;
            };

            var chainedCallback = createChainedEventKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isNull);
          });
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

      group('createChainedCollapseCallback', () {
        test('should return an CollapseCallback that calls the two provided functions', () {
          bool calledA = false, calledB = false;
          CollapseCallback a = () => calledA = true;
          CollapseCallback b = () => calledB = true;

          var chainedCallback = createChainedCollapseCallback(a, b);
          var result = chainedCallback();

          expect(calledA, isTrue);
          expect(calledB, isTrue);

          expect(result, isNull);
        });

        test('should return an CollapseCallback that calls the two provided functions in order', () {
          int counter = 1;
          bool calledA = false, calledB = false;
          CollapseCallback a = () {
            calledA = true;
            zonedExpect(counter, equals(1));
            counter++;
          };
          CollapseCallback b = () {
            calledB = true;
            zonedExpect(counter, equals(2));
          };

          var chainedCallback = createChainedCollapseCallback(a, b);
          chainedCallback();

          expect(calledA, isTrue);
          expect(calledB, isTrue);
        });

        group('should return an CollapseCallback that calls the two provided functions and returns', () {
          test('false if the first provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            CollapseCallback a = () {
              calledA = true;
              return false;
            };
            CollapseCallback b = () => calledB = true;

            var chainedCallback = createChainedCollapseCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            CollapseCallback a = () => calledA = true;
            CollapseCallback b = () {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedCollapseCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if both provided functions return false', () {
            bool calledA = false,
              calledB = false;
            CollapseCallback a = () {
              calledA = true;
              return false;
            };
            CollapseCallback b = () {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedCollapseCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            bool calledA = false,
              calledB = false;
            CollapseCallback a = () {
              calledA = true;
              return true;
            };
            CollapseCallback b = () {
              calledB = true;
              return;
            };

            var chainedCallback = createChainedCollapseCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isNull);
          });
        });

        test('should gracefully handle one provided function being null', () {
          bool calledA = false;
          CollapseCallback a = () => calledA = true;

          var chainedCallback = createChainedCollapseCallback(a, null);
          chainedCallback();

          expect(calledA, isTrue);
        });

        test('should gracefully handle both provided functions being null', () {
          var chainedCallback = createChainedCollapseCallback(null, null);
          var result = chainedCallback();

          expect(result, isNull);
        });
      });
    });
  });
}
