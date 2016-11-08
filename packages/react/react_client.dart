// Copyright (c) 2013-2016, the Clean project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS()
library react_client;

import "dart:async";
import "dart:collection";
import "dart:html";

import "package:js/js.dart";
import "package:react/react.dart";
import "package:react/react_client/js_interop_helpers.dart";
import 'package:react/react_client/react_interop.dart';
import "package:react/react_dom.dart";
import "package:react/react_dom_server.dart";
import "package:react/src/react_client/synthetic_event_wrappers.dart" as events;
import 'package:react/src/typedefs.dart';

export 'package:react/react_client/react_interop.dart' show ReactElement, ReactJsComponentFactory;

final EmptyObject emptyJsMap = new EmptyObject();

/// Type of [children] must be child or list of children, when child is [ReactElement] or [String]
typedef ReactElement ReactComponentFactory(Map props, [dynamic children]);
typedef Component ComponentFactory();

/// The type of [Component.ref] specified as a callback.
///
/// See: <https://facebook.github.io/react/docs/more-about-refs.html#the-ref-callback-attribute>
typedef _CallbackRef(componentOrDomNode);

/// Creates ReactJS [ReactElement] instances.
abstract class ReactComponentFactoryProxy implements Function {
  /// The type of component created by this factory.
  get type;

  /// Returns a new rendered component instance with the specified [props] and [children].
  ReactElement call(Map props, [dynamic children]);

  /// Used to implement a variadic version of [call], in which children may be specified as additional arguments.
  dynamic noSuchMethod(Invocation invocation);
}

/// Prepares [children] to be passed to the ReactJS [React.createElement] and
/// the Dart [react.Component].
///
/// Currently only involves converting a top-level non-[List] [Iterable] to
/// a non-growable [List], but this may be updated in the future to support
/// advanced nesting and other kinds of children.
dynamic listifyChildren(dynamic children) {
  if (React.isValidElement(children)) {
    // Short-circuit if we're dealing with a ReactElement to avoid the dart2js
    // interceptor lookup involved in Dart type-checking.
    return children;
  } else if (children is Iterable && children is! List) {
    return children.toList(growable: false);
  } else {
    return children;
  }
}

/// Creates ReactJS [Component] instances for Dart components.
class ReactDartComponentFactoryProxy<TComponent extends Component> extends ReactComponentFactoryProxy {
  /// The ReactJS class used as the type for all [ReactElement]s built by
  /// this factory.
  final ReactClass reactClass;

  /// The JS component factory used by this factory to build [ReactElement]s.
  final ReactJsComponentFactory reactComponentFactory;

  /// The cached Dart default props retrieved from [reactClass] that are passed
  /// into [generateExtendedJsProps] upon [ReactElement] creation.
  final Map defaultProps;

  ReactDartComponentFactoryProxy(ReactClass reactClass) :
      this.reactClass = reactClass,
      this.reactComponentFactory = React.createFactory(reactClass),
      this.defaultProps = reactClass.dartDefaultProps;

  ReactClass get type => reactClass;

  ReactElement call(Map props, [dynamic children]) {
    children = listifyChildren(children);

    return reactComponentFactory(
      generateExtendedJsProps(props, children, defaultProps: defaultProps),
      children
    );
  }

  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #call && invocation.isMethod) {
      Map props = invocation.positionalArguments[0];
      List children = listifyChildren(invocation.positionalArguments.sublist(1));

      markChildrenValidated(children);

      return reactComponentFactory(
        generateExtendedJsProps(props, children, defaultProps: defaultProps),
        children
      );
    }

    return super.noSuchMethod(invocation);
  }

  /// Returns a JavaScript version of the specified [props], preprocessed for consumption by ReactJS and prepared for
  /// consumption by the [react] library internals.
  static InteropProps generateExtendedJsProps(Map props, dynamic children, {Map defaultProps}) {
    if (children == null) {
      children = [];
    } else if (children is! Iterable) {
      children = [children];
    }

    // 1. Merge in defaults (if they were specified)
    // 2. Add specified props and children.
    // 3. Remove "reserved" props that should not be visible to the rendered component.

    // [1]
    Map extendedProps = (defaultProps != null ? new Map.from(defaultProps) : {})
      // [2]
      ..addAll(props)
      ..['children'] = children
      // [3]
      ..remove('key')
      ..remove('ref');

    var internal = new ReactDartComponentInternal()
      ..props = extendedProps;

    var interopProps = new InteropProps(internal: internal);

    // Don't pass a key into InteropProps if one isn't defined, so that the value will
    // be `undefined` in the JS, which is ignored by React, whereas `null` isn't.
    if (props.containsKey('key')) {
      interopProps.key = props['key'];
    }

    if (props.containsKey('ref')) {
      var ref = props['ref'];

      // If the ref is a callback, pass ReactJS a function that will call it
      // with the Dart Component instance, not the ReactComponent instance.
      if (ref is _CallbackRef) {
        interopProps.ref = allowInterop((ReactComponent instance) =>
            ref(instance == null ? null : instance.props.internal.component));
      } else {
        interopProps.ref = ref;
      }
    }

    return interopProps;
  }
}

