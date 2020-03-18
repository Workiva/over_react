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
// NOTE: Similarly to standard components, adding the ignore undefined_identifier
// will be necessary.
// ignore_for_file: undefined_identifier
library over_react.dom_components;

import 'package:meta/meta.dart';
import 'package:over_react/src/component/prop_mixins.dart';
import 'package:over_react/src/component_declaration/builder_helpers.dart'
    as builder_helpers;
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';

part 'dom_components.example.over_react.g.dart';

//--------------------------- New boilerplate spike ----------------------------

// -----------------------------------------------------------------------------
// ----------------------------- Handwritten Code ------------------------------
// -----------------------------------------------------------------------------

// Exactly the same class as is used for functional components
class PropsFactory<T extends builder_helpers.UiProps> {
  final T Function(Map props) map;
  final T Function(JsBackedMap props) jsMap;

  PropsFactory({
    @required this.map,
    @required this.jsMap,
  });

  PropsFactory.fromUiFactory(builder_helpers.UiFactory<T> factory) : this.map = factory, this.jsMap = factory;
}

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
  static DomProps a([backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.a;

  /// Returns a new builder that renders an `<abbr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps abbr([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.abbr;

  /// Returns a new builder that renders an `<address>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps address([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.address;

  /// Returns a new builder that renders an `<area>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps area([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.area;

  /// Returns a new builder that renders an `<article>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps article([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.article;

  /// Returns a new builder that renders an `<aside>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps aside([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.aside;

  /// Returns a new builder that renders an `<audio>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps audio([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.audio;

  /// Returns a new builder that renders a `<b>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps b([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.b;

  /// Returns a new builder that renders a `<base>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps base([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.base;

  /// Returns a new builder that renders a `<bdi>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps bdi([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.bdi;

  /// Returns a new builder that renders a `<bdo>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps bdo([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.bdo;

  /// Returns a new builder that renders a `<big>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps big([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.big;

  /// Returns a new builder that renders a `<blockquote>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps blockquote([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.blockquote;

  /// Returns a new builder that renders a `<body>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps body([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.body;

  /// Returns a new builder that renders a `<br>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps br([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.br;

  /// Returns a new builder that renders a `<button>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps button([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.button;

  /// Returns a new builder that renders a `<canvas>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps canvas([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.canvas;

  /// Returns a new builder that renders a `<caption>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps caption([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.caption;

  /// Returns a new builder that renders a `<cite>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps cite([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.cite;

  /// Returns a new builder that renders a `<code>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps code([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.code;

  /// Returns a new builder that renders a `<col>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps col([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.col;

  /// Returns a new builder that renders a `<colgroup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps colgroup([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.colgroup;

  /// Returns a new builder that renders a `<data>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps data([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.data;

  /// Returns a new builder that renders a `<datalist>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps datalist([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.datalist;

  /// Returns a new builder that renders a `<dd>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dd([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.dd;

  /// Returns a new builder that renders a `<del>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps del([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.del;

  /// Returns a new builder that renders a `<details>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps details([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.details;

  /// Returns a new builder that renders a `<dfn>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dfn([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.dfn;

  /// Returns a new builder that renders a `<dialog>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dialog([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.dialog;

  /// Returns a new builder that renders a `<div>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static $DomPropsImpl div([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.div;

  /// Returns a new builder that renders a `<dl>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dl([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.dl;

  /// Returns a new builder that renders a `<dt>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps dt([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.dt;

  /// Returns a new builder that renders an `<em>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps em([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.em;

  /// Returns a new builder that renders an `<embed>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps embed([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.embed;

  /// Returns a new builder that renders a `<fieldset>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps fieldset([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.fieldset;

  /// Returns a new builder that renders a `<figcaption>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps figcaption([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.figcaption;

  /// Returns a new builder that renders a `<figure>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps figure([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.figure;

  /// Returns a new builder that renders a `<footer>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps footer([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.footer;

  /// Returns a new builder that renders a `<form>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps form([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.form;

  /// Returns a new builder that renders a `<h1>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h1([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.h1;

  /// Returns a new builder that renders a `<h2>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h2([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.h2;

  /// Returns a new builder that renders a `<h3>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h3([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.h3;

  /// Returns a new builder that renders a `<h4>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h4([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.h4;

  /// Returns a new builder that renders a `<h5>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h5([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.h5;

  /// Returns a new builder that renders a `<h6>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps h6([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.h6;

  /// Returns a new builder that renders a `<head>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps head([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.head;

  /// Returns a new builder that renders a `<header>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps header([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.header;

  /// Returns a new builder that renders a `<hr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps hr([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.hr;

  /// Returns a new builder that renders a `<html>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps html([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.html;

  /// Returns a new builder that renders an `<i>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps i([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.i;

  /// Returns a new builder that renders an `<iframe>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps iframe([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.iframe;

  /// Returns a new builder that renders an `<img>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps img([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.img;

  /// Returns a new builder that renders an `<input>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps input([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.input;

  /// Returns a new builder that renders an `<ins>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ins([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.ins;

  /// Returns a new builder that renders a `<kbd>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps kbd([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.kbd;

  /// Returns a new builder that renders a `<keygen>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps keygen([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.keygen;

  /// Returns a new builder that renders a `<label>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps label([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.label;

  /// Returns a new builder that renders a `<legend>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps legend([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.legend;

  /// Returns a new builder that renders a `<li>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps li([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.li;

  /// Returns a new builder that renders a `<link>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps link([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.link;

  /// Returns a new builder that renders a `<main>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps main([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.main;

  /// Returns a new builder that renders a `<backingMap>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps map([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.map;

  /// Returns a new builder that renders a `<mark>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps mark([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.mark;

  /// Returns a new builder that renders a `<menu>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps menu([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.menu;

  /// Returns a new builder that renders a `<menuitem>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps menuitem([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.menuitem;

  /// Returns a new builder that renders a `<meta>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps meta([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.meta;

  /// Returns a new builder that renders a `<meter>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps meter([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.meter;

  /// Returns a new builder that renders a `<nav>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps nav([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.nav;

  /// Returns a new builder that renders a `<noscript>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps noscript([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.noscript;

  /// Returns a new builder that renders an `<object>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps object([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.object;

  /// Returns a new builder that renders an `<ol>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ol([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.ol;

  /// Returns a new builder that renders an `<optgroup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps optgroup([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.optgroup;

  /// Returns a new builder that renders an `<option>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps option([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.option;

  /// Returns a new builder that renders an `<output>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps output([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.output;

  /// Returns a new builder that renders a `<p>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps p([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.p;

  /// Returns a new builder that renders a `<param>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps param([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.param;

  /// Returns a new builder that renders a `<picture>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps picture([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.picture;

  /// Returns a new builder that renders a `<pre>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps pre([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.pre;

  /// Returns a new builder that renders a `<progress>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps progress([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.progress;

  /// Returns a new builder that renders a `<q>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps q([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.q;

  /// Returns a new builder that renders a `<rp>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps rp([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.rp;

  /// Returns a new builder that renders a `<rt>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps rt([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.rt;

  /// Returns a new builder that renders a `<ruby>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ruby([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.ruby;

  /// Returns a new builder that renders a `<s>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps s([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.s;

  /// Returns a new builder that renders a `<samp>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps samp([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.samp;

  /// Returns a new builder that renders a `<script>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps script([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.script;

  /// Returns a new builder that renders a `<section>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps section([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.section;

  /// Returns a new builder that renders a `<select>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps select([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.select;

  /// Returns a new builder that renders a `<small>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps small([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.small;

  /// Returns a new builder that renders a `<source>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps source([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.source;

  /// Returns a new builder that renders a `<span>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps span([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.span;

  /// Returns a new builder that renders a `<strong>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps strong([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.strong;

  /// Returns a new builder that renders a `<style>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps style([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.style;

  /// Returns a new builder that renders a `<sub>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps sub([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.sub;

  /// Returns a new builder that renders a `<summary>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps summary([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.summary;

  /// Returns a new builder that renders a `<sup>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps sup([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.sup;

  /// Returns a new builder that renders a `<table>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps table([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.table;

  /// Returns a new builder that renders a `<tbody>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps tbody([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.tbody;

  /// Returns a new builder that renders a `<td>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps td([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.td;

  /// Returns a new builder that renders a `<textarea>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps textarea([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.textarea;

  /// Returns a new builder that renders a `<tfoot>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps tfoot([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.tfoot;

  /// Returns a new builder that renders a `<th>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps th([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.th;

  /// Returns a new builder that renders a `<thead>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps thead([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.thead;

  /// Returns a new builder that renders a `<time>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps time([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.time;

  /// Returns a new builder that renders a `<title>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps title([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.title;

  /// Returns a new builder that renders a `<tr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps tr([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.tr;

  /// Returns a new builder that renders a `<track>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps track([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.track;

  /// Returns a new builder that renders an `<u>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps u([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.u;

  /// Returns a new builder that renders an `<ul>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps ul([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.ul;

  /// Returns a new builder that renders a `<var>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps variable([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.variable;

  /// Returns a new builder that renders a `<video>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps video([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.video;

  /// Returns a new builder that renders a `<wbr>` tag with getters/setters for all DOM-related React props,
  /// optionally backed by a specified map.
  static DomProps wbr([Map backingMap]) => $domPropsConfig.map(backingMap)..componentFactory = react.wbr;

  // SVG Elements
  /// Returns a new builder that renders an `<a>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgA([Map backingMap]) => SvgProps(react.a, backingMap);

  /// Returns a new builder that renders an `<altGlyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyph([Map backingMap]) => SvgProps(react.altGlyph, backingMap);

  /// Returns a new builder that renders an `<altGlyphDef>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyphDef([Map backingMap]) => SvgProps(react.altGlyphDef, backingMap);

  /// Returns a new builder that renders an `<altGlyphItem>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps altGlyphItem([Map backingMap]) => SvgProps(react.altGlyphItem, backingMap);

  /// Returns a new builder that renders an `<animate>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animate([Map backingMap]) => SvgProps(react.animate, backingMap);

  /// Returns a new builder that renders an `<animateColor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateColor([Map backingMap]) => SvgProps(react.animateColor, backingMap);

  /// Returns a new builder that renders an `<animateMotion>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateMotion([Map backingMap]) => SvgProps(react.animateMotion, backingMap);

  /// Returns a new builder that renders an `<animateTransform>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps animateTransform([Map backingMap]) => SvgProps(react.animateTransform, backingMap);

  /// Returns a new builder that renders an `<audio>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgAudio([Map backingMap]) => SvgProps(react.audio, backingMap);

  /// Returns a new builder that renders a `<canvas>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgCanvas([Map backingMap]) => SvgProps(react.canvas, backingMap);

  /// Returns a new builder that renders a `<circle>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps circle([Map backingMap]) => SvgProps(react.circle, backingMap);

  /// Returns a new builder that renders a `<clipPath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps clipPath([Map backingMap]) => SvgProps(react.clipPath, backingMap);

  /// Returns a new builder that renders a `<color-profile>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps colorProfile([Map backingMap]) => SvgProps(react.colorProfile, backingMap);

  /// Returns a new builder that renders a `<cursor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps cursor([Map backingMap]) => SvgProps(react.cursor, backingMap);

  /// Returns a new builder that renders a `<defs>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps defs([Map backingMap]) => SvgProps(react.defs, backingMap);

  /// Returns a new builder that renders a `<desc>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps desc([Map backingMap]) => SvgProps(react.desc, backingMap);

  /// Returns a new builder that renders a `<discard>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps discard([Map backingMap]) => SvgProps(react.discard, backingMap);

  /// Returns a new builder that renders an `<ellipse>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps ellipse([Map backingMap]) => SvgProps(react.ellipse, backingMap);

  /// Returns a new builder that renders a `<feBlend>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feBlend([Map backingMap]) => SvgProps(react.feBlend, backingMap);

  /// Returns a new builder that renders a `<feColorMatrix>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feColorMatrix([Map backingMap]) => SvgProps(react.feColorMatrix, backingMap);

  /// Returns a new builder that renders a `<feComponentTransfer>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feComponentTransfer([Map backingMap]) => SvgProps(react.feComponentTransfer, backingMap);

  /// Returns a new builder that renders a `<feComposite>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feComposite([Map backingMap]) => SvgProps(react.feComposite, backingMap);

  /// Returns a new builder that renders a `<feConvolveMatrix>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feConvolveMatrix([Map backingMap]) => SvgProps(react.feConvolveMatrix, backingMap);

  /// Returns a new builder that renders a `<feDiffuseLighting>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDiffuseLighting([Map backingMap]) => SvgProps(react.feDiffuseLighting, backingMap);

  /// Returns a new builder that renders a `<feDisplacementMap>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDisplacementMap([Map backingMap]) => SvgProps(react.feDisplacementMap, backingMap);

  /// Returns a new builder that renders a `<feDistantLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDistantLight([Map backingMap]) => SvgProps(react.feDistantLight, backingMap);

  /// Returns a new builder that renders a `<feDropShadow>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feDropShadow([Map backingMap]) => SvgProps(react.feDropShadow, backingMap);

  /// Returns a new builder that renders a `<feFlood>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFlood([Map backingMap]) => SvgProps(react.feFlood, backingMap);

  /// Returns a new builder that renders a `<feFuncA>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncA([Map backingMap]) => SvgProps(react.feFuncA, backingMap);

  /// Returns a new builder that renders a `<feFuncB>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncB([Map backingMap]) => SvgProps(react.feFuncB, backingMap);

  /// Returns a new builder that renders a `<feFuncG>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncG([Map backingMap]) => SvgProps(react.feFuncG, backingMap);

  /// Returns a new builder that renders a `<feFuncR>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feFuncR([Map backingMap]) => SvgProps(react.feFuncR, backingMap);

  /// Returns a new builder that renders a `<feGaussianBlur>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feGaussianBlur([Map backingMap]) => SvgProps(react.feGaussianBlur, backingMap);

  /// Returns a new builder that renders a `<feImage>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feImage([Map backingMap]) => SvgProps(react.feImage, backingMap);

  /// Returns a new builder that renders a `<feMerge>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMerge([Map backingMap]) => SvgProps(react.feMerge, backingMap);

  /// Returns a new builder that renders a `<feMergeNode>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMergeNode([Map backingMap]) => SvgProps(react.feMergeNode, backingMap);

  /// Returns a new builder that renders a `<feMorphology>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feMorphology([Map backingMap]) => SvgProps(react.feMorphology, backingMap);

  /// Returns a new builder that renders a `<feOffset>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feOffset([Map backingMap]) => SvgProps(react.feOffset, backingMap);

  /// Returns a new builder that renders a `<fePointLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fePointLight([Map backingMap]) => SvgProps(react.fePointLight, backingMap);

  /// Returns a new builder that renders a `<feSpecularLighting>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feSpecularLighting([Map backingMap]) => SvgProps(react.feSpecularLighting, backingMap);

  /// Returns a new builder that renders a `<feSpotLight>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feSpotLight([Map backingMap]) => SvgProps(react.feSpotLight, backingMap);

  /// Returns a new builder that renders a `<feTile>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feTile([Map backingMap]) => SvgProps(react.feTile, backingMap);

  /// Returns a new builder that renders a `<feTurbulence>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps feTurbulence([Map backingMap]) => SvgProps(react.feTurbulence, backingMap);

  /// Returns a new builder that renders a `<filter>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps filter([Map backingMap]) => SvgProps(react.filter, backingMap);

  /// Returns a new builder that renders a `<font>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps font([Map backingMap]) => SvgProps(react.font, backingMap);

  /// Returns a new builder that renders a `<font-face>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFace([Map backingMap]) => SvgProps(react.fontFace, backingMap);

  /// Returns a new builder that renders a `<font-face-format>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceFormat([Map backingMap]) => SvgProps(react.fontFaceFormat, backingMap);

  /// Returns a new builder that renders a `<font-face-name>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceName([Map backingMap]) => SvgProps(react.fontFaceName, backingMap);

  /// Returns a new builder that renders a `<font-face-src>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceSrc([Map backingMap]) => SvgProps(react.fontFaceSrc, backingMap);

  /// Returns a new builder that renders a `<font-face-uri>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps fontFaceUri([Map backingMap]) => SvgProps(react.fontFaceUri, backingMap);

  /// Returns a new builder that renders a `<foreignObject>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps foreignObject([Map backingMap]) => SvgProps(react.foreignObject, backingMap);

  /// Returns a new builder that renders a `<g>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps g([Map backingMap]) => SvgProps(react.g, backingMap);

  /// Returns a new builder that renders a `<glyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps glyph([Map backingMap]) => SvgProps(react.glyph, backingMap);

  /// Returns a new builder that renders a `<glyphRef>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps glyphRef([Map backingMap]) => SvgProps(react.glyphRef, backingMap);

  /// Returns a new builder that renders a `<hatch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hatch([Map backingMap]) => SvgProps(react.hatch, backingMap);

  /// Returns a new builder that renders a `<hatchpath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hatchpath([Map backingMap]) => SvgProps(react.hatchpath, backingMap);

  /// Returns a new builder that renders a `<hkern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps hkern([Map backingMap]) => SvgProps(react.hkern, backingMap);

  /// Returns a new builder that renders an `<iframe>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgIframe([Map backingMap]) => SvgProps(react.iframe, backingMap);

  /// Returns a new builder that renders an `<image>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps image([Map backingMap]) => SvgProps(react.image, backingMap);

  /// Returns a new builder that renders a `<line>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps line([Map backingMap]) => SvgProps(react.line, backingMap);

  /// Returns a new builder that renders a `<linearGradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps linearGradient([Map backingMap]) => SvgProps(react.linearGradient, backingMap);

  /// Returns a new builder that renders a `<marker>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps marker([Map backingMap]) => SvgProps(react.marker, backingMap);

  /// Returns a new builder that renders a `<mask>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mask([Map backingMap]) => SvgProps(react.mask, backingMap);

  /// Returns a new builder that renders a `<mesh>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mesh([Map backingMap]) => SvgProps(react.mesh, backingMap);

  /// Returns a new builder that renders a `<meshgradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshgradient([Map backingMap]) => SvgProps(react.meshgradient, backingMap);

  /// Returns a new builder that renders a `<meshpatch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshpatch([Map backingMap]) => SvgProps(react.meshpatch, backingMap);

  /// Returns a new builder that renders a `<meshrow>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps meshrow([Map backingMap]) => SvgProps(react.meshrow, backingMap);

  /// Returns a new builder that renders a `<metadata>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps metadata([Map backingMap]) => SvgProps(react.metadata, backingMap);

  /// Returns a new builder that renders a `<missing-glyph>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps missingGlyph([Map backingMap]) => SvgProps(react.missingGlyph, backingMap);

  /// Returns a new builder that renders a `<mpath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps mpath([Map backingMap]) => SvgProps(react.mpath, backingMap);

  /// Returns a new builder that renders a `<path>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps path([Map backingMap]) => SvgProps(react.path, backingMap);

  /// Returns a new builder that renders a `<pattern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps pattern([Map backingMap]) => SvgProps(react.pattern, backingMap);

  /// Returns a new builder that renders a `<polygon>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps polygon([Map backingMap]) => SvgProps(react.polygon, backingMap);

  /// Returns a new builder that renders a `<polyline>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps polyline([Map backingMap]) => SvgProps(react.polyline, backingMap);

  /// Returns a new builder that renders a `<radialGradient>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps radialGradient([Map backingMap]) => SvgProps(react.radialGradient, backingMap);

  /// Returns a new builder that renders a `<rect>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps rect([Map backingMap]) => SvgProps(react.rect, backingMap);

  /// Returns a new builder that renders a `<script>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgScript([Map backingMap]) => SvgProps(react.script, backingMap);

  /// Returns a new builder that renders a `<set>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgSet([Map backingMap]) => SvgProps(react.svgSet, backingMap);

  /// Returns a new builder that renders a `<solidcolor>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps solidcolor([Map backingMap]) => SvgProps(react.solidcolor, backingMap);

  /// Returns a new builder that renders a `<stop>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps stop([Map backingMap]) => SvgProps(react.stop, backingMap);

  /// Returns a new builder that renders a `<style>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgStyle([Map backingMap]) => SvgProps(react.style, backingMap);

  /// Returns a new builder that renders a `<svg>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svg([Map backingMap]) => SvgProps(react.svg, backingMap);

  /// Returns a new builder that renders a `<switch>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgSwitch([Map backingMap]) => SvgProps(react.svgSwitch, backingMap);

  /// Returns a new builder that renders a `<symbol>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps symbol([Map backingMap]) => SvgProps(react.symbol, backingMap);

  /// Returns a new builder that renders a `<text>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps text([Map backingMap]) => SvgProps(react.text, backingMap);

  /// Returns a new builder that renders a `<textPath>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps textPath([Map backingMap]) => SvgProps(react.textPath, backingMap);

  /// Returns a new builder that renders a `<title>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgTitle([Map backingMap]) => SvgProps(react.title, backingMap);

  /// Returns a new builder that renders a `<tref>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps tref([Map backingMap]) => SvgProps(react.tref, backingMap);

  /// Returns a new builder that renders a `<tspan>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps tspan([Map backingMap]) => SvgProps(react.tspan, backingMap);

  /// Returns a new builder that renders an `<unknown>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps unknown([Map backingMap]) => SvgProps(react.unknown, backingMap);

  /// Returns a new builder that renders an `<use>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps use([Map backingMap]) => SvgProps(react.use, backingMap);

  /// Returns a new builder that renders a `<video>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps svgVideo([Map backingMap]) => SvgProps(react.video, backingMap);

  /// Returns a new builder that renders a `<view>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps view([Map backingMap]) => SvgProps(react.view, backingMap);

  /// Returns a new builder that renders a `<vkern>` tag with getters/setters for all SVG-related React props,
  /// optionally backed by a specified map.
  static SvgProps vkern([Map backingMap]) => SvgProps(react.vkern, backingMap);
}
