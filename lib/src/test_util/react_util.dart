library test_util.react_util;

import 'dart:html';
import 'dart:js';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:web_skin_dart/ui_core.dart';

export 'package:web_skin_dart/src/ui_core/util/react_wrappers.dart';

JsObject _React = context['React'];

/// Renders a React component or builder into a detached node and returns the JsObject instance.
JsObject render(dynamic component) {
  return react_test_utils.renderIntoDocument(component is ComponentDefinition ? component.build() : component);
}

/// Shallow-renders a component using [react_test_utils.ReactShallowRenderer].
///
/// See: <https://facebook.github.io/react/docs/test-utils.html#shallow-rendering>.
JsObject renderShallow(JsObject instance) {
  var renderer = react_test_utils.createRenderer();
  renderer.render(instance);
  return renderer.getRenderOutput();
}

/// Unmounts a React component.
///
/// [instanceOrContainerNode] can be a [JsObject] React instance,
/// or an [Element] container node (argument to [react.render]).
///
/// For convenience, this method does nothing if [instanceOrContainerNode] is null,
/// or if it's a non-mounted React instance.
void unmount(dynamic instanceOrContainerNode) {
  if (instanceOrContainerNode == null) {
    return;
  }

  if (instanceOrContainerNode is JsObject && !isMounted(instanceOrContainerNode)) {
    return;
  }

  Element containerNode;

  if (instanceOrContainerNode is JsObject) {
    containerNode = findDomNode(instanceOrContainerNode).parent;
  } else if (instanceOrContainerNode is Element) {
    containerNode = instanceOrContainerNode;
  } else {
    throw new ArgumentError(
        '`instanceOrNode` must be null, a JsObject instance, or an Element. Was: $instanceOrContainerNode.'
    );
  }

  react.unmountComponentAtNode(containerNode);
}

/// Renders a React component or builder into a detached node and returns the associated DOM node.
Element renderAndGetDom(dynamic component) {
  return findDomNode(react_test_utils.renderIntoDocument(component is ComponentDefinition ? component.build() : component));
}

/// List of elements attached to the DOM and used as mount points in previous calls to [renderAttachedToDocument].
List<Element> _attachedReactContainers = [];

/// Renders the component into the document as opposed to a headless node.
/// Returns the rendered component.
JsObject renderAttachedToDocument(dynamic component) {
  var container = new DivElement()..className = 'render-attached-to-document-container';
  _attachedReactContainers.add(container);

  document.body.append(container);

  return react.render(component is ComponentDefinition ? component.build() : component, container);
}

/// Unmounts and removes the mount nodes for components rendered via [renderAttachedToDocument].
void tearDownAttachedNodes() {
  _attachedReactContainers.forEach((container) {
    react.unmountComponentAtNode(container);
    container.remove();
  });

  _attachedReactContainers.clear();
}

/// Returns the internal Map used by react-dart to maintain the native Dart component.
Map _getInternal(JsObject instance) => instance[PROPS][INTERNAL];

/// Returns whether the React [instance] is mounted.
bool isMounted(JsObject instance) {
  bool isMounted = instance.callMethod('isMounted', []);
  // Workaround for https://github.com/facebook/react/pull/3815 (Fixed in React 0.14)
  isMounted ??= false;
  return isMounted;
}

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

/// Returns the first descendant of [root] that has its `data-test-id` prop value set to [value].
///
/// Returns null if no descendant has its `data-test-id` prop value set [value].
///
///     var renderedInstance = render(Dom.div()(
///         (Dom.div()..testId = 'first-div')() // Div1
///         Dom.div()(
///           (Dom.div()..testId = 'nested-div')() // Div2
///         )
///       )
///     );
///
///     var firstDiv = getByTestId(renderedInstance, 'first-div'); // Returns Div1
///     var nestedDiv = getByTestId(renderedInstance, 'nested-div'); // Returns Div2
///     var secondDiv = getByTestId(renderedInstance, 'second-div'); // Returns null
JsObject getByTestId(JsObject root, String value) {
  bool first = false;

  var results = react_test_utils.findAllInRenderedTree(root, new JsFunction.withThis((_, JsObject descendant) {
    if (first) {
      return false;
    }

    bool hasValue = false;

    if (isDartComponent(descendant)) {
      hasValue = getDartComponent(descendant).props['data-test-id'] == value;
    } else {
      hasValue = descendant[PROPS]['data-test-id'] == value;
    }

    if (hasValue) {
      first = true;
    }

    return hasValue;
  }));

  if (results.isEmpty) {
    return null;
  } else {
    return results.single;
  }
}
/// Returns the [Element] of the first descendant of [root] that has its `data-test-id` prop value set to [value].
///
/// Returns null if no descendant has its `data-test-id` prop value set to [value].
Element getDomByTestId(JsObject root, String value) {
  var instance = getByTestId(root, value);
  if (instance != null) {
    return findDomNode(instance);
  }

  return null;
}

/// Returns the [react.Component] of the first descendant of [root] that has its `data-test-id` prop value set to [value].
///
/// Returns null if no descendant has its `data-test-id` prop value set to [value].
react.Component getComponentByTestId(JsObject root, String value) {
  return getDartComponent(getByTestId(root, value));
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
