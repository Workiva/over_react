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

/// [UiComponent]-based api with typed props for react-dart DOM components.
library over_react.dom_components;

import 'package:over_react/src/component/prop_mixins.dart';
import 'package:over_react/src/component_declaration/component_base.dart' as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart' as builder_helpers;
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/src/react_client/js_backed_map.dart';

/// Returns a new [DomProps], optionally backed by a specified Map.
///
/// Convenient for adding DOM props inline to non-DOM components:
/// <pre>
/// <!>  ..addProps(domProps()..style = {'display': 'none'})
/// <!>  ..addProps(domProps()
/// <!>    ..id = 'my_component'
/// <!>    ..title = 'tooltip for my component'
/// <!>  )
/// </pre>
/// <!-- use pre tags and HTML markup until WebStorm fully supports Dart doc comment markdown -->
DomProps domProps([Map backingMap]) => new DomProps(null, backingMap);

typedef DomProps DomPropsFactory();

// Include pieces from builder_helpers so that consumers can type these instances
// as the `UiProps` exposed in `over_react.dart` and not have to pull in `component_base`.
class DomProps extends component_base.UiProps
    with
        DomPropsMixin,
        builder_helpers.GeneratedClass
    implements
        builder_helpers.UiProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  DomProps(this.componentFactory, [Map props]) : this.props = props ?? new JsBackedMap();

  @override
  ReactComponentFactoryProxy componentFactory;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';
}

// Include pieces from builder_helpers so that consumers can type these instances
// as the `UiProps` exposed in `over_react.dart` and not have to pull in `component_base`.
class SvgProps extends component_base.UiProps
    with
        DomPropsMixin,
        SvgPropsMixin,
        builder_helpers.GeneratedClass
    implements
        DomProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  SvgProps(this.componentFactory, [Map props]) : this.props = props ?? new JsBackedMap();

  @override
  ReactComponentFactoryProxy componentFactory;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';
}

