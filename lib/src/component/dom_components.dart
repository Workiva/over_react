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
  /// Returns a new [DomPropsMixin] that renders an `<a>` tag with getters/setters for all DOM-related React props
  static DomProps a([Map map]) => new DomProps(react.a, map);
  /// Returns a new [DomPropsMixin] that renders an `<abbr>` tag with getters/setters for all DOM-related React props
 static DomProps abbr([Map map]) => new DomProps(react.abbr, map);
  /// Returns a new [DomPropsMixin] that renders an `<address>` tag with getters/setters for all DOM-related React props
 static DomProps address([Map map]) => new DomProps(react.address, map);
  /// Returns a new [DomPropsMixin] that renders an `<area>` tag with getters/setters for all DOM-related React props
 static DomProps area([Map map]) => new DomProps(react.area, map);
  /// Returns a new [DomPropsMixin] that renders an `<article>` tag with getters/setters for all DOM-related React props
 static DomProps article([Map map]) => new DomProps(react.article, map);
  /// Returns a new [DomPropsMixin] that renders an `<aside>` tag with getters/setters for all DOM-related React props
 static DomProps aside([Map map]) => new DomProps(react.aside, map);
  /// Returns a new [DomPropsMixin] that renders an `<audio>` tag with getters/setters for all DOM-related React props
 static DomProps audio([Map map]) => new DomProps(react.audio, map);
  /// Returns a new [DomPropsMixin] that renders a `<b>` tag with getters/setters for all DOM-related React props
 static DomProps b([Map map]) => new DomProps(react.b, map);
  /// Returns a new [DomPropsMixin] that renders a `<base>` tag with getters/setters for all DOM-related React props
 static DomProps base([Map map]) => new DomProps(react.base, map);
  /// Returns a new [DomPropsMixin] that renders a `<bdi>` tag with getters/setters for all DOM-related React props
 static DomProps bdi([Map map]) => new DomProps(react.bdi, map);
  /// Returns a new [DomPropsMixin] that renders a `<bdo>` tag with getters/setters for all DOM-related React props
 static DomProps bdo([Map map]) => new DomProps(react.bdo, map);
  /// Returns a new [DomPropsMixin] that renders a `<big>` tag with getters/setters for all DOM-related React props
 static DomProps big([Map map]) => new DomProps(react.big, map);
  /// Returns a new [DomPropsMixin] that renders a `<blockquote>` tag with getters/setters for all DOM-related React props
 static DomProps blockquote([Map map]) => new DomProps(react.blockquote, map);
  /// Returns a new [DomPropsMixin] that renders a `<body>` tag with getters/setters for all DOM-related React props
 static DomProps body([Map map]) => new DomProps(react.body, map);
  /// Returns a new [DomPropsMixin] that renders a `<br>` tag with getters/setters for all DOM-related React props
 static DomProps br([Map map]) => new DomProps(react.br, map);
  /// Returns a new [DomPropsMixin] that renders a `<button>` tag with getters/setters for all DOM-related React props
 static DomProps button([Map map]) => new DomProps(react.button, map);
  /// Returns a new [DomPropsMixin] that renders a `<canvas>` tag with getters/setters for all DOM-related React props
 static DomProps canvas([Map map]) => new DomProps(react.canvas, map);
  /// Returns a new [DomPropsMixin] that renders a `<caption>` tag with getters/setters for all DOM-related React props
 static DomProps caption([Map map]) => new DomProps(react.caption, map);
  /// Returns a new [DomPropsMixin] that renders a `<cite>` tag with getters/setters for all DOM-related React props
 static DomProps cite([Map map]) => new DomProps(react.cite, map);
  /// Returns a new [DomPropsMixin] that renders a `<code>` tag with getters/setters for all DOM-related React props
 static DomProps code([Map map]) => new DomProps(react.code, map);
  /// Returns a new [DomPropsMixin] that renders a `<col>` tag with getters/setters for all DOM-related React props
 static DomProps col([Map map]) => new DomProps(react.col, map);
  /// Returns a new [DomPropsMixin] that renders a `<colgroup>` tag with getters/setters for all DOM-related React props
 static DomProps colgroup([Map map]) => new DomProps(react.colgroup, map);
  /// Returns a new [DomPropsMixin] that renders a `<data>` tag with getters/setters for all DOM-related React props
 static DomProps data([Map map]) => new DomProps(react.data, map);
  /// Returns a new [DomPropsMixin] that renders a `<datalist>` tag with getters/setters for all DOM-related React props
 static DomProps datalist([Map map]) => new DomProps(react.datalist, map);
  /// Returns a new [DomPropsMixin] that renders a `<dd>` tag with getters/setters for all DOM-related React props
 static DomProps dd([Map map]) => new DomProps(react.dd, map);
  /// Returns a new [DomPropsMixin] that renders a `<del>` tag with getters/setters for all DOM-related React props
 static DomProps del([Map map]) => new DomProps(react.del, map);
  /// Returns a new [DomPropsMixin] that renders a `<details>` tag with getters/setters for all DOM-related React props
 static DomProps details([Map map]) => new DomProps(react.details, map);
  /// Returns a new [DomPropsMixin] that renders a `<dfn>` tag with getters/setters for all DOM-related React props
 static DomProps dfn([Map map]) => new DomProps(react.dfn, map);
  /// Returns a new [DomPropsMixin] that renders a `<dialog>` tag with getters/setters for all DOM-related React props
 static DomProps dialog([Map map]) => new DomProps(react.dialog, map);
  /// Returns a new [DomPropsMixin] that renders a `<div>` tag with getters/setters for all DOM-related React props
 static DomProps div([Map map]) => new DomProps(react.div, map);
  /// Returns a new [DomPropsMixin] that renders a `<dl>` tag with getters/setters for all DOM-related React props
 static DomProps dl([Map map]) => new DomProps(react.dl, map);
  /// Returns a new [DomPropsMixin] that renders a `<dt>` tag with getters/setters for all DOM-related React props
 static DomProps dt([Map map]) => new DomProps(react.dt, map);
  /// Returns a new [DomPropsMixin] that renders an `<em>` tag with getters/setters for all DOM-related React props
 static DomProps em([Map map]) => new DomProps(react.em, map);
  /// Returns a new [DomPropsMixin] that renders an `<embed>` tag with getters/setters for all DOM-related React props
 static DomProps embed([Map map]) => new DomProps(react.embed, map);
  /// Returns a new [DomPropsMixin] that renders a `<fieldset>` tag with getters/setters for all DOM-related React props
 static DomProps fieldset([Map map]) => new DomProps(react.fieldset, map);
  /// Returns a new [DomPropsMixin] that renders a `<figcaption>` tag with getters/setters for all DOM-related React props
 static DomProps figcaption([Map map]) => new DomProps(react.figcaption, map);
  /// Returns a new [DomPropsMixin] that renders a `<figure>` tag with getters/setters for all DOM-related React props
 static DomProps figure([Map map]) => new DomProps(react.figure, map);
  /// Returns a new [DomPropsMixin] that renders a `<footer>` tag with getters/setters for all DOM-related React props
 static DomProps footer([Map map]) => new DomProps(react.footer, map);
  /// Returns a new [DomPropsMixin] that renders a `<form>` tag with getters/setters for all DOM-related React props
 static DomProps form([Map map]) => new DomProps(react.form, map);
  /// Returns a new [DomPropsMixin] that renders a `<h1>` tag with getters/setters for all DOM-related React props
 static DomProps h1([Map map]) => new DomProps(react.h1, map);
  /// Returns a new [DomPropsMixin] that renders a `<h2>` tag with getters/setters for all DOM-related React props
 static DomProps h2([Map map]) => new DomProps(react.h2, map);
  /// Returns a new [DomPropsMixin] that renders a `<h3>` tag with getters/setters for all DOM-related React props
 static DomProps h3([Map map]) => new DomProps(react.h3, map);
  /// Returns a new [DomPropsMixin] that renders a `<h4>` tag with getters/setters for all DOM-related React props
 static DomProps h4([Map map]) => new DomProps(react.h4, map);
  /// Returns a new [DomPropsMixin] that renders a `<h5>` tag with getters/setters for all DOM-related React props
 static DomProps h5([Map map]) => new DomProps(react.h5, map);
  /// Returns a new [DomPropsMixin] that renders a `<h6>` tag with getters/setters for all DOM-related React props
 static DomProps h6([Map map]) => new DomProps(react.h6, map);
  /// Returns a new [DomPropsMixin] that renders a `<head>` tag with getters/setters for all DOM-related React props
 static DomProps head([Map map]) => new DomProps(react.head, map);
  /// Returns a new [DomPropsMixin] that renders a `<header>` tag with getters/setters for all DOM-related React props
 static DomProps header([Map map]) => new DomProps(react.header, map);
  /// Returns a new [DomPropsMixin] that renders a `<hr>` tag with getters/setters for all DOM-related React props
 static DomProps hr([Map map]) => new DomProps(react.hr, map);
  /// Returns a new [DomPropsMixin] that renders a `<html>` tag with getters/setters for all DOM-related React props
 static DomProps html([Map map]) => new DomProps(react.html, map);
  /// Returns a new [DomPropsMixin] that renders an `<i>` tag with getters/setters for all DOM-related React props
 static DomProps i([Map map]) => new DomProps(react.i, map);
  /// Returns a new [DomPropsMixin] that renders an `<iframe>` tag with getters/setters for all DOM-related React props
 static DomProps iframe([Map map]) => new DomProps(react.iframe, map);
  /// Returns a new [DomPropsMixin] that renders an `<img>` tag with getters/setters for all DOM-related React props
 static DomProps img([Map map]) => new DomProps(react.img, map);
  /// Returns a new [DomPropsMixin] that renders an `<input>` tag with getters/setters for all DOM-related React props
 static DomProps input([Map map]) => new DomProps(react.input, map);
  /// Returns a new [DomPropsMixin] that renders an `<ins>` tag with getters/setters for all DOM-related React props
 static DomProps ins([Map map]) => new DomProps(react.ins, map);
  /// Returns a new [DomPropsMixin] that renders a `<kbd>` tag with getters/setters for all DOM-related React props
 static DomProps kbd([Map map]) => new DomProps(react.kbd, map);
  /// Returns a new [DomPropsMixin] that renders a `<keygen>` tag with getters/setters for all DOM-related React props
 static DomProps keygen([Map map]) => new DomProps(react.keygen, map);
  /// Returns a new [DomPropsMixin] that renders a `<label>` tag with getters/setters for all DOM-related React props
 static DomProps label([Map map]) => new DomProps(react.label, map);
  /// Returns a new [DomPropsMixin] that renders a `<legend>` tag with getters/setters for all DOM-related React props
 static DomProps legend([Map map]) => new DomProps(react.legend, map);
  /// Returns a new [DomPropsMixin] that renders a `<li>` tag with getters/setters for all DOM-related React props
 static DomProps li([Map map]) => new DomProps(react.li, map);
  /// Returns a new [DomPropsMixin] that renders a `<link>` tag with getters/setters for all DOM-related React props
 static DomProps link([Map map]) => new DomProps(react.link, map);
  /// Returns a new [DomPropsMixin] that renders a `<main>` tag with getters/setters for all DOM-related React props
 static DomProps main([Map map]) => new DomProps(react.main, map);
  /// Returns a new [DomPropsMixin] that renders a `<map>` tag with getters/setters for all DOM-related React props
 static DomProps map([Map map]) => new DomProps(react.map, map);
  /// Returns a new [DomPropsMixin] that renders a `<mark>` tag with getters/setters for all DOM-related React props
 static DomProps mark([Map map]) => new DomProps(react.mark, map);
  /// Returns a new [DomPropsMixin] that renders a `<menu>` tag with getters/setters for all DOM-related React props
 static DomProps menu([Map map]) => new DomProps(react.menu, map);
  /// Returns a new [DomPropsMixin] that renders a `<menuitem>` tag with getters/setters for all DOM-related React props
 static DomProps menuitem([Map map]) => new DomProps(react.menuitem, map);
  /// Returns a new [DomPropsMixin] that renders a `<meta>` tag with getters/setters for all DOM-related React props
 static DomProps meta([Map map]) => new DomProps(react.meta, map);
  /// Returns a new [DomPropsMixin] that renders a `<meter>` tag with getters/setters for all DOM-related React props
 static DomProps meter([Map map]) => new DomProps(react.meter, map);
  /// Returns a new [DomPropsMixin] that renders a `<nav>` tag with getters/setters for all DOM-related React props
 static DomProps nav([Map map]) => new DomProps(react.nav, map);
  /// Returns a new [DomPropsMixin] that renders a `<noscript>` tag with getters/setters for all DOM-related React props
 static DomProps noscript([Map map]) => new DomProps(react.noscript, map);
  /// Returns a new [DomPropsMixin] that renders an `<object>` tag with getters/setters for all DOM-related React props
 static DomProps object([Map map]) => new DomProps(react.object, map);
  /// Returns a new [DomPropsMixin] that renders an `<ol>` tag with getters/setters for all DOM-related React props
 static DomProps ol([Map map]) => new DomProps(react.ol, map);
  /// Returns a new [DomPropsMixin] that renders an `<optgroup>` tag with getters/setters for all DOM-related React props
 static DomProps optgroup([Map map]) => new DomProps(react.optgroup, map);
  /// Returns a new [DomPropsMixin] that renders an `<option>` tag with getters/setters for all DOM-related React props
 static DomProps option([Map map]) => new DomProps(react.option, map);
  /// Returns a new [DomPropsMixin] that renders an `<output>` tag with getters/setters for all DOM-related React props
 static DomProps output([Map map]) => new DomProps(react.output, map);
  /// Returns a new [DomPropsMixin] that renders a `<p>` tag with getters/setters for all DOM-related React props
 static DomProps p([Map map]) => new DomProps(react.p, map);
  /// Returns a new [DomPropsMixin] that renders a `<param>` tag with getters/setters for all DOM-related React props
 static DomProps param([Map map]) => new DomProps(react.param, map);
  /// Returns a new [DomPropsMixin] that renders a `<picture>` tag with getters/setters for all DOM-related React props
 static DomProps picture([Map map]) => new DomProps(react.picture, map);
  /// Returns a new [DomPropsMixin] that renders a `<pre>` tag with getters/setters for all DOM-related React props
 static DomProps pre([Map map]) => new DomProps(react.pre, map);
  /// Returns a new [DomPropsMixin] that renders a `<progress>` tag with getters/setters for all DOM-related React props
 static DomProps progress([Map map]) => new DomProps(react.progress, map);
  /// Returns a new [DomPropsMixin] that renders a `<q>` tag with getters/setters for all DOM-related React props
 static DomProps q([Map map]) => new DomProps(react.q, map);
  /// Returns a new [DomPropsMixin] that renders a `<rp>` tag with getters/setters for all DOM-related React props
 static DomProps rp([Map map]) => new DomProps(react.rp, map);
  /// Returns a new [DomPropsMixin] that renders a `<rt>` tag with getters/setters for all DOM-related React props
 static DomProps rt([Map map]) => new DomProps(react.rt, map);
  /// Returns a new [DomPropsMixin] that renders a `<ruby>` tag with getters/setters for all DOM-related React props
 static DomProps ruby([Map map]) => new DomProps(react.ruby, map);
  /// Returns a new [DomPropsMixin] that renders a `<s>` tag with getters/setters for all DOM-related React props
 static DomProps s([Map map]) => new DomProps(react.s, map);
  /// Returns a new [DomPropsMixin] that renders a `<samp>` tag with getters/setters for all DOM-related React props
 static DomProps samp([Map map]) => new DomProps(react.samp, map);
  /// Returns a new [DomPropsMixin] that renders a `<script>` tag with getters/setters for all DOM-related React props
 static DomProps script([Map map]) => new DomProps(react.script, map);
  /// Returns a new [DomPropsMixin] that renders a `<section>` tag with getters/setters for all DOM-related React props
 static DomProps section([Map map]) => new DomProps(react.section, map);
  /// Returns a new [DomPropsMixin] that renders a `<select>` tag with getters/setters for all DOM-related React props
 static DomProps select([Map map]) => new DomProps(react.select, map);
  /// Returns a new [DomPropsMixin] that renders a `<small>` tag with getters/setters for all DOM-related React props
 static DomProps small([Map map]) => new DomProps(react.small, map);
  /// Returns a new [DomPropsMixin] that renders a `<source>` tag with getters/setters for all DOM-related React props
 static DomProps source([Map map]) => new DomProps(react.source, map);
  /// Returns a new [DomPropsMixin] that renders a `<span>` tag with getters/setters for all DOM-related React props
 static DomProps span([Map map]) => new DomProps(react.span, map);
  /// Returns a new [DomPropsMixin] that renders a `<strong>` tag with getters/setters for all DOM-related React props
 static DomProps strong([Map map]) => new DomProps(react.strong, map);
  /// Returns a new [DomPropsMixin] that renders a `<style>` tag with getters/setters for all DOM-related React props
 static DomProps style([Map map]) => new DomProps(react.style, map);
  /// Returns a new [DomPropsMixin] that renders a `<sub>` tag with getters/setters for all DOM-related React props
 static DomProps sub([Map map]) => new DomProps(react.sub, map);
  /// Returns a new [DomPropsMixin] that renders a `<summary>` tag with getters/setters for all DOM-related React props
 static DomProps summary([Map map]) => new DomProps(react.summary, map);
  /// Returns a new [DomPropsMixin] that renders a `<sup>` tag with getters/setters for all DOM-related React props
 static DomProps sup([Map map]) => new DomProps(react.sup, map);
  /// Returns a new [DomPropsMixin] that renders a `<table>` tag with getters/setters for all DOM-related React props
 static DomProps table([Map map]) => new DomProps(react.table, map);
  /// Returns a new [DomPropsMixin] that renders a `<tbody>` tag with getters/setters for all DOM-related React props
 static DomProps tbody([Map map]) => new DomProps(react.tbody, map);
  /// Returns a new [DomPropsMixin] that renders a `<td>` tag with getters/setters for all DOM-related React props
 static DomProps td([Map map]) => new DomProps(react.td, map);
  /// Returns a new [DomPropsMixin] that renders a `<textarea>` tag with getters/setters for all DOM-related React props
 static DomProps textarea([Map map]) => new DomProps(react.textarea, map);
  /// Returns a new [DomPropsMixin] that renders a `<tfoot>` tag with getters/setters for all DOM-related React props
 static DomProps tfoot([Map map]) => new DomProps(react.tfoot, map);
  /// Returns a new [DomPropsMixin] that renders a `<th>` tag with getters/setters for all DOM-related React props
 static DomProps th([Map map]) => new DomProps(react.th, map);
  /// Returns a new [DomPropsMixin] that renders a `<thead>` tag with getters/setters for all DOM-related React props
 static DomProps thead([Map map]) => new DomProps(react.thead, map);
  /// Returns a new [DomPropsMixin] that renders a `<time>` tag with getters/setters for all DOM-related React props
 static DomProps time([Map map]) => new DomProps(react.time, map);
  /// Returns a new [DomPropsMixin] that renders a `<title>` tag with getters/setters for all DOM-related React props
 static DomProps title([Map map]) => new DomProps(react.title, map);
  /// Returns a new [DomPropsMixin] that renders a `<tr>` tag with getters/setters for all DOM-related React props
 static DomProps tr([Map map]) => new DomProps(react.tr, map);
  /// Returns a new [DomPropsMixin] that renders a `<track>` tag with getters/setters for all DOM-related React props
 static DomProps track([Map map]) => new DomProps(react.track, map);
  /// Returns a new [DomPropsMixin] that renders an `<u>` tag with getters/setters for all DOM-related React props
 static DomProps u([Map map]) => new DomProps(react.u, map);
  /// Returns a new [DomPropsMixin] that renders an `<ul>` tag with getters/setters for all DOM-related React props
 static DomProps ul([Map map]) => new DomProps(react.ul, map);
  /// Returns a new [DomPropsMixin] that renders a `<var>` tag with getters/setters for all DOM-related React props
 static DomProps variable([Map map]) => new DomProps(react.variable, map);
  /// Returns a new [DomPropsMixin] that renders a `<video>` tag with getters/setters for all DOM-related React props
 static DomProps video([Map map]) => new DomProps(react.video, map);
  /// Returns a new [DomPropsMixin] that renders a `<wbr>` tag with getters/setters for all DOM-related React props
 static DomProps wbr([Map map]) => new DomProps(react.wbr, map);

  // SVG Elements
  /// Returns a new [SvgPropsMixin] that renders an `<a>` tag with getters/setters for all SVG-related React props
  static SvgProps svgA() => new SvgProps(react.a);
  /// Returns a new [SvgPropsMixin] that renders an `<altGlyph>` tag with getters/setters for all SVG-related React props
  static SvgProps altGlyph() => new SvgProps(react.altGlyph);
  /// Returns a new [SvgPropsMixin] that renders an `<altGlyphDef>` tag with getters/setters for all SVG-related React props
  static SvgProps altGlyphDef() => new SvgProps(react.altGlyphDef);
  /// Returns a new [SvgPropsMixin] that renders an `<altGlyphItem>` tag with getters/setters for all SVG-related React props
  static SvgProps altGlyphItem() => new SvgProps(react.altGlyphItem);
  /// Returns a new [SvgPropsMixin] that renders an `<animate>` tag with getters/setters for all SVG-related React props
  static SvgProps animate() => new SvgProps(react.animate);
  /// Returns a new [SvgPropsMixin] that renders an `<animateColor>` tag with getters/setters for all SVG-related React props
  static SvgProps animateColor() => new SvgProps(react.animateColor);
  /// Returns a new [SvgPropsMixin] that renders an `<animateMotion>` tag with getters/setters for all SVG-related React props
  static SvgProps animateMotion() => new SvgProps(react.animateMotion);
  /// Returns a new [SvgPropsMixin] that renders an `<animateTransform>` tag with getters/setters for all SVG-related React props
  static SvgProps animateTransform() => new SvgProps(react.animateTransform);
  /// Returns a new [SvgPropsMixin] that renders an `<audio>` tag with getters/setters for all SVG-related React props
  static SvgProps svgAudio() => new SvgProps(react.audio);
  /// Returns a new [SvgPropsMixin] that renders a `<canvas>` tag with getters/setters for all SVG-related React props
  static SvgProps svgCanvas() => new SvgProps(react.canvas);
  /// Returns a new [SvgPropsMixin] that renders a `<circle>` tag with getters/setters for all SVG-related React props
  static SvgProps circle() => new SvgProps(react.circle);
  /// Returns a new [SvgPropsMixin] that renders a `<clipPath>` tag with getters/setters for all SVG-related React props
  static SvgProps clipPath() => new SvgProps(react.clipPath);
  /// Returns a new [SvgPropsMixin] that renders a `<color-profile>` tag with getters/setters for all SVG-related React props
  static SvgProps colorProfile() => new SvgProps(react.colorProfile);
  /// Returns a new [SvgPropsMixin] that renders a `<cursor>` tag with getters/setters for all SVG-related React props
  static SvgProps cursor() => new SvgProps(react.cursor);
  /// Returns a new [SvgPropsMixin] that renders a `<defs>` tag with getters/setters for all SVG-related React props
  static SvgProps defs() => new SvgProps(react.defs);
  /// Returns a new [SvgPropsMixin] that renders a `<desc>` tag with getters/setters for all SVG-related React props
  static SvgProps desc() => new SvgProps(react.desc);
  /// Returns a new [SvgPropsMixin] that renders a `<discard>` tag with getters/setters for all SVG-related React props
  static SvgProps discard() => new SvgProps(react.discard);
  /// Returns a new [SvgPropsMixin] that renders an `<ellipse>` tag with getters/setters for all SVG-related React props
  static SvgProps ellipse() => new SvgProps(react.ellipse);
  /// Returns a new [SvgPropsMixin] that renders a `<feBlend>` tag with getters/setters for all SVG-related React props
  static SvgProps feBlend() => new SvgProps(react.feBlend);
  /// Returns a new [SvgPropsMixin] that renders a `<feColorMatrix>` tag with getters/setters for all SVG-related React props
  static SvgProps feColorMatrix() => new SvgProps(react.feColorMatrix);
  /// Returns a new [SvgPropsMixin] that renders a `<feComponentTransfer>` tag with getters/setters for all SVG-related React props
  static SvgProps feComponentTransfer() => new SvgProps(react.feComponentTransfer);
  /// Returns a new [SvgPropsMixin] that renders a `<feComposite>` tag with getters/setters for all SVG-related React props
  static SvgProps feComposite() => new SvgProps(react.feComposite);
  /// Returns a new [SvgPropsMixin] that renders a `<feConvolveMatrix>` tag with getters/setters for all SVG-related React props
  static SvgProps feConvolveMatrix() => new SvgProps(react.feConvolveMatrix);
  /// Returns a new [SvgPropsMixin] that renders a `<feDiffuseLighting>` tag with getters/setters for all SVG-related React props
  static SvgProps feDiffuseLighting() => new SvgProps(react.feDiffuseLighting);
  /// Returns a new [SvgPropsMixin] that renders a `<feDisplacementMap>` tag with getters/setters for all SVG-related React props
  static SvgProps feDisplacementMap() => new SvgProps(react.feDisplacementMap);
  /// Returns a new [SvgPropsMixin] that renders a `<feDistantLight>` tag with getters/setters for all SVG-related React props
  static SvgProps feDistantLight() => new SvgProps(react.feDistantLight);
  /// Returns a new [SvgPropsMixin] that renders a `<feDropShadow>` tag with getters/setters for all SVG-related React props
  static SvgProps feDropShadow() => new SvgProps(react.feDropShadow);
  /// Returns a new [SvgPropsMixin] that renders a `<feFlood>` tag with getters/setters for all SVG-related React props
  static SvgProps feFlood() => new SvgProps(react.feFlood);
  /// Returns a new [SvgPropsMixin] that renders a `<feFuncA>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncA() => new SvgProps(react.feFuncA);
  /// Returns a new [SvgPropsMixin] that renders a `<feFuncB>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncB() => new SvgProps(react.feFuncB);
  /// Returns a new [SvgPropsMixin] that renders a `<feFuncG>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncG() => new SvgProps(react.feFuncG);
  /// Returns a new [SvgPropsMixin] that renders a `<feFuncR>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncR() => new SvgProps(react.feFuncR);
  /// Returns a new [SvgPropsMixin] that renders a `<feGaussianBlur>` tag with getters/setters for all SVG-related React props
  static SvgProps feGaussianBlur() => new SvgProps(react.feGaussianBlur);
  /// Returns a new [SvgPropsMixin] that renders a `<feImage>` tag with getters/setters for all SVG-related React props
  static SvgProps feImage() => new SvgProps(react.feImage);
  /// Returns a new [SvgPropsMixin] that renders a `<feMerge>` tag with getters/setters for all SVG-related React props
  static SvgProps feMerge() => new SvgProps(react.feMerge);
  /// Returns a new [SvgPropsMixin] that renders a `<feMergeNode>` tag with getters/setters for all SVG-related React props
  static SvgProps feMergeNode() => new SvgProps(react.feMergeNode);
  /// Returns a new [SvgPropsMixin] that renders a `<feMorphology>` tag with getters/setters for all SVG-related React props
  static SvgProps feMorphology() => new SvgProps(react.feMorphology);
  /// Returns a new [SvgPropsMixin] that renders a `<feOffset>` tag with getters/setters for all SVG-related React props
  static SvgProps feOffset() => new SvgProps(react.feOffset);
  /// Returns a new [SvgPropsMixin] that renders a `<fePointLight>` tag with getters/setters for all SVG-related React props
  static SvgProps fePointLight() => new SvgProps(react.fePointLight);
  /// Returns a new [SvgPropsMixin] that renders a `<feSpecularLighting>` tag with getters/setters for all SVG-related React props
  static SvgProps feSpecularLighting() => new SvgProps(react.feSpecularLighting);
  /// Returns a new [SvgPropsMixin] that renders a `<feSpotLight>` tag with getters/setters for all SVG-related React props
  static SvgProps feSpotLight() => new SvgProps(react.feSpotLight);
  /// Returns a new [SvgPropsMixin] that renders a `<feTile>` tag with getters/setters for all SVG-related React props
  static SvgProps feTile() => new SvgProps(react.feTile);
  /// Returns a new [SvgPropsMixin] that renders a `<feTurbulence>` tag with getters/setters for all SVG-related React props
  static SvgProps feTurbulence() => new SvgProps(react.feTurbulence);
  /// Returns a new [SvgPropsMixin] that renders a `<filter>` tag with getters/setters for all SVG-related React props
  static SvgProps filter() => new SvgProps(react.filter);
  /// Returns a new [SvgPropsMixin] that renders a `<font>` tag with getters/setters for all SVG-related React props
  static SvgProps font() => new SvgProps(react.font);
  /// Returns a new [SvgPropsMixin] that renders a `<font-face>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFace() => new SvgProps(react.fontFace);
  /// Returns a new [SvgPropsMixin] that renders a `<font-face-format>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceFormat() => new SvgProps(react.fontFaceFormat);
  /// Returns a new [SvgPropsMixin] that renders a `<font-face-name>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceName() => new SvgProps(react.fontFaceName);
  /// Returns a new [SvgPropsMixin] that renders a `<font-face-src>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceSrc() => new SvgProps(react.fontFaceSrc);
  /// Returns a new [SvgPropsMixin] that renders a `<font-face-uri>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceUri() => new SvgProps(react.fontFaceUri);
  /// Returns a new [SvgPropsMixin] that renders a `<foreignObject>` tag with getters/setters for all SVG-related React props
  static SvgProps foreignObject() => new SvgProps(react.foreignObject);
  /// Returns a new [SvgPropsMixin] that renders a `<g>` tag with getters/setters for all SVG-related React props
  static SvgProps g() => new SvgProps(react.g);
  /// Returns a new [SvgPropsMixin] that renders a `<glyph>` tag with getters/setters for all SVG-related React props
  static SvgProps glyph() => new SvgProps(react.glyph);
  /// Returns a new [SvgPropsMixin] that renders a `<glyphRef>` tag with getters/setters for all SVG-related React props
  static SvgProps glyphRef() => new SvgProps(react.glyphRef);
  /// Returns a new [SvgPropsMixin] that renders a `<hatch>` tag with getters/setters for all SVG-related React props
  static SvgProps hatch() => new SvgProps(react.hatch);
  /// Returns a new [SvgPropsMixin] that renders a `<hatchpath>` tag with getters/setters for all SVG-related React props
  static SvgProps hatchpath() => new SvgProps(react.hatchpath);
  /// Returns a new [SvgPropsMixin] that renders a `<hkern>` tag with getters/setters for all SVG-related React props
  static SvgProps hkern() => new SvgProps(react.hkern);
  /// Returns a new [SvgPropsMixin] that renders an `<iframe>` tag with getters/setters for all SVG-related React props
  static SvgProps svgIframe() => new SvgProps(react.iframe);
  /// Returns a new [SvgPropsMixin] that renders an `<image>` tag with getters/setters for all SVG-related React props
  static SvgProps image() => new SvgProps(react.image);
  /// Returns a new [SvgPropsMixin] that renders a `<line>` tag with getters/setters for all SVG-related React props
  static SvgProps line() => new SvgProps(react.line);
  /// Returns a new [SvgPropsMixin] that renders a `<linearGradient>` tag with getters/setters for all SVG-related React props
  static SvgProps linearGradient() => new SvgProps(react.linearGradient);
  /// Returns a new [SvgPropsMixin] that renders a `<marker>` tag with getters/setters for all SVG-related React props
  static SvgProps marker() => new SvgProps(react.marker);
  /// Returns a new [SvgPropsMixin] that renders a `<mask>` tag with getters/setters for all SVG-related React props
  static SvgProps mask() => new SvgProps(react.mask);
  /// Returns a new [SvgPropsMixin] that renders a `<mesh>` tag with getters/setters for all SVG-related React props
  static SvgProps mesh() => new SvgProps(react.mesh);
  /// Returns a new [SvgPropsMixin] that renders a `<meshgradient>` tag with getters/setters for all SVG-related React props
  static SvgProps meshgradient() => new SvgProps(react.meshgradient);
  /// Returns a new [SvgPropsMixin] that renders a `<meshpatch>` tag with getters/setters for all SVG-related React props
  static SvgProps meshpatch() => new SvgProps(react.meshpatch);
  /// Returns a new [SvgPropsMixin] that renders a `<meshrow>` tag with getters/setters for all SVG-related React props
  static SvgProps meshrow() => new SvgProps(react.meshrow);
  /// Returns a new [SvgPropsMixin] that renders a `<metadata>` tag with getters/setters for all SVG-related React props
  static SvgProps metadata() => new SvgProps(react.metadata);
  /// Returns a new [SvgPropsMixin] that renders a `<missing-glyph>` tag with getters/setters for all SVG-related React props
  static SvgProps missingGlyph() => new SvgProps(react.missingGlyph);
  /// Returns a new [SvgPropsMixin] that renders a `<mpath>` tag with getters/setters for all SVG-related React props
  static SvgProps mpath() => new SvgProps(react.mpath);
  /// Returns a new [SvgPropsMixin] that renders a `<path>` tag with getters/setters for all SVG-related React props
  static SvgProps path() => new SvgProps(react.path);
  /// Returns a new [SvgPropsMixin] that renders a `<pattern>` tag with getters/setters for all SVG-related React props
  static SvgProps pattern() => new SvgProps(react.pattern);
  /// Returns a new [SvgPropsMixin] that renders a `<polygon>` tag with getters/setters for all SVG-related React props
  static SvgProps polygon() => new SvgProps(react.polygon);
  /// Returns a new [SvgPropsMixin] that renders a `<polyline>` tag with getters/setters for all SVG-related React props
  static SvgProps polyline() => new SvgProps(react.polyline);
  /// Returns a new [SvgPropsMixin] that renders a `<radialGradient>` tag with getters/setters for all SVG-related React props
  static SvgProps radialGradient() => new SvgProps(react.radialGradient);
  /// Returns a new [SvgPropsMixin] that renders a `<rect>` tag with getters/setters for all SVG-related React props
  static SvgProps rect() => new SvgProps(react.rect);
  /// Returns a new [SvgPropsMixin] that renders a `<script>` tag with getters/setters for all SVG-related React props
  static SvgProps svgScript() => new SvgProps(react.script);
  /// Returns a new [SvgPropsMixin] that renders a `<set>` tag with getters/setters for all SVG-related React props
  static SvgProps svgSet() => new SvgProps(react.svgSet);
  /// Returns a new [SvgPropsMixin] that renders a `<solidcolor>` tag with getters/setters for all SVG-related React props
  static SvgProps solidcolor() => new SvgProps(react.solidcolor);
  /// Returns a new [SvgPropsMixin] that renders a `<stop>` tag with getters/setters for all SVG-related React props
  static SvgProps stop() => new SvgProps(react.stop);
  /// Returns a new [SvgPropsMixin] that renders a `<style>` tag with getters/setters for all SVG-related React props
  static SvgProps svgStyle() => new SvgProps(react.style);
  /// Returns a new [SvgPropsMixin] that renders a `<svg>` tag with getters/setters for all SVG-related React props
  static SvgProps svg() => new SvgProps(react.svg);
  /// Returns a new [SvgPropsMixin] that renders a `<switch>` tag with getters/setters for all SVG-related React props
  static SvgProps svgSwitch() => new SvgProps(react.svgSwitch);
  /// Returns a new [SvgPropsMixin] that renders a `<symbol>` tag with getters/setters for all SVG-related React props
  static SvgProps symbol() => new SvgProps(react.symbol);
  /// Returns a new [SvgPropsMixin] that renders a `<text>` tag with getters/setters for all SVG-related React props
  static SvgProps text() => new SvgProps(react.text);
  /// Returns a new [SvgPropsMixin] that renders a `<textPath>` tag with getters/setters for all SVG-related React props
  static SvgProps textPath() => new SvgProps(react.textPath);
  /// Returns a new [SvgPropsMixin] that renders a `<title>` tag with getters/setters for all SVG-related React props
  static SvgProps svgTitle() => new SvgProps(react.title);
  /// Returns a new [SvgPropsMixin] that renders a `<tref>` tag with getters/setters for all SVG-related React props
  static SvgProps tref() => new SvgProps(react.tref);
  /// Returns a new [SvgPropsMixin] that renders a `<tspan>` tag with getters/setters for all SVG-related React props
  static SvgProps tspan() => new SvgProps(react.tspan);
  /// Returns a new [SvgPropsMixin] that renders an `<unknown>` tag with getters/setters for all SVG-related React props
  static SvgProps unknown() => new SvgProps(react.unknown);
  /// Returns a new [SvgPropsMixin] that renders an `<use>` tag with getters/setters for all SVG-related React props
  static SvgProps use() => new SvgProps(react.use);
  /// Returns a new [SvgPropsMixin] that renders a `<video>` tag with getters/setters for all SVG-related React props
  static SvgProps svgVideo() => new SvgProps(react.video);
  /// Returns a new [SvgPropsMixin] that renders a `<view>` tag with getters/setters for all SVG-related React props
  static SvgProps view() => new SvgProps(react.view);
  /// Returns a new [SvgPropsMixin] that renders a `<vkern>` tag with getters/setters for all SVG-related React props
  static SvgProps vkern() => new SvgProps(react.vkern);
}
