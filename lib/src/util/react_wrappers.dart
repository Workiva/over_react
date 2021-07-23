// Copyright 2016 Workiva Inc.
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
library over_react.react_wrappers;

import 'dart:collection';
import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/component_type_checking.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/js_interop_helpers.dart' show jsifyAndAllowInterop;
import 'package:react/react_client/react_interop.dart' hide createRef;
import 'package:react/react_dom.dart' as react_dom;

// Notes
// ---------------------------------------------------------------------------
//
// 1.  This is of type `dynamic` out of necessity, since the actual type,
//     `ReactComponent | Element`, cannot be expressed in Dart's type system.
//
//     React 0.14 augments DOM nodes with its own properties and uses them as
//     DOM component instances. To Dart's JS interop, those instances look
//     like DOM nodes, so they get converted to the corresponding DOM node
//     interceptors, and thus cannot be used with a custom `@JS()` class.
//
//     So, React composite component instances will be of type
//     `ReactComponent`, whereas DOM component instance will be of type
//     `Element`.

/// Returns internal data structure used by react-dart to maintain the native Dart component
/// for a given react-dart [ReactElement] or [ReactComponent] [instance].
// ignore: deprecated_member_use
ReactDartComponentInternal _getInternal(/* ReactElement|ReactComponent */ instance) =>
    // ignore: deprecated_member_use
    (instance.props as InteropProps).internal;

/// Returns the internal representation of a Dart component's props as maintained by react-dart.
///
/// Similar to `ReactElement.props` in JS, but also includes `props.children`.
Map? _getExtendedProps(/* ReactElement|ReactComponent */ instance) {
  return _getInternal(instance).props;
}

/// Returns the [ReactElement.key] associated with the specified [instance].
dynamic getInstanceKey(ReactElement instance) => instance.key;

/// Returns the [ReactElement.ref] associated with the specified [instance].
dynamic getInstanceRef(ReactElement instance) => instance.ref;

/// Returns whether an [instance] is a native Dart component (a react-dart [ReactElement] or [ReactComponent]).
bool isDartComponent(Object?/* ReactElement|ReactComponent|Element */ instance) {
  return instance != null && _getDartComponentVersionFromInstance(instance) != null;
}

/// Returns [ReactClass.dartComponentVersion] if [instance] is a Dart component
/// (react-dart [ReactElement] or [ReactComponent]), and null for other types of components.
///
/// [instance] may not be null.
String? _getDartComponentVersionFromInstance(Object/* ReactElement|ReactComponent|Element */ instance) {
  // Don't try to access these properties on a DOM component
  if (instance is Element) {
    return null;
  }

  // We need `type` if it's a ReactElement, or `constructor` if it's a `ReactComponent`.
  final type = getProperty(instance, 'type') ?? getProperty(instance, 'constructor');
  // ignore: invalid_use_of_protected_member
  return ReactDartComponentVersion.fromType(type);
}

/// Whether [Expando]s can be used on [ReactElement]s.
///
/// At the time this was written, this should return:
///
/// - `true` for dart2js and Dart VM
/// - `false` for DDC
final bool _canUseExpandoOnReactElement = (() {
  var expando = Expando<bool>('_canUseExpandoOnReactElement test');
  var reactElement = react.div({}) as ReactElement;

  try {
    expando[reactElement] = true;
  } catch (_) {
    return false;
  }

  return true;
})();

/// A cache of props for a given [ReactElement].
///
/// If caching isn't possible due to [_canUseExpandoOnReactElement] being false,
/// then this will be initialized to `null`, and caching will be disabled.
final Expando<Map>? _elementPropsCache = _canUseExpandoOnReactElement
    ? Expando<Map>('_elementPropsCache')
    : null;

