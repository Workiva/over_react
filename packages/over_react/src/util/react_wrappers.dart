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

import 'package:js/js.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart';
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
ReactDartComponentInternal _getInternal(/* ReactElement|ReactComponent */  instance) =>
    (instance.props as InteropProps).internal; // ignore: avoid_as

/// Returns the internal representation of a Dart component's props as maintained by react-dart.
///
/// Similar to ReactElement.props in JS, but also includes `children`.
Map _getExtendedProps(/* ReactElement|ReactComponent */  instance) {
  return _getInternal(instance).props;
}

/// Returns 'key' associated with the specified React instance.
dynamic getInstanceKey(ReactElement instance) {
  return instance.key;
}

/// Returns 'ref' associated with the specified React instance.
dynamic getInstanceRef(ReactElement instance) {
  return instance.ref;
}

/// Returns whether a component is a native Dart component (react-dart [ReactElement] or [ReactComponent]).
bool isDartComponent(/* [1] */ instance) {
  // Don't try to access internal on a DOM component
  if (instance is Element) {
    return false;
  }

  return _getInternal(instance) != null;
}

@JS('Object.keys')
external Iterable _objectKeys(object);

/// Returns a Dart Map copy of the JS property key-value pairs in [jsMap].
Map _dartifyJsMap(jsMap) {
  return new Map.fromIterable(_objectKeys(jsMap),
      value: (key) => getProperty(jsMap, key)
  );
}

/// Returns the props for a [ReactElement] or composite [ReactComponent] [instance],
/// shallow-converted to a Dart Map for convenience.
///
/// If `style` is specified in props, then it too is shallow-converted and included
/// in the returned Map.
Map getJsProps(/* ReactElement|ReactComponent */ instance) {
  var props = _dartifyJsMap(instance.props);

  // Convert the nested style map so it can be read by Dart code.
  var style = props['style'];
  if (style != null) {
    props['style'] = _dartifyJsMap(style);
  }

  return props;
}

/// Returns an unmodifiable Map view of props for a [ReactElement] or composite [ReactComponent] [instance].
///
/// For a native Dart component, this returns its [react.Component.props] in an unmodifiable Map view.
/// For a JS component, this returns the result of [getJsProps] in an unmodifiable Map view.
///
/// Throws if [instance] is not a valid [ReactElement] or composite [ReactComponent] .
Map getProps(/* ReactElement|ReactComponent */ instance) {
  if (isValidElement(instance) || _isCompositeComponent(instance)) {
    var propsMap = isDartComponent(instance) ? _getExtendedProps(instance) : getJsProps(instance);
    return new UnmodifiableMapView(propsMap);
  }

  throw new ArgumentError.value(instance, 'instance', 'must be a valid ReactElement or composite ReactComponent');
}

/// Returns the DOM node associated with a mounted React component [instance],
/// which can be a [ReactComponent]/[Element] or [react.Component].
///
/// This method simply wraps react.findDOMNode with strong typing for the return value
/// (and for the function itself, which is declared using `var` in react-dart).
Element findDomNode(dynamic instance) => react_dom.findDOMNode(instance);

/// Dart wrapper for React.isValidElement.
///
/// _From the JS docs:_
/// > Verifies the object is a ReactElement
bool isValidElement(dynamic object) {
  return React.isValidElement(object);
}

/// Returns whether [instance] is a ReactElement for a DOM node.
bool isDomElement(dynamic instance) {
  return isValidElement(instance) && (instance as ReactElement).type is String; // ignore: avoid_as
}

/// Returns whether [instance] is a composite [ReactComponent].
///
/// __Not for external use.__
bool _isCompositeComponent(dynamic object) {
  return object != null && getProperty(object, 'isReactComponent') != null;
}

