// @dart=2.11
// Copyright 2023 Workiva Inc.
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

import 'dart:async';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/promise_interop.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart' as react_interop;
import 'package:react_testing_library/react_testing_library.dart';
import 'package:test/test.dart';
import 'fixtures/lazy_load_me_props.dart';
import 'fixtures/lazy_load_me_component.dart' deferred as lazy_load_me;

@JS('React.lazy')
external react_interop.ReactClass jsLazy(Promise Function() factory);

// Only intended for testing purposes, Please do not copy/paste this into your repo.
// This will most likely be added to the PUBLIC api in the future,
// but needs more testing and Typing decisions to be made first.
UiFactory<T> lazy<T extends UiProps>(Future<UiFactory<T>> Function() factory, UiFactoryConfig<T> factoryConfig) {
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
    factoryConfig,
  );
}

const lazyId = 'lazy';
const gregIsNotLazy = 'gregisnotlazy';
const loadingId = 'loading';
void main() {
  group('Suspense', () {
    test('renders fallback UI first followed by the real component', () async {
      final lazyLoadCompleter = Completer<void>();
      final LazyLoadMe = lazy(
        () async {
          await lazy_load_me.loadLibrary();
          await lazyLoadCompleter.future;
          return lazy_load_me.LazyLoadMe;
        },
        UiFactoryConfig(
          displayName: 'LazyLoadMe',
          propsFactory: PropsFactory.fromUiFactory(LazyLoadMePropsMapView),
        ),
      );

      final view = render(
        (Suspense()..fallback = (Dom.span()..addTestId(loadingId))())(
          (LazyLoadMe()
            ..addTestId(lazyId)
            ..initialCount = 2)(),
        ),
      );

      expect(view.getByTestId(loadingId), isNotNull);
      expect(view.queryByTestId(lazyId), isNull);
      lazyLoadCompleter.complete();
      expect(await view.findByTestId(lazyId), isNotNull);
    });

    test('is instant after the lazy component has been loaded once', () async {
      final lazyLoadCompleter = Completer<void>();
      const suspenseFallbackTimeout = Duration(milliseconds: 100);

      final LazyLoadMe = lazy(
        () async {
          await lazy_load_me.loadLibrary();
          await lazyLoadCompleter.future;
          return lazy_load_me.LazyLoadMe;
        },
        UiFactoryConfig(
          displayName: 'LazyLoadMe',
          propsFactory: PropsFactory.fromUiFactory(LazyLoadMePropsMapView),
        ),
      );

      {
        final view = render(
          (Suspense()..fallback = (Dom.span()..addTestId(loadingId))())(
            (LazyLoadMe()
              ..addTestId(lazyId)
              ..initialCount = 2)(),
          ),
        );

        expect(view.getByTestId(loadingId), isNotNull);
        expect(view.queryByTestId(lazyId), isNull);

        await Future.delayed(Duration(seconds: 1));
        expect(view.queryByTestId(lazyId), isNull, reason: 'should not be found until the lazy component finishes loading');

        lazyLoadCompleter.complete();
        expect(await view.findByTestId(lazyId, timeout: suspenseFallbackTimeout), isNotNull);
        view.unmount();
      }
      {
        final view = render(
          (Suspense()..fallback = (Dom.span()..addTestId(loadingId))())(
            (LazyLoadMe()
              ..addTestId(gregIsNotLazy)
              ..initialCount = 2)(),
          ),
        );

        expect(view.getByTestId(gregIsNotLazy), isNotNull);
      }
    });
  });
}
