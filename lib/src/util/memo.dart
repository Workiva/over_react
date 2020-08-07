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

library over_react.memo;

import 'package:over_react/src/component_declaration/component_type_checking.dart';
import 'package:react/react_client/react_interop.dart' as react_interop;
import 'package:react/react_client.dart';
import 'package:over_react/component_base.dart';

/// A [higher order component](https://reactjs.org/docs/higher-order-components.html) for function components
/// that behaves similar to the way [`React.PureComponent`](https://reactjs.org/docs/react-api.html#reactpurecomponent)
/// does for class-based components.
///
/// If your function component renders the same result given the same props, you can wrap it in a call to
/// `memo` for a performance boost in some cases by memoizing the result. This means that React will skip
/// rendering the component, and reuse the last rendered result.
///
/// > __NOTE:__ This should only be used to wrap function components.
///
/// ```dart
/// import 'package:over_react/over_react.dart';
///
/// UiFactory<UiProps> MemoExample = memo<UiProps>(uiFunction(
///   (props) {
///     // render using props
///   },
///   UiFactoryConfig(),
/// ));
/// ```
///
/// `memo` only affects props changes. If your function component wrapped in `memo` has a
/// `useState` or `useContext` Hook in its implementation, it will still rerender when `state` or `context` change.
///
/// By default it will only shallowly compare complex objects in the props map.
/// If you want control over the comparison, you can also provide a custom comparison
/// function to the [areEqual] argument as shown in the example below.
///
/// ```dart
/// import 'package:over_react/over_react.dart';
///
/// UiFactory<MemoWithComparisonProps> MemoWithComparison = memo<MemoWithComparisonProps>(uiFunction(
///   (props) {
///     // render using props
///   },
///   $MemoWithComparisonConfig, // ignore: undefined_identifier
/// ), areEqual: (prevProps, nextProps) {
///   // Do some custom comparison logic to return a bool based on prevProps / nextProps
/// });
/// ```
///
/// > __This method only exists as a performance optimization.__
/// >
/// > Do not rely on it to “prevent” a render, as this can lead to bugs.
///
/// See: <https://reactjs.org/docs/react-api.html#reactmemo>.
UiFactory<TProps> memo<TProps extends UiProps>(UiFactory<TProps> factory,
    {bool Function(TProps prevProps, TProps nextProps) areEqual,
    String displayName}) {
  enforceFunctionComponent(factory().componentFactory);

  ReactComponentFactoryProxy hoc;
  if (areEqual != null) {
    bool wrapProps(Map prevProps, Map nextProps) {
      final tPrevProps = factory(prevProps);
      final tNextProps = factory(nextProps);
      return areEqual(tPrevProps, tNextProps);
    }

    hoc = react_interop.memo(factory().componentFactory, areEqual: wrapProps);
  } else {
    hoc = react_interop.memo(factory().componentFactory);
  }

  setComponentTypeMeta(hoc,
      isHoc: true, parentType: factory().componentFactory);

  TProps forwardedFactory([Map props]) {
    return factory(props)..componentFactory = hoc;
  }

  return forwardedFactory;
}