/// A class that provides namespacing for static DOM component factory methods, much like `React.DOM` in React JS.
abstract class Dom {
  /// Returns a new builder that renders an `<a>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps a([Map backingMap]) => new DomProps(react.a, backingMap);
  /// Returns a new builder that renders an `<abbr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps abbr([Map backingMap]) => new DomProps(react.abbr, backingMap);
  /// Returns a new builder that renders an `<address>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps address([Map backingMap]) => new DomProps(react.address, backingMap);
  /// Returns a new builder that renders an `<area>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps area([Map backingMap]) => new DomProps(react.area, backingMap);
  /// Returns a new builder that renders an `<article>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps article([Map backingMap]) => new DomProps(react.article, backingMap);
  /// Returns a new builder that renders an `<aside>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps aside([Map backingMap]) => new DomProps(react.aside, backingMap);
  /// Returns a new builder that renders an `<audio>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps audio([Map backingMap]) => new DomProps(react.audio, backingMap);
  /// Returns a new builder that renders a `<b>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps b([Map backingMap]) => new DomProps(react.b, backingMap);
  /// Returns a new builder that renders a `<base>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps base([Map backingMap]) => new DomProps(react.base, backingMap);
  /// Returns a new builder that renders a `<bdi>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps bdi([Map backingMap]) => new DomProps(react.bdi, backingMap);
  /// Returns a new builder that renders a `<bdo>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps bdo([Map backingMap]) => new DomProps(react.bdo, backingMap);
  /// Returns a new builder that renders a `<big>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps big([Map backingMap]) => new DomProps(react.big, backingMap);
  /// Returns a new builder that renders a `<blockquote>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps blockquote([Map backingMap]) => new DomProps(react.blockquote, backingMap);
  /// Returns a new builder that renders a `<body>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps body([Map backingMap]) => new DomProps(react.body, backingMap);
  /// Returns a new builder that renders a `<br>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps br([Map backingMap]) => new DomProps(react.br, backingMap);
  /// Returns a new builder that renders a `<button>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps button([Map backingMap]) => new DomProps(react.button, backingMap);
  /// Returns a new builder that renders a `<canvas>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps canvas([Map backingMap]) => new DomProps(react.canvas, backingMap);
  /// Returns a new builder that renders a `<caption>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps caption([Map backingMap]) => new DomProps(react.caption, backingMap);
  /// Returns a new builder that renders a `<cite>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps cite([Map backingMap]) => new DomProps(react.cite, backingMap);
  /// Returns a new builder that renders a `<code>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps code([Map backingMap]) => new DomProps(react.code, backingMap);
  /// Returns a new builder that renders a `<col>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps col([Map backingMap]) => new DomProps(react.col, backingMap);
  /// Returns a new builder that renders a `<colgroup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps colgroup([Map backingMap]) => new DomProps(react.colgroup, backingMap);
  /// Returns a new builder that renders a `<data>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps data([Map backingMap]) => new DomProps(react.data, backingMap);
  /// Returns a new builder that renders a `<datalist>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps datalist([Map backingMap]) => new DomProps(react.datalist, backingMap);
  /// Returns a new builder that renders a `<dd>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps dd([Map backingMap]) => new DomProps(react.dd, backingMap);
  /// Returns a new builder that renders a `<del>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps del([Map backingMap]) => new DomProps(react.del, backingMap);
  /// Returns a new builder that renders a `<details>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps details([Map backingMap]) => new DomProps(react.details, backingMap);
  /// Returns a new builder that renders a `<dfn>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps dfn([Map backingMap]) => new DomProps(react.dfn, backingMap);
  /// Returns a new builder that renders a `<dialog>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps dialog([Map backingMap]) => new DomProps(react.dialog, backingMap);
  /// Returns a new builder that renders a `<div>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps div([Map backingMap]) => new DomProps(react.div, backingMap);
  /// Returns a new builder that renders a `<dl>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps dl([Map backingMap]) => new DomProps(react.dl, backingMap);
  /// Returns a new builder that renders a `<dt>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps dt([Map backingMap]) => new DomProps(react.dt, backingMap);
  /// Returns a new builder that renders an `<em>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps em([Map backingMap]) => new DomProps(react.em, backingMap);
  /// Returns a new builder that renders an `<embed>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps embed([Map backingMap]) => new DomProps(react.embed, backingMap);
  /// Returns a new builder that renders a `<fieldset>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps fieldset([Map backingMap]) => new DomProps(react.fieldset, backingMap);
  /// Returns a new builder that renders a `<figcaption>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps figcaption([Map backingMap]) => new DomProps(react.figcaption, backingMap);
  /// Returns a new builder that renders a `<figure>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps figure([Map backingMap]) => new DomProps(react.figure, backingMap);
  /// Returns a new builder that renders a `<footer>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps footer([Map backingMap]) => new DomProps(react.footer, backingMap);
  /// Returns a new builder that renders a `<form>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps form([Map backingMap]) => new DomProps(react.form, backingMap);
  /// Returns a new builder that renders a `<h1>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps h1([Map backingMap]) => new DomProps(react.h1, backingMap);
  /// Returns a new builder that renders a `<h2>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps h2([Map backingMap]) => new DomProps(react.h2, backingMap);
  /// Returns a new builder that renders a `<h3>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps h3([Map backingMap]) => new DomProps(react.h3, backingMap);
  /// Returns a new builder that renders a `<h4>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps h4([Map backingMap]) => new DomProps(react.h4, backingMap);
  /// Returns a new builder that renders a `<h5>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps h5([Map backingMap]) => new DomProps(react.h5, backingMap);
  /// Returns a new builder that renders a `<h6>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps h6([Map backingMap]) => new DomProps(react.h6, backingMap);
  /// Returns a new builder that renders a `<head>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps head([Map backingMap]) => new DomProps(react.head, backingMap);
  /// Returns a new builder that renders a `<header>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps header([Map backingMap]) => new DomProps(react.header, backingMap);
  /// Returns a new builder that renders a `<hr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps hr([Map backingMap]) => new DomProps(react.hr, backingMap);
  /// Returns a new builder that renders a `<html>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps html([Map backingMap]) => new DomProps(react.html, backingMap);
  /// Returns a new builder that renders an `<i>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps i([Map backingMap]) => new DomProps(react.i, backingMap);
  /// Returns a new builder that renders an `<iframe>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps iframe([Map backingMap]) => new DomProps(react.iframe, backingMap);
  /// Returns a new builder that renders an `<img>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps img([Map backingMap]) => new DomProps(react.img, backingMap);
  /// Returns a new builder that renders an `<input>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps input([Map backingMap]) => new DomProps(react.input, backingMap);
  /// Returns a new builder that renders an `<ins>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps ins([Map backingMap]) => new DomProps(react.ins, backingMap);
  /// Returns a new builder that renders a `<kbd>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps kbd([Map backingMap]) => new DomProps(react.kbd, backingMap);
  /// Returns a new builder that renders a `<keygen>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps keygen([Map backingMap]) => new DomProps(react.keygen, backingMap);
  /// Returns a new builder that renders a `<label>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps label([Map backingMap]) => new DomProps(react.label, backingMap);
  /// Returns a new builder that renders a `<legend>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps legend([Map backingMap]) => new DomProps(react.legend, backingMap);
  /// Returns a new builder that renders a `<li>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps li([Map backingMap]) => new DomProps(react.li, backingMap);
  /// Returns a new builder that renders a `<link>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps link([Map backingMap]) => new DomProps(react.link, backingMap);
  /// Returns a new builder that renders a `<main>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps main([Map backingMap]) => new DomProps(react.main, backingMap);
  /// Returns a new builder that renders a `<backingMap>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps map([Map backingMap]) => new DomProps(react.map, backingMap);
  /// Returns a new builder that renders a `<mark>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps mark([Map backingMap]) => new DomProps(react.mark, backingMap);
  /// Returns a new builder that renders a `<menu>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps menu([Map backingMap]) => new DomProps(react.menu, backingMap);
  /// Returns a new builder that renders a `<menuitem>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps menuitem([Map backingMap]) => new DomProps(react.menuitem, backingMap);
  /// Returns a new builder that renders a `<meta>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps meta([Map backingMap]) => new DomProps(react.meta, backingMap);
  /// Returns a new builder that renders a `<meter>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps meter([Map backingMap]) => new DomProps(react.meter, backingMap);
  /// Returns a new builder that renders a `<nav>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps nav([Map backingMap]) => new DomProps(react.nav, backingMap);
  /// Returns a new builder that renders a `<noscript>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps noscript([Map backingMap]) => new DomProps(react.noscript, backingMap);
  /// Returns a new builder that renders an `<object>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps object([Map backingMap]) => new DomProps(react.object, backingMap);
  /// Returns a new builder that renders an `<ol>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps ol([Map backingMap]) => new DomProps(react.ol, backingMap);
  /// Returns a new builder that renders an `<optgroup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps optgroup([Map backingMap]) => new DomProps(react.optgroup, backingMap);
  /// Returns a new builder that renders an `<option>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps option([Map backingMap]) => new DomProps(react.option, backingMap);
  /// Returns a new builder that renders an `<output>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps output([Map backingMap]) => new DomProps(react.output, backingMap);
  /// Returns a new builder that renders a `<p>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps p([Map backingMap]) => new DomProps(react.p, backingMap);
  /// Returns a new builder that renders a `<param>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps param([Map backingMap]) => new DomProps(react.param, backingMap);
  /// Returns a new builder that renders a `<picture>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps picture([Map backingMap]) => new DomProps(react.picture, backingMap);
  /// Returns a new builder that renders a `<pre>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps pre([Map backingMap]) => new DomProps(react.pre, backingMap);
  /// Returns a new builder that renders a `<progress>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps progress([Map backingMap]) => new DomProps(react.progress, backingMap);
  /// Returns a new builder that renders a `<q>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps q([Map backingMap]) => new DomProps(react.q, backingMap);
  /// Returns a new builder that renders a `<rp>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps rp([Map backingMap]) => new DomProps(react.rp, backingMap);
  /// Returns a new builder that renders a `<rt>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps rt([Map backingMap]) => new DomProps(react.rt, backingMap);
  /// Returns a new builder that renders a `<ruby>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps ruby([Map backingMap]) => new DomProps(react.ruby, backingMap);
  /// Returns a new builder that renders a `<s>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps s([Map backingMap]) => new DomProps(react.s, backingMap);
  /// Returns a new builder that renders a `<samp>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps samp([Map backingMap]) => new DomProps(react.samp, backingMap);
  /// Returns a new builder that renders a `<script>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps script([Map backingMap]) => new DomProps(react.script, backingMap);
  /// Returns a new builder that renders a `<section>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps section([Map backingMap]) => new DomProps(react.section, backingMap);
  /// Returns a new builder that renders a `<select>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps select([Map backingMap]) => new DomProps(react.select, backingMap);
  /// Returns a new builder that renders a `<small>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps small([Map backingMap]) => new DomProps(react.small, backingMap);
  /// Returns a new builder that renders a `<source>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps source([Map backingMap]) => new DomProps(react.source, backingMap);
  /// Returns a new builder that renders a `<span>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps span([Map backingMap]) => new DomProps(react.span, backingMap);
  /// Returns a new builder that renders a `<strong>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps strong([Map backingMap]) => new DomProps(react.strong, backingMap);
  /// Returns a new builder that renders a `<style>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps style([Map backingMap]) => new DomProps(react.style, backingMap);
  /// Returns a new builder that renders a `<sub>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps sub([Map backingMap]) => new DomProps(react.sub, backingMap);
  /// Returns a new builder that renders a `<summary>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps summary([Map backingMap]) => new DomProps(react.summary, backingMap);
  /// Returns a new builder that renders a `<sup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps sup([Map backingMap]) => new DomProps(react.sup, backingMap);
  /// Returns a new builder that renders a `<table>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps table([Map backingMap]) => new DomProps(react.table, backingMap);
  /// Returns a new builder that renders a `<tbody>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps tbody([Map backingMap]) => new DomProps(react.tbody, backingMap);
  /// Returns a new builder that renders a `<td>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps td([Map backingMap]) => new DomProps(react.td, backingMap);
  /// Returns a new builder that renders a `<textarea>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps textarea([Map backingMap]) => new DomProps(react.textarea, backingMap);
  /// Returns a new builder that renders a `<tfoot>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps tfoot([Map backingMap]) => new DomProps(react.tfoot, backingMap);
  /// Returns a new builder that renders a `<th>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps th([Map backingMap]) => new DomProps(react.th, backingMap);
  /// Returns a new builder that renders a `<thead>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps thead([Map backingMap]) => new DomProps(react.thead, backingMap);
  /// Returns a new builder that renders a `<time>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps time([Map backingMap]) => new DomProps(react.time, backingMap);
  /// Returns a new builder that renders a `<title>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps title([Map backingMap]) => new DomProps(react.title, backingMap);
  /// Returns a new builder that renders a `<tr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps tr([Map backingMap]) => new DomProps(react.tr, backingMap);
  /// Returns a new builder that renders a `<track>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps track([Map backingMap]) => new DomProps(react.track, backingMap);
  /// Returns a new builder that renders an `<u>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps u([Map backingMap]) => new DomProps(react.u, backingMap);
  /// Returns a new builder that renders an `<ul>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps ul([Map backingMap]) => new DomProps(react.ul, backingMap);
  /// Returns a new builder that renders a `<var>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps variable([Map backingMap]) => new DomProps(react.variable, backingMap);
  /// Returns a new builder that renders a `<video>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps video([Map backingMap]) => new DomProps(react.video, backingMap);
  /// Returns a new builder that renders a `<wbr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
 static DomProps wbr([Map backingMap]) => new DomProps(react.wbr, backingMap);

