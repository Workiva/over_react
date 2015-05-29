part of w_ui_platform.ui_core;

JsObject _React = context['React'];
Map _getInternal(JsObject jsThis) => jsThis[PROPS][INTERNAL];

JsObject _convertDartProps(Map extendedProps) {
  var convertedArgs = newJsObjectEmpty();

  if (extendedProps.containsKey('key')) {
    convertedArgs['key'] = extendedProps['key'];
  }
  if (extendedProps.containsKey('ref')) {
    convertedArgs['ref'] = extendedProps['ref'];
  }

  convertedArgs[INTERNAL] = {PROPS: extendedProps};

  return convertedArgs;
}
JsObject cloneElement(JsObject element, [Map config, List children]) {
  JsObject convertedConfig;

  Map internal = _getInternal(element);
  if (internal == null) {
    // Plain JS component
    convertedConfig = config != null ? newJsMap(config) : null;
  } else {
    // react-dart component
    Map oldConfig = internal[PROPS];

    Map extendedProps = new Map.from(oldConfig);
    if (config != null) {
      extendedProps.addAll(config);
    }
    if (children != null) {
      extendedProps['children'] = children;
    }

    convertedConfig = _convertDartProps(extendedProps);
  }


  List jsMethodArgs = [element, convertedConfig];
  if (children != null) {
    jsMethodArgs.add(new JsArray.from(children));
  }

  return _React.callMethod('cloneElement', jsMethodArgs);;
}

