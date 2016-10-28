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
library test_util.react_util;

import 'dart:collection';
import 'dart:html';

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_test_utils.dart' as react_test_utils;

export 'package:over_react/src/util/react_wrappers.dart';

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

/// Maximum number of components that can be rendered at a given time, before being automatically unmounted.
///
/// Defaulted to `5` because typically a single test will not render more than `5` components.
int maxRenderedQueueLength = 5;

/// Maximum number of shallow renderers that can be mounted at a given time, before being automatically unmounted.
///
/// Defaulted to `5` because typically a single test will not create more than `5` shallow renderers.
int maxShallowRendererQueueLength = 5;

/// Rolling list of rendered instances.
///
/// Should never have a length that exceeds [maxRenderedQueueLength].
var _renderedInstances = [];

/// Rolling list of shallow renderers.
///
/// Should never have a length that exceeds [maxShallowRendererQueueLength].
var _shallowRenderers = [];

/// Adds [renderedInstance] to [_renderedInstances].
///
/// If [_renderedInstances.length] is larger than or equal to [maxRenderedQueueLength] the oldest instance will be
/// unmounted and removed from the list.
void _addToRenderedInstanceQueue(dynamic renderedInstance) {
  if (_renderedInstances.length >= maxRenderedQueueLength) {
    unmount(_renderedInstances.last);
    _renderedInstances.removeLast();
  }

  _renderedInstances.insert(0, renderedInstance);
}

/// Adds [renderer] to [_shallowRenderers].
///
/// If [_shallowRenderers.length] is larger than or equal to [maxShallowRendererQueueLength] the oldest rendered will be
/// unmounted and removed from the list.
void _addToShallowRendererQueue(react_test_utils.ReactShallowRenderer renderer) {
  if (_shallowRenderers.length >= maxShallowRendererQueueLength) {
    _shallowRenderers.last.unmount();
    _shallowRenderers.removeLast();
  }

  _shallowRenderers.insert(0, renderer);
}

/// Renders a React component or builder into a detached node and returns the component instance.
///
/// By default the rendered instance will be added to [_shallowRenderers] via [_addToShallowRendererQueue] to not
/// have this happen set [addToRenderedQueue] to false.
/* [1] */ render(dynamic component, {bool addToRenderedQueue: true}) {
  var renderedInstance = react_test_utils.renderIntoDocument(component is component_base.UiProps ? component.build() : component);
  if (addToRenderedQueue) _addToRenderedInstanceQueue(renderedInstance);
  return renderedInstance;
}

/// Shallow-renders a component using [react_test_utils.ReactShallowRenderer].
///
/// By default the rendered instance will be added to [_renderedInstances] via [_addToRenderedInstanceQueue] to not
/// have this happen set [addToRenderedQueue] to false.
///
/// See: <https://facebook.github.io/react/docs/test-utils.html#shallow-rendering>.
ReactElement renderShallow(ReactElement instance, {bool addToRendererQueue: true}) {
  var renderer = react_test_utils.createRenderer();
  if (addToRendererQueue) _addToShallowRendererQueue(renderer);
  renderer.render(instance);
  return renderer.getRenderOutput();
}

/// Unmounts a React component.
///
/// [instanceOrContainerNode] can be a [ReactComponent]/[Element] React instance,
/// or an [Element] container node (argument to [react_dom.render]).
///
/// For convenience, this method does nothing if [instanceOrContainerNode] is null,
/// or if it's a non-mounted React instance.
void unmount(dynamic instanceOrContainerNode) {
  if (instanceOrContainerNode == null) {
    return;
  }

  Element containerNode;

  if (instanceOrContainerNode is Element) {
    containerNode = instanceOrContainerNode;
  } else if (
      react_test_utils.isCompositeComponent(instanceOrContainerNode) ||
      react_test_utils.isDOMComponent(instanceOrContainerNode)
  ) {
    if (!instanceOrContainerNode.isMounted()) {
      return;
    }

    containerNode = findDomNode(instanceOrContainerNode)?.parent;
  } else {
    throw new ArgumentError(
        '`instanceOrNode` must be null, a ReactComponent instance, or an Element. Was: $instanceOrContainerNode.'
    );
  }

  if (containerNode != null) react_dom.unmountComponentAtNode(containerNode);
}

