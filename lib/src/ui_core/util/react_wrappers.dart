part of w_ui_platform.ui_core;

JsObject _React = context['React'];

/// Returns the internal Map used by react-dart to maintain the native Dart component.
Map _getInternal(JsObject instance) => instance[PROPS][INTERNAL];

/// Returns the internal representation of a Dart component's props as maintained by react-dart
/// Similar to ReactElement.props in JS, but also includes `key`, `ref` and `children`
Map _getExtendedProps(JsObject instance) {
  return _getInternal(instance)[PROPS];
}

/// Helper with logic borrowed from react-dart that returns a JsObject version of props,
/// preprocessed for consumption by React JS and prepared for consumption by the react-dart wrapper internals/
JsObject _convertDartProps(Map extendedProps) {
  var convertedProps = newJsObjectEmpty();

  // Transfer over key and ref if they're specified so React JS knows about them.
  if (extendedProps.containsKey('key')) {
    convertedProps['key'] = extendedProps['key'];
  }
  if (extendedProps.containsKey('ref')) {
    convertedProps['ref'] = extendedProps['ref'];
  }

  // Put Dart props inside the internal object, which will be accessed and manipulated by the react-dart wrapper.
  convertedProps[INTERNAL] = {PROPS: extendedProps};

  return convertedProps;
}

/// Returns 'key' associated with the specified React instance.
dynamic getInstanceKey(JsObject instance) {
  return instance['key'];
}

/// Returns 'ref' associated with the specified React instance.
dynamic getInstanceRef(JsObject instance) {
  return instance['ref'];
}

/// Returns whether a component is a native Dart component.
bool isDartComponent(JsObject instance) {
  return _getInternal(instance) != null;
}

/// Returns the props for a React JS component instance, shallow-converted to a Dart Map for convenience.
Map getJsProps(JsObject instance) {
  JsObject props = instance[PROPS];

  Map convertedProps = {};

  JsArray keys = (context['Object'] as JsObject).callMethod('keys', [props]);
  keys.forEach((key) {
    convertedProps[key] = props[key];
  });

  return convertedProps;
}

/// Returns the props for a component.
///
/// For a native Dart component, this returns its [react.Component.props] Map.
/// For a JS component, this returns the result of [getJsProps].
Map getProps(JsObject instance) {
  return isDartComponent(instance) ? _getExtendedProps(instance) : getJsProps(instance);
}

/// Returns the DOM node associated with a mounted React component [instance],
/// which can be a [JsObject] or [react.Component].
///
/// This method simply wraps react.findDOMNode with strong typing for the return value
/// (and for the function itself, which is declared using `var` in react-dart).
Element findDomNode(JsObject instance) => react.findDOMNode(instance);

/// Returns whether the instance is a valid ReactElement and was created using the specified Dart factory
bool isValidElementOfType(dynamic instance, ReactComponentFactory factory) {
  return isValidElement(instance) ? isComponentOfType(instance, factory) : false;
}

/// Returns whether the instance was created using the specified Dart factory
/// TODO: Find better way of determining the type of rendered components
bool isComponentOfType(JsObject instance, ReactComponentFactory factory) {
  if (instance != null && factory != null) {
    return factory is ReactComponentFactoryProxy && instance['type'] == factory.reactComponentFactory['type'];
  }
   return false;
}

/// Dart wrapper for React.isValidElement.
///
/// _From the JS docs:_
/// > Verifies the object is a ReactElement
bool isValidElement(dynamic object) {
  return _React.callMethod('isValidElement', [object]);
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
JsObject preparePropsChangeset(JsObject element, Map newProps, [List newChildren]) {
  JsObject propsChangeset;

  Map internal = _getInternal(element);
  if (internal == null) {
    // Plain JS component
    propsChangeset = newProps != null ? newJsMap(newProps) : null;
  } else {
    // react-dart component
    Map oldExtendedProps = internal[PROPS];

    Map extendedProps = new Map.from(oldExtendedProps);
    if (newProps != null) {
      extendedProps.addAll(newProps);
    }
    if (newChildren != null) {
      extendedProps['children'] = newChildren;
    }

    propsChangeset = _convertDartProps(extendedProps);
  }

  return propsChangeset;
}

/// Dart wrapper for React.cloneElement.
///
/// _From the JS docs:_
/// > Clone and return a new ReactElement using element as the starting point.
/// > The resulting element will have the original element's props with the new props merged in shallowly.
/// > New children will replace existing children.
/// > Unlike React.addons.cloneWithProps, key and ref from the original element will be preserved.
/// > There is no special behavior for merging any props (unlike cloneWithProps).
/// > See the [v0.13 RC2 blog post](https://facebook.github.io/react/blog/2015/03/03/react-v0.13-rc2.html) for additional details.
JsObject cloneElement(JsObject element, [Map props, List children]) {
  JsObject propsChangeset = preparePropsChangeset(element, props, children);

  List jsMethodArgs = [element, propsChangeset];
  if (children != null) {
    jsMethodArgs.add(new JsArray.from(children));
  }

  return _React.callMethod('cloneElement', jsMethodArgs);
}

/// Returns a new JsArray from the specified List, so that non-flat children can be used with react-dart.
///
/// Workaround until <https://github.com/cleandart/react-dart/issues/60> is fixed.
JsArray prepareNestedChildren(List children) {
  return children == null ? null : new JsArray.from(children);
}
