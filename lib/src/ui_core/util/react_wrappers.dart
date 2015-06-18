part of w_ui_platform.ui_core;

JsObject _React = context['React'];
Map _getInternal(JsObject jsThis) => jsThis[PROPS][INTERNAL];

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

bool isValidElement(dynamic object) {
  return _React.callMethod('isValidElement', [object]);
}
