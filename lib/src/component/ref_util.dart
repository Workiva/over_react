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

import 'dart:js_util';

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

/// Automatically passes a [Ref] through a component to one of its children.
///
/// > __NOTE:__ This should only be used to wrap components that extend from `Component2`.
///
/// __Example 1:__ Forwarding refs to DOM components
///
/// ```dart
/// import 'dart:html';
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/react_dom.dart' as react_dom;
///
/// // ---------- Component Definition ----------
///
/// final FancyButton = forwardRef<DomProps>((props, ref) {
///   final classes = ClassNameBuilder.fromProps(props)
///     ..add('FancyButton');
///
///   return (Dom.button()
///     ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
///     ..className = classes.toClassName()
///     ..ref = ref
///   )('Click me!');
/// })(Dom.button);
///
/// // ---------- Component Consumption ----------
///
/// void main() {
///   final ref = createRef<Element>();
///
///   react_dom.render(
///       (FancyButton()
///         ..ref = ref
///         ..onClick = (_) {
///           print(ref.current.outerHtml);
///         }
///       )(),
///       querySelector('#idOfSomeNodeInTheDom')
///   );
///
///   // You can still get a ref directly to the DOM button:
///   final buttonNode = ref.current;
/// }
/// ```
///
/// __Example 2:__ Forwarding refs in higher-order components
///
/// ```dart
/// import 'dart:html';
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/react_dom.dart' as react_dom;
///
/// // ---------- Component Definitions ----------
///
/// final FancyButton = forwardRef<DomProps>((props, ref) {
///   final classes = ClassNameBuilder.fromProps(props)
///     ..add('FancyButton');
///
///   return (Dom.button()
///     ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
///     ..className = classes.toClassName()
///     ..ref = ref
///   )('Click me!');
/// })(Dom.button);
///
/// final LogProps = forwardRef<LogPropsProps>((props, ref) {
///   return (_LogProps()
///     ..addProps(props)
///     .._forwardedRef = ref
///   )('Click me!');
/// })(_LogProps);
///
/// UiFactory<LogPropsProps> _LogProps = _$_LogProps;
///
/// mixin LogPropsProps on UiProps {
///   BuilderOnlyUiFactory<DomProps> builder;
///
///   // Private since we only use this to pass along the value of `ref` to
///   // the return value of forwardRef.
///   //
///   // Consumers can set this private field value using the public `ref` setter.
///   Ref _forwardedRef;
/// }
///
/// class LogPropsComponent extends UiComponent2<LogPropsProps> {
///   @override
///   void componentDidUpdate(Map prevProps, _, [__]) {
///     print('old props: $prevProps');
///     print('new props: $props');
///   }
///
///   @override
///   render() {
///     return (props.builder()
///       ..modifyProps(addUnconsumedDomProps)
///       ..ref = props._forwardedRef
///     )(props.children);
///   }
/// }
///
/// // ---------- Component Consumption ----------
///
/// void main() {
///   setClientConfiguration();
///   final ref = createRef<Element>();
///
///   react_dom.render(
///       (LogProps()
///         ..builder = FancyButton
///         ..className = 'btn btn-primary'
///         ..ref = ref
///         ..onClick = (_) {
///           print(ref.current.outerHtml);
///         }
///       )(),
///       querySelector('#idOfSomeNodeInTheDom')
///   );
///
///   // You can still get a ref directly to the DOM button:
///   final buttonNode = ref.current;
/// }
/// ```
///
/// Learn more: <https://reactjs.org/docs/forwarding-refs.html>.
UiFactory<TProps> Function(UiFactory<TProps>) forwardRef<TProps extends UiProps>(
    Function(TProps props, Ref ref) wrapperFunction, {String displayName}) {

  UiFactory<TProps> wrapWithForwardRef(UiFactory<TProps> factory) {
    enforceMinimumComponentVersionFor(factory().componentFactory);
    
    if (displayName == null) {
      final componentFactoryType = factory().componentFactory.type;
      if (componentFactoryType is String) {
        // DomComponent
        displayName = componentFactoryType;
      } else if (componentFactoryType is Function) {
        // JS component factories, Dart function components, Dart composite components
        displayName = getProperty(componentFactoryType, 'displayName');

        if (displayName == null) {
          final ctor = getProperty(componentFactoryType, 'constructor');
          displayName = (ctor == null ? null : getProperty(ctor, 'name')) ?? 'Anonymous';
        }
      }
    }
    
    Object wrapProps(Map props, Ref ref) {
      return wrapperFunction(factory(props), ref);
    }
    ReactComponentFactoryProxy hoc = react_interop.forwardRef(wrapProps, displayName: displayName);
    setComponentTypeMeta(hoc, isHoc: true, parentType: factory().componentFactory);

    TProps forwardedFactory([Map props]) {
      return factory(props)..componentFactory = hoc;
    }

    return forwardedFactory;
  }

  return wrapWithForwardRef;
}

