// Copyright 2018 Workiva Inc.
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
library internal_resize_observer_test;

import 'dart:async';

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/resize/resize_observer.dart' as internal;
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

void main() {
  group('ResizeObserver', () {
    test('calls onInitialize on mount', () async {
      var calls = [];
      ResizeSensorEvent initEvent;
      renderAttachedToDocument((internal.ResizeObserver()
        ..onInitialize = (event) {
          initEvent = event;
          calls.add('onInitialize');
        }
      )(
        (Dom.div()
          ..style = {
            'width': '100px',
            'height': '200px',
          }
        )()
      ));

      await new Future.delayed(const Duration(seconds: 1));

      expect(calls, ['onInitialize']);
      expect(initEvent.newWidth, 100);
      expect(initEvent.newHeight, 200);
    });

    test('calls onResize when the component resizes', () async {
      var calls = [];
      ResizeSensorEvent resizeEvent;
      var renderedInstance = renderAttachedToDocument((internal.ResizeObserver()
        ..onResize = (event) {
          resizeEvent = event;
          calls.add('onResize');
        }
      )(
        (Dom.div()
          ..style = {
            'width': '100px',
            'height': '200px',
          }
        )()
      ));

      print(findDomNode(renderedInstance).innerHtml);

      await new Future.delayed(const Duration(seconds: 1));

      expect(calls, isEmpty);

      // ignore: avoid_as
      (getDartComponent(renderedInstance) as internal.ResizeObserverComponent).childRef.style.height = '100px';

      await new Future.delayed(const Duration(seconds: 1));

      expect(calls, ['onResize']);

      expect(resizeEvent.newWidth, 100);
      expect(resizeEvent.newHeight, 100);
    });

    group('common component functionality:', () {
      commonComponentTests(internal.ResizeObserver, childrenFactory: () => Dom.div()());
    },
        // Mirrors don't work in the DDC.
        tags: 'no-ddc'
    );
  });
}
