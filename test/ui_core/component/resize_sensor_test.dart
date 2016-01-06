@Timeout(const Duration(seconds: 2))
library resize_sensor_test;

import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_test_utils.dart' as reactTestUtils;
import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/component/resize_sensor.dart';
import 'package:web_skin_dart/test_util.dart';

import '../../wsd_test_util/common_component_tests.dart';
import '../../wsd_test_util/zone.dart';

void main() {
  group('ResizeSensor', () {
    const int containerWidth = 100;
    const int containerHeight = 100;

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

    Element renderSensorIntoContainer(ResizeHandler handler) {
      // Create component hierarchy.
      var sensor = (ResizeSensor()..onResize = handler)();
      var container = react.div({
        'className': 'container',
        'style': {
          'position': 'absolute',
          'width': containerWidth,
          'height': containerHeight
        }
      }, sensor);

      // Render into DOM and validate.
      var jsContainer = react.render(container, domTarget);
      var jsTree = reactTestUtils.findRenderedDOMComponentWithClass(jsContainer, 'container');
      expect(jsTree, isNotNull);

      // Return the container element for testing.
      return reactTestUtils.getDomNode(jsTree);
    }

    /// Expect resize sensor invokes registered `onResize` callback.
    ///
    /// Note: Test cases must await calls to this function. A boolean value is
    /// tracked to confirm callback invocation, instead of `expectAsync`, due to
    /// oddities in detecting callback invocations.
    Future expectResizeAfter(void action(Element container),
        {void onResize(ResizeSensorEvent)}) async {
      var wasResizeDetected = false;

      Element containerEl;
      containerEl = renderSensorIntoContainer((event) {
        if (onResize != null) {
          onResize(event);
        }
        wasResizeDetected = true;
      });

      action(containerEl);

      // Note: there is a delay here because Smithy has trouble running these
      // tests successfully without it. :(
      await new Future.delayed(const Duration(milliseconds: 200),
          () => expect(wasResizeDetected, isTrue));
    }

    group('should render with the correct styles when isFlexChild is', () {
      test('true', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexChild = true)());

        expect(renderedNode.style.position, equals('relative'));
        expect(renderedNode.style.flex, equals('1 1 0%'));
        expect(renderedNode.style.display, equals('block'));
      });

      test('false', () {
        var renderedNode = renderAndGetDom(ResizeSensor()());

        expect(renderedNode.style.position, equals('relative'));
        expect(renderedNode.style.width, equals('100%'));
        expect(renderedNode.style.height, equals('100%'));
      });
    });

    // Test that every last ResizeSensor node is hidden, ensuring that scrollbars don't show up in Safari.
    group('should set `visibility: hidden` on all of its descendants when isFlexChild is', () {
      test('true', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexChild = true)());
        var descendants = renderedNode.querySelectorAll('*');

        descendants.forEach((descendant) {
          expect(descendant.style.visibility, equals('hidden'));;
        });
      });

      test('false', () {
        var renderedNode = renderAndGetDom((ResizeSensor()..isFlexChild = false)());
        var descendants = renderedNode.querySelectorAll('*');
        
        descendants.forEach((descendant) {
          expect(descendant.style.visibility, equals('hidden'));;
        });
      });
    });

    test('should detect when bounding rect grows horizontally', () async {
      await expectResizeAfter((containerEl) {
        containerEl.style.width = '${containerWidth * 2}px';
      });
    });

    test('should detect when bounding rect grows vertically', () async {
      await expectResizeAfter((containerEl) {
        containerEl.style.height = '${containerHeight * 2}px';
      });
    });

    test('should detect when bounding rect shrinks horizontally', () async {
      await expectResizeAfter((containerEl) {
        containerEl.style.width = '${containerWidth / 2}px';
      });
    });

    test('should detect when bounding rect shrinks vertically', () async {
      await expectResizeAfter((containerEl) {
        containerEl.style.height = '${containerHeight / 2}px';
      });
    });

    test('should pass the correct event args on resize', () async {
      await expectResizeAfter((containerEl) {
        containerEl.style.width = '${containerWidth * 2}px';
        containerEl.style.height = '${containerHeight * 2}px';
      }, onResize: (ResizeSensorEvent event) {
        zonedExpect(event.newWidth, equals(containerWidth * 2));
        zonedExpect(event.newHeight, equals(containerHeight * 2));
        zonedExpect(event.prevWidth, equals(containerWidth));
        zonedExpect(event.prevHeight, equals(containerHeight));
      });
    });

    group('common component functionality:', () {
      commonComponentTests(ResizeSensor);
    });
  });
}
