// Copyright (c) 2016, the Clean project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library react_dom_server;

/// Renders a ReactElement to its initial HTML. This should only be used on the server.
/// React will return an HTML string. You can use this method to generate HTML on the
/// server and send the markup down on the initial request for faster page loads and to
/// allow search engines to crawl your pages for SEO purposes.

/// If you call `ReactDOM.render()` on a node that already has this server-rendered markup,
/// React will preserve it and only attach event handlers, allowing you to have a very
/// performant first-load experience.
var renderToString;

/// Similar to [renderToString], except this doesn't create extra DOM attributes such as
/// data-react-id, that React uses internally. This is useful if you want to use React
/// as a simple static page generator, as stripping away the extra attributes can save
/// lots of bytes.
var renderToStaticMarkup;

/// Sets configuration based on passed functions.
///
/// Passes arguments to global variables.
setReactDOMServerConfiguration(customRenderToString, customRenderToStaticMarkup) {
  renderToString = customRenderToString;
  renderToStaticMarkup = customRenderToStaticMarkup;
}
