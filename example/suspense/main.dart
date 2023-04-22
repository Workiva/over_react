// Copyright 2022 Workiva Inc.
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

import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/promise_interop.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client/react_interop.dart' as react_interop;

import './lazy_component.dart' deferred as lazy_component;

//part 'main.over_react.g.dart';

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

final Lazy = lazy(() async {
  await lazy_component.loadLibrary();
  await Future.delayed(Duration(seconds: 5));
  return lazy_component.Lazy;
});

void main() {
    react_dom.render(StrictMode()(
      (Suspense()
        ..fallback = (Dom.div()..id = 'suspense')(
          'Loading...'
          )
        )(
          (Lazy()..['initialCount'] = 2)(
            (Dom.div()..id = 'Heyyy!')()
          )
        ),
      ),
      querySelector('#content')
    );
}
