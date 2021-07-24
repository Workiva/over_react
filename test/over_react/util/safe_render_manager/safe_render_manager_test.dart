// Copyright 2020 Workiva Inc.
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

// ignore_for_file: deprecated_member_use
@TestOn('browser')
library safe_render_manager_test;

import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/safe_render_manager/safe_render_manager.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:w_common/disposable.dart';

import 'test_component.dart';

/// Main entry point for SafeRenderManager testing
main() {
  setClientConfiguration();
  enableTestMode();

  group('SafeRenderManager', () {
    late Element mountNode;
    SafeRenderManager? renderManager;

    setUp(() {
      mountNode = DivElement();
      renderManager = SafeRenderManager(mountNode: mountNode);
    });

    tearDown(() async {
      await renderManager?.dispose();
      mountNode.remove();
    });

    group('render()', () {
      test('renders a component into the specified `mountNode`', () {
        renderManager!.render(Dom.div()('foo'));
        expect(mountNode.text, 'foo');
      });

      test('rerenders a component into the specified `mountNode`', () {
        renderManager!.render(Dom.div()('foo'));
        renderManager!.render(Dom.div()('bar'));

        expect(mountNode.text, 'bar');
      });

      group('renders a component and exposes a ref to it via `contentRef`', () {
        test('when there is no existing ref', () {
          renderManager!.render(Wrapper()());

          expect(renderManager!.contentRef, isNotNull);
          expect(renderManager!.contentRef, isA<WrapperComponent>());
        });

        test('by chaining any existing callback ref', () {
          WrapperComponent? existingWrapperRef;

          renderManager!.render((Wrapper()..ref = ((ref) => existingWrapperRef = ref as WrapperComponent))());

          expect(renderManager!.contentRef, isNotNull);
          expect(existingWrapperRef, same(renderManager!.contentRef));
        });
      });
    });

    group('tryUnmount()', () {
      group('unmounts the rendered component', () {
        setUp(() {
          renderManager!.render(Wrapper()());
          expect(mountNode.children, isNotEmpty);
        });

        test('', () {
          renderManager!.tryUnmount();
          expect(mountNode.children, isEmpty);
        });

        test('and calls the provided callback when complete', () async {
          renderManager!.render(Wrapper()());

          expect(mountNode.children, isNotEmpty);

          final onUnmountCompleter = Completer();

          renderManager!.tryUnmount(onMaybeUnmounted: bind1Guarded((isUnmounted) {
            expect(mountNode.children, isEmpty);
            expect(isUnmounted, isTrue);

            onUnmountCompleter.complete();
          }));

          await onUnmountCompleter.future;
        });
      });

      test('invokes the provided callback immediately when nothing has been rendered', () {
        expect(mountNode.children, isEmpty, reason: 'test setup sanity check');

        bool onUnmountCalledSynchronously = false;

        renderManager!.tryUnmount(onMaybeUnmounted: bind1Guarded((isUnmounted) {
          expect(isUnmounted, isTrue);
          onUnmountCalledSynchronously = true;
        }));

        expect(onUnmountCalledSynchronously, isTrue);
      });
    });

    group('automatically attaches and detaches the mount node', () {
      setUp(() async {
        // Clean up the manager from the above setUp block.
        await renderManager?.dispose();
        renderManager = null;
      });

      test('when autoAttachMountNode is true', () {
        renderManager = SafeRenderManager(autoAttachMountNode: true);
        expect(document.contains(renderManager!.mountNode), isFalse, reason: 'test setup check');

        renderManager!.render(Dom.div()());
        expect(renderManager!.mountNode.parent, document.body);

        renderManager!.tryUnmount();
        expect(renderManager!.mountNode.parent, isNull);
      });

      test('unless autoAttachMountNode is false', () {
        renderManager = SafeRenderManager(autoAttachMountNode: false);
        expect(renderManager!.mountNode.parent, isNull, reason: 'test setup check');

        renderManager!.render(Dom.div()());
        expect(renderManager!.mountNode.parent, isNull);

        // Attach the node manually
        document.body!.append(renderManager!.mountNode);
        addTearDown(renderManager!.mountNode.remove);

        renderManager!.tryUnmount();
        expect(renderManager!.mountNode.parent, document.body, reason: 'should not have removed the mount node');
      });
    });

    group('throws when the object is interacted with after disposal:', () {
      final throwsObjectDisposedException = throwsA(isA<ObjectDisposedException>());

      setUp(() async {
        await renderManager!.dispose();
      });

      test('render', () {
        expect(() => renderManager!.render(Dom.div()()), throwsObjectDisposedException);
      });

      test('tryUnmount', () {
        expect(() => renderManager!.tryUnmount(), throwsObjectDisposedException);
      });
    });

    group('gracefully handles uncaught component lifecycle errors', () {
      void sharedTests() {
        group('recovers,', () {
          test('and can dispose properly', () async {
            // Should not throw
            await renderManager!.dispose();
          });

          test('and can render content again and then dispose properly', () async {
            renderManager!.render(Dom.div()('second render'));
            expect(renderManager!.mountNode.text, 'second render');

            // Should not throw
            await renderManager!.dispose();
            expect(renderManager!.mountNode.text, isEmpty);
          });
        });
      }

      group('on initial mount,', () {
        setUp(() {
          try {
            renderManager!.render((Test()
              ..onComponentDidMount = bind0(expectAsync0(() {
                throw TestExceptionThrownFromLifecycle();
              }, id: 'onComponentDidMount'))
            )());
          } on TestExceptionThrownFromLifecycle catch (_) {}
        });

        sharedTests();
      });

      // rerender and unmount are tested below
    });

    group('edge-cases:', () {
      group('rerenders content correctly when when initial and second render happen synchronously and', () {
        LifecycleCallback? onRender;

        setUp(() {
          onRender = null;
        });

        // ---------------------------------------------------------------------
        // Begin unmount sharedTests
        void sharedRerenderTests({required bool isThrowingTest}) {
          group('calls come from', () {
            const render1Text = 'render1';
            const render2Text = 'render2';

            late bool onMaybeUnmountedCalled;

            setUp(() {
              onMaybeUnmountedCalled = false;
            });

            tearDown(() async {
              const additionalRenderText = 'additionalRenderText';
              renderManager!.render(Test()(additionalRenderText));
              expect(mountNode.text, additionalRenderText,
                  reason: 'should be able to render additional content properly afterwards');

              // Should not throw
              await renderManager!.dispose();
              expect(renderManager!.mountNode.text, isEmpty,
                  reason: 'should be able to dispose properly afterwards');
            });

            // ignore: use_function_type_syntax_for_parameters
            Future<Null> sharedTest({required void Function() setUpAndReturnTriggerRender(void doRenders()),
              required bool verifyImmediateRender,
              required bool verifyDeferredRender,
            }) async {
              if (verifyImmediateRender && verifyDeferredRender) {
                throw ArgumentError('verifyImmediateRender and verifyDeferredRender '
                    'are mutually exclusive and cannot both be set to true');
              }

              // Bind guarded so that any failing `expect`s, which result in synchronous errors,
              // are handled by the test zone's error handler and not swallowed
              // by whichever zone they end up being run in
              // (e.g., the root zone in the case of event handlers).
              final doRenders = bind0Guarded(expectAsync0(() {
                renderManager!.render(Test()(render1Text));
                // Catch any errors thrown synchronously by this call, which will
                // happen only when rendering is not deferred...
                try {
                  renderManager!.render((Test()..onRender = onRender)(render2Text));
                } on TestExceptionThrownFromLifecycle catch (_) {
                  // ...but rethrow them if we're not expecting them so they aren't swallowed.
                  if (!isThrowingTest) rethrow;
                }

                if (!isThrowingTest) {
                  if (verifyImmediateRender) {
                    expect(mountNode.text, render2Text, reason: 'should have updated synchronously');
                  }

                  if (verifyDeferredRender) {
                    expect(mountNode.text, isNot(anyOf(render1Text, render2Text)),
                        reason: 'should have updated synchronously');
                  }
                }
              }, id: 'doRenders', reason: 'needs to be called as part of test'));

              final triggerRenders = setUpAndReturnTriggerRender(doRenders);

              await pumpEventQueue();
              expect(onMaybeUnmountedCalled, isFalse,
                  reason: 'test setup: content should still be mounted before doRenders is called');
              expect(mountNode.text, isNot(anyOf(render1Text, render2Text)),
                  reason: 'test setup: content should still be mounted before doRenders is called');

              // Catch any errors thrown synchronously by this call, which will
              // happen only when rendering is deferred...
              try {
                triggerRenders();
              } on TestExceptionThrownFromLifecycle catch (_) {
                // ...but rethrow them if we're not expecting them so they aren't swallowed.
                if (!isThrowingTest) rethrow;
              }

              if (isThrowingTest) {
                expect(mountNode.text, isEmpty, reason: 'test setup check: React should have unmounted throwing component tree');
              } else {
                expect(mountNode.text, render2Text, reason: 'should have updated by now');
              }
            }

            group('the same React tree (rerenders only, not mounting), from a', () {
              test('event handler', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    document.body!.append(renderManager!.mountNode);
                    renderManager!.render((Wrapper()
                      ..onClick = (_) {
                        doRenders();
                      }
                    )('setup render'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager!.contentRef)!.click();
                  },
                );
              });

              test('callback of setState performed within event handler', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    document.body!.append(renderManager!.mountNode);
                    renderManager!.render((Wrapper()
                      ..onClick = (_) {
                        (renderManager!.contentRef as react.Component).setState({}, doRenders);
                      }
                    )('setup render'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager!.contentRef)!.click();
                  },
                );
              });

              test('lifecycle method (pre-commit phase)', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    renderManager!.render((Test()
                      ..onComponentWillUpdate = doRenders
                    )());

                    return () => (renderManager!.contentRef as react.Component).redraw();
                  },
                );
              });

              test('lifecycle method (post-commit phase)', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    renderManager!.render((Test()
                      ..onComponentDidUpdate = doRenders
                    )());

                    return () => (renderManager!.contentRef as react.Component).redraw();
                  },
                );
              });
            });

            group('another React tree, from a', () {
              test('event handler', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: false,
                  setUpAndReturnTriggerRender: (doRenders) {
                    final jacket = mount((Wrapper()
                      ..onClick = (_) {
                        doRenders();
                      }
                    )(), attachedToDocument: true);

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => jacket.getNode().click();
                  },
                );
              });

              test('callback of setState performed within event handler', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    late TestJacket jacket;
                    jacket = mount((Wrapper()
                      ..onClick = (_) {
                        jacket.getDartInstance().setState({}, doRenders);
                      }
                    )(), attachedToDocument: true);

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => jacket.getNode().click();
                  },
                );
              });

              test('lifecycle method (pre-commit phase)', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    final jacket = mount((Test()
                      ..onComponentWillUpdate = doRenders
                    )());

                    return () => jacket.getDartInstance().redraw();
                  },
                );
              });

              test('lifecycle method (post-commit phase)', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    final jacket = mount((Test()
                      ..onComponentDidUpdate = doRenders
                    )());

                    return () => jacket.getDartInstance().redraw();
                  },
                );
              });
            });
          });
        }
        // End rerender sharedTests
        // ---------------------------------------------------------------------

        group('second render occurs normally and', () {
          sharedRerenderTests(isThrowingTest: false);
        });

        group('second render throws and', () {
          setUp(() {
            onRender = bind0(expectAsync0(() {
              throw TestExceptionThrownFromLifecycle();
            }, id: 'onRender', max: 2)); // `max: 2` since React will call this more than once for some reason.
          });

          sharedRerenderTests(isThrowingTest: true);
        });
      });

      group('unmounts content safely when', () {
        LifecycleCallback? onComponentWillUnmount;

        setUp(() {
          onComponentWillUnmount = null;
        });

        tearDown(() async {
          const additionalRenderText = 'additionalRenderText';
          renderManager!.render(Test()(additionalRenderText));
          expect(mountNode.text, additionalRenderText,
              reason: 'should be able to render additional content properly afterwards');

          // Should not throw
          await renderManager!.dispose();
          expect(renderManager!.mountNode.text, isEmpty,
              reason: 'should be able to dispose properly afterwards');
        });

        // ---------------------------------------------------------------------
        // Begin unmount sharedTests
        void sharedUnmountTests({required bool isThrowingTest}) {
          group('unmount calls come from', () {
            late bool onMaybeUnmountedCalled;

            setUp(() {
              onMaybeUnmountedCalled = false;
            });

            // ignore: use_function_type_syntax_for_parameters
            Future<Null> sharedTest({required void Function() setUpAndReturnUnmounter(void doUnmount()),
              required bool verifyImmediateUnmount,
              required bool verifyDeferredUnmount,
            }) async {
              if (verifyImmediateUnmount && verifyDeferredUnmount) {
                throw ArgumentError('verifyImmediateUnmount and verifyDeferredUnmount '
                    'are mutually exclusive and cannot both be set to true');
              }

              void _doUnmount() {
                expect(mountNode.text, '1', reason: 'test setup check; should not have unmounted yet');

                renderManager!.tryUnmount(onMaybeUnmounted: bind1Guarded(expectAsync1((isUnmounted) {
                  onMaybeUnmountedCalled = true;
                  expect(isUnmounted, isTrue, reason: 'should have unmounted');
                }, id: 'onMaybeUnmounted', reason: 'should always be called on unmount')));

                if (verifyDeferredUnmount) {
                  expect(onMaybeUnmountedCalled, isFalse, reason: 'should not have unmounted yet');
                  expect(mountNode.text, '1', reason: 'should not have unmounted yet');
                }
                if (verifyImmediateUnmount) {
                  expect(onMaybeUnmountedCalled, isTrue, reason: 'should have unmounted by now');
                  expect(mountNode.text, '', reason: 'should have unmounted by now');
                }
              }
              // Bind guarded so that any failing `expect`s, which result in synchronous errors,
              // are handled by the test zone's error handler and not swallowed
              // by whichever zone they end up being run in
              // (e.g., the root zone in the case of event handlers).
              final doUnmount = bind0Guarded(expectAsync0(_doUnmount,
                  id: 'doUnmount', reason: 'must to be called as part of test'));

              final triggerUnmount = setUpAndReturnUnmounter(doUnmount);

              await pumpEventQueue();
              expect(onMaybeUnmountedCalled, isFalse,
                  reason: 'test setup: content should still be mounted before doUnmount is called');
              expect(mountNode.text, '1',
                  reason: 'test setup: content should still be mounted before doUnmount is called');

              // Catch any errors thrown synchronously by this call, which will
              // happen in some cases where mounting is synchronous...
              try {
                triggerUnmount();
              } on TestExceptionThrownFromLifecycle catch (_) {
                // ..but rethrow them if we're not expecting them so they aren't swallowed.
                if (!isThrowingTest) rethrow;
              }

              expect(onMaybeUnmountedCalled, isTrue,
                  reason: 'should have unmounted by now');
              expect(mountNode.text, '', reason: 'should have unmounted by now');
            }

            group('the same React tree, from a', () {
              test('event handler', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    document.body!.append(renderManager!.mountNode);
                    renderManager!.render((Test()
                      ..onClick = (_) {
                        callUnmount();
                      }
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager!.contentRef)!.click();
                  },
                );
              });

              test('callback of setState performed within event handler', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    document.body!.append(renderManager!.mountNode);
                    renderManager!.render((Test()
                      ..onClick = (_) {
                        (renderManager!.contentRef as react.Component).setState({}, callUnmount);
                      }
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager!.contentRef)!.click();
                  },
                );
              });

              test('lifecycle method (pre-commit phase)', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    renderManager!.render((Test()
                      ..onComponentWillUpdate = callUnmount
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    return () => (renderManager!.contentRef as react.Component).redraw();
                  },
                );
              });

              test('lifecycle method (post-commit phase)', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    renderManager!.render((Test()
                      ..onComponentDidUpdate = callUnmount
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    return () => (renderManager!.contentRef as react.Component).redraw();
                  },
                );
              });
            });

            group('another React tree, from a', () {
              setUp(() {
                renderManager!.render((Test()
                  ..onComponentWillUnmount = onComponentWillUnmount
                )('1'));
                expect(mountNode.text, '1', reason: 'test setup check');
              });

              test('event handler', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    final jacket = mount((Test()
                      ..onClick = (_) {
                        callUnmount();
                      }
                    )(), attachedToDocument: true);

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => jacket.getNode().click();
                  },
                );
              });

              test('callback of setState performed within event handler', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    late TestJacket jacket;
                    jacket = mount((Test()
                      ..onClick = (_) {
                        jacket.getDartInstance().setState({}, callUnmount);
                      }
                    )(), attachedToDocument: true);

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => jacket.getNode().click();
                  },
                );
              });

              test('lifecycle method (pre-commit phase)', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    final jacket = mount((Test()
                      ..onComponentWillUpdate = callUnmount
                    )());

                    return () => jacket.getDartInstance().redraw();
                  },
                );
              });

              test('lifecycle method (post-commit phase)', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    final jacket = mount((Test()
                      ..onComponentDidUpdate = callUnmount
                    )());

                    return () => jacket.getDartInstance().redraw();
                  },
                );
              });
            });
          });
        }
        // End unmount sharedTests
        // ---------------------------------------------------------------------

        group('unmounting occurs normally and', () {
          sharedUnmountTests(isThrowingTest: false);
        });

        group('unmounting throws and', () {
          setUp(() {
            onComponentWillUnmount = bind0(expectAsync0(() {
              throw TestExceptionThrownFromLifecycle();
            }, id: 'onComponentWillUnmount'));
          });

          sharedUnmountTests(isThrowingTest: true);
        });
      });
    });
  }, timeout: const Timeout(Duration(seconds: 1)));
}

/// Shorthand for [Zone.bindCallback] on the current zone.
ZoneCallback<R> bind0<R>(ZoneCallback<R> callback) =>
    Zone.current.bindCallback(callback);

/// Shorthand for [Zone.bindUnaryCallback] on the current zone.
ZoneUnaryCallback<R, T> bind1<R, T>(ZoneUnaryCallback<R, T> callback) =>
    Zone.current.bindUnaryCallback(callback);

/// Shorthand for [Zone.bindCallbackGuarded] on the current zone.
ZoneCallback<void> bind0Guarded(ZoneCallback<void> callback) =>
    Zone.current.bindCallbackGuarded(callback);

/// Shorthand for [Zone.bindUnaryCallbackGuarded] on the current zone.
ZoneUnaryCallback<void, T> bind1Guarded<T>(ZoneUnaryCallback<void, T> callback) =>
    Zone.current.bindUnaryCallbackGuarded(callback);

/// An exception used for testing, which we can tell apart from
/// other arbitrary exceptions via type-checking.
class TestExceptionThrownFromLifecycle implements Exception {}
