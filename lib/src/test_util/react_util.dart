library test_util.react_util;

import 'dart:html';
import 'dart:js';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:web_skin_dart/ui_core.dart';

// Expose utilities in ui_core/util/react_wrappers.dart
export 'package:web_skin_dart/ui_core.dart';

JsObject _React = context['React'];

/// Renders a React component or builder into the DOM and returns the JsObject instance.
JsObject render(dynamic component, [List children]) {
  return react_test_utils.renderIntoDocument(component is ComponentDefinition ? component.build(children) : component);
}

/// Renders a React component or builder into the DOM and returns the associated DOM node.
Element renderAndGetDom(dynamic component, [List children]) {
  return findDomNode(react_test_utils.renderIntoDocument(component is ComponentDefinition ? component.build(children) : component));
}

/// Element that will be wrapped around the component that will be rendered into the document.
Element _attachedReactContainer;

/// Renders the component into the document as opposed to a headless node.
/// Returns the rendered component.
JsObject renderAttachedToDocument(dynamic component, [List children]) {
  tearDownAttachedNode();

  _attachedReactContainer = new DivElement();

  document.body.append(_attachedReactContainer);

  return _React.callMethod('render', [
    component is ComponentDefinition ? component.build(children) : component,
    _attachedReactContainer
  ]);
}

/// Removes _attachedReactContainer from the document.
void tearDownAttachedNode() {
  if (_attachedReactContainer != null) {
    _attachedReactContainer.remove();
    _attachedReactContainer = null;
  }
}

/// Returns the internal Map used by react-dart to maintain the native Dart component.
Map _getInternal(JsObject instance) => instance[PROPS][INTERNAL];

/// Returns whether or not the instance is mounted
bool isMounted(JsObject instance) => _getInternal(instance)[IS_MOUNTED];

/// Returns the native Dart component associated with a React JS component instance, or null if the component is not Dart-based.
react.Component getDartComponent(JsObject instance) {
  var internal = _getInternal(instance);
  if (internal != null) {
    return internal[COMPONENT];
  }
  return null;
}

/// Returns a rendered component's ref, or null if it doesn't exist.
JsObject getRef(JsObject instance, dynamic ref) {
  if (instance == null) {
    return null;
  }
  return instance[REFS][ref];
}

/// Helper function to simulate clicks
void click(dynamic node) => context['React']['addons']['TestUtils']['Simulate'].callMethod('click', [node]);

/// Simulate a MouseEnter event by firing a MouseOut and a MouseOver, since MouseEnter simulation is not provided by react_test_utils.
void simulateMouseEnter(EventTarget target) {
  // Use any other node than [target].
  var from = document.body;
  var to = target;

  assert(from != to);

  react_test_utils.SimulateNative.mouseOut(from, {'relatedTarget': to});
  react_test_utils.SimulateNative.mouseOver(to, {'relatedTarget': from});
}

/// Simulate a MouseLeave event by firing a MouseOut and a MouseOver, since MouseLeave simulation is not provided by react_test_utils.
void simulateMouseLeave(EventTarget target) {
  var from = target;
  // Use any other node than [target].
  var to = document.body;

  assert(from != to);

  react_test_utils.SimulateNative.mouseOut(from, {'relatedTarget': to});
  react_test_utils.SimulateNative.mouseOver(to, {'relatedTarget': from});
}

/// Returns the single DOM component that ta component eventually renders down to.
///
/// Useful for checking props and simulating events on composite components like react.button.
JsObject getDomComponent(JsObject instance) {
  return react_test_utils.findAllInRenderedTree(instance, new JsFunction.withThis((_, JsObject descendant) {
    return react_test_utils.isDOMComponent(descendant);
  })).single;
}

/// Returns all descendants of a component that contain the specified prop key.
List<JsObject> findDescendantsWithProp(JsObject root, dynamic propKey) {
  return react_test_utils.findAllInRenderedTree(root, new JsFunction.withThis((_, JsObject descendant) {
    if (descendant == root) {
      return false;
    }

    bool hasProp;
    if (isDartComponent(descendant)) {
      hasProp = getDartComponent(descendant).props.containsKey(propKey);
    } else {
      hasProp = descendant[PROPS].hasProperty(propKey);
    }

    return hasProp;
  }));
}

/// Dart wrapper for setProps.
/// > Sets a subset of the props.
/// >
/// > @param {object} partialProps Subset of the next props.
/// > @param {?function} callback Called after props are updated.
void setProps(JsObject instance, Map props, [callback]) {
  JsObject propsChangeset = preparePropsChangeset(instance, props);
  instance.callMethod('setProps', [propsChangeset, callback]);
}

/// Helper component that renders whatever you tell it to. Necessary for rendering components with the 'ref' prop.
ReactComponentFactory RenderingContainerComponentFactory = react.registerComponent(() => new RenderingContainerComponent());
class RenderingContainerComponent extends react.Component {
  @override
  render() => props['renderer']();
}
