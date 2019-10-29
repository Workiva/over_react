@TestOn('browser')
library top_level_render_manager_test;

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:react/react.dart' as react;
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/safe_render_manager/safe_render_manager.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:w_common/disposable.dart';

import 'test_component.dart';

/// Main entry point for TopLevelRenderManager testing
main() {
  setClientConfiguration();
  enableTestMode();

  group('SafeRenderManager', () {
    Element mountNode;
    SafeRenderManager renderManager;

    setUp(() {
      mountNode = new DivElement();
      renderManager = new SafeRenderManager(mountNode: mountNode);
    });

    tearDown(() async {
      await renderManager?.dispose();
      mountNode.remove();
    });

    group('render()', () {
      test('renders a component into the specified `mountNode`', () {
        renderManager.render(Dom.div()('foo'));
        expect(mountNode.text, 'foo');
      });

      test('rerenders a component into the specified `mountNode`', () {
        renderManager.render(Dom.div()('foo'));
        renderManager.render(Dom.div()('bar'));

        expect(mountNode.text, 'bar');
      });

      group('renders a component and exposes a ref to it via `contentRef`', () {
        test('when there is no existing ref', () {
          renderManager.render(Wrapper()());

          expect(renderManager.contentRef, isNotNull);
          expect(renderManager.contentRef, const isInstanceOf<WrapperComponent>());
        });

        test('by chaining any existing callback ref', () {
          WrapperComponent existingWrapperRef;

          renderManager.render((Wrapper()..ref = ((ref) => existingWrapperRef = ref))());

          expect(renderManager.contentRef, isNotNull);
          expect(existingWrapperRef, same(renderManager.contentRef));
        });
      });
    });

    group('tryUnmount()', () {
      group('unmounts the rendered component', () {
        setUp(() {
          renderManager.render(Wrapper()());
          expect(mountNode.children, isNotEmpty);
        });

        test('', () async {
          renderManager.tryUnmount();
          expect(mountNode.children, isEmpty);
        });

        test('and calls the provided callback when complete', () async {
          renderManager.render(Wrapper()());

          expect(mountNode.children, isNotEmpty);

          final onUnmountCompleter = new Completer();

          renderManager.tryUnmount(onMaybeUnmounted: bind1Guarded((isUnmounted) {
            expect(mountNode.children, isEmpty);
            expect(isUnmounted, isTrue);

            onUnmountCompleter.complete();
          }));

          await onUnmountCompleter.future;
        });
      });

      test('invokes the provided callback immediately when nothing has been rendered', () async {
        expect(mountNode.children, isEmpty, reason: 'test setup sanity check');

        bool onUnmountCalledSynchronously = false;

        renderManager.tryUnmount(onMaybeUnmounted: bind1Guarded((isUnmounted) {
          expect(isUnmounted, isTrue);
          onUnmountCalledSynchronously = true;
        }));

        expect(onUnmountCalledSynchronously, isTrue);
      });
    });

    group('automatically attaches and detached the mount node', () {
      setUp(() async {
        // Clean up the manager from the above setUp block.
        await renderManager?.dispose();
        renderManager = null;
      });

      test('when autoAttachMountNode is true', () {
        renderManager = new SafeRenderManager(autoAttachMountNode: true);
        expect(document.contains(renderManager.mountNode), isFalse, reason: 'test setup check');

        renderManager.render(Dom.div()());
        expect(renderManager.mountNode.parent, document.body);

        renderManager.tryUnmount();
        expect(renderManager.mountNode.parent, isNull);
      });

      test('unless autoAttachMountNode is false', () {
        renderManager = new SafeRenderManager(autoAttachMountNode: false);
        expect(renderManager.mountNode.parent, isNull, reason: 'test setup check');

        renderManager.render(Dom.div()());
        expect(renderManager.mountNode.parent, isNull);

        // Attach the node manually
        document.body.append(renderManager.mountNode);
        addTearDown(renderManager.mountNode.remove);

        renderManager.tryUnmount();
        expect(renderManager.mountNode.parent, document.body, reason: 'should not have removed the mount node');
      });
    });

    group('throws when the object is interacted with after disposal:', () {
      final throwsObjectDisposedException = throwsA(const isInstanceOf<ObjectDisposedException>());

      setUp(() async {
        await renderManager.dispose();
      });

      test('render', () {
        expect(() => renderManager.render(Dom.div()()), throwsObjectDisposedException);
      });

      test('tryUnmount', () {
        expect(() => renderManager.tryUnmount(), throwsObjectDisposedException);
      });
    });

    group('gracefully handles uncaught component lifecycle errors', () {
      void sharedTests() {
        group('recovers,', () {
          test('and can dispose properly', () async {
            // Should not throw
            await renderManager.dispose();
          });

          test('and can render content again and then dispose properly', () async {
            renderManager.render(Dom.div()('second render'));
            expect(renderManager.mountNode.text, 'second render');

            // Should not throw
            await renderManager.dispose();
            expect(renderManager.mountNode.text, isEmpty);
          });
        });
      }

      group('on initial mount,', () {
        setUp(() {
          try {
            renderManager.render((Test()
              ..onComponentDidMount = bind0(expectAsyncCompat0(() {
                throw new TestExceptionThrownFromLifecycle();
              }, id: 'onComponentDidMount'))
            )());
          } on TestExceptionThrownFromLifecycle catch (_) {} catch (e) {
            // Handle the error being JSified in Dartium, preventing us from using `on`.
            if (!e.toString().contains(TestExceptionThrownFromLifecycle.typeName)) {
              rethrow;
            }
          }
        });

        sharedTests();
      });

      // rerender and unmount are tested below
    });

    group('edge-cases:', () {
      group('rerenders content correctly when when initial and second render happen synchronously and', () {
        LifecycleCallback onRender;

        setUp(() {
          onRender = null;
        });

        // ---------------------------------------------------------------------
        // Begin unmount sharedTests
        void sharedRerenderTests({@required bool isThrowingTest}) {
          group('calls come from', () {
            const render1Text = 'render1';
            const render2Text = 'render2';

            bool onMaybeUnmountedCalled;

            setUp(() {
              onMaybeUnmountedCalled = false;
            });

            tearDown(() async {
              const additionalRenderText = 'additionalRenderText';
              renderManager.render(Test()(additionalRenderText));
              expect(mountNode.text, additionalRenderText,
                  reason: 'should be able to render additional content properly afterwards');

              // Should not throw
              await renderManager.dispose();
              expect(renderManager.mountNode.text, isEmpty,
                  reason: 'should be able to dispose properly afterwards');
            });

            Future<Null> sharedTest({@required Func0 setUpAndReturnTriggerRender(void doRenders()),
              @required bool verifyImmediateRender,
              @required bool verifyDeferredRender,
            }) async {
              if (verifyImmediateRender && verifyDeferredRender) {
                throw new ArgumentError('verifyImmediateRender and verifyDeferredRender '
                    'are mutually exclusive and cannot both be set to true');
              }

              // Bind guarded so that any failing `expect`s, which result in synchronous errors,
              // are handled by the test zone's error handler and not swallowed
              // by whichever zone they end up being run in
              // (e.g., the root zone in the case of event handlers).
              final doRenders = bind0Guarded(expectAsyncCompat0(() {
                renderManager.render(Test()(render1Text));
                // Catch any errors thrown synchronously by this call, which will
                // happen only when rendering is not deferred...
                try {
                  renderManager.render((Test()..onRender = onRender)(render2Text));
                } on TestExceptionThrownFromLifecycle catch (_) {
                  // ...but rethrow them if we're not expecting them so they aren't swallowed.
                  if (!isThrowingTest) rethrow;
                } catch (e) {
                  // Handle the error being JSified in Dartium, preventing us from using `on`.
                  if (!e.toString().contains(TestExceptionThrownFromLifecycle.typeName)) {
                    rethrow;
                  }

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
              } catch (e) {
                // Handle the error being JSified in Dartium, preventing us from using `on`.
                if (!e.toString().contains(TestExceptionThrownFromLifecycle.typeName)) {
                  rethrow;
                }

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
                    document.body.append(renderManager.mountNode);
                    renderManager.render((Wrapper()
                      ..onClick = (_) {
                        doRenders();
                      }
                    )('setup render'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager.contentRef).click();
                  },
                );
              });

              test('callback of setState performed within event handler', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    document.body.append(renderManager.mountNode);
                    renderManager.render((Wrapper()
                      ..onClick = (_) {
                        (renderManager.contentRef as react.Component).setState({}, doRenders);
                      }
                    )('setup render'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager.contentRef).click();
                  },
                );
              });

              test('lifecycle method (pre-commit phase)', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    renderManager.render((Test()
                      ..onComponentWillUpdate = doRenders
                    )());

                    return () => (renderManager.contentRef as react.Component).redraw();
                  },
                );
              });

              test('lifecycle method (post-commit phase)', () async {
                await sharedTest(
                  verifyImmediateRender: false,
                  verifyDeferredRender: true,
                  setUpAndReturnTriggerRender: (doRenders) {
                    renderManager.render((Test()
                      ..onComponentDidUpdate = doRenders
                    )());

                    return () => (renderManager.contentRef as react.Component).redraw();
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
                    TestJacket jacket;
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
            onRender = bind0(expectAsyncCompat0(() {
              throw new TestExceptionThrownFromLifecycle();
            }, id: 'onRender', max: 2)); // `max: 2` since React will call this more than once for some reason.
          });

          sharedRerenderTests(isThrowingTest: true);
        });
      });

      group('unmounts content safely when', () {
        LifecycleCallback onComponentWillUnmount;

        setUp(() {
          onComponentWillUnmount = null;
        });

        tearDown(() async {
          const additionalRenderText = 'additionalRenderText';
          renderManager.render(Test()(additionalRenderText));
          expect(mountNode.text, additionalRenderText,
              reason: 'should be able to render additional content properly afterwards');

          // Should not throw
          await renderManager.dispose();
          expect(renderManager.mountNode.text, isEmpty,
              reason: 'should be able to dispose properly afterwards');
        });

        // ---------------------------------------------------------------------
        // Begin unmount sharedTests
        void sharedUnmountTests({@required bool isThrowingTest}) {
          group('unmount calls come from', () {
            bool onMaybeUnmountedCalled;

            setUp(() {
              onMaybeUnmountedCalled = false;
            });

            Future<Null> sharedTest({@required Func0 setUpAndReturnUnmounter(void doUnmount()),
              @required bool verifyImmediateUnmount,
              @required bool verifyDeferredUnmount,
            }) async {
              if (verifyImmediateUnmount && verifyDeferredUnmount) {
                throw new ArgumentError('verifyImmediateUnmount and verifyDeferredUnmount '
                    'are mutually exclusive and cannot both be set to true');
              }

              _doUnmount() {
                expect(mountNode.text, '1', reason: 'test setup check; should not have unmounted yet');

                renderManager.tryUnmount(onMaybeUnmounted: bind1Guarded(expectAsyncCompat1((isUnmounted) {
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
              final doUnmount = bind0Guarded(expectAsyncCompat0(_doUnmount,
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
              } catch (e) {
                // Handle the error being JSified in Dartium, preventing us from using `on`.
                if (!e.toString().contains(TestExceptionThrownFromLifecycle.typeName)) {
                  rethrow;
                }

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
                    document.body.append(renderManager.mountNode);
                    renderManager.render((Test()
                      ..onClick = (_) {
                        callUnmount();
                      }
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager.contentRef).click();
                  },
                );
              });

              test('callback of setState performed within event handler', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    document.body.append(renderManager.mountNode);
                    renderManager.render((Test()
                      ..onClick = (_) {
                        (renderManager.contentRef as react.Component).setState({}, callUnmount);
                      }
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    // Use a real click since simulated clicks don't trigger this async behavior
                    return () => findDomNode(renderManager.contentRef).click();
                  },
                );
              });

              test('lifecycle method (pre-commit phase)', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    renderManager.render((Test()
                      ..onComponentWillUpdate = callUnmount
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    return () => (renderManager.contentRef as react.Component).redraw();
                  },
                );
              });

              test('lifecycle method (post-commit phase)', () async {
                await sharedTest(
                  verifyImmediateUnmount: false,
                  verifyDeferredUnmount: true,
                  setUpAndReturnUnmounter: (callUnmount) {
                    renderManager.render((Test()
                      ..onComponentDidUpdate = callUnmount
                      ..onComponentWillUnmount = onComponentWillUnmount
                    )('1'));

                    return () => (renderManager.contentRef as react.Component).redraw();
                  },
                );
              });
            });

            group('another React tree, from a', () {
              setUp(() {
                renderManager.render((Test()
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
                    TestJacket jacket;
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
            onComponentWillUnmount = bind0(expectAsyncCompat0(() {
              throw new TestExceptionThrownFromLifecycle();
            }, id: 'onComponentWillUnmount'));
          });

          sharedUnmountTests(isThrowingTest: true);
        });
      });
    });
  }, timeout: const Timeout(const Duration(seconds: 1)));
}

/// Shorthand for [Zone.bindCallback] on the current zone.
ZoneCallback<R> bind0<R>(ZoneCallback<R> callback) =>
    Zone.current.bindCallback(callback, runGuarded: false);

/// Shorthand for [Zone.bindUnaryCallback] on the current zone.
ZoneUnaryCallback<R, T> bind1<R, T>(ZoneUnaryCallback<R, T> callback) =>
    Zone.current.bindUnaryCallback(callback, runGuarded: false);

/// Shorthand for [Zone.bindCallbackGuarded] on the current zone.
ZoneCallback<Null> bind0Guarded(ZoneCallback<Null> callback) =>
    Zone.current.bindCallback(callback, runGuarded: true);

/// Shorthand for [Zone.bindUnaryCallbackGuarded] on the current zone.
ZoneUnaryCallback<Null, T> bind1Guarded<T>(ZoneUnaryCallback<Null, T> callback) =>
    Zone.current.bindUnaryCallback(callback, runGuarded: true);

/// An exception used for testing, which we can tell apart from
/// other arbitrary exceptions via type-checking.
class TestExceptionThrownFromLifecycle implements Exception {
  static String get typeName => (TestExceptionThrownFromLifecycle).toString();
}

typedef void VoidFunc0();

/// A version of [expectAsync0] that behaves more like the version in the latest,
/// Dart-2-only version of the test package.
///
/// Notably, any synchronous errors thrown by [callback] are propagated normally
/// instead of being treated as uncaught errors in the test zone.
Func0<T> expectAsyncCompat0<T>(T callback(),
    {int count: 1, int max: 0, String id, String reason}) {
  // Set up a real expectation but don't run callback inside it so that any errors
  // thrown aren't handled by expectAsync's error handlers.
  final expectedDummy = expectAsync0(() {}, count: count, max: max, id: id, reason: reason);
  return () {
    expectedDummy();
    return callback();
  };
}

/// A version of [expectAsync1] that behaves more like the version in the latest,
/// Dart-2-only version of the test package.
///
/// Notably, any synchronous errors thrown by [callback] are propagated normally
/// instead of being treated as uncaught errors in the test zone.
Func1<T, A> expectAsyncCompat1<T, A>(T callback(A a),
    {int count: 1, int max: 0, String id, String reason}) {
  // Set up a real expectation but don't run callback inside it so that any errors
  // thrown aren't handled by expectAsync's error handlers.
  final expectedDummy = expectAsync1((_) {}, count: count, max: max, id: id, reason: reason);
  return ([a]) {
    expectedDummy(a);
    return callback(a);
  };
}