  // SVG Elements
  /// Returns a new builder that renders an `<a>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgA([Map backingMap]) => new SvgProps(react.a, backingMap);
  /// Returns a new builder that renders an `<altGlyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyph([Map backingMap]) => new SvgProps(react.altGlyph, backingMap);
  /// Returns a new builder that renders an `<altGlyphDef>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyphDef([Map backingMap]) => new SvgProps(react.altGlyphDef, backingMap);
  /// Returns a new builder that renders an `<altGlyphItem>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyphItem([Map backingMap]) => new SvgProps(react.altGlyphItem, backingMap);
  /// Returns a new builder that renders an `<animate>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animate([Map backingMap]) => new SvgProps(react.animate, backingMap);
  /// Returns a new builder that renders an `<animateColor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateColor([Map backingMap]) => new SvgProps(react.animateColor, backingMap);
  /// Returns a new builder that renders an `<animateMotion>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateMotion([Map backingMap]) => new SvgProps(react.animateMotion, backingMap);
  /// Returns a new builder that renders an `<animateTransform>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateTransform([Map backingMap]) => new SvgProps(react.animateTransform, backingMap);
  /// Returns a new builder that renders an `<audio>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgAudio([Map backingMap]) => new SvgProps(react.audio, backingMap);
  /// Returns a new builder that renders a `<canvas>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgCanvas([Map backingMap]) => new SvgProps(react.canvas, backingMap);
  /// Returns a new builder that renders a `<circle>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps circle([Map backingMap]) => new SvgProps(react.circle, backingMap);
  /// Returns a new builder that renders a `<clipPath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps clipPath([Map backingMap]) => new SvgProps(react.clipPath, backingMap);
  /// Returns a new builder that renders a `<color-profile>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps colorProfile([Map backingMap]) => new SvgProps(react.colorProfile, backingMap);
  /// Returns a new builder that renders a `<cursor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps cursor([Map backingMap]) => new SvgProps(react.cursor, backingMap);
  /// Returns a new builder that renders a `<defs>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps defs([Map backingMap]) => new SvgProps(react.defs, backingMap);
  /// Returns a new builder that renders a `<desc>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps desc([Map backingMap]) => new SvgProps(react.desc, backingMap);
  /// Returns a new builder that renders a `<discard>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps discard([Map backingMap]) => new SvgProps(react.discard, backingMap);
  /// Returns a new builder that renders an `<ellipse>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps ellipse([Map backingMap]) => new SvgProps(react.ellipse, backingMap);
  /// Returns a new builder that renders a `<feBlend>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feBlend([Map backingMap]) => new SvgProps(react.feBlend, backingMap);
  /// Returns a new builder that renders a `<feColorMatrix>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feColorMatrix([Map backingMap]) => new SvgProps(react.feColorMatrix, backingMap);
  /// Returns a new builder that renders a `<feComponentTransfer>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feComponentTransfer([Map backingMap]) => new SvgProps(react.feComponentTransfer, backingMap);
  /// Returns a new builder that renders a `<feComposite>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feComposite([Map backingMap]) => new SvgProps(react.feComposite, backingMap);
  /// Returns a new builder that renders a `<feConvolveMatrix>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feConvolveMatrix([Map backingMap]) => new SvgProps(react.feConvolveMatrix, backingMap);
  /// Returns a new builder that renders a `<feDiffuseLighting>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDiffuseLighting([Map backingMap]) => new SvgProps(react.feDiffuseLighting, backingMap);
  /// Returns a new builder that renders a `<feDisplacementMap>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDisplacementMap([Map backingMap]) => new SvgProps(react.feDisplacementMap, backingMap);
  /// Returns a new builder that renders a `<feDistantLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDistantLight([Map backingMap]) => new SvgProps(react.feDistantLight, backingMap);
  /// Returns a new builder that renders a `<feDropShadow>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDropShadow([Map backingMap]) => new SvgProps(react.feDropShadow, backingMap);
  /// Returns a new builder that renders a `<feFlood>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFlood([Map backingMap]) => new SvgProps(react.feFlood, backingMap);
  /// Returns a new builder that renders a `<feFuncA>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncA([Map backingMap]) => new SvgProps(react.feFuncA, backingMap);
  /// Returns a new builder that renders a `<feFuncB>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncB([Map backingMap]) => new SvgProps(react.feFuncB, backingMap);
  /// Returns a new builder that renders a `<feFuncG>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncG([Map backingMap]) => new SvgProps(react.feFuncG, backingMap);
  /// Returns a new builder that renders a `<feFuncR>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncR([Map backingMap]) => new SvgProps(react.feFuncR, backingMap);
  /// Returns a new builder that renders a `<feGaussianBlur>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feGaussianBlur([Map backingMap]) => new SvgProps(react.feGaussianBlur, backingMap);
  /// Returns a new builder that renders a `<feImage>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feImage([Map backingMap]) => new SvgProps(react.feImage, backingMap);
  /// Returns a new builder that renders a `<feMerge>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMerge([Map backingMap]) => new SvgProps(react.feMerge, backingMap);
  /// Returns a new builder that renders a `<feMergeNode>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMergeNode([Map backingMap]) => new SvgProps(react.feMergeNode, backingMap);
  /// Returns a new builder that renders a `<feMorphology>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMorphology([Map backingMap]) => new SvgProps(react.feMorphology, backingMap);
  /// Returns a new builder that renders a `<feOffset>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feOffset([Map backingMap]) => new SvgProps(react.feOffset, backingMap);
  /// Returns a new builder that renders a `<fePointLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fePointLight([Map backingMap]) => new SvgProps(react.fePointLight, backingMap);
  /// Returns a new builder that renders a `<feSpecularLighting>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feSpecularLighting([Map backingMap]) => new SvgProps(react.feSpecularLighting, backingMap);
  /// Returns a new builder that renders a `<feSpotLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feSpotLight([Map backingMap]) => new SvgProps(react.feSpotLight, backingMap);
  /// Returns a new builder that renders a `<feTile>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feTile([Map backingMap]) => new SvgProps(react.feTile, backingMap);
  /// Returns a new builder that renders a `<feTurbulence>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feTurbulence([Map backingMap]) => new SvgProps(react.feTurbulence, backingMap);
  /// Returns a new builder that renders a `<filter>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps filter([Map backingMap]) => new SvgProps(react.filter, backingMap);
  /// Returns a new builder that renders a `<font>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps font([Map backingMap]) => new SvgProps(react.font, backingMap);
  /// Returns a new builder that renders a `<font-face>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFace([Map backingMap]) => new SvgProps(react.fontFace, backingMap);
  /// Returns a new builder that renders a `<font-face-format>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceFormat([Map backingMap]) => new SvgProps(react.fontFaceFormat, backingMap);
  /// Returns a new builder that renders a `<font-face-name>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceName([Map backingMap]) => new SvgProps(react.fontFaceName, backingMap);
  /// Returns a new builder that renders a `<font-face-src>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceSrc([Map backingMap]) => new SvgProps(react.fontFaceSrc, backingMap);
  /// Returns a new builder that renders a `<font-face-uri>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceUri([Map backingMap]) => new SvgProps(react.fontFaceUri, backingMap);
  /// Returns a new builder that renders a `<foreignObject>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps foreignObject([Map backingMap]) => new SvgProps(react.foreignObject, backingMap);
  /// Returns a new builder that renders a `<g>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps g([Map backingMap]) => new SvgProps(react.g, backingMap);
  /// Returns a new builder that renders a `<glyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps glyph([Map backingMap]) => new SvgProps(react.glyph, backingMap);
  /// Returns a new builder that renders a `<glyphRef>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps glyphRef([Map backingMap]) => new SvgProps(react.glyphRef, backingMap);
  /// Returns a new builder that renders a `<hatch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hatch([Map backingMap]) => new SvgProps(react.hatch, backingMap);
  /// Returns a new builder that renders a `<hatchpath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hatchpath([Map backingMap]) => new SvgProps(react.hatchpath, backingMap);
  /// Returns a new builder that renders a `<hkern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hkern([Map backingMap]) => new SvgProps(react.hkern, backingMap);
  /// Returns a new builder that renders an `<iframe>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgIframe([Map backingMap]) => new SvgProps(react.iframe, backingMap);
  /// Returns a new builder that renders an `<image>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps image([Map backingMap]) => new SvgProps(react.image, backingMap);
  /// Returns a new builder that renders a `<line>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps line([Map backingMap]) => new SvgProps(react.line, backingMap);
  /// Returns a new builder that renders a `<linearGradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps linearGradient([Map backingMap]) => new SvgProps(react.linearGradient, backingMap);
  /// Returns a new builder that renders a `<marker>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps marker([Map backingMap]) => new SvgProps(react.marker, backingMap);
  /// Returns a new builder that renders a `<mask>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mask([Map backingMap]) => new SvgProps(react.mask, backingMap);
  /// Returns a new builder that renders a `<mesh>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mesh([Map backingMap]) => new SvgProps(react.mesh, backingMap);
  /// Returns a new builder that renders a `<meshgradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshgradient([Map backingMap]) => new SvgProps(react.meshgradient, backingMap);
  /// Returns a new builder that renders a `<meshpatch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshpatch([Map backingMap]) => new SvgProps(react.meshpatch, backingMap);
  /// Returns a new builder that renders a `<meshrow>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshrow([Map backingMap]) => new SvgProps(react.meshrow, backingMap);
  /// Returns a new builder that renders a `<metadata>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps metadata([Map backingMap]) => new SvgProps(react.metadata, backingMap);
  /// Returns a new builder that renders a `<missing-glyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps missingGlyph([Map backingMap]) => new SvgProps(react.missingGlyph, backingMap);
  /// Returns a new builder that renders a `<mpath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mpath([Map backingMap]) => new SvgProps(react.mpath, backingMap);
  /// Returns a new builder that renders a `<path>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps path([Map backingMap]) => new SvgProps(react.path, backingMap);
  /// Returns a new builder that renders a `<pattern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps pattern([Map backingMap]) => new SvgProps(react.pattern, backingMap);
  /// Returns a new builder that renders a `<polygon>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps polygon([Map backingMap]) => new SvgProps(react.polygon, backingMap);
  /// Returns a new builder that renders a `<polyline>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps polyline([Map backingMap]) => new SvgProps(react.polyline, backingMap);
  /// Returns a new builder that renders a `<radialGradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps radialGradient([Map backingMap]) => new SvgProps(react.radialGradient, backingMap);
  /// Returns a new builder that renders a `<rect>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps rect([Map backingMap]) => new SvgProps(react.rect, backingMap);
  /// Returns a new builder that renders a `<script>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgScript([Map backingMap]) => new SvgProps(react.script, backingMap);
  /// Returns a new builder that renders a `<set>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgSet([Map backingMap]) => new SvgProps(react.svgSet, backingMap);
  /// Returns a new builder that renders a `<solidcolor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps solidcolor([Map backingMap]) => new SvgProps(react.solidcolor, backingMap);
  /// Returns a new builder that renders a `<stop>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps stop([Map backingMap]) => new SvgProps(react.stop, backingMap);
  /// Returns a new builder that renders a `<style>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgStyle([Map backingMap]) => new SvgProps(react.style, backingMap);
  /// Returns a new builder that renders a `<svg>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svg([Map backingMap]) => new SvgProps(react.svg, backingMap);
  /// Returns a new builder that renders a `<switch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgSwitch([Map backingMap]) => new SvgProps(react.svgSwitch, backingMap);
  /// Returns a new builder that renders a `<symbol>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps symbol([Map backingMap]) => new SvgProps(react.symbol, backingMap);
  /// Returns a new builder that renders a `<text>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps text([Map backingMap]) => new SvgProps(react.text, backingMap);
  /// Returns a new builder that renders a `<textPath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps textPath([Map backingMap]) => new SvgProps(react.textPath, backingMap);
  /// Returns a new builder that renders a `<title>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgTitle([Map backingMap]) => new SvgProps(react.title, backingMap);
  /// Returns a new builder that renders a `<tref>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps tref([Map backingMap]) => new SvgProps(react.tref, backingMap);
  /// Returns a new builder that renders a `<tspan>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps tspan([Map backingMap]) => new SvgProps(react.tspan, backingMap);
  /// Returns a new builder that renders an `<unknown>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps unknown([Map backingMap]) => new SvgProps(react.unknown, backingMap);
  /// Returns a new builder that renders an `<use>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps use([Map backingMap]) => new SvgProps(react.use, backingMap);
  /// Returns a new builder that renders a `<video>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgVideo([Map backingMap]) => new SvgProps(react.video, backingMap);
  /// Returns a new builder that renders a `<view>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps view([Map backingMap]) => new SvgProps(react.view, backingMap);
  /// Returns a new builder that renders a `<vkern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps vkern([Map backingMap]) => new SvgProps(react.vkern, backingMap);
}