/// Automatically passes a [Ref] through a component to one of its children.
///
/// > __NOTE:__ This should only be used to wrap components that extend from `Component2`
/// > or components using the function syntax.
///
/// __Example 1:__ Forwarding refs to DOM components
///
/// ```dart
/// import 'dart:html';
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/react_dom.dart' as react_dom;
///
/// // ---------- Component Definition ----------
///
/// final FancyButton = uiForwardRef<DomProps>((props, ref) {
///     final classes = ClassNameBuilder.fromProps(props)..add('FancyButton');
///
///     return (Dom.button()
///       ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
///       ..className = classes.toClassName()
///       ..ref = ref
///     )('Click me!');
///   },
///   Dom.button.asForwardRefConfig<DomProps>(displayName: 'FancyButton'),
/// );
///
/// // ---------- Component Consumption ----------
///
/// void main() {
///   final ref = createRef<Element>();
///
///   react_dom.render(
///       (FancyButton()
///         ..ref = ref
///         ..onClick = (_) {
///           print(ref.current.outerHtml);
///         }
///       )(),
///       querySelector('#idOfSomeNodeInTheDom')
///   );
///
///   // You can still get a ref directly to the DOM button:
///   final buttonNode = ref.current;
/// }
/// ```
///
/// __Example 2:__ Forwarding refs in higher-order (non-function) components
///
/// ```dart
/// import 'dart:html';
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/react_dom.dart' as react_dom;
///
/// // ---------- Component Definitions ----------
///
/// final FancyButton = uiForwardRef<DomProps>((props, ref) {
///     final classes = ClassNameBuilder.fromProps(props)..add('FancyButton');
///
///     return (Dom.button()
///       ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
///       ..className = classes.toClassName()
///       ..ref = ref
///     )('Click me!');
///   },
///   Dom.button.asForwardRefConfig<DomProps>(displayName: 'FancyButton'),
/// );
///
/// // ---------- Wrapping a Class Component ----------
/// // Here you have two options:
/// //   - Option 1: Use the class component's UI Factory to construct a function
/// //   component config. This needs to be done because the builder recognizes
/// //   `LogPropsProps` as already consumed (by the class component).
/// //
/// //   - Option 2: Create a new props class. This just works around the issue
/// //   described for Option 1 because it is creating a new props class, but it
/// //   only needs to mixin in the props mixins that the original props class used.
/// //
/// // Choosing between the options is likely circumstantial or at least preferential
/// // if all else is the same. The advantage to Option 1 is that if the class component
/// // has numerous mixins, it is much more concise to create the function component
/// // config. Option 2 has the benefit that it matches the declaration of standard
/// // function components (which `uiForwardRef` returns). Additionally, Option 2
/// // illustrates how one could add additional props to the wrapping function component.
///
/// // Option 1 Example
/// final LogsPropsComponent = uiForwardRef<LogPropsProps>((props, ref) {
///     return (_LogProps()
///       ..addProps(props)
///       .._forwardedRef = ref)();
///   },
///   _LogProps.asForwardRefConfig<LogPropsProps>(displayName: 'LogsProps'),
/// );
///
/// // Option 2 Example:
///
/// // This is not necessary but is just in place to illustrate that more props
/// // can be specified and consumed.
/// mixin AnotherPropsMixin on UiProps {
///   String anExampleAdditionalProp;
/// }
///
/// class LogsPropsComponent2Props = UiProps with AnotherPropsMixin, LogPropsProps;
///
/// final LogsPropsComponent2 = uiForwardRef<LogsPropsComponent2Props>((props, ref) {
///     useEffect(() {
///       print(props.anExampleAdditionalProp);
///     });
///
///     return (_LogProps()
///       ..addProps(props)
///       .._forwardedRef = ref)();
///   },
///   $LogsPropsComponent2Config
/// );
///
/// UiFactory<LogPropsProps> _LogProps = _$_LogProps;
///
/// mixin LogPropsProps on UiProps {
///   BuilderOnlyUiFactory<DomProps> builder;
///
///   // Private since we only use this to pass along the value of `ref` to
///   // the return value of forwardRef.
///   //
///   // Consumers can set this private field value using the public `ref` setter.
///   Ref _forwardedRef;
/// }
///
/// class LogPropsComponent extends UiComponent2<LogPropsProps> {
///   @override
///   void componentDidUpdate(Map prevProps, _, [__]) {
///     print('old props: $prevProps');
///     print('new props: $props');
///   }
///
///   @override
///   render() {
///     return (props.builder()
///       ..modifyProps(addUnconsumedDomProps)
///       ..ref = props._forwardedRef
///     )(props.children);
///   }
/// }
///
/// // ---------- Component Consumption ----------
///
/// void main() {
///   final ref = createRef<Element>();
///
///   react_dom.render(
///       (LogProps()
///         ..builder = FancyButton
///         ..className = 'btn btn-primary'
///         ..ref = ref
///         ..onClick = (_) {
///           print(ref.current.outerHtml);
///         }
///       )(),
///       querySelector('#idOfSomeNodeInTheDom')
///   );
///
///   // You can still get a ref directly to the DOM button:
///   final buttonNode = ref.current;
/// }
/// ```
///
/// __Example 3:__ Forwarding refs in higher-order (all function) components
///
/// ```dart
/// import 'dart:html';
/// import 'package:over_react/over_react.dart';
/// import 'package:over_react/react_dom.dart' as react_dom;
/// import 'package:react/hooks.dart';
///
/// // ---------- Component Definitions ----------
///
/// final FancyButton = uiForwardRef<DomProps>((props, ref) {
///     final classes = ClassNameBuilder.fromProps(props)..add('FancyButton');
///
///     return (Dom.button()
///       ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
///       ..className = classes.toClassName()
///       ..ref = ref
///     )('Click me!');
///   },
///   Dom.button.asForwardRefConfig<DomProps>(displayName: 'FancyButton'),
/// );
///
/// mixin LogPropsProps on UiProps {
///   BuilderOnlyUiFactory<DomProps> builder;
/// }
///
/// final LogProps = uiForwardRef<LogPropsProps>(
///   (props, ref) {
///     final prevPropsRef = useRef<LogPropsProps>(null);
///
///     useEffect(() {
///       if (prevPropsRef.current != null) {
///         print('old props: ${prevPropsRef.current}');
///         print('new props: $props');
///       }
///
///       prevPropsRef.current = props;
///     });
///
///     return ((props.builder()
///       ..addProps(getPropsToForward(props, onlyCopyDomProps: true))
///       ..ref = ref)(props.children));
///   },
///   $LogPropsConfig, // ignore: undefined_identifier
/// );
///
/// // ---------- Component Consumption ----------
///
/// void main() {
///   final ref = createRef<Element>();
///
///   react_dom.render(
///       (LogProps()
///         ..builder = FancyButton
///         ..className = 'btn btn-primary'
///         ..ref = ref
///         ..onClick = (_) {
///           print(ref.current.outerHtml);
///         }
///       )(),
///       querySelector('#idOfSomeNodeInTheDom')
///   );
///
///   // You can still get a ref directly to the DOM button:
///   final buttonNode = ref.current;
/// }
/// ```
///
/// Learn more: <https://reactjs.org/docs/forwarding-refs.html>.
UiFactory<TProps> uiForwardRef<TProps extends bh.UiProps>(
    dynamic Function(TProps props, dynamic ref) functionComponent,
    FunctionComponentConfig<TProps> config) {
  ArgumentError.checkNotNull(config, 'config');

  // ignore: invalid_use_of_protected_member
  var propsFactory = config.propsFactory;

  // Get the display name from the inner function if possible so it doesn't become `_uiFunctionWrapper`
  final displayName = config.displayName ?? getFunctionName(functionComponent);

  dynamic _uiFunctionWrapper(dynamic props, dynamic ref) {
    return functionComponent(propsFactory.jsMap(props), ref);
  }

  ReactJsComponentFactoryProxy factory;

  // If a consumer uses `asForwardRefConfig` to generate the function component
  // config, displayName could be `null`.
  if (displayName != null && displayName.trim().isNotEmpty) {
    factory = react_interop.forwardRef(_uiFunctionWrapper, displayName: displayName);
  } else {
    factory = react_interop.forwardRef(_uiFunctionWrapper);
  }

  if (propsFactory == null) {
    if (TProps != UiProps && TProps != GenericUiProps) {
      throw ArgumentError(
          'config.propsFactory must be provided when using custom props classes');
    }
    propsFactory = PropsFactory.fromUiFactory(
            ([backingMap]) => GenericUiProps(factory, backingMap))
    as PropsFactory<TProps>;
  }

  TProps _uiFactory([Map backingMap]) {
    TProps builder;
    if (backingMap == null) {
      builder = propsFactory.jsMap(JsBackedMap());
    } else if (backingMap is JsBackedMap) {
      builder = propsFactory.jsMap(backingMap);
    } else {
      builder = propsFactory.map(backingMap);
    }

    return builder..componentFactory = factory;
  }

  return _uiFactory;
}
