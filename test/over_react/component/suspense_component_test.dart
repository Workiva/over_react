// Copyright 2019 Workiva Inc.
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
@JS()
library suspense_component_test;

import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/promise_interop.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart' as react_interop;
import 'package:test/test.dart';

import 'fixtures/dummy_component.dart';

@JS('React.lazy')
external react_interop.ReactClass jsLazy(Promise Function() factory);

// Only intended for testing purposes, Please do not copy/paste this into your repo.
// This will most likely be added to the PUBLIC api in the future,
// but needs more testing and Typing decisions to be made first.
UiFactory<UiProps> lazy<T extends UiProps>(Future<UiFactory<T>> Function() factory) {
  return uiJsComponent(
    ReactJsComponentFactoryProxy(
      jsLazy(
        allowInterop(
          () => futureToPromise(
            // React.lazy only supports "default exports" from a module.
            // This `{default: yourExport}` workaround can be found in the React.lazy RFC comments.
            // See: https://github.com/reactjs/rfcs/pull/64#issuecomment-431507924
            (() async {
              //resolvedFactory = await factory();
              return jsify({'default': (await factory()).elementType});
            })(),
          ),
        ),
      ),
    ),
    Dom.div.asForwardRefConfig(displayName: 'Lazy'),
);
}

void main() {
  group('Suspense', () {
    test('renders fallback UI first followed by the real component', () {
      final wrappingDivRef = createRef<Element>();

      renderAttachedToDocument(
        (Dom.div()
          ..ref = wrappingDivRef
        )(
          (Suspense()..fallback = (Dom.span()..id = 'loading')())(
            Dom.div()(),
            Dom.div()(),
            Dom.div()(),
            Dom.div()(),
          ),
        ),
      );

      expect(wrappingDivRef.current.children, hasLength(4));
    });

    test('is instant after the lazy component has been loaded once', () {
      var callCount = 0;
      var jacket = mount(
        (Suspense()..key = 1)(
          (Dummy()
            ..onComponentDidMount = () {
              callCount++;
            })(),
        ),
      );

      expect(callCount, 1);

      jacket.rerender(
        (Suspense()..key = 2)(
          (Dummy()
            ..onComponentDidMount = () {
              callCount++;
            })(),
        ),
      );

      expect(callCount, 2,
          reason:
              'Dummy should have been remounted as a result of Suspense key changing');
    });
  });
}