/// Returns an unmodifiable Map view of props for a [ReactElement] or composite [ReactComponent] [instance].
///
/// For a native Dart component, this returns its [react.Component.props] in an unmodifiable Map view.
/// For a JS component, this returns the result of [unconvertJsProps] in an unmodifiable Map view.
///
/// If [traverseWrappers] is `true` then it will return an unmodifiable Map view of props of the first non-"Wrapper"
/// instance.
///
/// Throws if [instance] is not a valid [ReactElement] or composite [ReactComponent] .
Map getProps(Object/* ReactElement|ReactComponent */ instance, {bool traverseWrappers = false}) {
  var isCompositeComponent = _isCompositeComponent(instance);

  if (isValidElement(instance) || isCompositeComponent) {
    if (traverseWrappers) {
      ComponentTypeMeta instanceTypeMeta;

      if (isCompositeComponent && isDartComponent(instance)) {
        final type = getProperty((getDartComponent(instance)!.jsThis as Object?)!, 'constructor') as ReactClass?;
        instanceTypeMeta = getComponentTypeMeta(type!);
      } else if (isValidElement(instance)) {
        instanceTypeMeta = getComponentTypeMeta(((instance as dynamic).type as Object?)!);
      } else {
        throw ArgumentError.value(instance, 'instance',
            'must either be a Dart component ReactComponent or ReactElement when traverseWrappers is true.');
      }

      if (instanceTypeMeta.isWrapper) {
        assert(isDartComponent(instance) && 'Non-dart components should not be wrappers' is String);

        final children = getProps(instance)['children'] as List?;

        if (children != null && children.isNotEmpty && isValidElement(children.first)) {
          return getProps(children.first as Object, traverseWrappers: true);
        }
      }
    }

    if (_elementPropsCache != null && !isCompositeComponent) {
      var cachedView = _elementPropsCache![instance];
      if (cachedView != null) return cachedView;
    }

    Map rawPropsOrCopy;

    final dartComponentVersion = _getDartComponentVersionFromInstance(instance);
    if (dartComponentVersion == ReactDartComponentVersion.component) { // ignore: invalid_use_of_protected_member
      rawPropsOrCopy = _getExtendedProps(instance)!;
    } else if (dartComponentVersion == ReactDartComponentVersion.component2) { // ignore: invalid_use_of_protected_member
      // TODO Since JS props are frozen don't wrap in UnmodifiableMapView once https://github.com/dart-lang/sdk/issues/15432 is fixed
      rawPropsOrCopy = JsBackedMap.backedBy((instance as dynamic).props as JsMap);
    } else {
      rawPropsOrCopy = unconvertJsProps(instance);
    }

    final unmodifiableProps = UnmodifiableMapView(rawPropsOrCopy);
    if (_elementPropsCache != null && !isCompositeComponent) {
      _elementPropsCache![instance] = unmodifiableProps;
    }

    return unmodifiableProps;
  }

  throw ArgumentError.value(instance, 'instance', 'must be a valid ReactElement or composite ReactComponent');
}

/// Returns the DOM node associated with a mounted React component [instance],
/// which can be a [ReactComponent]/[Element] or [react.Component2].
///
/// This method simply wraps react.findDOMNode with strong typing for the return value
/// (and for the function itself, which is declared using `var` in react-dart).
Element? findDomNode(dynamic instance) => react_dom.findDOMNode(instance) as Element?;

/// Returns a portal that renders [children] into a [container].
///
/// Portals provide a first-class way to render children into a DOM node that exists outside the DOM hierarchy of the parent component.
///
/// [children] can be any renderable React child, such as a [ReactElement], [String], or fragment.
///
/// See: <https://reactjs.org/docs/portals.html>
ReactPortal createPortal(dynamic children, Element container) => ReactDom.createPortal(children, container);

/// Dart wrapper for React.isValidElement.
///
/// _From the JS docs:_
/// > Verifies the [object] is a ReactElement
bool isValidElement(dynamic object) {
  return React.isValidElement(object);
}

/// Returns whether [instance] is a ReactElement for a DOM node.
bool isDomElement(dynamic instance) {
  return isValidElement(instance) &&
      (instance as ReactElement).type is String; // ignore: avoid_as
}

/// Returns whether [instance] is a composite [ReactComponent].
///
/// __Not for external use.__
bool _isCompositeComponent(Object? instance) {
  return instance != null && getProperty(instance, 'isReactComponent') != null;
}