/// Returns a new JS map with the specified props and children changes, properly prepared for consumption by
/// React JS methods such as cloneWithProps(), setProps(), and other methods that accept changesets of props to be
/// merged into existing props.
///
/// Handles both Dart and JS React components, returning the appropriate props structure for each type:
///
/// * For Dart components, existing props are read from [InteropProps.internal], which are then merged with
///   the new [newProps] and saved in a new [InteropProps] with the expected [ReactDartComponentInternal] structure.
///   Children are likewise copied/overwritten as expected.
///
/// * For JS components, a copy of [newProps] is returned, since React will merge the props without any special handling.
dynamic preparePropsChangeset(ReactElement element, Map newProps, [Iterable newChildren]) {
  var propsChangeset;

  final internal = _getInternal(element);
  if (internal == null) {
    // Plain JS component
    if (newProps == null) {
      propsChangeset = null;
    } else {
      if (isDomElement(element)) {
        // Convert props for DOM components so that style Maps and event handlers
        // are properly converted.
        Map convertedProps = new Map.from(newProps);
        ReactDomComponentFactoryProxy.convertProps(convertedProps);
        propsChangeset = jsify(convertedProps);
      } else {
        propsChangeset = jsify(newProps);
      }
    }
  } else {
    // react-dart component
    Map oldExtendedProps = internal.props;

    Map extendedProps = new Map.from(oldExtendedProps);
    if (newProps != null) {
      extendedProps.addAll(newProps);
    }

    propsChangeset = ReactDartComponentFactoryProxy.generateExtendedJsProps(extendedProps, newChildren ?? extendedProps['children']);
  }

  return propsChangeset;
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
ReactElement cloneElement(ReactElement element, [Map props, Iterable children]) {
  var propsChangeset = preparePropsChangeset(element, props, children);

  if (children != null) {
    return _cloneElement(element, propsChangeset, children);
  } else {
    return _cloneElement(element, propsChangeset);
  }
}

/// Returns the native Dart component associated with a React JS component instance, or null if the component is not Dart-based.
react.Component getDartComponent(/* [1] */ instance) {
  if (instance is Element) {
    return null;
  }

  return _getInternal(instance)?.component;
}

/// A function that, when supplied as the `ref` prop, is called with the component instance
/// as soon as it is mounted.
///
/// This instance can be used to retrieve a component's DOM node or to call a component's public API methods.
///
/// The component instance will be of the type:
///   * [react.Component] for Dart components
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
typedef CallbackRef(ref);

/// Returns a function that chains [element]'s callback ref (if one exists) with [newCallbackRef].
///
/// Throws [ArgumentError] if [element.ref] is a `String` ref or otherwise not a [CallbackRef].
///
/// TODO: This method makes assumptions about how react-dart does callback refs for dart components, so this method should be moved there (UIP-1118).
CallbackRef chainRef(ReactElement element, CallbackRef newCallbackRef) {
  final existingRef = element.ref;

  // If there's no existing ref, just return the new one.
  if (existingRef == null) return newCallbackRef;

  if (existingRef is String) {
    throw new ArgumentError.value(existingRef, 'element.ref',
        'The existing ref is a String ref and cannot be chained');
  }

  if (existingRef is! Function) {
    throw new ArgumentError.value(existingRef, 'element.ref',
        'The existing ref is invalid and cannot be chained');
  }

  // Use a local function as opposed to a function expression so that its name shows up in any stack traces.
  void chainedRef(ref) {
    // For Dart components, the existing ref is a function passed to the JS that wraps the Dart
    // callback ref and converts the JS instance to the Dart component.
    //
    // So, we need to undo the wrapping around this chained ref and pass in the JS instance.
    existingRef(ref is react.Component ? ref.jsThis : ref);

    if (newCallbackRef != null) newCallbackRef(ref);
  }

  return chainedRef;
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
/// Returns the associated [react.Component] for Dart components or the [ReactComponent]
/// for JS components.
///
/// To use in Dartium, over_react must be imported in the current context.
dynamic get $r {
  var component = _get$R();

  return isDartComponent(component)
      ? component.props.internal.component
      : component;
}