/// Renders a React component or builder into a detached node and returns the associated DOM node.
///
/// By default the rendered instance will be added to [_renderedInstances] via [_addToRenderedInstanceQueue] to not
/// have this happen set [addToRenderedQueue] to false.
Element renderAndGetDom(dynamic component, {bool addToRenderedQueue: true}) {
  return findDomNode(render(component, addToRenderedQueue: addToRenderedQueue));
}

/// Renders a React component or builder into a detached node and returns the associated Dart component.
react.Component renderAndGetComponent(dynamic component) => getDartComponent(render(component));

/// List of elements attached to the DOM and used as mount points in previous calls to [renderAttachedToDocument].
List<Element> _attachedReactContainers = [];

/// Renders the component into the document as opposed to a headless node.
/// Returns the rendered component.
/* [1] */ renderAttachedToDocument(dynamic component) {
  var container = new DivElement()
    ..className = 'render-attached-to-document-container'
    // Set arbitrary height and width for container to ensure nothing is cut off.
    ..style.setProperty('width', '800px')
    ..style.setProperty('height', '800px');

  _attachedReactContainers.add(container);

  document.body.append(container);

  return react_dom.render(component is component_base.UiProps ? component.build() : component, container);
}

/// Unmounts and removes the mount nodes for components rendered via [renderAttachedToDocument].
void tearDownAttachedNodes() {
  _attachedReactContainers.forEach((container) {
    react_dom.unmountComponentAtNode(container);
    container.remove();
  });

  _attachedReactContainers.clear();
}

/// Returns a rendered component's ref, or null if it doesn't exist.
///
/// The return type is [ReactComponent] for composite components, and [Element] for DOM components.
///
/// Using `getRef()` can be tedious for nested / complex components. It is recommended to use [getByTestId] instead.
dynamic getRef(ReactComponent instance, dynamic ref) {
  if (instance == null) {
    return null;
  }
  return getProperty(instance.refs, ref);
}

typedef void _EventSimulatorAlias(componentOrNode, [Map eventData]);

/// Helper function to simulate clicks
final _EventSimulatorAlias click = react_test_utils.Simulate.click;

/// Helper function to simulate change
final _EventSimulatorAlias change = react_test_utils.Simulate.change;

/// Helper function to simulate focus
final _EventSimulatorAlias focus = react_test_utils.Simulate.focus;

/// Helper function to simulate blur
final _EventSimulatorAlias blur = react_test_utils.Simulate.blur;

/// Helper function to simulate mouseMove events.
final _EventSimulatorAlias mouseMove = react_test_utils.Simulate.mouseMove;

/// Helper function to simulate keyDown events.
final _EventSimulatorAlias keyDown = react_test_utils.Simulate.keyDown;

/// Helper function to simulate keyUp events.
final _EventSimulatorAlias keyUp = react_test_utils.Simulate.keyUp;

/// Helper function to simulate keyPress events.
final _EventSimulatorAlias keyPress = react_test_utils.Simulate.keyPress;

/// Helper function to simulate mouseEnter events.
final _EventSimulatorAlias mouseEnter = (componentOrNode, [Map eventData = const {}]) =>
    Simulate._mouseEnter(componentOrNode, jsify(eventData));

/// Helper function to simulate mouseLeave events.
final _EventSimulatorAlias mouseLeave = (componentOrNode, [Map eventData = const {}]) =>
    Simulate._mouseLeave(componentOrNode, jsify(eventData));

@JS('React.addons.TestUtils.Simulate')
abstract class Simulate {
  @JS('mouseEnter')
  external static void _mouseEnter(dynamic target, [eventData]);

  @JS('mouseLeave')
  external static void _mouseLeave(dynamic target, [eventData]);
}

/// Returns whether [props] contains [key] with a value set to a space-delimited string containing [value].
bool _hasTestId(Map props, String key, String value) {
  var testId = props[key];
  return testId != null && splitSpaceDelimitedString(testId.toString()).contains(value);
}

