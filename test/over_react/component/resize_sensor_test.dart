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

import 'package:over_react/over_react.dart';
import 'package:over_react/src/component/resize/resize_observer.dart' as internal;
import 'package:over_react/src/component/resize/resize_sensor.dart' as internal;
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

void main() {
  group('ResizeSensor', () {
    group('renders the correct base component when useResizeObserver is', () {
      test('true', () {
        var renderedInstance = render((ResizeSensor()..useResizeObserver = true)(Dom.div()()));
        var internalComponent = getComponentByTestId(renderedInstance, 'ResizeSensor.internal');

        expect(internalComponent, new isInstanceOf<internal.ResizeObserverComponent>());
      });

      test('false', () {
        var renderedInstance = render(ResizeSensor()());
        var internalComponent = getComponentByTestId(renderedInstance, 'ResizeSensor.internal');

        expect(internalComponent, new isInstanceOf<internal.ResizeSensorComponent>());
      });
    });


    group('common component functionality:', () {
      commonComponentTests(ResizeSensor, unconsumedPropKeys: [const $PropKeys(ResizeSensorPropsMixin)]);
    },
        // Mirrors don't work in the DDC.
        tags: 'no-ddc'
    );
  });
}