/// The static methods that proxy JS component lifecycle methods to Dart components.
final ReactDartInteropStatics _dartInteropStatics = (() {
  var zone = Zone.current;

  /// Wrapper for [Component.getInitialState].
  void initComponent(ReactComponent jsThis, ReactDartComponentInternal internal, ComponentStatics componentStatics) => zone.run(() {
    var redraw = () {
      if (internal.isMounted) {
        jsThis.setState(emptyJsMap);
      }
    };

    Ref getRef = (name) {
      var ref = getProperty(jsThis.refs, name);
      if (ref == null) return null;
      if (ref is Element) return ref;

      return (ref as ReactComponent).props?.internal?.component ?? ref;
    };

    Component component = componentStatics.componentFactory()
        ..initComponentInternal(internal.props, redraw, getRef, jsThis);

    internal.component = component;
    internal.isMounted = false;
    internal.props = component.props;

    component.initStateInternal();
  });

  /// Wrapper for [Component.componentWillMount].
  void handleComponentWillMount(ReactDartComponentInternal internal) => zone.run(() {
    internal.isMounted = true;
    internal.component
        ..componentWillMount()
        ..transferComponentState();
  });

  /// Wrapper for [Component.componentDidMount].
  void handleComponentDidMount(ReactDartComponentInternal internal) => zone.run(() {
    internal.component.componentDidMount();
  });

  _getNextProps(Component component, ReactDartComponentInternal nextInternal) {
    var newProps = nextInternal.props;
    return newProps != null ? new Map.from(newProps) : {};
  }

  /// 1. Add [component] to [newArgs] to keep it in [InteropProps.internal]
  /// 2. Update [Component.props] using the value stored to [Component.nextProps]
  ///    in `componentWillReceiveProps`.
  /// 3. Update [Component.state] by calling [Component.transferComponentState]
  _afterPropsChange(Component component, ReactDartComponentInternal nextInternal) {
    // [1]
    nextInternal.component = component;

    // [2]
    component.props = component.nextProps;

    // [3]
    component.transferComponentState();
  }

  void _callSetStateCallbacks(Component component) {
    component.setStateCallbacks.forEach((callback()) { callback(); });
    component.setStateCallbacks.clear();
  }

  void _callSetStateTransactionalCallbacks(Component component) {
    var nextState = component.nextState;
    var props = new UnmodifiableMapView(component.props);

    component.transactionalSetStateCallbacks.forEach((callback) { nextState.addAll(callback(nextState, props)); });
    component.transactionalSetStateCallbacks.clear();
  }

  /// Wrapper for [Component.componentWillReceiveProps].
  void handleComponentWillReceiveProps(ReactDartComponentInternal internal, ReactDartComponentInternal nextInternal) => zone.run(() {
    var nextProps = _getNextProps(internal.component, nextInternal);
    internal.component
      ..nextProps = nextProps
      ..componentWillReceiveProps(nextProps);
  });

  /// Wrapper for [Component.shouldComponentUpdate].
  bool handleShouldComponentUpdate(ReactDartComponentInternal internal, ReactDartComponentInternal nextInternal) => zone.run(() {
    Component component = internal.component;
    _callSetStateTransactionalCallbacks(component);

    if (component.shouldComponentUpdate(component.nextProps, component.nextState)) {
      return true;
    } else {
      // If component should not update, update props / transfer state because componentWillUpdate will not be called.
      _afterPropsChange(component, nextInternal);
      _callSetStateCallbacks(component);
      return false;
  }
  });

  /// Wrapper for [Component.componentWillUpdate].
  void handleComponentWillUpdate(ReactDartComponentInternal internal, ReactDartComponentInternal nextInternal) => zone.run(() {
    Component component = internal.component;
    component.componentWillUpdate(component.nextProps, component.nextState);
    _afterPropsChange(component, nextInternal);
  });

  /// Wrapper for [Component.componentDidUpdate].
  ///
  /// Uses [prevState] which was transferred from [Component.nextState] in [componentWillUpdate].
  void handleComponentDidUpdate(ReactDartComponentInternal internal, ReactDartComponentInternal prevInternal) => zone.run(() {
    var prevInternalProps = prevInternal.props;
    Component component = internal.component;
    component.componentDidUpdate(prevInternalProps, component.prevState);
    _callSetStateCallbacks(component);
  });

  /// Wrapper for [Component.componentWillUnmount].
  void handleComponentWillUnmount(ReactDartComponentInternal internal) => zone.run(() {
    internal.isMounted = false;
    internal.component.componentWillUnmount();
  });

  /// Wrapper for [Component.render].
  dynamic handleRender(ReactDartComponentInternal internal) => zone.run(() {
    return internal.component.render();
  });

  return new ReactDartInteropStatics(
      initComponent: allowInterop(initComponent),
      handleComponentWillMount: allowInterop(handleComponentWillMount),
      handleComponentDidMount: allowInterop(handleComponentDidMount),
      handleComponentWillReceiveProps: allowInterop(handleComponentWillReceiveProps),
      handleShouldComponentUpdate: allowInterop(handleShouldComponentUpdate),
      handleComponentWillUpdate: allowInterop(handleComponentWillUpdate),
      handleComponentDidUpdate: allowInterop(handleComponentDidUpdate),
      handleComponentWillUnmount: allowInterop(handleComponentWillUnmount),
      handleRender: allowInterop(handleRender)
  );
})();