/// Returns the first descendant of [root] that has its [key] test ID prop value set to a space-delimited string
/// containing [value], or null if no matching descendant can be found.
///
/// This method works for:
///
/// * [ReactComponent] render trees (output of [render])
/// * [ReactElement] trees (output of [renderShallow]/[Component.render])
///
/// __Example:__
///
///     var renderedInstance = render(Dom.div()(
///         // Div1
///         (Dom.div()..addTestId('first-div'))()
///
///         Dom.div()(
///           // Div2
///           (Dom.div()
///             ..addTestId('second-div')
///             ..addTestId('nested-div')
///           )()
///         )
///       )
///     );
///
///     var firstDiv = getByTestId(renderedInstance, 'first-div'); // Returns Div1
///     var secondDiv = getByTestId(renderedInstance, 'second-div'); // Returns Div2
///     var nestedDiv = getByTestId(renderedInstance, 'nested-div'); // Returns Div2
///     var nonexistentDiv = getByTestId(renderedInstance, 'nonexistent-div'); // Returns null
///
/// It is recommended that, instead of setting this [key] prop manually, you should use the
/// [UiProps.addTestId] method so the prop is only set in a test environment.
/* [1] */ getByTestId(/* [1] */ root, String value, {String key: defaultTestIdKey}) {
  if (isValidElement(root)) {
    return _getByTestIdShallow(root, value, key: key);
  }

  bool first = false;

  var results = react_test_utils.findAllInRenderedTree(root, allowInterop((ReactComponent descendant) {
    if (first) {
      return false;
    }

    var props = react_test_utils.isDOMComponent(descendant)
      ? findDomNode(descendant).attributes
      : getProps(descendant);

    bool hasValue = _hasTestId(props, key, value);

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
/// Returns the [Element] of the first descendant of [root] that has its [key] prop value set to [value].
///
/// Returns null if no descendant has its [key] prop value set to [value].
Element getDomByTestId(/* [1] */ root, String value, {String key: defaultTestIdKey}) {
  return findDomNode(getByTestId(root, value, key: key));
}

/// Returns the [react.Component] of the first descendant of [root] that has its [key] prop value set to [value].
///
/// Returns null if no descendant has its [key] prop value set to [value].
react.Component getComponentByTestId(/* [1] */ root, String value, {String key: defaultTestIdKey}) {
  var instance = getByTestId(root, value, key: key);
  if (instance != null) {
    return getDartComponent(instance);
  }

  return null;
}

/// Returns the props of the first descendant of [root] that has its [key] prop value set to [value].
///
/// Returns null if no descendant has its [key] prop value set to [value].
Map getPropsByTestId(/* [1] */ root, String value, {String key: defaultTestIdKey}) {
  var instance = getByTestId(root, value, key: key);
  if (instance != null) {
    return getProps(instance);
  }

  return null;
}

ReactElement _getByTestIdShallow(ReactElement root, String value, {String key: defaultTestIdKey}) {
  Iterable flattenChildren(dynamic children) sync* {
    if (children is Iterable) {
      yield* children.expand(flattenChildren);
    } else {
      yield children;
    }
  }

  var breadthFirstDescendants = new Queue()..add(root);
  while (breadthFirstDescendants.isNotEmpty) {
    var descendant = breadthFirstDescendants.removeFirst();
    if (!isValidElement(descendant)) {
      continue;
    }

    var props = getProps(descendant);
    if (_hasTestId(props, key, value)) {
      return descendant;
    }

    breadthFirstDescendants.addAll(flattenChildren(props['children']));
  }

  return null;
}

/// Returns all descendants of a component that contain the specified prop key.
List findDescendantsWithProp(/* [1] */ root, dynamic propKey) {
  List descendantsWithProp = react_test_utils.findAllInRenderedTree(root, allowInterop((ReactComponent descendant) {
    if (descendant == root) {
      return false;
    }

    bool hasProp;
    if (isDartComponent(descendant)) {
      hasProp = getDartComponent(descendant).props.containsKey(propKey);
    } else if (react_test_utils.isCompositeComponent(descendant)) {
      hasProp = getProps(descendant).containsKey(propKey);
    } else if (react_test_utils.isDOMComponent(descendant)) {
      hasProp = findDomNode(descendant).attributes.containsKey(propKey);
    }

    return hasProp;
  }));

  return descendantsWithProp;
}

/// Helper component that renders whatever you tell it to. Necessary for rendering components with the 'ref' prop.
final RenderingContainerComponentFactory =
    react.registerComponent(() => new RenderingContainerComponent()) as ReactComponentFactory;

class RenderingContainerComponent extends react.Component {
  @override
  render() => props['renderer']();
}
