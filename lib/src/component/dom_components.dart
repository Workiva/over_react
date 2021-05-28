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

/// `UiComponent`-based api with typed props for react-dart DOM components.
library over_react.dom_components;

import 'package:over_react/src/component/prop_mixins.dart';
import 'package:over_react/src/component_declaration/builder_helpers.dart'
    as builder_helpers;
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';

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
DomProps domProps([Map backingMap]) => DomProps(null, backingMap);

// ignore: prefer_generic_function_type_aliases
typedef DomProps DomPropsFactory();

// Include pieces from builder_helpers so that consumers can type these instances
// as the `UiProps` exposed in `over_react.dart` and not have to pull in `component_base`.
class DomProps extends builder_helpers.UiProps with DomPropsMixin {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  DomProps(this.componentFactory, [Map props]) : this.props = props ?? JsBackedMap();

  @override
  ReactComponentFactoryProxy componentFactory;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';

  @override
  bool get $isClassGenerated => true;
}

// Include pieces from builder_helpers so that consumers can type these instances
// as the `UiProps` exposed in `over_react.dart` and not have to pull in `component_base`.
class SvgProps extends builder_helpers.UiProps with DomPropsMixin, SvgPropsMixin implements DomProps {
  // Initialize to a JsBackedMap so that copying can be optimized
  // when converting props during ReactElement creation.
  // TODO 3.0.0-wip generate JsBackedMap-based implementation used when no backing map is provided, like we do for Component2
  SvgProps(this.componentFactory, [Map props]) : this.props = props ?? JsBackedMap();

  @override
  ReactComponentFactoryProxy componentFactory;

  @override
  final Map props;

  @override
  String get propKeyNamespace => '';

  @override
  bool get $isClassGenerated => true;
}

/// A class that provides namespacing for static DOM component factory methods, much like `React.DOM` in React JS.
abstract class Dom {
  /// Returns a new builder that renders an `<a>` tag with getters/setters for all DOM-related React props,

