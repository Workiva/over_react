@Timeout(const Duration(seconds: 2))
library resize_sensor_test;

import 'dart:async';
import 'dart:html';

import 'package:platform_detect/platform_detect.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:test/test.dart';
import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/test_util.dart';

import '../../wsd_test_util/common_component_tests.dart';
import '../../wsd_test_util/zone.dart';

void main() {
  group('ResizeSensor', () {
    const int defaultContainerWidth = 100;
    const int defaultContainerHeight = 100;

    Element domTarget;

    setUp(() {
      domTarget = document.createElement('div');
      document.body.append(domTarget);
      // Perform setup needed for using 'zonedExpect'.
      storeZone();
    });

    tearDown(() {
      domTarget.remove();
    });

    Element renderSensorIntoContainer({ResizeSensorHandler onInitialize, ResizeSensorHandler onResize,
        int width: defaultContainerWidth, int height: defaultContainerHeight, Map resizeSensorProps}) {
      // Create component hierarchy.
      var sensor = (ResizeSensor()
        ..addProps(resizeSensorProps)
        ..onInitialize = onInitialize
        ..onResize = onResize
      )();
      var container = react.div({
        'className': 'container',
        'style': {
          'position': 'absolute',
          'width': width,
          'height': height
        }
      }, sensor);

      // Render into DOM and validate.
      var jsContainer = react_dom.render(container, domTarget);

      // Return the container element for testing.
      return findDomNode(jsContainer);
    }

    /// Expect resize sensor invokes registered `onResize` callback.
    ///
    /// Note: Test cases must await calls to this function. A boolean value is
    /// tracked to confirm callback invocation, instead of `expectAsync`, due to
    /// oddities in detecting callback invocations.
    Future expectResizeAfter(void action(Element container),
        {ResizeSensorHandler onResize, int width: defaultContainerWidth, int height: defaultContainerHeight,
        Map resizeSensorProps}) async {
      var resizeDetectedCompleter = new Completer();

      Element containerEl;
      containerEl = renderSensorIntoContainer(onResize: (event) {
        if (onResize != null) {
          onResize(event);
        }
        resizeDetectedCompleter.complete();
      }, width: width, height: height, resizeSensorProps: resizeSensorProps);

      action(containerEl);

      await resizeDetectedCompleter.future;
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

        var nodeStyleDecl = renderedNode.style;
        if (browser.isInternetExplorer && browser.version.major < 11) {
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-positive'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-negative'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-preferred-size'), '0%');
        } else if (browser.isSafari && browser.version.major < 9) {
          expect(nodeStyleDecl.getPropertyValue('-webkit-flex'), '1 1 0%');
        } else {
          expect(nodeStyleDecl.getPropertyValue('flex'), '1 1 0%');
        }
      });

      test('when isFlexContainer is true', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexContainer = true)());

        expect(renderedNode.style.position, equals('relative'));

        var nodeStyleDecl = renderedNode.style;
        if (browser.isInternetExplorer && browser.version.major < 11) {
          expect(renderedNode.style.display, equals('-ms-flexbox'));
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-positive'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-negative'), '1');
          expect(nodeStyleDecl.getPropertyValue('-ms-flex-preferred-size'), '0%');
        } else if (browser.isSafari && browser.version.major < 9) {
          expect(renderedNode.style.display, equals('-webkit-flex'));
          expect(nodeStyleDecl.getPropertyValue('-webkit-flex'), '1 1 0%');
        } else {
          expect(renderedNode.style.display, equals('flex'));
          expect(nodeStyleDecl.getPropertyValue('flex'), '1 1 0%');
        }
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

    group('should detect when bounding rect grows horizontally', () {
      test('', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.width = '${defaultContainerWidth * 2}px';
        });
      });

      test('even when the bounding rect is very small', () async {
        await expectResizeAfter((containerEl) {
          containerEl.style.width = '4px';
        }, width: 2, height: 2);
      });

      test('and shrink is true', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.width = '${defaultContainerWidth * 2}px';
        }, resizeSensorProps: ResizeSensor()..shrink = true);
      });
    });

    group('should detect when bounding rect grows vertically', () {
      test('', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.height = '${defaultContainerHeight * 2}px';
        });
      });

      test('even when the bounding rect is very small', () async {
        await expectResizeAfter((containerEl) {
          containerEl.style.height = '4px';
        }, width: 2, height: 2);
      });

      test('and shrink is true', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.height = '${defaultContainerHeight * 2}px';
        }, resizeSensorProps: ResizeSensor()..shrink = true);
      });
    });

    group('should detect when bounding rect shrinks horizontally', () {
      test('', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.width = '${defaultContainerWidth / 2}px';
        });
      });

      test('even when the bounding rect is very small', () async {
        await expectResizeAfter((containerEl) {
          containerEl.style.width = '1px';
        }, width: 2, height: 2);
      });

      test('and shrink is true', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.width = '${defaultContainerWidth / 2}px';
        }, resizeSensorProps: ResizeSensor()..shrink = true);
      });
    });

    group('should detect when bounding rect shrinks vertically', () {
      test('', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.height = '${defaultContainerHeight / 2}px';
        });
      });

      test('even when the bounding rect is very small', () async {
        await expectResizeAfter((containerEl) {
          containerEl.style.height = '1px';
        }, width: 2, height: 2);
      });

      test('and shrink is true', () async{
        await expectResizeAfter((containerEl) {
          containerEl.style.height = '${defaultContainerHeight / 2}px';
        }, resizeSensorProps: ResizeSensor()..shrink = true);
      });
    });

    test('should pass the correct event args on resize', () async {
      await expectResizeAfter((containerEl) {
        containerEl.style.width = '${defaultContainerWidth * 2}px';
        containerEl.style.height = '${defaultContainerHeight * 2}px';
      }, onResize: (ResizeSensorEvent event) {
        zonedExpect(event.newWidth, equals(defaultContainerWidth * 2));
        zonedExpect(event.newHeight, equals(defaultContainerHeight * 2));
        zonedExpect(event.prevWidth, equals(defaultContainerWidth));
        zonedExpect(event.prevHeight, equals(defaultContainerHeight));
      });
    });

    group('should pass the correct event args on initialize', () {
      test('when initial width and height are non-zero', () async {
        await expectInitialize(onInitialize: (ResizeSensorEvent event) {
          zonedExpect(event.newWidth, equals(100));
          zonedExpect(event.newHeight, equals(100));
          zonedExpect(event.prevWidth, equals(0));
          zonedExpect(event.prevHeight, equals(0));
        }, width: 100, height: 100);
      });

      test('when initial width and height are zero', () async {
        await expectInitialize(onInitialize: (ResizeSensorEvent event) {
          zonedExpect(event.newWidth, equals(0));
          zonedExpect(event.newHeight, equals(0));
          zonedExpect(event.prevWidth, equals(0));
          zonedExpect(event.prevHeight, equals(0));
        }, width: 0, height: 0);
      });
    });

    group('common component functionality:', () {
      commonComponentTests(ResizeSensor);
    });
  });
}
