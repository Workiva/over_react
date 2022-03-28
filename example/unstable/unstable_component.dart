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

import 'dart:html';

import 'package:over_react/over_react.dart';

part 'unstable_component.over_react.g.dart';

@Props(keyNamespace: '')
mixin UnstableComponentPropsMixin on UiProps {
  bool legitProp;
  Map mapProp;
}

@Props(keyNamespace: '')
class UnstableComponentProps = UiProps with UnstableComponentPropsMixin, UnstableUiPropsMixin;

@Deprecated('Using this UiFactory without `.stable` provides the latest typed props. This component will not render anything unless you use `MyComponent().unstable` eg. `(MyComponent().unstable..someProp = \'something\')()`')
UiFactory<UnstableComponentProps> UnstableComponent = uiFunction(
  (props) {
    return Dom.div()(
        Dom.div()('legit prop: ${props.legitProp}'),
        Dom.div()('fake prop: ${props["fakeProp"]}'),
        Dom.div()('map prop: ${props.mapProp != null ? props.mapProp["test"] : 'No Map'}'),
        Dom.div()(props.children),
        Dom.br()(),
    );
  },
  _$UnstableComponentConfig, // ignore: undefined_identifier
);

/// This would be part moved into OverReact lib somewhere. This is just a POC.
mixin UnstableUiPropsMixin on UiProps {
  dynamic get unstable {
    return UnstableUiPropsCallable(this);
  }

  /// This component is current "UNSTABLE", meaning the props API may change.
  /// In order to use this component you must use the `.unstable` property:
  /// ```dart
  ///   (ExampleComponent().unstable
  ///     ..someProp = 'whatever'
  ///   )();
  /// ```
  @override
  //@Deprecated('This component will not render anything until you use `MyComponent().unstable` eg. `(MyComponent().unstable..someProp = \'something\')()`')
  ReactElement call([covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c1, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c2 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c3 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c4 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c5 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c6 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c7 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c8 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c9 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c10 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c11 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c12 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c13 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c14 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c15 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c16 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c17 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c18 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c19 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c20 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c21 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c22 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c23 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c24 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c25 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c26 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c27 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c28 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c29 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c30 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c31 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c32 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c33 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c34 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c35 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c36 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c37 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c38 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c39 = _nope, covariant _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY c40 = _nope]) {
    window.console.error('${this} will not render anything until you use `${this}().unstable` eg. `(${this}().unstable..someProp = \'something\')()`');
    return null;
  }
}

const _nope = _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY();

// ignore: camel_case_types
class _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY {
  const _CANNOT_BE_USED_WITHOUT_UNSTABLE_PROPERTY();
}