/// Returns a new [ReactComponentFactory] which produces a new JS
/// [`ReactClass` component class](https://facebook.github.io/react/docs/top-level-api.html#react.createclass).
ReactComponentFactory _registerComponent(ComponentFactory componentFactory, [Iterable<String> skipMethods = const []]) {
  var componentStatics = new ComponentStatics(componentFactory);

  /// Create the JS [`ReactClass` component class](https://facebook.github.io/react/docs/top-level-api.html#react.createclass)
  /// with custom JS lifecycle methods.
  var reactComponentClass = React.createClass(
      createReactDartComponentClassConfig(_dartInteropStatics, componentStatics)
        ..displayName = componentFactory().displayName
  );

  // Cache default props and store them on the ReactClass so they can be used
  // by ReactDartComponentFactoryProxy and externally.
  final Map defaultProps = new Map.unmodifiable(componentFactory().getDefaultProps());
  reactComponentClass.dartDefaultProps = defaultProps;

  return new ReactDartComponentFactoryProxy(reactComponentClass);
}

/// Creates ReactJS [ReactElement] instances for DOM components.
class ReactDomComponentFactoryProxy extends ReactComponentFactoryProxy {
  /// The name of the proxied DOM component.
  ///
  /// E.g. `'div'`, `'a'`, `'h1'`
  final String name;

  /// The JS component factory used by this factory to build [ReactElement]s.
  final Function factory;

  ReactDomComponentFactoryProxy(name) :
    this.name = name,
    this.factory = React.createFactory(name);

  @override
  String get type => name;

  @override
  ReactElement call(Map props, [dynamic children]) {
    convertProps(props);
    return factory(jsify(props), listifyChildren(children));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #call && invocation.isMethod) {
      Map props = invocation.positionalArguments[0];
      List children = listifyChildren(invocation.positionalArguments.sublist(1));

      convertProps(props);
      markChildrenValidated(children);

      return factory(jsify(props), children);
    }

    return super.noSuchMethod(invocation);
  }

  /// Prepares the bound values, event handlers, and style props for consumption by ReactJS DOM components.
  static void convertProps(Map props) {
    _convertBoundValues(props);
    _convertEventHandlers(props);
  }
}

/// Create react-dart registered component for the HTML [Element].
_reactDom(String name) {
  return new ReactDomComponentFactoryProxy(name);
}

/// Returns whether an [InputElement] is a [CheckboxInputElement] based the value of the `type` key in [props].
_isCheckbox(props) {
  return props['type'] == 'checkbox';
}

/// Get value from the provided [domElem].
///
/// If the [domElem] is a [CheckboxInputElement], return [bool], else return [String] value.
_getValueFromDom(domElem) {
  var props = domElem.attributes;

  if (_isCheckbox(props)) {
    return domElem.checked;
  } else {
    return domElem.value;
  }
}

