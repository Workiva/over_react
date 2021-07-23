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
import 'package:over_react/src/component_declaration/function_component.dart';
import 'package:over_react/src/component_declaration/builder_helpers.dart' as bh;
import 'package:react/react_client/js_backed_map.dart';
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

/// Creates a function component capable of forwarding its ref to
/// a component it renders.
///
/// Learn more: <https://reactjs.org/docs/forwarding-refs.html>.
///
/// [_config] should always be a `UiFactoryConfig<TProps>` and is only `dynamic` to
/// avoid an unnecessary cast in the boilerplate.
///
/// ### Example 1: Updating a function component to forward a ref:
///
/// _This example mirrors the JS example in the link above._
///
/// Consider a `FancyButton` function component that renders the native button DOM element:
/// ```dart
/// mixin FancyButtonProps on UiProps {}
///
/// UiFactory<FancyButtonProps> FancyButton = uiFunction(
///   (props) {
///     return (Dom.button()
///       ..className = 'FancyButton'
///     )(props.children);
///   },
///   _$FancyButtonConfig, // ignore: undefined_identifier
/// );
/// ```
///
/// Normally, you can't set a ref on function components, but if you change
/// [uiFunction] to `uiForwardRef`, you'll get a new `ref` argument that will be
/// populate with any ref set on `FancyButton`. We This ref can then be
/// "forwarded" to some other component.
///
/// ```dart
/// mixin FancyButtonProps on UiProps {}
///
/// UiFactory<FancyButtonProps> FancyButton = uiForwardRef(
///   (props, ref) {
///     return (Dom.button()
///       ..ref = ref
///       ..className = 'FancyButton'
///     )(props.children);
///   },
///   _$FancyButtonConfig, // ignore: undefined_identifier
/// );
///
/// usageExample() {
///   // You can now get a ref directly to the DOM button:
///   final ref = createRef<ButtonElement>();
///   return (FancyButton()..ref = ref)();
/// }
/// ```
///
/// ### Example 2: Creating a [higher-order component](https://reactjs.org/docs/higher-order-components.html)
/// that forwards its ref to the wrapped component.
///
/// ```dart
/// /// Wraps a component ([factoryToWrap]) in a new component that logs when rendered.
/// UiFactory<TProps> withLogging<TProps extends UiProps>(UiFactory<TProps> factoryToWrap) {
///   return uiForwardRef(
///     (props, ref) {
///       useEffect(() => '${factoryToWrap().componentFactory.type} rendered!');
///
///       // ignore statement addresses analyzer bug with this syntax (https://github.com/dart-lang/sdk/issues/42975)
///       // ignore: invocation_of_non_function_expression
///       return (factoryToWrap()
///         ..addAll(props)
///         ..ref = ref
///       )(props.children);
///     },
///     factoryToBeWrapped.asForwardRefConfig(
///       displayName: 'WithLogging',
///     ),
///   );
/// }
///
/// UiFactory<FancyButtonProps> FancyButton = ...;
///
/// /// This can be used just like FancyButton, and setting a ref on it will work the same!
/// UiFactory<FancyButtonProps> FancyButtonWithLogging = withLogging(FancyButton);
/// ```
///
/// ### Example 3: Exposing inner refs in class components
///
/// While it's usually easier to pass `uiForwardRef`'s `ref` argument directly
/// to the desired component, sometimes it's nested within a class component
/// that can't forward refs itself, and it's non-trivial to update that class
/// component to a function component.
///
/// In this case, you can pass the ref to the class component as a custom prop,
/// and have the class component forward it to the right location.
///
/// Here, we'll make our class component factory private and only expose a
/// version wrapped in `uiForwardRef`:
///
/// ```dart
/// UiFactory<FooProps> _Foo = _$_Foo; // ignore: undefined_identifier
/// mixin FooProps on UiProps {
///   // Private since we only use this to pass along the ref provided in
///   // uiForwardRef.
///   //
///   // Consumers will effectively be setting this when they set `ref` on the public factory.
///   dynamic _inputRef;
/// }
/// class FooComponent extends UiComponent2<FooProps> {
///   @override
///   render() {
///     return Dom.div()(
///       (Dom.input()
///         ..type = 'text'
///         ..ref = props._inputRef
///       )()
///     );
///   }
/// }
///
/// // ---------- Wrapping a Class Component ----------
/// // Here you have two options:
/// //   - Option 1: Use the class component's factory as the UiFactoryConfig arg.
/// //   This needs to be done because the builder recognizes
/// //   `FooProps` as already consumed (by the class component).
/// //
/// //   - Option 2: Create a new props class. This just works around the issue
/// //   described for Option 1 because it is creating a new props class, but it
/// //   only needs to mix in the props mixins that the original props class used.
/// //
/// // Choosing between the options is likely circumstantial or preferential.
/// // The advantage to Option 1 is that if the class component has numerous mixins,
/// // it is much more concise to create the function component config.
/// // Option 2 has the benefit that it matches the declaration of standard
/// // function components (which `uiForwardRef` returns). Additionally, Option 2
/// // illustrates how one could add additional props to the wrapped function component.
///
/// //
/// // Option 1 Example
/// UiFactory<FooProps> Foo = uiForwardRef((props, ref) {
///     return (_Foo()
///       ..addProps(props)
///       .._inputRef = ref
///     )();
///   },
///   _Foo.asForwardRefConfig(displayName: 'Foo'),
/// );
///
/// //
/// // Option 2 Example:
///
/// // This is not necessary but is just in place to illustrate that more props
/// // can be specified and consumed.
/// mixin AnotherPropsMixin on UiProps {
///   String anExampleAdditionalProp;
/// }
///
/// class Foo2Props = UiProps with AnotherPropsMixin, FooProps;
/// UiFactory<Foo2Props> Foo2 = uiForwardRef((props, ref) {
///     print(props.anExampleAdditionalProp);
///
///     return (_Foo()
///       ..addProps(props)
///       .._inputRef = ref
///     )();
///   },
///   _$Foo2Config, // ignore: undefined_identifier
/// );
UiFactory<TProps> uiForwardRef<TProps extends bh.UiProps>(
    dynamic Function(TProps props, dynamic ref) functionComponent, dynamic _config) {
  ArgumentError.checkNotNull(_config, '_config');

  if (_config is! UiFactoryConfig<TProps>) {
    throw ArgumentError('_config should be a UiFactory<TProps>. Make sure you are '
        r'using either the generated factory config (i.e. _$FooConfig) or manually '
        'declaring your config correctly.');
  }

  final config = _config;

  // ignore: invalid_use_of_protected_member
  var propsFactory = config.propsFactory;

  // Get the display name from the inner function if possible so it doesn't become `_uiFunctionWrapper`.
  // If the function is an anonymous function and a display name is not set,
  // this will be an empty string.
  final displayName = config.displayName ?? getFunctionName(functionComponent);

  dynamic _uiFunctionWrapper(JsBackedMap props, dynamic ref) {
    return functionComponent(propsFactory!.jsMap(props), ref);
  }

  // Always pass displayName, even if it's empty,
  // since we don't want forwardRef2 to use _uiFunctionWrapper as the name.
  final factory =
      react_interop.forwardRef2(_uiFunctionWrapper, displayName: displayName);

  if (propsFactory == null) {
    if (TProps != UiProps && TProps != GenericUiProps) {
      throw ArgumentError('config.propsFactory must be provided when using custom props classes');
    }
    propsFactory = PropsFactory.fromUiFactory(([backingMap]) => GenericUiProps(factory, backingMap))
        as PropsFactory<TProps>;
  }

  TProps _uiFactory([Map? backingMap]) {
    TProps builder;
    if (backingMap == null) {
      builder = propsFactory!.jsMap(JsBackedMap());
    } else if (backingMap is JsBackedMap) {
      builder = propsFactory!.jsMap(backingMap);
    } else {
      builder = propsFactory!.map(backingMap);
    }

    return builder..componentFactory = factory;
  }

  registerComponentTypeAlias(factory, _uiFactory);

  return _uiFactory;
}
