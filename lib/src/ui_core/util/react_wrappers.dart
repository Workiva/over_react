library ui_core.react_wrappers;

import 'dart:html';
import 'dart:js';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:js/js.dart';

/// Returns the internal Map used by react-dart to maintain the native Dart component.
ReactDartComponentInternal _getInternal(ReactElement instance) => instance.props.internal;

/// Returns the internal representation of a Dart component's props as maintained by react-dart
/// Similar to ReactElement.props in JS, but also includes `key`, `ref` and `children`
Map _getExtendedProps(ReactElement instance) {
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
bool isDartComponent(instance) {
  // Don't try to access internal on a DOM component
  return instance is! Element && _getInternal(instance) != null;
}

@JS('Object.keys')
external Iterable _objectKeys(object);

/// Returns the props for a React JS component instance, shallow-converted to a Dart Map for convenience.
Map getJsProps(ReactElement instance) {
  var props = instance.props;

  return new Map.fromIterable(_objectKeys(props),
      value: (key) => getProperty(props, key)
  );
}

/// Returns the props for a component.
///
/// For a native Dart component, this returns its [react.Component.props] Map.
/// For a JS component, this returns the result of [getJsProps].
Map getProps(instance) {
  return isDartComponent(instance) ? _getExtendedProps(instance) : getJsProps(instance);
}

/// Returns the DOM node associated with a mounted React component [instance],
/// which can be a [ReactComponent]/[Element] or [react.Component].
///
/// This method simply wraps react.findDOMNode with strong typing for the return value
/// (and for the function itself, which is declared using `var` in react-dart).
Element findDomNode(dynamic instance) => react.findDOMNode(instance);

/// Dart wrapper for React.isValidElement.
///
/// _From the JS docs:_
/// > Verifies the object is a ReactElement
bool isValidElement(dynamic object) {
  return React.isValidElement(object);
}

/// Returns whether [instance] is a ReactElement for a DOM node.
bool isDomElement(dynamic instance) {
  return isValidElement(instance) && (instance as ReactElement).type is String;
}

/// Returns a new JS map with the specified props and children changes, properly prepared for consumption by
/// React JS methods such as cloneWithProps(), setProps(), and other methods that accept changesets of props to be
/// merged into existing props.
///
/// Handles both Dart and JS React components, returning the appropriate props structure for each type:
///
/// * For Dart components, existing props are read from the "__internal__" props map, which are then merged with
///   the new [newProps] and saved in a new JS map with the expected "__internal__" structure.
///   Children are likewise copied/overwritten as expected.
///
/// * For JS components, a copy of [newProps] is returned, since React will merge the props without any special handling.
preparePropsChangeset(ReactElement element, Map newProps, [List newChildren]) {
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
ReactElement cloneElement(ReactElement element, [Map props, List children]) {
  var propsChangeset = preparePropsChangeset(element, props, children);

  if (children != null) {
    return _cloneElement(element, propsChangeset, children);
  } else {
    return _cloneElement(element, propsChangeset);
  }
}

/// Returns a new JsArray from the specified List, so that non-flat children can be used with react-dart.
///
/// Workaround until <https://github.com/cleandart/react-dart/issues/60> is fixed.
List prepareNestedChildren(List children) => children;

/// Returns whether the React [instance] is mounted.
bool isMounted(dynamic instance) {
  if (instance is Element) {
    return new JsObject.fromBrowserObject(instance).callMethod('isMounted', []);
  }

  return (instance as ReactComponent).isMounted();
}

/// Returns the native Dart component associated with a React JS component instance, or null if the component is not Dart-based.
react.Component getDartComponent(instance) {
  if (instance is Element) {
    return null;
  }

  return _getInternal(instance)?.component;
}
