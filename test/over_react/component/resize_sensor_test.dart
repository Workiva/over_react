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

@Timeout(const Duration(seconds: 2))
library resize_sensor_test;

import 'dart:async';
import 'dart:html';

import 'package:platform_detect/platform_detect.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:test/test.dart';

void main() {
  group('ResizeSensor', () {
    const int defaultContainerWidth = 100;
    const int defaultContainerHeight = 100;

    Element domTarget;
    ResizeSensorComponent resizeSensorRef;
    Element containerRef;

    setUp(() {
      domTarget = document.createElement('div');
      document.body.append(domTarget);
      // Perform setup needed for using 'zonedExpect'.
      storeZone();
    });

    tearDown(() {
      domTarget.remove();
      resizeSensorRef = null;
      containerRef = null;
    });

    void renderSensorIntoContainer({
        ResizeSensorHandler onInitialize,
        ResizeSensorHandler onResize,
        int width: defaultContainerWidth,
        int height: defaultContainerHeight,
        Map resizeSensorProps
    }) {
      // Create component hierarchy.
      var sensor = (ResizeSensor()
        ..addProps(resizeSensorProps)
        ..onInitialize = onInitialize
        ..onResize = onResize
        ..ref = (ref) { resizeSensorRef = ref; }
      )();
      var container = (Dom.div()
        ..className =  'container'
        ..style = {
          'position': 'absolute',
          'width': width,
          'height': height
        }
        ..ref = (ref) { containerRef = ref; }
      )(sensor);

      // Render into DOM and validate.
      react_dom.render(container, domTarget);
    }

    /// Expect resize sensor invokes registered [onResize] callback.
    ///
    /// Note: Test cases must await calls to this function. A boolean value is
    /// tracked to confirm callback invocation, instead of `expectAsync`, due to
    /// oddities in detecting callback invocations.
    ///
    /// The returned future will complete after [onResize] is called [resizeEventCount] times.
    Future expectResizeAfter(void action(), {
        ResizeSensorHandler onResize,
        ResizeSensorHandler onInitialize,
        int width: defaultContainerWidth,
        int height: defaultContainerHeight,
        Map resizeSensorProps,
        int resizeEventCount: 1
    }) async {
      var resizes = new StreamController();

      var resizesDone = resizes.stream.take(resizeEventCount).drain();

      renderSensorIntoContainer(onResize: (event) {
        if (onResize != null) onResize(event);

        resizes.add(event);
      }, width: width, height: height, onInitialize: onInitialize, resizeSensorProps: resizeSensorProps);

      if (resizeSensorRef.props.quickMount) {
        // Quick-mount ResizeSensors can't detect changes until one animation frame and two scroll events
        // after mounting. Give them some time to settle.
        await window.animationFrame;
        await window.animationFrame;
      }

      action();

      await resizesDone.then((_) { resizes.close(); });
    }

    /// Expect resize sensor invokes registered `onInitialize` callback.
    ///
    /// The caller must await this function. See above.
    Future expectInitialize({ResizeSensorHandler onInitialize, int width: defaultContainerWidth,
        int height: defaultContainerHeight}) async {
      var initializeDetectedCompleter = new Completer();

      renderSensorIntoContainer(onInitialize: (event) {
        if (onInitialize != null) {
          onInitialize(event);
        }
        initializeDetectedCompleter.complete();
      }, width: width, height: height);

      await initializeDetectedCompleter.future;
    }

    group('should render with the correct styles', () {
      test('by default', () {
        var renderedNode = renderAndGetDom(ResizeSensor()());

        expect(renderedNode.style.position, equals('relative'));
        expect(renderedNode.style.width, equals('100%'));
        expect(renderedNode.style.height, equals('100%'));
      });

      test('when isFlexChild is true', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexChild = true)());

        expect(renderedNode.style.position, equals('relative'));
        expect(renderedNode.style.display, equals('block'));
        expect(renderedNode.style.minHeight, '0px');

        var nodeStyleDecl = renderedNode.style;
        if (browser.isInternetExplorer && browser.version.major < 11) {
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-positive'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-negative'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-preferred-size'), '0%');
        } else {
          expect(nodeStyleDecl.getPropertyValue('flex'), '1 1 0%');
        }
      });

      test('when isFlexContainer is true', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexContainer = true)());

        expect(renderedNode.style.position, equals('relative'));
        expect(renderedNode.style.minHeight, '0px');

        var nodeStyleDecl = renderedNode.style;
        if (browser.isInternetExplorer && browser.version.major < 11) {
          expect(renderedNode.style.display, equals('-ms-flexbox'));
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-positive'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-negative'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-preferred-size'), '0%');
        } else {
          expect(renderedNode.style.display, equals('flex'));
          expect(nodeStyleDecl.getPropertyValue('flex'), '1 1 0%');
        }
      });

      test('when overridden by consumer', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..style = {'width':'auto','height':'auto'})());

        expect(renderedNode.style.position, equals('relative'));
        expect(renderedNode.style.width, equals('auto'));
        expect(renderedNode.style.height, equals('auto'));
      });
    });

    // Test that every last ResizeSensor node is hidden with both visibility and opacity,
    // ensuring that scrollbars don't show up in Safari.
    group('should hide all of its descendants when isFlexChild is', () {
      test('true', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexChild = true)());
        var descendants = renderedNode.querySelectorAll('*');

        descendants.forEach((descendant) {
          expect(descendant.style.visibility, equals('hidden'));;
          expect(descendant.style.opacity, equals('0'));;
        });
      });

      test('false', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexChild = false)());
        var descendants = renderedNode.querySelectorAll('*');

        descendants.forEach((descendant) {
          expect(descendant.style.visibility, equals('hidden'));;
          expect(descendant.style.opacity, equals('0'));;
        });
      });
    });

    void sharedResizeDetectTests({bool quickMount}) {
      group('when props.quickMount is $quickMount: detects when the bounding rect', () {
        const testResizeAmounts = const <String, int>{
          'tiny': 1,
          'medium': 10,
          'large': 100,
          'huge': 1000,
          'Hugh-Mungus': 10000,
        };

        ResizeSensorProps props;

        setUp(() {
          props = ResizeSensor()
            ..quickMount = quickMount;
        });

        group('grows horizontally', () {
          testResizeAmounts.forEach((String description, int amount) {
            test('by a $description amount (${amount}px)', () async {
              await expectResizeAfter(() {
                containerRef.style.width = '${defaultContainerWidth + amount}px';
              }, resizeSensorProps: props);
            });
          });

          test('even when the bounding rect is very small', () async {
            await expectResizeAfter(() {
              containerRef.style.width = '4px';
            }, width: 2, height: 2, resizeSensorProps: props);
          });

          test('and shrink is true', () async {
            props.shrink = true;

            await expectResizeAfter(() {
              containerRef.style.width = '${defaultContainerWidth * 2}px';
            }, resizeSensorProps: props);
          });
        });

        group('grows vertically', () {
          testResizeAmounts.forEach((String description, int amount) {
            test('by a $description amount (${amount}px)', () async{
              await expectResizeAfter(() {
                containerRef.style.height = '${defaultContainerHeight + amount}px';
              }, resizeSensorProps: props);
            });
          });

          test('even when the bounding rect is very small', () async {
            await expectResizeAfter(() {
              containerRef.style.height = '4px';
            }, width: 2, height: 2, resizeSensorProps: props);
          });

          test('and shrink is true', () async {
            props.shrink = true;

            await expectResizeAfter(() {
              containerRef.style.height = '${defaultContainerHeight * 2}px';
            }, resizeSensorProps: props);
          });
        });

        group('shrinks horizontally', () {
          testResizeAmounts.forEach((String description, int amount) {
            test('by a $description amount (${amount}px)', () async{
              await expectResizeAfter(() {
                containerRef.style.width = '${defaultContainerWidth}px';
              }, width: defaultContainerWidth + amount, resizeSensorProps: props);
            });
          });

          test('even when the bounding rect is very small', () async {
            await expectResizeAfter(() {
              containerRef.style.width = '1px';
            }, width: 2, height: 2, resizeSensorProps: props);
          });

          test('and shrink is true', () async{
            props.shrink = true;

            await expectResizeAfter(() {
              containerRef.style.width = '${defaultContainerWidth / 2}px';
            }, resizeSensorProps: props);
          });
        });

        group('shrinks vertically', () {
          testResizeAmounts.forEach((String description, int amount) {
            test('by a $description amount (${amount}px)', () async{
              await expectResizeAfter(() {
                containerRef.style.height = '${defaultContainerHeight}px';
              }, height: defaultContainerHeight + amount, resizeSensorProps: props);
            });
          });

          test('even when the bounding rect is very small', () async {
            await expectResizeAfter(() {
              containerRef.style.height = '1px';
            }, width: 2, height: 2, resizeSensorProps: props);
          });

          test('and shrink is true', () async {
            props.shrink = true;

            await expectResizeAfter(() {
              containerRef.style.height = '${defaultContainerHeight / 2}px';
            }, resizeSensorProps: props);
          });
        });
      });
    }

    sharedResizeDetectTests(quickMount: false);
    sharedResizeDetectTests(quickMount: true);

    group('when quickMount is', () {
      group('false:', () {
        test('passes the correct event args on resize', () async {
          await expectResizeAfter(() {
            containerRef.style.width = '${defaultContainerWidth * 2}px';
            containerRef.style.height = '${defaultContainerHeight * 2}px';
          }, onResize: (ResizeSensorEvent event) {
            zonedExpect(event.newWidth, equals(defaultContainerWidth * 2));
            zonedExpect(event.newHeight, equals(defaultContainerHeight * 2));
            zonedExpect(event.prevWidth, equals(defaultContainerWidth));
            zonedExpect(event.prevHeight, equals(defaultContainerHeight));
          });
        });

        group('passes the correct event args on initialize', () {
          setUp(() {
            startRecordingValidationWarnings();
          });

          tearDown(() {
            stopRecordingValidationWarnings();
          });

          test('when initial width and height are non-zero', () async {
            await expectInitialize(onInitialize: (ResizeSensorEvent event) {
              zonedExpect(event.newWidth, equals(100));
              zonedExpect(event.newHeight, equals(100));
              zonedExpect(event.prevWidth, equals(0));
              zonedExpect(event.prevHeight, equals(0));
            }, width: 100, height: 100);

            // Should not warn about onInitialize when props.quickMount is false.
            rejectValidationWarning(contains('onInitialize'));
          });

          test('when initial width and height are zero', () async {
            await expectInitialize(onInitialize: (ResizeSensorEvent event) {
              zonedExpect(event.newWidth, equals(0));
              zonedExpect(event.newHeight, equals(0));
              zonedExpect(event.prevWidth, equals(0));
              zonedExpect(event.prevHeight, equals(0));
            }, width: 0, height: 0);

            // Should not warn about onInitialize when props.quickMount is false.
            rejectValidationWarning(contains('onInitialize'));
          });
        });
      });

      group('true:', () {
        ResizeSensorProps props;

        setUp(() {
          startRecordingValidationWarnings();

          props = ResizeSensor()
            ..quickMount = true;
        });

        tearDown(() {
          stopRecordingValidationWarnings();
        });

        test('warns when props.onInitialize is set and does not call it', () async {
          bool onInitializeCalled = false;

          await expectResizeAfter(() {
            containerRef.style.width = '${defaultContainerWidth * 2}px';
            containerRef.style.height = '${defaultContainerHeight * 2}px';
          }, onInitialize: (_) {
            onInitializeCalled = true;
          }, resizeSensorProps: props);

          expect(onInitializeCalled, isFalse);
          verifyValidationWarning(contains('props.onInitialize will not be called when props.quickMount is true'));
        }, testOn: '!js');

        test('does not warn about props.onInitialize when it is not set', () async {
          await expectResizeAfter(() {
            containerRef.style.width = '${defaultContainerWidth * 2}px';
            containerRef.style.height = '${defaultContainerHeight * 2}px';
          }, resizeSensorProps: props);

          rejectValidationWarning(contains('onInitialize'));
        }, testOn: '!js');

        test('passes the correct event args on resize', () async {
          var resizeEvents = <ResizeSensorEvent>[];

          await expectResizeAfter(() async {
            containerRef.style.width = '${defaultContainerWidth + 10}px';
            containerRef.style.height = '${defaultContainerHeight + 10}px';

            await window.animationFrame;
            await window.animationFrame;

            containerRef.style.width = '${defaultContainerWidth + 20}px';
            containerRef.style.height = '${defaultContainerHeight + 20}px';
          }, onResize: resizeEvents.add, resizeEventCount: 2, resizeSensorProps: props);

          expect(resizeEvents, hasLength(2));

          var firstEvent = resizeEvents[0];
          var secondEvent = resizeEvents[1];

          expect(firstEvent.prevWidth, 0, reason: 'first previous dimensions should be zero when quick-mount is enabled');
          expect(firstEvent.prevHeight, 0, reason: 'first previous dimensions should be zero when quick-mount is enabled');
          expect(firstEvent.newWidth, defaultContainerWidth + 10, reason: 'should report the newSize properly');
          expect(firstEvent.newHeight, defaultContainerHeight + 10, reason: 'should report the newSize properly');

          expect(secondEvent.prevWidth, defaultContainerWidth + 10, reason: 'should have stored previous dimensions for subsequent events');
          expect(secondEvent.prevHeight, defaultContainerHeight + 10, reason: 'should have stored previous dimensions for subsequent events');
          expect(secondEvent.newWidth, defaultContainerWidth + 20, reason: 'should report the newSize properly');
          expect(secondEvent.newHeight, defaultContainerHeight + 20, reason: 'should report the newSize properly');
        });
      });
    });

    group('should indicate that the sensor needs to be reset', () {
      Element validTarget;
      Element detachedTarget;
      Map<String, bool> calls;

      setUp(() {
        calls = <String, bool>{};
      });

      tearDown(() {
        calls = null;
      });

      group('when mounted into a node that is not attached to the DOM', () {
        setUp(() {
          ValidationUtil.WARNINGS_ENABLED = true;
          startRecordingValidationWarnings();
          detachedTarget = new DivElement();
          detachedTarget.style.width = '200px';
          detachedTarget.style.height = '200px';
          mount((ResizeSensor()
            ..onDetachedMountCheck = (needsReset) { calls['onDetachedMountCheck'] = needsReset; }
          )(), attachedToDocument: false, mountNode: detachedTarget);
        });

        tearDown(() {
          stopRecordingValidationWarnings();
          detachedTarget = null;
        });

        test('by providing a `true` argument value to the `props.onDetachedMountCheck` callback', () {
          expect(calls['onDetachedMountCheck'], isTrue);
        });

        test('and does not emit a validation warning about not needing to set the `onDetachedMountCheck` callback.', () {
          rejectValidationWarning(contains('The ResizeSensor was not mounted detached from the DOM'));
        });
      });

      group('unless mounted into a node that is attached to the DOM', () {
        setUp(() {
          ValidationUtil.WARNINGS_ENABLED = true;
          startRecordingValidationWarnings();
          validTarget = new DivElement();
          validTarget.style.width = '200px';
          validTarget.style.height = '200px';
          document.body.append(validTarget);
          mount((ResizeSensor()
            ..onDetachedMountCheck = (needsReset) { calls['onDetachedMountCheck'] = needsReset; }
          )(), attachedToDocument: true, mountNode: validTarget);
        });

        tearDown(() {
          stopRecordingValidationWarnings();
          validTarget.remove();
          validTarget = null;
        });

        test('- providing a `false` argument value to the `props.onDetachedMountCheck` callback', () {
          expect(calls['onDetachedMountCheck'], isFalse);
        });

        test('and emits a validation warning about not needing to set the `onDetachedMountCheck` callback.', () {
          verifyValidationWarning(contains('The ResizeSensor was not mounted detached from the DOM'));
        }, tags: 'ddc');
      });
    });

    test('provides a `forceResetDetachedSensor` method that calls `_reset`', () {
      var calls = [];
      TestJacket<ResizeSensorComponent> jacket = mount((ResizeSensor()
        ..onDidReset = () { calls.add('onDidReset'); }
      )());
      calls.clear();

      jacket.getDartInstance().forceResetDetachedSensor();

      expect(calls, ['onDidReset']);
    });

    group('common component functionality:', () {
      commonComponentTests(ResizeSensor);
    });
  });
}