  /// optionally backed by a specified map.
  static DomProps a([Map backingMap]) => DomProps(react.a as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<abbr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps abbr([Map backingMap]) => DomProps(react.abbr as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<address>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps address([Map backingMap]) => DomProps(react.address as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<area>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps area([Map backingMap]) => DomProps(react.area as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<article>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps article([Map backingMap]) => DomProps(react.article as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<aside>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps aside([Map backingMap]) => DomProps(react.aside as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<audio>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps audio([Map backingMap]) => DomProps(react.audio as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<b>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps b([Map backingMap]) => DomProps(react.b as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<base>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps base([Map backingMap]) => DomProps(react.base as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<bdi>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps bdi([Map backingMap]) => DomProps(react.bdi as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<bdo>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps bdo([Map backingMap]) => DomProps(react.bdo as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<big>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps big([Map backingMap]) => DomProps(react.big as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<blockquote>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps blockquote([Map backingMap]) => DomProps(react.blockquote as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<body>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps body([Map backingMap]) => DomProps(react.body as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<br>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps br([Map backingMap]) => DomProps(react.br as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<button>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps button([Map backingMap]) => DomProps(react.button as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<canvas>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps canvas([Map backingMap]) => DomProps(react.canvas as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<caption>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps caption([Map backingMap]) => DomProps(react.caption as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<cite>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps cite([Map backingMap]) => DomProps(react.cite as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<code>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps code([Map backingMap]) => DomProps(react.code as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<col>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps col([Map backingMap]) => DomProps(react.col as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<colgroup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps colgroup([Map backingMap]) => DomProps(react.colgroup as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<data>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps data([Map backingMap]) => DomProps(react.data as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<datalist>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps datalist([Map backingMap]) => DomProps(react.datalist as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<dd>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dd([Map backingMap]) => DomProps(react.dd as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<del>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps del([Map backingMap]) => DomProps(react.del as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<details>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps details([Map backingMap]) => DomProps(react.details as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<dfn>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dfn([Map backingMap]) => DomProps(react.dfn as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<dialog>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dialog([Map backingMap]) => DomProps(react.dialog as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<div>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps div([Map backingMap]) => DomProps(react.div as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<dl>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dl([Map backingMap]) => DomProps(react.dl as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<dt>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dt([Map backingMap]) => DomProps(react.dt as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<em>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps em([Map backingMap]) => DomProps(react.em as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<embed>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps embed([Map backingMap]) => DomProps(react.embed as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<fieldset>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps fieldset([Map backingMap]) => DomProps(react.fieldset as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<figcaption>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps figcaption([Map backingMap]) => DomProps(react.figcaption as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<figure>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps figure([Map backingMap]) => DomProps(react.figure as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<footer>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps footer([Map backingMap]) => DomProps(react.footer as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<form>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps form([Map backingMap]) => DomProps(react.form as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<h1>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h1([Map backingMap]) => DomProps(react.h1 as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<h2>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h2([Map backingMap]) => DomProps(react.h2 as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<h3>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h3([Map backingMap]) => DomProps(react.h3 as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<h4>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h4([Map backingMap]) => DomProps(react.h4 as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<h5>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h5([Map backingMap]) => DomProps(react.h5 as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<h6>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h6([Map backingMap]) => DomProps(react.h6 as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<head>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps head([Map backingMap]) => DomProps(react.head as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<header>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps header([Map backingMap]) => DomProps(react.header as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<hr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps hr([Map backingMap]) => DomProps(react.hr as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<html>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps html([Map backingMap]) => DomProps(react.html as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<i>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps i([Map backingMap]) => DomProps(react.i as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<iframe>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps iframe([Map backingMap]) => DomProps(react.iframe as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<img>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps img([Map backingMap]) => DomProps(react.img as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<input>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps input([Map backingMap]) => DomProps(react.input as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<ins>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ins([Map backingMap]) => DomProps(react.ins as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<kbd>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps kbd([Map backingMap]) => DomProps(react.kbd as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<keygen>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps keygen([Map backingMap]) => DomProps(react.keygen as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<label>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps label([Map backingMap]) => DomProps(react.label as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<legend>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps legend([Map backingMap]) => DomProps(react.legend as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<li>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps li([Map backingMap]) => DomProps(react.li as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<link>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps link([Map backingMap]) => DomProps(react.link as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<main>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps main([Map backingMap]) => DomProps(react.htmlMain as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<backingMap>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps map([Map backingMap]) => DomProps(react.map as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<mark>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps mark([Map backingMap]) => DomProps(react.mark as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<menu>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps menu([Map backingMap]) => DomProps(react.menu as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<menuitem>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps menuitem([Map backingMap]) => DomProps(react.menuitem as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<meta>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps meta([Map backingMap]) => DomProps(react.meta as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<meter>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps meter([Map backingMap]) => DomProps(react.meter as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<nav>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps nav([Map backingMap]) => DomProps(react.nav as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<noscript>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps noscript([Map backingMap]) => DomProps(react.noscript as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<object>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps object([Map backingMap]) => DomProps(react.object as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<ol>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ol([Map backingMap]) => DomProps(react.ol as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<optgroup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps optgroup([Map backingMap]) => DomProps(react.optgroup as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<option>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps option([Map backingMap]) => DomProps(react.option as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<output>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps output([Map backingMap]) => DomProps(react.output as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<p>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps p([Map backingMap]) => DomProps(react.p as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<param>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps param([Map backingMap]) => DomProps(react.param as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<picture>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps picture([Map backingMap]) => DomProps(react.picture as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<pre>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps pre([Map backingMap]) => DomProps(react.pre as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<progress>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps progress([Map backingMap]) => DomProps(react.progress as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<q>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps q([Map backingMap]) => DomProps(react.q as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<rp>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps rp([Map backingMap]) => DomProps(react.rp as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<rt>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps rt([Map backingMap]) => DomProps(react.rt as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<ruby>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ruby([Map backingMap]) => DomProps(react.ruby as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<s>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps s([Map backingMap]) => DomProps(react.s as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<samp>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps samp([Map backingMap]) => DomProps(react.samp as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<script>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps script([Map backingMap]) => DomProps(react.script as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<section>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps section([Map backingMap]) => DomProps(react.section as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<select>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps select([Map backingMap]) => DomProps(react.select as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<small>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps small([Map backingMap]) => DomProps(react.small as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<source>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps source([Map backingMap]) => DomProps(react.source as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<span>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps span([Map backingMap]) => DomProps(react.span as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<strong>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps strong([Map backingMap]) => DomProps(react.strong as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<style>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps style([Map backingMap]) => DomProps(react.style as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<sub>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps sub([Map backingMap]) => DomProps(react.sub as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<summary>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps summary([Map backingMap]) => DomProps(react.summary as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<sup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps sup([Map backingMap]) => DomProps(react.sup as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<table>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps table([Map backingMap]) => DomProps(react.table as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<tbody>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps tbody([Map backingMap]) => DomProps(react.tbody as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<td>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps td([Map backingMap]) => DomProps(react.td as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<textarea>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps textarea([Map backingMap]) => DomProps(react.textarea as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<tfoot>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps tfoot([Map backingMap]) => DomProps(react.tfoot as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<th>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps th([Map backingMap]) => DomProps(react.th as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<thead>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps thead([Map backingMap]) => DomProps(react.thead as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<time>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps time([Map backingMap]) => DomProps(react.time as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<title>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps title([Map backingMap]) => DomProps(react.title as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<tr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps tr([Map backingMap]) => DomProps(react.tr as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<track>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps track([Map backingMap]) => DomProps(react.track as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<u>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps u([Map backingMap]) => DomProps(react.u as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<ul>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ul([Map backingMap]) => DomProps(react.ul as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<var>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps variable([Map backingMap]) => DomProps(react.variable as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<video>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps video([Map backingMap]) => DomProps(react.video as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<wbr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps wbr([Map backingMap]) => DomProps(react.wbr as ReactComponentFactoryProxy/*!*/, backingMap);

  // SVG Elements
  /// Returns a new builder that renders an `<a>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgA([Map backingMap]) => SvgProps(react.a as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<altGlyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyph([Map backingMap]) => SvgProps(react.altGlyph as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<altGlyphDef>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyphDef([Map backingMap]) => SvgProps(react.altGlyphDef as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<altGlyphItem>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyphItem([Map backingMap]) => SvgProps(react.altGlyphItem as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<animate>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animate([Map backingMap]) => SvgProps(react.animate as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<animateColor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateColor([Map backingMap]) => SvgProps(react.animateColor as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<animateMotion>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateMotion([Map backingMap]) => SvgProps(react.animateMotion as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<animateTransform>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateTransform([Map backingMap]) => SvgProps(react.animateTransform as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<audio>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgAudio([Map backingMap]) => SvgProps(react.audio as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<canvas>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgCanvas([Map backingMap]) => SvgProps(react.canvas as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<circle>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps circle([Map backingMap]) => SvgProps(react.circle as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<clipPath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps clipPath([Map backingMap]) => SvgProps(react.clipPath as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<color-profile>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps colorProfile([Map backingMap]) => SvgProps(react.colorProfile as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<cursor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps cursor([Map backingMap]) => SvgProps(react.cursor as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<defs>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps defs([Map backingMap]) => SvgProps(react.defs as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<desc>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps desc([Map backingMap]) => SvgProps(react.desc as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<discard>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps discard([Map backingMap]) => SvgProps(react.discard as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<ellipse>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps ellipse([Map backingMap]) => SvgProps(react.ellipse as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feBlend>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feBlend([Map backingMap]) => SvgProps(react.feBlend as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feColorMatrix>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feColorMatrix([Map backingMap]) => SvgProps(react.feColorMatrix as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feComponentTransfer>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feComponentTransfer([Map backingMap]) => SvgProps(react.feComponentTransfer as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feComposite>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feComposite([Map backingMap]) => SvgProps(react.feComposite as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feConvolveMatrix>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feConvolveMatrix([Map backingMap]) => SvgProps(react.feConvolveMatrix as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feDiffuseLighting>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDiffuseLighting([Map backingMap]) => SvgProps(react.feDiffuseLighting as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feDisplacementMap>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDisplacementMap([Map backingMap]) => SvgProps(react.feDisplacementMap as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feDistantLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDistantLight([Map backingMap]) => SvgProps(react.feDistantLight as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feDropShadow>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDropShadow([Map backingMap]) => SvgProps(react.feDropShadow as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feFlood>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFlood([Map backingMap]) => SvgProps(react.feFlood as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feFuncA>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncA([Map backingMap]) => SvgProps(react.feFuncA as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feFuncB>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncB([Map backingMap]) => SvgProps(react.feFuncB as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feFuncG>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncG([Map backingMap]) => SvgProps(react.feFuncG as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feFuncR>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncR([Map backingMap]) => SvgProps(react.feFuncR as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feGaussianBlur>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feGaussianBlur([Map backingMap]) => SvgProps(react.feGaussianBlur as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feImage>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feImage([Map backingMap]) => SvgProps(react.feImage as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feMerge>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMerge([Map backingMap]) => SvgProps(react.feMerge as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feMergeNode>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMergeNode([Map backingMap]) => SvgProps(react.feMergeNode as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feMorphology>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMorphology([Map backingMap]) => SvgProps(react.feMorphology as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feOffset>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feOffset([Map backingMap]) => SvgProps(react.feOffset as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<fePointLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fePointLight([Map backingMap]) => SvgProps(react.fePointLight as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feSpecularLighting>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feSpecularLighting([Map backingMap]) => SvgProps(react.feSpecularLighting as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feSpotLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feSpotLight([Map backingMap]) => SvgProps(react.feSpotLight as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feTile>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feTile([Map backingMap]) => SvgProps(react.feTile as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<feTurbulence>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feTurbulence([Map backingMap]) => SvgProps(react.feTurbulence as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<filter>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps filter([Map backingMap]) => SvgProps(react.filter as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<font>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps font([Map backingMap]) => SvgProps(react.font as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<font-face>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFace([Map backingMap]) => SvgProps(react.fontFace as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<font-face-format>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceFormat([Map backingMap]) => SvgProps(react.fontFaceFormat as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<font-face-name>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceName([Map backingMap]) => SvgProps(react.fontFaceName as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<font-face-src>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceSrc([Map backingMap]) => SvgProps(react.fontFaceSrc as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<font-face-uri>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceUri([Map backingMap]) => SvgProps(react.fontFaceUri as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<foreignObject>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps foreignObject([Map backingMap]) => SvgProps(react.foreignObject as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<g>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps g([Map backingMap]) => SvgProps(react.g as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<glyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps glyph([Map backingMap]) => SvgProps(react.glyph as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<glyphRef>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps glyphRef([Map backingMap]) => SvgProps(react.glyphRef as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<hatch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hatch([Map backingMap]) => SvgProps(react.hatch as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<hatchpath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hatchpath([Map backingMap]) => SvgProps(react.hatchpath as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<hkern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hkern([Map backingMap]) => SvgProps(react.hkern as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<iframe>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgIframe([Map backingMap]) => SvgProps(react.iframe as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<image>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps image([Map backingMap]) => SvgProps(react.image as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<line>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps line([Map backingMap]) => SvgProps(react.line as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<linearGradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps linearGradient([Map backingMap]) => SvgProps(react.linearGradient as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<marker>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps marker([Map backingMap]) => SvgProps(react.marker as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<mask>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mask([Map backingMap]) => SvgProps(react.mask as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<mesh>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mesh([Map backingMap]) => SvgProps(react.mesh as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<meshgradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshgradient([Map backingMap]) => SvgProps(react.meshgradient as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<meshpatch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshpatch([Map backingMap]) => SvgProps(react.meshpatch as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<meshrow>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshrow([Map backingMap]) => SvgProps(react.meshrow as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<metadata>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps metadata([Map backingMap]) => SvgProps(react.metadata as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<missing-glyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps missingGlyph([Map backingMap]) => SvgProps(react.missingGlyph as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<mpath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mpath([Map backingMap]) => SvgProps(react.mpath as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<path>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps path([Map backingMap]) => SvgProps(react.path as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<pattern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps pattern([Map backingMap]) => SvgProps(react.pattern as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<polygon>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps polygon([Map backingMap]) => SvgProps(react.polygon as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<polyline>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps polyline([Map backingMap]) => SvgProps(react.polyline as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<radialGradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps radialGradient([Map backingMap]) => SvgProps(react.radialGradient as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<rect>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps rect([Map backingMap]) => SvgProps(react.rect as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<script>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgScript([Map backingMap]) => SvgProps(react.script as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<set>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgSet([Map backingMap]) => SvgProps(react.svgSet as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<solidcolor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps solidcolor([Map backingMap]) => SvgProps(react.solidcolor as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<stop>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps stop([Map backingMap]) => SvgProps(react.stop as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<style>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgStyle([Map backingMap]) => SvgProps(react.style as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<svg>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svg([Map backingMap]) => SvgProps(react.svg as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<switch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgSwitch([Map backingMap]) => SvgProps(react.svgSwitch as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<symbol>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps symbol([Map backingMap]) => SvgProps(react.symbol as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<text>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps text([Map backingMap]) => SvgProps(react.text as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<textPath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps textPath([Map backingMap]) => SvgProps(react.textPath as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<title>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgTitle([Map backingMap]) => SvgProps(react.title as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<tref>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps tref([Map backingMap]) => SvgProps(react.tref as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<tspan>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps tspan([Map backingMap]) => SvgProps(react.tspan as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<unknown>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps unknown([Map backingMap]) => SvgProps(react.unknown as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders an `<use>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps use([Map backingMap]) => SvgProps(react.use as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<video>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgVideo([Map backingMap]) => SvgProps(react.video as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<view>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps view([Map backingMap]) => SvgProps(react.view as ReactComponentFactoryProxy/*!*/, backingMap);

  /// Returns a new builder that renders a `<vkern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps vkern([Map backingMap]) => SvgProps(react.vkern as ReactComponentFactoryProxy/*!*/, backingMap);
}
