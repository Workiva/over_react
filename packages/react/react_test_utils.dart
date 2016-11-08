// Copyright (c) 2016, the Clean project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS()
library react.test_utils;

import 'package:js/js.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/src/react_test_utils/simulate_wrappers.dart' as simulate_wrappers;

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


/// Returns the 'type' of a component.
///
/// For a DOM components, this with return the String corresponding to its tagName ('div', 'a', etc.).
/// For React.createClass()-based components, this with return the [ReactClass].
dynamic getComponentType(ReactComponentFactory componentFactory) {
  if (componentFactory is ReactComponentFactoryProxy) {
    return componentFactory.type;
  }
  return null;
}

typedef bool ComponentTestFunction(/* [1] */ component);

/// Event simulation interface.
///
/// Provides methods for each type of event that can be handled by a React
/// component.  All methods are used in the same way:
///
///   Simulate.{eventName}(ReactComponent|Element componentOrNode, [Map] eventData)
///
/// This should include all events documented at:
/// http://facebook.github.io/react/docs/events.html
class Simulate {
  static void blur(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.blur(componentOrNode, jsify(eventData));
  static void change(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.change(componentOrNode, jsify(eventData));
  static void click(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.click(componentOrNode, jsify(eventData));
  static void contextMenu(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.contextMenu(componentOrNode, jsify(eventData));
  static void copy(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.copy(componentOrNode, jsify(eventData));
  static void cut(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.cut(componentOrNode, jsify(eventData));
  static void doubleClick(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.doubleClick(componentOrNode, jsify(eventData));
  static void drag(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.drag(componentOrNode, jsify(eventData));
  static void dragEnd(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.dragEnd(componentOrNode, jsify(eventData));
  static void dragEnter(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.dragEnter(componentOrNode, jsify(eventData));
  static void dragExit(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.dragExit(componentOrNode, jsify(eventData));
  static void dragLeave(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.dragLeave(componentOrNode, jsify(eventData));
  static void dragOver(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.dragOver(componentOrNode, jsify(eventData));
  static void dragStart(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.dragStart(componentOrNode, jsify(eventData));
  static void drop(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.drop(componentOrNode, jsify(eventData));
  static void focus(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.focus(componentOrNode, jsify(eventData));
  static void input(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.input(componentOrNode, jsify(eventData));
  static void keyDown(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.keyDown(componentOrNode, jsify(eventData));
  static void keyPress(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.keyPress(componentOrNode, jsify(eventData));
  static void keyUp(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.keyUp(componentOrNode, jsify(eventData));
  static void mouseDown(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.mouseDown(componentOrNode, jsify(eventData));
  static void mouseMove(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.mouseMove(componentOrNode, jsify(eventData));
  static void mouseOut(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.mouseOut(componentOrNode, jsify(eventData));
  static void mouseOver(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.mouseOver(componentOrNode, jsify(eventData));
  static void mouseUp(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.mouseUp(componentOrNode, jsify(eventData));
  static void paste(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.paste(componentOrNode, jsify(eventData));
  static void scroll(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.scroll(componentOrNode, jsify(eventData));
  static void submit(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.submit(componentOrNode, jsify(eventData));
  static void touchCancel(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.touchCancel(componentOrNode, jsify(eventData));
  static void touchEnd(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.touchEnd(componentOrNode, jsify(eventData));
  static void touchMove(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.touchMove(componentOrNode, jsify(eventData));
  static void touchStart(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.touchStart(componentOrNode, jsify(eventData));
  static void wheel(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.Simulate.wheel(componentOrNode, jsify(eventData));
}

/// Native event simulation interface.
///
/// Current implementation does not support change and keyPress native events
///
/// Provides methods for each type of event that can be handled by a React
/// component.  All methods are used in the same way:
///
///   SimulateNative.{eventName}(/* [1] */ componentOrNode, [Map] eventData)
class SimulateNative {
  static void blur(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.blur(componentOrNode, jsify(eventData));
  static void click(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.click(componentOrNode, jsify(eventData));
  static void contextMenu(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.contextMenu(componentOrNode, jsify(eventData));
  static void copy(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.copy(componentOrNode, jsify(eventData));
  static void cut(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.cut(componentOrNode, jsify(eventData));
  static void doubleClick(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.doubleClick(componentOrNode, jsify(eventData));
  static void drag(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.drag(componentOrNode, jsify(eventData));
  static void dragEnd(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.dragEnd(componentOrNode, jsify(eventData));
  static void dragEnter(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.dragEnter(componentOrNode, jsify(eventData));
  static void dragExit(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.dragExit(componentOrNode, jsify(eventData));
  static void dragLeave(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.dragLeave(componentOrNode, jsify(eventData));
  static void dragOver(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.dragOver(componentOrNode, jsify(eventData));
  static void dragStart(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.dragStart(componentOrNode, jsify(eventData));
  static void drop(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.drop(componentOrNode, jsify(eventData));
  static void focus(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.focus(componentOrNode, jsify(eventData));
  static void input(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.input(componentOrNode, jsify(eventData));
  static void keyDown(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.keyDown(componentOrNode, jsify(eventData));
  static void keyUp(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.keyUp(componentOrNode, jsify(eventData));
  static void mouseDown(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.mouseDown(componentOrNode, jsify(eventData));
  static void mouseMove(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.mouseMove(componentOrNode, jsify(eventData));
  static void mouseOut(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.mouseOut(componentOrNode, jsify(eventData));
  static void mouseOver(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.mouseOver(componentOrNode, jsify(eventData));
  static void mouseUp(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.mouseUp(componentOrNode, jsify(eventData));
  static void paste(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.paste(componentOrNode, jsify(eventData));
  static void scroll(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.scroll(componentOrNode, jsify(eventData));
  static void submit(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.submit(componentOrNode, jsify(eventData));
  static void touchCancel(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.touchCancel(componentOrNode, jsify(eventData));
  static void touchEnd(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.touchEnd(componentOrNode, jsify(eventData));
  static void touchMove(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.touchMove(componentOrNode, jsify(eventData));
  static void touchStart(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.touchStart(componentOrNode, jsify(eventData));
  static void wheel(/* [1] */ componentOrNode, [Map eventData = const {}]) => simulate_wrappers.SimulateNative.wheel(componentOrNode, jsify(eventData));
}

/// Traverse all components in tree and accumulate all components where
/// test(component) is true. This is not that useful on its own, but it's
/// used as a primitive for other test utils
///
/// Included in Dart for completeness
@JS('React.addons.TestUtils.findAllInRenderedTree')
external List<dynamic> findAllInRenderedTree(/* [1] */ tree, ComponentTestFunction test);

/// Like scryRenderedDOMComponentsWithClass() but expects there to be one
/// result, and returns that one result, or throws exception if there is
/// any other number of matches besides one.
@JS('React.addons.TestUtils.findRenderedDOMComponentWithClass')
external dynamic /* [1] */ findRenderedDOMComponentWithClass(/* [1] */ tree, String className);

/// Like scryRenderedDOMComponentsWithTag() but expects there to be one result,
/// and returns that one result, or throws exception if there is any other
/// number of matches besides one.
@JS('React.addons.TestUtils.findRenderedDOMComponentWithTag')
external dynamic /* [1] */ findRenderedDOMComponentWithTag(/* [1] */ tree, String tag);


@JS('React.addons.TestUtils.findRenderedComponentWithType')
external dynamic /* [1] */ _findRenderedComponentWithType(/* [1] */ tree, dynamic type);

/// Same as scryRenderedComponentsWithType() but expects there to be one result
/// and returns that one result, or throws exception if there is any other
/// number of matches besides one.
/* [1] */ findRenderedComponentWithType(
    /* [1] */ tree, ReactComponentFactory componentType) {
  return _findRenderedComponentWithType(tree, getComponentType(componentType));
}

@JS('React.addons.TestUtils.isCompositeComponent')
external bool _isCompositeComponent(/* [1] */ instance);

/// Returns true if element is a composite component.
/// (created with React.createClass()).
bool isCompositeComponent(/* [1] */ instance) {
  return _isCompositeComponent(instance)
         // Workaround for DOM components being detected as composite: https://github.com/facebook/react/pull/3839
         && getProperty(instance, 'tagName') == null;
}

@JS('React.addons.TestUtils.isCompositeComponentWithType')
external bool _isCompositeComponentWithType(/* [1] */ instance, dynamic type);

/// Returns true if instance is a composite component.
/// (created with React.createClass()) whose type is of a React componentClass.
bool isCompositeComponentWithType(/* [1] */ instance, ReactComponentFactory componentClass) {
  return _isCompositeComponentWithType(instance, getComponentType(componentClass));
}

/// Returns true if instance is a DOM component (such as a <div> or <span>).
@JS('React.addons.TestUtils.isDOMComponent')
external bool isDOMComponent(/* [1] */ instance);

/// Returns true if [object] is a valid React component.
@JS('React.addons.TestUtils.isElement')
external bool isElement(dynamic object);

@JS('React.addons.TestUtils.isElementOfType')
external bool _isElementOfType(dynamic element, dynamic componentClass);

/// Returns true if [element] is a ReactElement whose type is of a
/// React componentClass.
bool isElementOfType(dynamic element, ReactComponentFactory componentFactory) {
  return _isElementOfType(element, getComponentType(componentFactory));
}

@JS('React.addons.TestUtils.scryRenderedComponentsWithType')
external List<dynamic> /* [1] */ _scryRenderedComponentsWithType(/* [1] */ tree, dynamic type);

/// Finds all instances of components with type equal to componentClass.
List<dynamic> /* [1] */ scryRenderedComponentsWithType(/* [1] */ tree, ReactComponentFactory componentClass) {
  return _scryRenderedComponentsWithType(tree, getComponentType(componentClass));
}

@JS('React.addons.TestUtils.scryRenderedDOMComponentsWithClass')
/// Finds all instances of components in the rendered tree that are DOM
/// components with the class name matching className.
external List<dynamic> scryRenderedDOMComponentsWithClass(/* [1] */ tree, String className);

@JS('React.addons.TestUtils.scryRenderedDOMComponentsWithTag')
/// Finds all instances of components in the rendered tree that are DOM
/// components with the tag name matching tagName.
external List<dynamic> scryRenderedDOMComponentsWithTag(/* [1] */ tree, String tagName);

/// Render a Component into a detached DOM node in the document.
@JS('React.addons.TestUtils.renderIntoDocument')
external /* [1] */ renderIntoDocument(ReactElement instance);

/// Pass a mocked component module to this method to augment it with useful
/// methods that allow it to be used as a dummy React component. Instead of
/// rendering as usual, the component will become a simple <div> (or other tag
/// if mockTagName is provided) containing any provided children.
@JS('React.addons.TestUtils.mockComponent')
external ReactClass mockComponent(ReactClass componentClass, String mockTagName);

/// Returns a ReactShallowRenderer instance
///
/// More info on using shallow rendering: https://facebook.github.io/react/docs/test-utils.html#shallow-rendering
@JS('React.addons.TestUtils.createRenderer')
external ReactShallowRenderer createRenderer();

/// ReactShallowRenderer wrapper
///
/// Usage:
/// ```
/// ReactShallowRenderer shallowRenderer = createRenderer();
/// shallowRenderer.render(div({'className': 'active'}));
///
/// ReactElement renderedOutput = shallowRenderer.getRenderOutput();
/// Map props = getProps(renderedOutput);
/// expect(props['className'], 'active');
/// ```
///
/// See react_with_addons.js#ReactShallowRenderer
@JS()
class ReactShallowRenderer {
  /// Get the rendered output. [render] must be called first
  external ReactElement getRenderOutput();
  external void render(ReactElement element, [context]);
  external void unmount();
}
