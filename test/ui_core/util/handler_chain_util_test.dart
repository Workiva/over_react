library handler_chain_util_test;

import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../../wsd_test_util/zone.dart';

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
      group('createChainedTargetKeyCallback', () {
        test('should return an TargetKeyCallback that calls the two provided functions', () {
          bool calledA = false,
            calledB = false;
          TargetKeyCallback a = (event, key) => calledA = true;
          TargetKeyCallback b = (event, key) => calledB = true;

          var chainedCallback = createChainedTargetKeyCallback(a, b);
          var result = chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);

          expect(result, isNull);
        });

        test('should return an TargetKeyCallback that calls the two provided functions in order', () {
          int counter = 1;
          bool calledA = false,
            calledB = false;
          TargetKeyCallback a = (event, key) {
            calledA = true;
            zonedExpect(counter, equals(1));
            counter++;
          };
          TargetKeyCallback b = (event, key) {
            calledB = true;
            zonedExpect(counter, equals(2));
          };

          var chainedCallback = createChainedTargetKeyCallback(a, b);
          chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);
        });

        group('should return an TargetKeyCallback that calls the two provided functions and returns', () {
          test('false if the first provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            TargetKeyCallback a = (event, key) {
              calledA = true;
              return false;
            };
            TargetKeyCallback b = (event, key) => calledB = true;

            var chainedCallback = createChainedTargetKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            bool calledA = false, calledB = false;
            TargetKeyCallback a = (event, key) => calledA = true;
            TargetKeyCallback b = (event, key) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedTargetKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if both provided functions return false', () {
            bool calledA = false, calledB = false;
            TargetKeyCallback a = (event, key) {
              calledA = true;
              return false;
            };
            TargetKeyCallback b = (event, key) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedTargetKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            bool calledA = false, calledB = false;
            TargetKeyCallback a = (event, key) {
              calledA = true;
              return true;
            };
            TargetKeyCallback b = (event, key) {
              calledB = true;
              return;
            };

            var chainedCallback = createChainedTargetKeyCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isNull);
          });
        });

        test('should gracefully handle one provided function being null', () {
          bool calledA = false;
          TargetKeyCallback a = (event, key) => calledA = true;

          var chainedCallback = createChainedTargetKeyCallback(a, null);
          chainedCallback(null, null);

          expect(calledA, isTrue);
        });

        test('should gracefully handle both provided functions being null', () {
          var chainedCallback = createChainedTargetKeyCallback(null, null);
          var result = chainedCallback(null, null);

          expect(result, isNull);
        });
      });

      group('createChainedTargetKeyIndexCallback', () {
        test('should return an TargetKeyIndexCallback that calls the two provided functions', () {
          bool calledA = false,
            calledB = false;
          TargetKeyIndexCallback a = (event, key, index) => calledA = true;
          TargetKeyIndexCallback b = (event, key, index) => calledB = true;

          var chainedCallback = createChainedTargetKeyIndexCallback(a, b);
          var result = chainedCallback(null, null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);

          expect(result, isNull);
        });

        test('should return an TargetKeyIndexCallback that calls the two provided functions in order', () {
          int counter = 1;
          bool calledA = false,
            calledB = false;
          TargetKeyIndexCallback a = (event, key, index) {
            calledA = true;
            zonedExpect(counter, equals(1));
            counter++;
          };
          TargetKeyIndexCallback b = (event, key, index) {
            calledB = true;
            zonedExpect(counter, equals(2));
          };

          var chainedCallback = createChainedTargetKeyIndexCallback(a, b);
          chainedCallback(null, null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);
        });

        group('should return an TargetKeyIndexCallback that calls the two provided functions and returns', () {
          test('false if the first provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            TargetKeyIndexCallback a = (event, key, index) {
              calledA = true;
              return false;
            };
            TargetKeyIndexCallback b = (event, key, index) => calledB = true;

            var chainedCallback = createChainedTargetKeyIndexCallback(a, b);
            var result = chainedCallback(null, null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            bool calledA = false, calledB = false;
            TargetKeyIndexCallback a = (event, key, index) => calledA = true;
            TargetKeyIndexCallback b = (event, key, index) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedTargetKeyIndexCallback(a, b);
            var result = chainedCallback(null, null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if both provided functions return false', () {
            bool calledA = false, calledB = false;
            TargetKeyIndexCallback a = (event, key, index) {
              calledA = true;
              return false;
            };
            TargetKeyIndexCallback b = (event, key, index) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedTargetKeyIndexCallback(a, b);
            var result = chainedCallback(null, null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            bool calledA = false, calledB = false;
            TargetKeyIndexCallback a = (event, key, index) {
              calledA = true;
              return true;
            };
            TargetKeyIndexCallback b = (event, key, index) {
              calledB = true;
              return;
            };

            var chainedCallback = createChainedTargetKeyIndexCallback(a, b);
            var result = chainedCallback(null, null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isNull);
          });
        });

        test('should gracefully handle one provided function being null', () {
          bool calledA = false;
          TargetKeyIndexCallback a = (event, key, index) => calledA = true;

          var chainedCallback = createChainedTargetKeyIndexCallback(a, null);
          chainedCallback(null, null, null);

          expect(calledA, isTrue);
        });

        test('should gracefully handle both provided functions being null', () {
          var chainedCallback = createChainedTargetKeyIndexCallback(null, null);
          var result = chainedCallback(null, null, null);

          expect(result, isNull);
        });
      });

      group('createChainedTargetKeyCallbackFromList', () {
        group('returns', () {
          test('false if the first provided function returns false', () {
            var flags = [false, false, false];
            var callbacks = [
              (event, key) {
                flags[0] = true;
                return false;
              },
              (event, key) => flags[1] = true,
              (event, key) => flags[2] = true
            ];

            var chainedCallback = createChainedTargetKeyCallbackFromList(callbacks);
            var result = chainedCallback(null, null);

            expect(flags[0], isTrue);
            expect(flags[1], isTrue);
            expect(flags[2], isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            var flags = [false, false, false];
            var callbacks = [
              (event, key) => flags[0] = true,
              (event, key) {
                flags[1] = true;
                return false;
              },
              (event, key) => flags[2] = true
            ];

            var chainedCallback = createChainedTargetKeyCallbackFromList(callbacks);
            var result = chainedCallback(null, null);

            expect(flags[0], isTrue);
            expect(flags[1], isTrue);
            expect(flags[2], isTrue);

            expect(result, isFalse);
          });

          test('false if the last provided functions returns false', () {
            var flags = [false, false, false];
            var callbacks = [
              (event, key) => flags[0] = true,
              (event, key) => flags[1] = true,
              (event, key) {
                flags[2] = true;
                return false;
              }
            ];

            var chainedCallback = createChainedTargetKeyCallbackFromList(callbacks);
            var result = chainedCallback(null, null);

            expect(flags[0], isTrue);
            expect(flags[1], isTrue);
            expect(flags[2], isTrue);

            expect(result, isFalse);
          });

          test('false if two provided functions return false', () {
            var flags = [false, false, false];
            var callbacks = [
              (event, key) => flags[0] = true,
              (event, key) {
                flags[1] = true;
                return false;
              },
              (event, key) {
                flags[2] = true;
                return false;
              }
            ];

            var chainedCallback = createChainedTargetKeyCallbackFromList(callbacks);
            var result = chainedCallback(null, null);

            expect(flags[0], isTrue);
            expect(flags[1], isTrue);
            expect(flags[2], isTrue);

            expect(result, isFalse);
          });

          test('false if all provided functions return false', () {
            var flags = [false, false, false];
            var callbacks = [
              (event, key) {
                flags[0] = true;
                return false;
              },
              (event, key) {
                flags[1] = true;
                return false;
              },
              (event, key) {
                flags[2] = true;
                return false;
              }
            ];

            var chainedCallback = createChainedTargetKeyCallbackFromList(callbacks);
            var result = chainedCallback(null, null);

            expect(flags[0], isTrue);
            expect(flags[1], isTrue);
            expect(flags[2], isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            var flags = [false, false, false];
            var callbacks = [
              (event, key) => flags[0] = true,
              (event, key) => flags[1] = true,
              (event, key) => flags[2] = true
            ];

            var chainedCallback = createChainedTargetKeyCallbackFromList(callbacks);
            var result = chainedCallback(null, null);

            expect(flags[0], isTrue);
            expect(flags[1], isTrue);
            expect(flags[2], isTrue);

            expect(result, isNull);
          });
        });

        test('should gracefully handle provided functions being null', () {
          var callbacks = [
            null,
            null,
            null
          ];

          var chainedCallback = createChainedTargetKeyCallbackFromList(callbacks);
          var result = chainedCallback(null, null);

          expect(result, isNull);
        });
      });

      group('createChainedIndexCallback', () {
        test('should return an IndexCallback that calls the two provided functions', () {
          bool calledA = false,
              calledB = false;
          IndexCallback a = (event, index) => calledA = true;
          IndexCallback b = (event, index) => calledB = true;

          var chainedCallback = createChainedIndexCallback(a, b);
          var result = chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);

          expect(result, isNull);
        });

        test('should return an IndexCallback that calls the two provided functions in order', () {
          int counter = 1;
          bool calledA = false,
            calledB = false;
          IndexCallback a = (event, index) {
            calledA = true;
            zonedExpect(counter, equals(1));
            counter++;
          };
          IndexCallback b = (event, index) {
            calledB = true;
            zonedExpect(counter, equals(2));
          };

          var chainedCallback = createChainedIndexCallback(a, b);
          chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);
        });

        group('should return an IndexCallback that calls the two provided functions and returns', () {
          test('false if the first provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            IndexCallback a = (event, index) {
              calledA = true;
              return false;
            };
            IndexCallback b = (event, index) => calledB = true;

            var chainedCallback = createChainedIndexCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            bool calledA = false, calledB = false;
            IndexCallback a = (event, index) => calledA = true;
            IndexCallback b = (event, index) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedIndexCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if both provided functions return false', () {
            bool calledA = false, calledB = false;
            IndexCallback a = (event, index) {
              calledA = true;
              return false;
            };
            IndexCallback b = (event, index) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedIndexCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            bool calledA = false, calledB = false;
            IndexCallback a = (event, index) {
              calledA = true;
              return true;
            };
            IndexCallback b = (event, index) {
              calledB = true;
              return;
            };

            var chainedCallback = createChainedIndexCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isNull);
          });

          test('should gracefully handle one provided function being null', () {
            bool calledA = false;
            IndexCallback a = (event, index) => calledA = true;

            var chainedCallback = createChainedIndexCallback(a, null);
            chainedCallback(null, null);

            expect(calledA, isTrue);
          });

          test('should gracefully handle both provided functions being null', () {
            var chainedCallback = createChainedIndexCallback(null, null);
            var result = chainedCallback(null, null);

            expect(result, isNull);
          });
        });
      });

      group('createFocusDidChangeCallback', () {
        test('should return a FocusDidChangeCallback that calls the two provided functions', () {
          bool calledA = false, calledB = false;
          FocusDidChangeCallback a = (current, prev) => calledA = true;
          FocusDidChangeCallback b = (current, prev) => calledB = true;

          var chainedCallback = createChainedFocusDidChangeCallback(a, b);
          var result = chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);

          expect(result, isNull);
        });

        test('should return a FocusDidChangeCallback that calls the two provided functions in order', () {
          int counter = 1;
          bool calledA = false, calledB = false;
          FocusDidChangeCallback a = (current, prev) {
            calledA = true;
            zonedExpect(counter, equals(1));
            counter++;
          };
          FocusDidChangeCallback b = (current, prev) {
            calledB = true;
            zonedExpect(counter, equals(2));
          };

          var chainedCallback = createChainedFocusDidChangeCallback(a, b);
          chainedCallback(null, null);

          expect(calledA, isTrue);
          expect(calledB, isTrue);
        });

        group('should return a FocusDidChangeCallback that calls the two provided functions and returns', () {
          test('false if the first provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            FocusDidChangeCallback a = (current, prev) {
              calledA = true;
              return false;
            };
            FocusDidChangeCallback b = (current, prev) => calledB = true;

            var chainedCallback = createChainedFocusDidChangeCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            FocusDidChangeCallback a = (current, prev) => calledA = true;
            FocusDidChangeCallback b = (current, prev) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedFocusDidChangeCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if both provided functions return false', () {
            bool calledA = false,
              calledB = false;
            FocusDidChangeCallback a = (current, prev) {
              calledA = true;
              return false;
            };
            FocusDidChangeCallback b = (current, prev) {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedFocusDidChangeCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            bool calledA = false,
              calledB = false;
            FocusDidChangeCallback a = (current, prev) {
              calledA = true;
              return true;
            };
            FocusDidChangeCallback b = (current, prev) {
              calledB = true;
              return;
            };

            var chainedCallback = createChainedFocusDidChangeCallback(a, b);
            var result = chainedCallback(null, null);

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isNull);
          });
        });

        test('should gracefully handle one provided function being null', () {
          bool calledA = false;
          FocusDidChangeCallback a = (current, prev) => calledA = true;

          var chainedCallback = createChainedFocusDidChangeCallback(a, null);
          chainedCallback(null, null);

          expect(calledA, isTrue);
        });

        test('should gracefully handle both provided functions being null', () {
          var chainedCallback = createChainedFocusDidChangeCallback(null, null);
          var result = chainedCallback(null, null);

          expect(result, isNull);
        });
      });

      group('createChainedCallback', () {
        test('should return a Callback that calls the two provided functions', () {
          bool calledA = false, calledB = false;
          Callback a = () => calledA = true;
          Callback b = () => calledB = true;

          var chainedCallback = createChainedCallback(a, b);
          var result = chainedCallback();

          expect(calledA, isTrue);
          expect(calledB, isTrue);

          expect(result, isNull);
        });

        test('should return a Callback that calls the two provided functions in order', () {
          int counter = 1;
          bool calledA = false, calledB = false;
          Callback a = () {
            calledA = true;
            zonedExpect(counter, equals(1));
            counter++;
          };
          Callback b = () {
            calledB = true;
            zonedExpect(counter, equals(2));
          };

          var chainedCallback = createChainedCallback(a, b);
          chainedCallback();

          expect(calledA, isTrue);
          expect(calledB, isTrue);
        });

        group('should return a Callback that calls the two provided functions and returns', () {
          test('false if the first provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            Callback a = () {
              calledA = true;
              return false;
            };
            Callback b = () => calledB = true;

            var chainedCallback = createChainedCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if the second provided functions returns false', () {
            bool calledA = false,
              calledB = false;
            Callback a = () => calledA = true;
            Callback b = () {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('false if both provided functions return false', () {
            bool calledA = false,
              calledB = false;
            Callback a = () {
              calledA = true;
              return false;
            };
            Callback b = () {
              calledB = true;
              return false;
            };

            var chainedCallback = createChainedCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isFalse);
          });

          test('null if no provided function returns false', () {
            bool calledA = false,
              calledB = false;
            Callback a = () {
              calledA = true;
              return true;
            };
            Callback b = () {
              calledB = true;
              return;
            };

            var chainedCallback = createChainedCallback(a, b);
            var result = chainedCallback();

            expect(calledA, isTrue);
            expect(calledB, isTrue);

            expect(result, isNull);
          });
        });

        test('should gracefully handle one provided function being null', () {
          bool calledA = false;
          Callback a = () => calledA = true;

          var chainedCallback = createChainedCallback(a, null);
          chainedCallback();

          expect(calledA, isTrue);
        });

        test('should gracefully handle both provided functions being null', () {
          var chainedCallback = createChainedCallback(null, null);
          var result = chainedCallback();

          expect(result, isNull);
        });
      });
    });
  });
}
