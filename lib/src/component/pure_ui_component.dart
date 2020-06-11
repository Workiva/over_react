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

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

/// A mixin to make a [UiComponent2] instance behave
/// like a [ReactJS `PureComponent`](https://reactjs.org/docs/react-api.html#reactpurecomponent).
///
/// If your component does not support `props.children`, you can override [supportsPropChildren]
/// to `false` for further optimizations.
mixin PureUiComponent<T extends UiProps> on UiComponent2<T> {
  @mustCallSuper
  @override
  bool shouldComponentUpdate(Map nextProps, Map nextState) {
    final currentPropsWithoutChildren = Map.of(this.props)..remove('children');
    final nextPropsWithoutChildren = Map.of(nextProps)..remove('children');

    bool shouldUpdate = true;

    try {
      shouldUpdate = !_deepCollectionEquality.equals(currentPropsWithoutChildren, nextPropsWithoutChildren) ||
          !_deepCollectionEquality.equals(this.state, nextState) ||
          (supportsPropChildren && !const ListEquality().equals(this.props['children'], nextProps['children']));
    } catch (_) {
      // Catch any errors if un-extensible objects are present within props / state,
      // and simply update the component if/when this happens.
    }

    return shouldUpdate;
  }

  /// Whether the component supports `props.children`.
  ///
  /// Set to false to skip an equality check of `props.children` within [shouldComponentUpdate].
  bool get supportsPropChildren => true;
}

class _ReactElementSafeEquality<E> implements Equality<E> {
  const _ReactElementSafeEquality();

  @override
  bool equals(Object e1, Object e2) => e1 == e2;

  @override
  // This returns 0 when the object is a ReactElement to work around
  // https://github.com/dart-lang/sdk/issues/36354. The behavior of `hashCode`
  // under dart2js is to return 0, so we do the same here. Under content-shell,
  // if `e` is a function, it will likewise throw an error.
  int hash(Object e) => e is! Function && isValidElement(e) ? 0 : e.hashCode;

  @override
  bool isValidKey(Object o) => true;
}

const _deepCollectionEquality = DeepCollectionEquality(_ReactElementSafeEquality());