/// Set value to props based on type of input.
///
/// _Note: Processing checkbox `checked` value is handled as a special case._
_setValueToProps(Map props, val) {
  if (_isCheckbox(props)) {
    if(val) {
      props['checked'] = true;
    } else {
      if(props.containsKey('checked')) {
         props.remove('checked');
      }
    }
  } else {
    props['value'] = val;
  }
}

/// Convert bound values to pure value and packed onChange function
_convertBoundValues(Map args) {
  var boundValue = args['value'];

  if (boundValue is List) {
    _setValueToProps(args, boundValue[0]);
    args['value'] = boundValue[0];
    var onChange = args['onChange'];

    // Put new function into onChange event handler.
    // If there was something listening for that event, trigger it and return its return value.
    args['onChange'] = (event) {
      boundValue[1](_getValueFromDom(event.target));

      if (onChange != null) {
        return onChange(event);
      }
    };
  }
}

/// Convert packed event handler into wrapper and pass it only the Dart [SyntheticEvent] object converted from the
/// [events.SyntheticEvent] event.
_convertEventHandlers(Map args) {
  var zone = Zone.current;
  args.forEach((propKey, value) {
    var eventFactory = _eventPropKeyToEventFactory[propKey];
    if (eventFactory != null && value != null) {
      args[propKey] = (events.SyntheticEvent e, [String domId, Event event]) => zone.run(() {
        value(eventFactory(e));
      });
    }
  });
}

/// A mapping from event prop keys to their respective event factories.
///
/// Used in [_convertEventHandlers] for efficient event handler conversion.
const Map<String, Function> _eventPropKeyToEventFactory = const <String, Function>{
  // SyntheticClipboardEvent
  'onCopy': syntheticClipboardEventFactory,
  'onCut': syntheticClipboardEventFactory,
  'onPaste': syntheticClipboardEventFactory,

  // SyntheticKeyboardEvent
  'onKeyDown': syntheticKeyboardEventFactory,
  'onKeyPress': syntheticKeyboardEventFactory,
  'onKeyUp': syntheticKeyboardEventFactory,

  // SyntheticFocusEvent
  'onFocus': syntheticFocusEventFactory,
  'onBlur': syntheticFocusEventFactory,

  // SyntheticFormEvent
  'onChange': syntheticFormEventFactory,
  'onInput': syntheticFormEventFactory,
  'onSubmit': syntheticFormEventFactory,
  'onReset': syntheticFormEventFactory,

  // SyntheticMouseEvent
  'onClick': syntheticMouseEventFactory,
  'onContextMenu': syntheticMouseEventFactory,
  'onDoubleClick': syntheticMouseEventFactory,
  'onDrag': syntheticMouseEventFactory,
  'onDragEnd': syntheticMouseEventFactory,
  'onDragEnter': syntheticMouseEventFactory,
  'onDragExit': syntheticMouseEventFactory,
  'onDragLeave': syntheticMouseEventFactory,
  'onDragOver': syntheticMouseEventFactory,
  'onDragStart': syntheticMouseEventFactory,
  'onDrop': syntheticMouseEventFactory,
  'onMouseDown': syntheticMouseEventFactory,
  'onMouseEnter': syntheticMouseEventFactory,
  'onMouseLeave': syntheticMouseEventFactory,
  'onMouseMove': syntheticMouseEventFactory,
  'onMouseOut': syntheticMouseEventFactory,
  'onMouseOver': syntheticMouseEventFactory,
  'onMouseUp': syntheticMouseEventFactory,

  // SyntheticTouchEvent
  'onTouchCancel': syntheticTouchEventFactory,
  'onTouchEnd': syntheticTouchEventFactory,
  'onTouchMove': syntheticTouchEventFactory,
  'onTouchStart': syntheticTouchEventFactory,

  // SyntheticUIEvent
  'onScroll': syntheticUIEventFactory,

  // SyntheticWheelEvent
  'onWheel': syntheticWheelEventFactory,
};

/// Wrapper for [SyntheticEvent].
SyntheticEvent syntheticEventFactory(events.SyntheticEvent e) {
  return new SyntheticEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type);
}

/// Wrapper for [SyntheticClipboardEvent].
SyntheticClipboardEvent syntheticClipboardEventFactory(events.SyntheticClipboardEvent e) {
  return new SyntheticClipboardEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type, e.clipboardData);
}

