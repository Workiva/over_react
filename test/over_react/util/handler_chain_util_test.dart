// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library handler_chain_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

/// Main entry point for HandlerChainUtil testing
main() {
  group('HandlerChainUtil', () {
    group('generic chaining:', () {
      Function createTestChainFunction({returnValue, onCall(List args)}) {
        testChainFunction([
            arg1 = unspecified,
            arg2 = unspecified,
            arg3 = unspecified,
            arg4 = unspecified,
            arg5 = unspecified,
            arg6 = unspecified
        ]) {
          if (onCall != null) {
            var args = [arg1, arg2, arg3, arg4, arg5, arg6].takeWhile((item) => item != unspecified).toList();
            onCall(args);
          }

          return returnValue;
        };

        return testChainFunction;
      }

      /// Shared tests for [CallbackUtil] subclasses supporting different arities.
      ///
      /// Expects callback arguments to be typed to [TestGenericType].
      void sharedTests<S extends Function>(CallbackUtil callbackUtil, int arity) {
        List generateArgs() {
          return new List.generate(arity, (_) => new TestGenericType());
        }

        List generateBadTypeArgs() {
          return new List.generate(arity, (_) => new Object());
        }

        group('chain()', () {
          test('returns a when b is null', () {
            var a = createTestChainFunction();
            expect(callbackUtil.chain(a, null), same(a));
          });

          test('returns b when a is null', () {
            var b = createTestChainFunction();
            expect(callbackUtil.chain(null, b), same(b));
          });

          test('returns a noop function of arity $arity when both a and b are null', () {
            var chained = callbackUtil.chain(null, null);

            expect(chained, const TypeMatcher<Function>());
            expect(() => Function.apply(chained, generateArgs()), returnsNormally);
          });

          group('returns a function of arity $arity that', () {
            test('calls both functions in order', () {
              var calls = [];

              var a = createTestChainFunction(onCall: (args) {
                calls.add(['a', args]);
              });
              var b = createTestChainFunction(onCall: (args) {
                calls.add(['b', args]);
              });

              var chained = callbackUtil.chain(a, b);

              var expectedArgs = generateArgs();

              Function.apply(chained, expectedArgs);

              expect(calls, equals([
                ['a', expectedArgs],
                ['b', expectedArgs],
              ]));
            });

            group('returns false when', () {
              test('a returns false', () {
                var a = createTestChainFunction(returnValue: false);
                var b = createTestChainFunction();

                var chained = callbackUtil.chain(a, b);

                expect(Function.apply(chained, generateArgs()), isFalse);
              });

              test('b returns false', () {
                var a = createTestChainFunction();
                var b = createTestChainFunction(returnValue: false);

                var chained = callbackUtil.chain(a, b);

                expect(Function.apply(chained, generateArgs()), isFalse);
              });

              test('a and b both return false', () {
                var a = createTestChainFunction(returnValue: false);
                var b = createTestChainFunction(returnValue: false);

                var chained = callbackUtil.chain(a, b);

                expect(Function.apply(chained, generateArgs()), isFalse);
              });
            });

            group('returns null when', () {
              test('a and b return something other than false', () {
                var a = createTestChainFunction();
                var b = createTestChainFunction();

                var chained = callbackUtil.chain(a, b);

                expect(Function.apply(chained, generateArgs()), isNull);
              });
            });

            if (arity != 0) {
              test('has arguments typed to the specified generic parameters', () {
                var a = createTestChainFunction();
                var b = createTestChainFunction();

                expect(() => Function.apply(a, generateArgs()), returnsNormally,
                    reason: 'need to verify that chaining function throws, so the chained functions cannot throw');
                expect(() => Function.apply(b, generateArgs()), returnsNormally,
                    reason: 'need to verify that chaining function throws, so the chained functions cannot throw');

                var chained = callbackUtil.chain(a, b);

                expect(() => Function.apply(chained, generateBadTypeArgs()), throwsA(const TypeMatcher<TypeError>()));
              }, testOn: 'dart-vm');
            }
          });
        });

        group('chainFromList()', () {
          group('returns a function of arity $arity that', () {
            test('calls all functions in order', () {
              var calls = [];

              var functions = new List<S>.generate(5, (index) {
                return createTestChainFunction(onCall: (args) {
                  calls.add(['function_$index', args]);
                });
              });

              var chained = callbackUtil.chainFromList(functions);

              var expectedArgs = generateArgs();

              Function.apply(chained, expectedArgs);

              expect(calls, equals([
                ['function_0', expectedArgs],
                ['function_1', expectedArgs],
                ['function_2', expectedArgs],
                ['function_3', expectedArgs],
                ['function_4', expectedArgs],
              ]));
            });

            test('returns false when any function returns false', () {
              var functions = new List<S>.generate(5, (_) => createTestChainFunction());
              functions.insert(2, createTestChainFunction(returnValue: false));

              var chained = callbackUtil.chainFromList(functions);

              expect(Function.apply(chained, generateArgs()), isFalse);
            });

            test('returns null when no function returns false', () {
              var functions = new List<S>.generate(5, (_) => createTestChainFunction());

              var chained = callbackUtil.chainFromList(functions);

              expect(Function.apply(chained, generateArgs()), isNull);
            });
          });

          group('gracefully handles', () {
            test('null functions', () {
              var calls = [];

              var functions = new List<S>.generate(5, (index) {
                return createTestChainFunction(onCall: (args) {
                  calls.add(['function_$index', args]);
                });
              });

              functions.insert(5, null);
              functions.insert(2, null);
              functions.insert(0, null);

              var chained = callbackUtil.chainFromList(functions);

              var expectedArgs = generateArgs();

              Function.apply(chained, expectedArgs);

              expect(calls, equals([
                ['function_0', expectedArgs],
                ['function_1', expectedArgs],
                ['function_2', expectedArgs],
                ['function_3', expectedArgs],
                ['function_4', expectedArgs],
              ]));
            });

            test('an empty list of functions', () {
              var chained = callbackUtil.chainFromList(<S>[]);

              expect(chained, const TypeMatcher<Function>());
              expect(() => Function.apply(chained, generateArgs()), returnsNormally);
            });
          });

          if (arity != 0) {
            test('has arguments typed to the specified generic parameters', () {
              var functions = new List<S>.generate(5, (_) => createTestChainFunction());

              functions.forEach((function) {
                expect(() => Function.apply(function, generateArgs()), returnsNormally,
                    reason: 'need to verify that chaining function throws, so the chained functions cannot throw');
              });

              var chained = callbackUtil.chainFromList(functions);

              expect(() => Function.apply(chained, generateBadTypeArgs()), throwsA(const TypeMatcher<TypeError>()));
            }, testOn: 'dart-vm');
          }
        });

        group('noop getter returns a function', () {
          test('with an arity of $arity', () {
            expect(() => Function.apply(callbackUtil.noop, generateArgs()), returnsNormally);
          });

          if (arity != 0) {
            test('with arguments typed to the specified generic parameters', () {
              expect(() => Function.apply(callbackUtil.noop, generateBadTypeArgs()),
                  throwsA(const TypeMatcher<TypeError>()));
            }, testOn: 'dart-vm');
          }
        });
      }

      group('CallbackUtil0Arg', () {
        sharedTests<Callback0Arg>(const CallbackUtil0Arg(), 0);
      });

      group('CallbackUtil1Arg', () {
        sharedTests<Callback1Arg>(const CallbackUtil1Arg<TestGenericType>(), 1);
      });

      group('CallbackUtil2Arg', () {
        sharedTests<Callback2Arg>(const CallbackUtil2Arg<TestGenericType, TestGenericType>(), 2);
      });

      group('CallbackUtil3Arg', () {
        sharedTests<Callback3Arg>(const CallbackUtil3Arg<TestGenericType, TestGenericType, TestGenericType>(), 3);
      });

      group('CallbackUtil4Arg', () {
        sharedTests<Callback4Arg>(const CallbackUtil4Arg<TestGenericType, TestGenericType, TestGenericType, TestGenericType>(), 4);
      });
    });
  });
}

class _Unspecified {
  const _Unspecified();
}
const _Unspecified unspecified = const _Unspecified();

class TestGenericType {}