/// Returns a new JS map with the specified props and children changes, properly prepared for consumption by
/// React JS methods such as `cloneElement`, `setProps`, and other methods that accept changesets of props to be
/// merged into existing props.
///
/// Handles both Dart and JS React components, returning the appropriate props structure for each type:
///
/// * For non-[react.Component2] Dart components, existing props are read from `InteropProps.internal`, which are then merged with
///   the new [newProps] and saved in a new [InteropProps] with the expected `ReactDartComponentInternal` structure.
/// * For [react.Component2] Dart components, [newProps] is passed through [ReactDartComponentFactoryProxy2.generateExtendedJsProps]
///   and then passed to React JS, which will merge the props normally.
/// * Children are likewise copied and potentially overwritten with [newChildren] as expected.
/// * For JS components, a JS copy of [newProps] is returned, since React will merge the props without any special handling.
///   If these values might contain event handlers
dynamic preparePropsChangeset(ReactElement element, Map? newProps, [Iterable? newChildren]) {
  final type = element.type;
  final dartComponentVersion = ReactDartComponentVersion.fromType(type); // ignore: invalid_use_of_protected_member

  // react.Component
  if (dartComponentVersion == ReactDartComponentVersion.component) { // ignore: invalid_use_of_protected_member
    Map oldExtendedProps = _getInternal(element).props!;

    Map extendedProps = Map.from(oldExtendedProps);
    if (newProps != null) {
      extendedProps.addAll(newProps);
    }

    // ignore: deprecated_member_use
    return ReactDartComponentFactoryProxy.generateExtendedJsProps(extendedProps, newChildren ?? extendedProps['children']);
  }

  if (newProps == null) {
    // Only pre-Component2 Dart components need changesets if props aren't null,
    // since the new children need to be stored on the props.internal.
    // Otherwise, we can pass `null` straight through to React.
    return null;
  }

  // react.Component2
  if (dartComponentVersion == ReactDartComponentVersion.component2) { // ignore: invalid_use_of_protected_member
    return ReactDartComponentFactoryProxy2.generateExtendedJsProps(newProps);
  }

  // DOM component
  if (type is String) {
    // Convert props for DOM components so that style Maps and event handlers
    // originating from Dart are properly converted.
    final convertedProps = Map.from(newProps);
    ReactDomComponentFactoryProxy.convertProps(convertedProps);
    return jsifyAndAllowInterop(convertedProps);
  }

  // JS Component
  return jsifyAndAllowInterop(newProps);
}

@JS('React.cloneElement')
external ReactElement _cloneElement(element, [props, children]);

/// Dart wrapper for React.cloneElement.
///
/// _From the JS docs:_
/// > Clone and return a new ReactElement using element as the starting point.
/// > The resulting element will have the original element's props with the new props merged in shallowly.
/// > New children will replace existing children.
/// > Unlike React.addons.cloneWithProps, key and ref from the original element will be preserved.
/// > There is no special behavior for merging any props (unlike cloneWithProps).
/// > See the [v0.13 RC2 blog post](https://facebook.github.io/react/blog/2015/03/03/react-v0.13-rc2.html) for additional details.
ReactElement cloneElement(ReactElement? element, [Map? props, Iterable? children]) {
  if (element == null) throw ArgumentError.notNull('element');

  var propsChangeset = preparePropsChangeset(element, props, children);

  if (children != null) {
    return _cloneElement(element, propsChangeset, children);
  } else {
    return _cloneElement(element, propsChangeset);
  }
}

/// Returns the native Dart component associated with a mounted component [instance].
///
/// Returns `null` if the [instance] is not Dart-based _(an [Element] or a JS composite component)_.
// ignore: deprecated_member_use
T? getDartComponent<T extends react.Component?>(Object /* ReactElement|ReactComponent|Element */ instance) {
  if (instance is Element) {
    return null;
  }

  bool instanceIsMounted() {
    if (isValidElement(instance)) {
      // `print` instead of `ValidationUtil.warn` so that this message shows up
      // in the test output when running `ddev test`.
      print(unindent(
          '''
          * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
          * WARNING: `getDartComponent`
          *
          * react-dart 4.0 no longer supports retrieving Dart components from
          * `ReactElement` (pre-mounted VDOM instances) in order to prevent memory leaks.
          *
          * This call to `getDartComponent` will return `null`.
          *
          * Start using the mounted JS component instance instead:
          *
          * Example:
          *     // Before
          *     var vdom = Button()('Click me');
          *     react_dom.render(vdom, mountNode);
          *     var dartInstance = getDartComponent(vdom);
          *
          *     // Fixed
          *     var vdom = Button()('Click me');
          *     var jsInstance = react_dom.render(vdom, mountNode);
          *     var dartInstance = getDartComponent(jsInstance);
          *
          * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
          '''
      ));
    }
    return true;
  }

  assert(instanceIsMounted());

  return (instance as ReactComponent).dartComponent as T?;
}

