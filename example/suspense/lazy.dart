import 'dart:js';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/promise_interop.dart';
import 'package:react/react_client/react_interop.dart' as react_interop;
import 'package:over_react/js_component.dart';
import 'package:react/react_client/component_factory.dart';

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
