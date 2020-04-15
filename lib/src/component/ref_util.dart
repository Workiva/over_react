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

import 'package:over_react/src/component_declaration/component_type_checking.dart';
import 'package:react/react_client/react_interop.dart' as react_interop;
import 'package:react/react_client.dart';
import 'package:over_react/component_base.dart';

/// Creates a [Ref] object that can be attached to a [ReactElement] via the ref prop.
///
/// __Example__:
///
///     UiFactory<BasicProps> Basic = _$Basic;
///
///     mixin BasicProps on UiProps {}
///
///     class BasicComponent extends UiComponent2<BasicProps> {
///       final Ref<InputElement> inputRef = createRef();
///
///       showInputCreateRefValue(_) {
///         print(inputRef.current.value);
///       }
///
///       @override
///       render() => Dom.div()(
///         (Dom.input()
///           ..ref = inputRef
///         )(),
///         (Dom.button()
///           ..onClick = showInputCreateRefValue
///         )('Click this button'),
///       );
///     }
///
/// Learn more: <https://reactjs.org/docs/refs-and-the-dom.html#creating-refs>.
Ref<T> createRef<T>() {
  return react_interop.createRef<T>();
}

/// Automatically passes a [Ref] through a component to one of its children.
///
/// > __NOTE:__ This should only be used to wrap components that extend from `Component2`.
///
/// __Example__:
///
///     UiFactory<DomProps> DivForwarded = forwardRef<DomProps>((props, ref) {
///       return (Dom.div()
///         ..ref = ref
///         ..className = 'special-class'
///       )(
///         props.children
///       );
///     })(Dom.div);
///
/// ___ OR ___
///
///     UiFactory<FooProps> FooForwarded = forwardRef<FooProps>((props, ref) {
///       return (Foo()
///         ..forwardedRef = ref
///       )();
///     })(Foo);
///
///     UiFactory<FooProps> Foo = _$Foo;
///
///     mixin FooProps on UiProps {
///       Ref forwardedRef;
///     }
///
///     @Component2()
///     class FooComponent extends UiComponent2<FooProps> {
///       @override
///       render() {
///         return (Dom.button()
///           ..ref = props.forwardedRef
///         )('Click this button');
///       }
///     }
///
/// Learn more: <https://reactjs.org/docs/forwarding-refs.html>.
UiFactory<TProps> Function(UiFactory<TProps>) forwardRef<TProps extends UiProps>(
    Function(TProps props, Ref ref) wrapperFunction) {

  UiFactory<TProps> wrapWithForwardRef(UiFactory<TProps> factory) {
    enforceMinimumComponentVersionFor(factory().componentFactory);

    Object wrapProps(Map props, Ref ref) {
      return wrapperFunction(factory(props), ref);
    }
    ReactComponentFactoryProxy hoc = react_interop.forwardRef(wrapProps);
    setComponentTypeMeta(hoc, isHoc: true, parentType: factory().componentFactory);

    TProps forwardedFactory([Map props]) {
      return factory(props)..componentFactory = hoc;
    }

    return forwardedFactory;
  }

  return wrapWithForwardRef;
}
