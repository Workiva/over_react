// Copyright (c) 2016, the Clean project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library react_dom;

/// Renders a ReactElement into the DOM in the supplied [container] and return a reference to the [component]
/// (or returns null for stateless components).
///
/// If the ReactElement was previously rendered into the [container], this will perform an update on it and only
/// mutate the DOM as necessary to reflect the latest React component.
var render = (component, container) {
  throw new Exception('setClientConfiguration must be called before render.');
};

/// Removes a mounted React [Component] from the DOM and cleans up its event handlers and state. If no component
/// was mounted in the container, calling this function does nothing. Returns true if a component was unmounted
/// and false if there was no component to unmount.
var unmountComponentAtNode;

/// If the [Component] has been mounted into the DOM, this returns the corresponding native browser DOM [Element].
var findDOMNode;

/// Sets configuration based on passed functions.
///
/// Passes arguments to global variables.
setReactDOMConfiguration(customRender, customUnmountComponentAtNode, customFindDOMNode) {
  render = customRender;
  unmountComponentAtNode = customUnmountComponentAtNode;
  findDOMNode = customFindDOMNode;
}
