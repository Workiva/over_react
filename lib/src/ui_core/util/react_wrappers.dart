part of w_ui_platform.ui_core;

JsObject _React = context['React'];

/// Returns the internal Map used by react-dart to maintain the native Dart component.
Map _getInternal(JsObject instance) => instance[PROPS][INTERNAL];

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

/// Helper function for getting the 'key' of a JsObject
dynamic getInstanceKey(JsObject instance) {
  return instance['key'];
}

/// Helper function for getting the 'ref' of a JsObject
dynamic getInstanceRef(JsObject instance) {
  return instance['key'];
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

/// Returns whether the instance is a valid ReactElement and was created using the specified Dart factory
bool isValidElementOfType(dynamic instance, ReactComponentFactory factory) {
  // TODO: Add isValidElement() from UIP-284
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
  JsObject convertedProps;

  Map internal = _getInternal(element);
  if (internal == null) {
    // Plain JS component
    convertedProps = props != null ? newJsMap(props) : null;
  } else {
    // react-dart component
    Map oldExtendedProps = internal[PROPS];

    Map extendedProps = new Map.from(oldExtendedProps);
    if (props != null) {
      extendedProps.addAll(props);
    }
    if (children != null) {
      extendedProps['children'] = children;
    }

    convertedProps = _convertDartProps(extendedProps);
  }

  List jsMethodArgs = [element, convertedProps];
  if (children != null) {
    jsMethodArgs.add(new JsArray.from(children));
  }

  return _React.callMethod('cloneElement', jsMethodArgs);
}