/// A function that, when supplied as [ReactPropsMixin.ref], is called with the component instance
/// as soon as it is mounted.
///
/// This instance can be used to retrieve a component's DOM node or to call a component's public API methods.
///
/// The component instance will be of the type:
///
///   * [react.Component2] for Dart components
///   * [ReactComponent] for JS composite components
///   * [Element] for DOM components
///
/// __Example:__
///
///     FooComponent _fooRef;
///
///     render() {
///       return (Foo()
///         ..ref = (ref) { _fooRef = ref; }
///       )();
///     }
///
///     barTheFoo() => _fooRef.bar();
///
///     getFooNode() => findDomNode(_fooRef);
///
/// See: <http://facebook.github.io/react/docs/more-about-refs.html#the-ref-callback-attribute>.
typedef CallbackRef(ref); // ignore: prefer_generic_function_type_aliases

/// Returns a function that chains the callback or [createRef]-based ref of the provided [element]
/// with [newCallbackRef].
///
/// If there is no existing ref, [newCallbackRef] is used.
///
/// Throws an [ArgumentError] if [ReactElement.ref] is a String ref.
///
/// TODO: This method makes assumptions about how react-dart does callback refs for dart components, so this method should be moved there (UIP-1118).
CallbackRef? chainRef(ReactElement element, CallbackRef? newCallbackRef) {
  final existingRef = element.ref as Object?;

  // If there's no existing ref, just return the new one.
  if (existingRef == null) return newCallbackRef;

  if (existingRef is String) {
    throw ArgumentError.value(existingRef, 'element.ref',
        'The existing ref is a String ref and cannot be chained');
  }

  if (existingRef is Function) { // Callback refs
    void chainedRef(ref) {
      // For Dart components, the existing ref is a function passed to the JS that wraps the Dart
      // callback ref and converts the JS instance to the Dart component.
      // So, we need to undo the wrapping around this chained ref and pass in the JS instance.
      existingRef(ref is react.Component ? ref.jsThis : ref); // ignore: deprecated_member_use

      if (newCallbackRef != null) newCallbackRef(ref);
    }

    return chainedRef;
  } else { // Assume it's a ref object created by createRef
    assert(existingRef is! Ref,
        'should be a JsRef; the factory that created `element` should never let a Dart ref get here');
    void chainedRef(ref) {
      // For Dart components, the existing ref is a Dart Ref object that converts
      // the JS instance on the JS ref to the Dart component.
      // So, we need to undo the wrapping around this chained ref and pass in the JS instance.
      //
      // Update `.current` manually on the ref object.
      // As per https://github.com/facebook/react/issues/13029 it should be fine to set current this way.
      // Use setProperty so we don't have to expose a `JsRef.current` setter, which could be misused.
      setProperty(existingRef, 'current', ref is react.Component ? ref.jsThis : ref); // ignore: deprecated_member_use

      if (newCallbackRef != null) newCallbackRef(ref);
    }

    return chainedRef;
  }
}

// React Dev tools

@JS('window.eval')
external dynamic _eval(String source);

@JS('_getR')
external ReactElement _jsGetR();

/// A function that returns `window.$r` from the JS.
///
/// Used instead of a `@JS()` function due to this issue: <https://github.com/dart-lang/sdk/issues/26718>
final Function _get$R = () {
  _eval(r'window._getR = function() {return $r;};');
  return _jsGetR;
}();

/// Returns a reference to the currently selected component in the
/// [React Dev Tools](https://github.com/facebook/react-devtools).
///
/// Returns the associated [ReactComponent.dartComponent] for Dart components or the [ReactComponent]
/// for JS components.
///
/// To use in Dartium, over_react must be imported in the current context.
dynamic get $r {
  var component = _get$R();

  return isDartComponent(component)
      // ignore: avoid_as
      ? (component as ReactComponent).dartComponent
      : component;
}
