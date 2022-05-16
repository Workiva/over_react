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

@TestOn('browser')
library safe_render_manager_helper_test;

import 'dart:async';

import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/safe_render_manager/safe_render_manager_helper.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';

/// Main entry point for SafeRenderManagerHelper testing
main() {
  enableTestMode();

  group('SafeRenderManagerHelper component', () {
    test('renders with the single child initially mounted', () {
      var renderedInstance = render((SafeRenderManagerHelper()
        ..getInitialContent = (Dom.div()..addTestId('singleChild'))
      )());

      expect(getByTestId(renderedInstance, 'singleChild'), isNotNull);
    });

    group('renderContent', () {
      dynamic renderedInstance;
      SafeRenderManagerHelperComponent component;

      setUp(() {
        renderedInstance = render((SafeRenderManagerHelper()
          ..getInitialContent = (Dom.div()..addTestId('singleChild'))
        )());
        component = getDartComponent(renderedInstance);
      });

      tearDown(() {
        renderedInstance = null;
        component = null;
      });

      test('renders new content', () {
        component.renderContent((Dom.div()..addTestId('singleChild2'))());

        expect(getByTestId(renderedInstance, 'singleChild'), isNull);
        expect(getByTestId(renderedInstance, 'singleChild2'), isNotNull);
      });
    });

    group('tryUnmountContent()', () {
      dynamic renderedInstance;
      SafeRenderManagerHelperComponent component;

      setUp(() {
        renderedInstance = render((SafeRenderManagerHelper()
          ..getInitialContent = (Dom.div()..addTestId('singleChild'))
        )());
        component = getDartComponent(renderedInstance);
      });

      tearDown(() {
        renderedInstance = null;
        component = null;
      });

      test('causes a rerender with the child unmounted', () {
        expect(getByTestId(renderedInstance, 'singleChild'), isNotNull, reason: 'test setup sanity check');

        component.tryUnmountContent();

        expect(getByTestId(renderedInstance, 'singleChild'), isNull);
      });

      test('causes a rerender and calls the specified callback', () async {
        expect(getByTestId(renderedInstance, 'singleChild'), isNotNull, reason: 'test setup sanity check');

        final onUnmountCompleter = Completer();

        storeZone();
        component.tryUnmountContent(onMaybeUnmounted: (isUnmounted) {
          zonedExpect(getByTestId(renderedInstance, 'singleChild'), isNull);
          zonedExpect(isUnmounted, isTrue);

          onUnmountCompleter.complete();
        });

        await onUnmountCompleter.future;
      });

      test('does not throw when called more than once', () {
        component.tryUnmountContent();
        expect(() => component.tryUnmountContent(), returnsNormally);
      });

      test('calls the specified callback if no content is rendered', () async {
        expect(getByTestId(renderedInstance, 'singleChild'), isNotNull, reason: 'test setup sanity check');

        final onUnmountCompleter = Completer();

        storeZone();
        component.tryUnmountContent();
        zonedExpect(getByTestId(renderedInstance, 'singleChild'), isNull);

        component.tryUnmountContent(onMaybeUnmounted: (isUnmounted) {
          zonedExpect(getByTestId(renderedInstance, 'singleChild'), isNull);
          zonedExpect(isUnmounted, isTrue);
          onUnmountCompleter.complete();
        });

        await onUnmountCompleter.future;
      });
    });
  });
}
