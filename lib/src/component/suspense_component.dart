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
library over_react.component.suspense_component;

import 'package:js/js.dart';
import 'package:over_react/src/component_declaration/component_declaration.dart';
import 'package:over_react/src/component_declaration/function_component.dart';
import 'package:react/react.dart' as react;
import 'package:over_react/src/util/js_component.dart';

part 'suspense_component.over_react.g.dart';

/// [Suspense] lets you display a fallback UI until its children have finished loading.
///
/// Like [Fragment], [Suspense] does not render any visible UI.
/// It lets you specify a loading indicator in case some components in
/// the tree below it are not yet ready to render.
/// [Suspense] currently works with:
/// - Components that use React.lazy
///   - (dynamic imports, not currently implemented in dart)
///
/// Example Usage:
/// ```
///   render() {
///     return Dom.div()(
///       Header()(),
///       (Suspense()
///         ..fallback = LoadingIndicator()()
///       )(
///         LazyBodyComponent()(),
///         NotALazyComponent()(),
///       ),
///       Footer()(),
///     );
///   }
/// ```
///
/// In the above example, [Suspense] will display the `LoadingIndicator` until
/// `LazyBodyComponent` is loaded. It will not display for `Header` or `Footer`.
///
/// However, any "lazy" descendant components in `LazyBodyComponent` and
/// `NotALazyComponent` will trigger the closest ancestor [Suspense].
///
/// See: <https://react.dev/reference/react/Suspense>
UiFactory<SuspenseProps> Suspense = uiJsComponent(
  react.Suspense,
  _$SuspenseConfig, // ignore: undefined_identifier
);

/// The concrete props class for the [Suspense] component.
class SuspenseProps = UiProps with SuspensePropsMixin;

@Props(keyNamespace: '')
mixin SuspensePropsMixin on UiProps {
  /// The actual UI you intend to render. If children suspends while rendering, the Suspense boundary will
  /// switch to rendering fallback.
  @override
  /*ReactNode*/ List<dynamic>? get children;

  /// An alternate UI to render in place of the actual UI if it has not finished loading. Any valid React node is
  /// accepted, though in practice, a fallback is a lightweight placeholder view, such as a loading spinner or skeleton.
  /// Suspense will automatically switch to fallback when children suspends, and back to children when the data is ready.
  /// If fallback suspends while rendering, it will activate the closest parent Suspense boundary.
  /*ReactNode*/ dynamic fallback;
}
