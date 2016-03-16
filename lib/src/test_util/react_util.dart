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

/// Returns a rendered component's ref, or null if it doesn't exist.
///
/// The return type is [JsObject] for composite components, and [Element] for DOM components.
///
/// Using `getRef()` can be tedious for nested / complex components. It is recommended to use [getByTestId] instead.
dynamic getRef(JsObject instance, dynamic ref) {
  if (instance == null) {
    return null;
  }
  return instance[REFS][ref];
}

/// Helper function to simulate clicks
void click(dynamic node) => context['React']['addons']['TestUtils']['Simulate'].callMethod('click', [node]);

/// Helper function to simulate mouseMove events.
void mouseMove(dynamic instanceOrNode) => react_test_utils.Simulate.mouseMove(instanceOrNode);

/// Helper function to simulate keyDown events.
void keyDown(dynamic instanceOrNode, [Map data = const {}]) => react_test_utils.Simulate.keyDown(instanceOrNode, data);

/// Helper function to simulate keyUp events.
void keyUp(dynamic instanceOrNode, [Map data = const {}]) => react_test_utils.Simulate.keyUp(instanceOrNode, data);

/// Helper function to simulate keyPress events.
void keyPress(dynamic instanceOrNode, [Map data = const {}]) => react_test_utils.Simulate.keyPress(instanceOrNode, data);

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

/// Returns the first descendant of [root] that has its [key] prop value set to [value].
///
/// Returns null if no descendant has its [key] prop value set [value].
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
///     var nonexistentDiv = getByTestId(renderedInstance, 'nonexistent-div'); // Returns null
///
/// It is recommended that, instead of setting this [key] prop manually, you should use the
/// [UiProps.testId] setter or [UiProps.setTestId] method so the prop is only set in a test environment.
JsObject getByTestId(JsObject root, String value, {String key: 'data-test-id'}) {
  bool first = false;

  var results = react_test_utils.findAllInRenderedTree(root, new JsFunction.withThis((_, descendant) {
    if (first) {
      return false;
    }

    descendant = react_test_utils.normalizeReactComponent(descendant);

    bool hasValue;

    if (descendant['tagName'] is String) {
      hasValue = findDomNode(descendant).attributes[key] == value;
    } else {
      hasValue = getProps(descendant)[key] == value;
    }

    if (hasValue) {
      first = true;
    }

    return hasValue;
  }));

  if (results.isEmpty) {
    return null;
  } else {
    return react_test_utils.normalizeReactComponent(results.single);
  }
}
/// Returns the [Element] of the first descendant of [root] that has its [key] prop value set to [value].
///
/// Returns null if no descendant has its [key] prop value set to [value].
Element getDomByTestId(JsObject root, String value, {String key: 'data-test-id'}) {
  return findDomNode(getByTestId(root, value, key: key));
}

/// Returns the [react.Component] of the first descendant of [root] that has its [key] prop value set to [value].
///
/// Returns null if no descendant has its [key] prop value set to [value].
react.Component getComponentByTestId(JsObject root, String value, {String key: 'data-test-id'}) {
  var instance = getByTestId(root, value, key: key);
  if (instance != null) {
    return getDartComponent(instance);
  }

  return null;
}

/// Returns the props of the first descendant of [root] that has its [key] prop value set to [value].
///
/// Returns null if no descendant has its [key] prop value set to [value].
Map getPropsByTestId(JsObject root, String value, {String key: 'data-test-id'}) {
  var instance = getByTestId(root, value, key: key);
  if (instance != null) {
    return getProps(instance);
  }

  return null;
}

JsObject getByTestIdShallow(JsObject root, String value, {String key: 'data-test-id'}) {
  var descendant;

  getDescendant(_root) {
    if (_root['props'][key] == value || (getProps(_root) != null && getProps(_root)[key] == value)) {
      descendant = _root;
      return;
    }

    if (_root['props']['children'] is List) {
      flattenChildren(List children) {
        children.forEach((_child) {
          if (_child != null && _child is! List && _child['props'] != null) {
            getDescendant(_child);
          }  else if (_child is List) {
            flattenChildren(_child);
          }
        });
      }

      flattenChildren(_root['props']['children']);
    } else if (
      _root['props']['children'] is! String &&
      _root['props']['children'] != null &&
      _root['props']['children']['props'] != null
    ) {
      getDescendant(_root['props']['children']);
    }
  }

  getDescendant(root);

  return descendant;
}

/// Returns all descendants of a component that contain the specified prop key.
///
/// Note: propKey must be a valid HTML5 attribute.
List<JsObject> findDescendantsWithProp(JsObject root, dynamic propKey) {
  List descendantsWithProp = react_test_utils.findAllInRenderedTree(root, new JsFunction.withThis((_, descendant) {
    if (descendant == root) {
      return false;
    }

    descendant = react_test_utils.normalizeReactComponent(descendant);

    bool hasProp;
    if (react_test_utils.isDOMComponent(descendant)) {
      hasProp = findDomNode(descendant).attributes.containsKey(propKey);
    } else if (isDartComponent(descendant)) {
      hasProp = getDartComponent(descendant).props.containsKey(propKey);
    } else if (react_test_utils.isCompositeComponent(descendant)) {
      hasProp = descendant[PROPS].hasProperty(propKey);
    }

    return hasProp;
  }));

  descendantsWithProp = descendantsWithProp.map(react_test_utils.normalizeReactComponent).toList();

  return descendantsWithProp;
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

/// Helper method that returns the `displayName` of the provided React component [factory].
String getNameFromFactory(BuilderOnlyUiFactory factory) => factory().componentFactory.reactClass['displayName'];
