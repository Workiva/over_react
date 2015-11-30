@Timeout(const Duration(seconds: 2))
library resize_sensor_test;

import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_test_utils.dart' as reactTestUtils;
import 'package:test/test.dart';
import 'package:web_skin_dart/src/ui_core/component/resize_sensor.dart';

import '../../wsd_test_util/common_component_tests.dart';

void main() {
  group('ResizeSensor', () {
    const int containerWidth = 100;
    const int containerHeight = 100;

    Element domTarget;

    setUp(() {
      domTarget = document.createElement('div');
      document.body.append(domTarget);
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
        expect(event.newWidth, equals(containerWidth * 2));
        expect(event.newHeight, equals(containerHeight * 2));
        expect(event.prevWidth, equals(containerWidth));
        expect(event.prevHeight, equals(containerHeight));
      });
    });

    group('common component functionality:', () {
      commonComponentTests(ResizeSensor);
    });
  });
}