/// Wrapper for [SyntheticKeyboardEvent].
SyntheticKeyboardEvent syntheticKeyboardEventFactory(events.SyntheticKeyboardEvent e) {
  return new SyntheticKeyboardEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted,
      e.nativeEvent, e.target, e.timeStamp, e.type, e.altKey,
      e.char, e.charCode, e.ctrlKey, e.locale, e.location,
      e.key, e.keyCode, e.metaKey, e.repeat, e.shiftKey);
}

/// Wrapper for [SyntheticFocusEvent].
SyntheticFocusEvent syntheticFocusEventFactory(events.SyntheticFocusEvent e) {
  return new SyntheticFocusEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type, e.relatedTarget);
}

/// Wrapper for [SyntheticFormEvent].
SyntheticFormEvent syntheticFormEventFactory(events.SyntheticFormEvent e) {
  return new SyntheticFormEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type);
}

/// Wrapper for [SyntheticDataTransfer].
SyntheticDataTransfer syntheticDataTransferFactory(events.SyntheticDataTransfer dt) {
  if (dt == null) return null;
  List<File> files = [];
  if (dt.files != null) {
    for (int i = 0; i < dt.files.length; i++) {
      files.add(dt.files[i]);
    }
  }
  List<String> types = [];
  if (dt.types != null) {
    for (int i = 0; i < dt.types.length; i++) {
      types.add(dt.types[i]);
    }
  }
  var effectAllowed;
  try {
    // Works around a bug in IE where dragging from outside the browser fails.
    // Trying to access this property throws the error "Unexpected call to method or property access.".
    effectAllowed = dt.effectAllowed;
  } catch (exception) {
    effectAllowed = 'uninitialized';
  }
  return new SyntheticDataTransfer(dt.dropEffect, effectAllowed, files, types);
}

/// Wrapper for [SyntheticMouseEvent].
SyntheticMouseEvent syntheticMouseEventFactory(events.SyntheticMouseEvent e) {
  SyntheticDataTransfer dt = syntheticDataTransferFactory(e.dataTransfer);
  return new SyntheticMouseEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type, e.altKey, e.button, e.buttons, e.clientX, e.clientY,
      e.ctrlKey, dt, e.metaKey, e.pageX, e.pageY, e.relatedTarget, e.screenX,
      e.screenY, e.shiftKey);
}

/// Wrapper for [SyntheticTouchEvent].
SyntheticTouchEvent syntheticTouchEventFactory(events.SyntheticTouchEvent e) {
  return new SyntheticTouchEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type, e.altKey, e.changedTouches, e.ctrlKey, e.metaKey,
      e.shiftKey, e.targetTouches, e.touches);
}

/// Wrapper for [SyntheticUIEvent].
SyntheticUIEvent syntheticUIEventFactory(events.SyntheticUIEvent e) {
  return new SyntheticUIEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type, e.detail, e.view);
}

/// Wrapper for [SyntheticWheelEvent].
SyntheticWheelEvent syntheticWheelEventFactory(events.SyntheticWheelEvent e) {
  return new SyntheticWheelEvent(e.bubbles, e.cancelable, e.currentTarget,
      e.defaultPrevented, () => e.preventDefault(),
      () => e.stopPropagation(), e.eventPhase, e.isTrusted, e.nativeEvent,
      e.target, e.timeStamp, e.type, e.deltaX, e.deltaMode, e.deltaY, e.deltaZ);
}

dynamic _findDomNode(component) {
  return ReactDom.findDOMNode(component is Component ? component.jsThis : component);
}

void setClientConfiguration() {
  try {
    // Attempt to invoke JS interop methods, which will throw if the
    // corresponding JS functions are not available.
    React.isValidElement(null);
    ReactDom.findDOMNode(null);
    createReactDartComponentClassConfig(null, null);
  } on NoSuchMethodError catch (_) {
    throw new Exception('react.js and react_dom.js must be loaded.');
  } catch(_) {
    throw new Exception('Loaded react.js must include react-dart JS interop helpers.');
  }

  setReactConfiguration(_reactDom, _registerComponent);
  setReactDOMConfiguration(ReactDom.render, ReactDom.unmountComponentAtNode, _findDomNode);
  setReactDOMServerConfiguration(ReactDomServer.renderToString, ReactDomServer.renderToStaticMarkup);
}
