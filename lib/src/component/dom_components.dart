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
import 'package:over_react/src/component_declaration/component_base.dart'
    as component_base;
import 'package:over_react/src/component_declaration/builder_helpers.dart'
    as builder_helpers;
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';

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
class DomProps extends component_base.UiProps
    with DomPropsMixin, builder_helpers.GeneratedClass
    implements builder_helpers.UiProps {
  // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
  DomProps(this.componentFactory, [Map props]) : this.props = props ?? ({});

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
    with DomPropsMixin, SvgPropsMixin, builder_helpers.GeneratedClass
    implements DomProps {
  // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
  SvgProps(this.componentFactory, [Map props]) : this.props = props ?? ({});

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
  static DomProps a() => DomProps(react.a);

  /// Returns a new [DomPropsMixin] that renders an `<abbr>` tag with getters/setters for all DOM-related React props
  static DomProps abbr() => DomProps(react.abbr);

  /// Returns a new [DomPropsMixin] that renders an `<address>` tag with getters/setters for all DOM-related React props
  static DomProps address() => DomProps(react.address);

  /// Returns a new [DomPropsMixin] that renders an `<area>` tag with getters/setters for all DOM-related React props
  static DomProps area() => DomProps(react.area);

  /// Returns a new [DomPropsMixin] that renders an `<article>` tag with getters/setters for all DOM-related React props
  static DomProps article() => DomProps(react.article);

  /// Returns a new [DomPropsMixin] that renders an `<aside>` tag with getters/setters for all DOM-related React props
  static DomProps aside() => DomProps(react.aside);

  /// Returns a new [DomPropsMixin] that renders an `<audio>` tag with getters/setters for all DOM-related React props
  static DomProps audio() => DomProps(react.audio);

  /// Returns a new [DomPropsMixin] that renders a `<b>` tag with getters/setters for all DOM-related React props
  static DomProps b() => DomProps(react.b);

  /// Returns a new [DomPropsMixin] that renders a `<base>` tag with getters/setters for all DOM-related React props
  static DomProps base() => DomProps(react.base);

  /// Returns a new [DomPropsMixin] that renders a `<bdi>` tag with getters/setters for all DOM-related React props
  static DomProps bdi() => DomProps(react.bdi);

  /// Returns a new [DomPropsMixin] that renders a `<bdo>` tag with getters/setters for all DOM-related React props
  static DomProps bdo() => DomProps(react.bdo);

  /// Returns a new [DomPropsMixin] that renders a `<big>` tag with getters/setters for all DOM-related React props
  static DomProps big() => DomProps(react.big);

  /// Returns a new [DomPropsMixin] that renders a `<blockquote>` tag with getters/setters for all DOM-related React props
  static DomProps blockquote() => DomProps(react.blockquote);

  /// Returns a new [DomPropsMixin] that renders a `<body>` tag with getters/setters for all DOM-related React props
  static DomProps body() => DomProps(react.body);

  /// Returns a new [DomPropsMixin] that renders a `<br>` tag with getters/setters for all DOM-related React props
  static DomProps br() => DomProps(react.br);

  /// Returns a new [DomPropsMixin] that renders a `<button>` tag with getters/setters for all DOM-related React props
  static DomProps button() => DomProps(react.button);

  /// Returns a new [DomPropsMixin] that renders a `<canvas>` tag with getters/setters for all DOM-related React props
  static DomProps canvas() => DomProps(react.canvas);

  /// Returns a new [DomPropsMixin] that renders a `<caption>` tag with getters/setters for all DOM-related React props
  static DomProps caption() => DomProps(react.caption);

  /// Returns a new [DomPropsMixin] that renders a `<cite>` tag with getters/setters for all DOM-related React props
  static DomProps cite() => DomProps(react.cite);

  /// Returns a new [DomPropsMixin] that renders a `<code>` tag with getters/setters for all DOM-related React props
  static DomProps code() => DomProps(react.code);

  /// Returns a new [DomPropsMixin] that renders a `<col>` tag with getters/setters for all DOM-related React props
  static DomProps col() => DomProps(react.col);

  /// Returns a new [DomPropsMixin] that renders a `<colgroup>` tag with getters/setters for all DOM-related React props
  static DomProps colgroup() => DomProps(react.colgroup);

  /// Returns a new [DomPropsMixin] that renders a `<data>` tag with getters/setters for all DOM-related React props
  static DomProps data() => DomProps(react.data);

  /// Returns a new [DomPropsMixin] that renders a `<datalist>` tag with getters/setters for all DOM-related React props
  static DomProps datalist() => DomProps(react.datalist);

  /// Returns a new [DomPropsMixin] that renders a `<dd>` tag with getters/setters for all DOM-related React props
  static DomProps dd() => DomProps(react.dd);

  /// Returns a new [DomPropsMixin] that renders a `<del>` tag with getters/setters for all DOM-related React props
  static DomProps del() => DomProps(react.del);

  /// Returns a new [DomPropsMixin] that renders a `<details>` tag with getters/setters for all DOM-related React props
  static DomProps details() => DomProps(react.details);

  /// Returns a new [DomPropsMixin] that renders a `<dfn>` tag with getters/setters for all DOM-related React props
  static DomProps dfn() => DomProps(react.dfn);

  /// Returns a new [DomPropsMixin] that renders a `<dialog>` tag with getters/setters for all DOM-related React props
  static DomProps dialog() => DomProps(react.dialog);

  /// Returns a new [DomPropsMixin] that renders a `<div>` tag with getters/setters for all DOM-related React props
  static DomProps div() => DomProps(react.div);

  /// Returns a new [DomPropsMixin] that renders a `<dl>` tag with getters/setters for all DOM-related React props
  static DomProps dl() => DomProps(react.dl);

  /// Returns a new [DomPropsMixin] that renders a `<dt>` tag with getters/setters for all DOM-related React props
  static DomProps dt() => DomProps(react.dt);

  /// Returns a new [DomPropsMixin] that renders an `<em>` tag with getters/setters for all DOM-related React props
  static DomProps em() => DomProps(react.em);

  /// Returns a new [DomPropsMixin] that renders an `<embed>` tag with getters/setters for all DOM-related React props
  static DomProps embed() => DomProps(react.embed);

  /// Returns a new [DomPropsMixin] that renders a `<fieldset>` tag with getters/setters for all DOM-related React props
  static DomProps fieldset() => DomProps(react.fieldset);

  /// Returns a new [DomPropsMixin] that renders a `<figcaption>` tag with getters/setters for all DOM-related React props
  static DomProps figcaption() => DomProps(react.figcaption);

  /// Returns a new [DomPropsMixin] that renders a `<figure>` tag with getters/setters for all DOM-related React props
  static DomProps figure() => DomProps(react.figure);

  /// Returns a new [DomPropsMixin] that renders a `<footer>` tag with getters/setters for all DOM-related React props
  static DomProps footer() => DomProps(react.footer);

  /// Returns a new [DomPropsMixin] that renders a `<form>` tag with getters/setters for all DOM-related React props
  static DomProps form() => DomProps(react.form);

  /// Returns a new [DomPropsMixin] that renders a `<h1>` tag with getters/setters for all DOM-related React props
  static DomProps h1() => DomProps(react.h1);

  /// Returns a new [DomPropsMixin] that renders a `<h2>` tag with getters/setters for all DOM-related React props
  static DomProps h2() => DomProps(react.h2);

  /// Returns a new [DomPropsMixin] that renders a `<h3>` tag with getters/setters for all DOM-related React props
  static DomProps h3() => DomProps(react.h3);

  /// Returns a new [DomPropsMixin] that renders a `<h4>` tag with getters/setters for all DOM-related React props
  static DomProps h4() => DomProps(react.h4);

  /// Returns a new [DomPropsMixin] that renders a `<h5>` tag with getters/setters for all DOM-related React props
  static DomProps h5() => DomProps(react.h5);

  /// Returns a new [DomPropsMixin] that renders a `<h6>` tag with getters/setters for all DOM-related React props
  static DomProps h6() => DomProps(react.h6);

  /// Returns a new [DomPropsMixin] that renders a `<head>` tag with getters/setters for all DOM-related React props
  static DomProps head() => DomProps(react.head);

  /// Returns a new [DomPropsMixin] that renders a `<header>` tag with getters/setters for all DOM-related React props
  static DomProps header() => DomProps(react.header);

  /// Returns a new [DomPropsMixin] that renders a `<hr>` tag with getters/setters for all DOM-related React props
  static DomProps hr() => DomProps(react.hr);

  /// Returns a new [DomPropsMixin] that renders a `<html>` tag with getters/setters for all DOM-related React props
  static DomProps html() => DomProps(react.html);

  /// Returns a new [DomPropsMixin] that renders an `<i>` tag with getters/setters for all DOM-related React props
  static DomProps i() => DomProps(react.i);

  /// Returns a new [DomPropsMixin] that renders an `<iframe>` tag with getters/setters for all DOM-related React props
  static DomProps iframe() => DomProps(react.iframe);

  /// Returns a new [DomPropsMixin] that renders an `<img>` tag with getters/setters for all DOM-related React props
  static DomProps img() => DomProps(react.img);

  /// Returns a new [DomPropsMixin] that renders an `<input>` tag with getters/setters for all DOM-related React props
  static DomProps input() => DomProps(react.input);

  /// Returns a new [DomPropsMixin] that renders an `<ins>` tag with getters/setters for all DOM-related React props
  static DomProps ins() => DomProps(react.ins);

  /// Returns a new [DomPropsMixin] that renders a `<kbd>` tag with getters/setters for all DOM-related React props
  static DomProps kbd() => DomProps(react.kbd);

  /// Returns a new [DomPropsMixin] that renders a `<keygen>` tag with getters/setters for all DOM-related React props
  static DomProps keygen() => DomProps(react.keygen);

  /// Returns a new [DomPropsMixin] that renders a `<label>` tag with getters/setters for all DOM-related React props
  static DomProps label() => DomProps(react.label);

  /// Returns a new [DomPropsMixin] that renders a `<legend>` tag with getters/setters for all DOM-related React props
  static DomProps legend() => DomProps(react.legend);

  /// Returns a new [DomPropsMixin] that renders a `<li>` tag with getters/setters for all DOM-related React props
  static DomProps li() => DomProps(react.li);

  /// Returns a new [DomPropsMixin] that renders a `<link>` tag with getters/setters for all DOM-related React props
  static DomProps link() => DomProps(react.link);

  /// Returns a new [DomPropsMixin] that renders a `<main>` tag with getters/setters for all DOM-related React props
  static DomProps main() => DomProps(react.main);

  /// Returns a new [DomPropsMixin] that renders a `<map>` tag with getters/setters for all DOM-related React props
  static DomProps map() => DomProps(react.map);

  /// Returns a new [DomPropsMixin] that renders a `<mark>` tag with getters/setters for all DOM-related React props
  static DomProps mark() => DomProps(react.mark);

  /// Returns a new [DomPropsMixin] that renders a `<menu>` tag with getters/setters for all DOM-related React props
  static DomProps menu() => DomProps(react.menu);

  /// Returns a new [DomPropsMixin] that renders a `<menuitem>` tag with getters/setters for all DOM-related React props
  static DomProps menuitem() => DomProps(react.menuitem);

  /// Returns a new [DomPropsMixin] that renders a `<meta>` tag with getters/setters for all DOM-related React props
  static DomProps meta() => DomProps(react.meta);

  /// Returns a new [DomPropsMixin] that renders a `<meter>` tag with getters/setters for all DOM-related React props
  static DomProps meter() => DomProps(react.meter);

  /// Returns a new [DomPropsMixin] that renders a `<nav>` tag with getters/setters for all DOM-related React props
  static DomProps nav() => DomProps(react.nav);

  /// Returns a new [DomPropsMixin] that renders a `<noscript>` tag with getters/setters for all DOM-related React props
  static DomProps noscript() => DomProps(react.noscript);

  /// Returns a new [DomPropsMixin] that renders an `<object>` tag with getters/setters for all DOM-related React props
  static DomProps object() => DomProps(react.object);

  /// Returns a new [DomPropsMixin] that renders an `<ol>` tag with getters/setters for all DOM-related React props
  static DomProps ol() => DomProps(react.ol);

  /// Returns a new [DomPropsMixin] that renders an `<optgroup>` tag with getters/setters for all DOM-related React props
  static DomProps optgroup() => DomProps(react.optgroup);

  /// Returns a new [DomPropsMixin] that renders an `<option>` tag with getters/setters for all DOM-related React props
  static DomProps option() => DomProps(react.option);

  /// Returns a new [DomPropsMixin] that renders an `<output>` tag with getters/setters for all DOM-related React props
  static DomProps output() => DomProps(react.output);

  /// Returns a new [DomPropsMixin] that renders a `<p>` tag with getters/setters for all DOM-related React props
  static DomProps p() => DomProps(react.p);

  /// Returns a new [DomPropsMixin] that renders a `<param>` tag with getters/setters for all DOM-related React props
  static DomProps param() => DomProps(react.param);

  /// Returns a new [DomPropsMixin] that renders a `<picture>` tag with getters/setters for all DOM-related React props
  static DomProps picture() => DomProps(react.picture);

  /// Returns a new [DomPropsMixin] that renders a `<pre>` tag with getters/setters for all DOM-related React props
  static DomProps pre() => DomProps(react.pre);

  /// Returns a new [DomPropsMixin] that renders a `<progress>` tag with getters/setters for all DOM-related React props
  static DomProps progress() => DomProps(react.progress);

  /// Returns a new [DomPropsMixin] that renders a `<q>` tag with getters/setters for all DOM-related React props
  static DomProps q() => DomProps(react.q);

  /// Returns a new [DomPropsMixin] that renders a `<rp>` tag with getters/setters for all DOM-related React props
  static DomProps rp() => DomProps(react.rp);

  /// Returns a new [DomPropsMixin] that renders a `<rt>` tag with getters/setters for all DOM-related React props
  static DomProps rt() => DomProps(react.rt);

  /// Returns a new [DomPropsMixin] that renders a `<ruby>` tag with getters/setters for all DOM-related React props
  static DomProps ruby() => DomProps(react.ruby);

  /// Returns a new [DomPropsMixin] that renders a `<s>` tag with getters/setters for all DOM-related React props
  static DomProps s() => DomProps(react.s);

  /// Returns a new [DomPropsMixin] that renders a `<samp>` tag with getters/setters for all DOM-related React props
  static DomProps samp() => DomProps(react.samp);

  /// Returns a new [DomPropsMixin] that renders a `<script>` tag with getters/setters for all DOM-related React props
  static DomProps script() => DomProps(react.script);

  /// Returns a new [DomPropsMixin] that renders a `<section>` tag with getters/setters for all DOM-related React props
  static DomProps section() => DomProps(react.section);

  /// Returns a new [DomPropsMixin] that renders a `<select>` tag with getters/setters for all DOM-related React props
  static DomProps select() => DomProps(react.select);

  /// Returns a new [DomPropsMixin] that renders a `<small>` tag with getters/setters for all DOM-related React props
  static DomProps small() => DomProps(react.small);

  /// Returns a new [DomPropsMixin] that renders a `<source>` tag with getters/setters for all DOM-related React props
  static DomProps source() => DomProps(react.source);

  /// Returns a new [DomPropsMixin] that renders a `<span>` tag with getters/setters for all DOM-related React props
  static DomProps span() => DomProps(react.span);

  /// Returns a new [DomPropsMixin] that renders a `<strong>` tag with getters/setters for all DOM-related React props
  static DomProps strong() => DomProps(react.strong);

  /// Returns a new [DomPropsMixin] that renders a `<style>` tag with getters/setters for all DOM-related React props
  static DomProps style() => DomProps(react.style);

  /// Returns a new [DomPropsMixin] that renders a `<sub>` tag with getters/setters for all DOM-related React props
  static DomProps sub() => DomProps(react.sub);

  /// Returns a new [DomPropsMixin] that renders a `<summary>` tag with getters/setters for all DOM-related React props
  static DomProps summary() => DomProps(react.summary);

  /// Returns a new [DomPropsMixin] that renders a `<sup>` tag with getters/setters for all DOM-related React props
  static DomProps sup() => DomProps(react.sup);

  /// Returns a new [DomPropsMixin] that renders a `<table>` tag with getters/setters for all DOM-related React props
  static DomProps table() => DomProps(react.table);

  /// Returns a new [DomPropsMixin] that renders a `<tbody>` tag with getters/setters for all DOM-related React props
  static DomProps tbody() => DomProps(react.tbody);

  /// Returns a new [DomPropsMixin] that renders a `<td>` tag with getters/setters for all DOM-related React props
  static DomProps td() => DomProps(react.td);

  /// Returns a new [DomPropsMixin] that renders a `<textarea>` tag with getters/setters for all DOM-related React props
  static DomProps textarea() => DomProps(react.textarea);

  /// Returns a new [DomPropsMixin] that renders a `<tfoot>` tag with getters/setters for all DOM-related React props
  static DomProps tfoot() => DomProps(react.tfoot);

  /// Returns a new [DomPropsMixin] that renders a `<th>` tag with getters/setters for all DOM-related React props
  static DomProps th() => DomProps(react.th);

  /// Returns a new [DomPropsMixin] that renders a `<thead>` tag with getters/setters for all DOM-related React props
  static DomProps thead() => DomProps(react.thead);

  /// Returns a new [DomPropsMixin] that renders a `<time>` tag with getters/setters for all DOM-related React props
  static DomProps time() => DomProps(react.time);

  /// Returns a new [DomPropsMixin] that renders a `<title>` tag with getters/setters for all DOM-related React props
  static DomProps title() => DomProps(react.title);

  /// Returns a new [DomPropsMixin] that renders a `<tr>` tag with getters/setters for all DOM-related React props
  static DomProps tr() => DomProps(react.tr);

  /// Returns a new [DomPropsMixin] that renders a `<track>` tag with getters/setters for all DOM-related React props
  static DomProps track() => DomProps(react.track);

  /// Returns a new [DomPropsMixin] that renders an `<u>` tag with getters/setters for all DOM-related React props
  static DomProps u() => DomProps(react.u);

  /// Returns a new [DomPropsMixin] that renders an `<ul>` tag with getters/setters for all DOM-related React props
  static DomProps ul() => DomProps(react.ul);

  /// Returns a new [DomPropsMixin] that renders a `<var>` tag with getters/setters for all DOM-related React props
  static DomProps variable() => DomProps(react.variable);

  /// Returns a new [DomPropsMixin] that renders a `<video>` tag with getters/setters for all DOM-related React props
  static DomProps video() => DomProps(react.video);

  /// Returns a new [DomPropsMixin] that renders a `<wbr>` tag with getters/setters for all DOM-related React props
  static DomProps wbr() => DomProps(react.wbr);

  // SVG Elements
  /// Returns a new [SvgPropsMixin] that renders an `<a>` tag with getters/setters for all SVG-related React props
  static SvgProps svgA() => SvgProps(react.a);

  /// Returns a new [SvgPropsMixin] that renders an `<altGlyph>` tag with getters/setters for all SVG-related React props
  static SvgProps altGlyph() => SvgProps(react.altGlyph);

  /// Returns a new [SvgPropsMixin] that renders an `<altGlyphDef>` tag with getters/setters for all SVG-related React props
  static SvgProps altGlyphDef() => SvgProps(react.altGlyphDef);

  /// Returns a new [SvgPropsMixin] that renders an `<altGlyphItem>` tag with getters/setters for all SVG-related React props
  static SvgProps altGlyphItem() => SvgProps(react.altGlyphItem);

  /// Returns a new [SvgPropsMixin] that renders an `<animate>` tag with getters/setters for all SVG-related React props
  static SvgProps animate() => SvgProps(react.animate);

  /// Returns a new [SvgPropsMixin] that renders an `<animateColor>` tag with getters/setters for all SVG-related React props
  static SvgProps animateColor() => SvgProps(react.animateColor);

  /// Returns a new [SvgPropsMixin] that renders an `<animateMotion>` tag with getters/setters for all SVG-related React props
  static SvgProps animateMotion() => SvgProps(react.animateMotion);

  /// Returns a new [SvgPropsMixin] that renders an `<animateTransform>` tag with getters/setters for all SVG-related React props
  static SvgProps animateTransform() => SvgProps(react.animateTransform);

  /// Returns a new [SvgPropsMixin] that renders an `<audio>` tag with getters/setters for all SVG-related React props
  static SvgProps svgAudio() => SvgProps(react.audio);

  /// Returns a new [SvgPropsMixin] that renders a `<canvas>` tag with getters/setters for all SVG-related React props
  static SvgProps svgCanvas() => SvgProps(react.canvas);

  /// Returns a new [SvgPropsMixin] that renders a `<circle>` tag with getters/setters for all SVG-related React props
  static SvgProps circle() => SvgProps(react.circle);

  /// Returns a new [SvgPropsMixin] that renders a `<clipPath>` tag with getters/setters for all SVG-related React props
  static SvgProps clipPath() => SvgProps(react.clipPath);

  /// Returns a new [SvgPropsMixin] that renders a `<color-profile>` tag with getters/setters for all SVG-related React props
  static SvgProps colorProfile() => SvgProps(react.colorProfile);

  /// Returns a new [SvgPropsMixin] that renders a `<cursor>` tag with getters/setters for all SVG-related React props
  static SvgProps cursor() => SvgProps(react.cursor);

  /// Returns a new [SvgPropsMixin] that renders a `<defs>` tag with getters/setters for all SVG-related React props
  static SvgProps defs() => SvgProps(react.defs);

  /// Returns a new [SvgPropsMixin] that renders a `<desc>` tag with getters/setters for all SVG-related React props
  static SvgProps desc() => SvgProps(react.desc);

  /// Returns a new [SvgPropsMixin] that renders a `<discard>` tag with getters/setters for all SVG-related React props
  static SvgProps discard() => SvgProps(react.discard);

  /// Returns a new [SvgPropsMixin] that renders an `<ellipse>` tag with getters/setters for all SVG-related React props
  static SvgProps ellipse() => SvgProps(react.ellipse);

  /// Returns a new [SvgPropsMixin] that renders a `<feBlend>` tag with getters/setters for all SVG-related React props
  static SvgProps feBlend() => SvgProps(react.feBlend);

  /// Returns a new [SvgPropsMixin] that renders a `<feColorMatrix>` tag with getters/setters for all SVG-related React props
  static SvgProps feColorMatrix() => SvgProps(react.feColorMatrix);

  /// Returns a new [SvgPropsMixin] that renders a `<feComponentTransfer>` tag with getters/setters for all SVG-related React props
  static SvgProps feComponentTransfer() => SvgProps(react.feComponentTransfer);

  /// Returns a new [SvgPropsMixin] that renders a `<feComposite>` tag with getters/setters for all SVG-related React props
  static SvgProps feComposite() => SvgProps(react.feComposite);

  /// Returns a new [SvgPropsMixin] that renders a `<feConvolveMatrix>` tag with getters/setters for all SVG-related React props
  static SvgProps feConvolveMatrix() => SvgProps(react.feConvolveMatrix);

  /// Returns a new [SvgPropsMixin] that renders a `<feDiffuseLighting>` tag with getters/setters for all SVG-related React props
  static SvgProps feDiffuseLighting() => SvgProps(react.feDiffuseLighting);

  /// Returns a new [SvgPropsMixin] that renders a `<feDisplacementMap>` tag with getters/setters for all SVG-related React props
  static SvgProps feDisplacementMap() => SvgProps(react.feDisplacementMap);

  /// Returns a new [SvgPropsMixin] that renders a `<feDistantLight>` tag with getters/setters for all SVG-related React props
  static SvgProps feDistantLight() => SvgProps(react.feDistantLight);

  /// Returns a new [SvgPropsMixin] that renders a `<feDropShadow>` tag with getters/setters for all SVG-related React props
  static SvgProps feDropShadow() => SvgProps(react.feDropShadow);

  /// Returns a new [SvgPropsMixin] that renders a `<feFlood>` tag with getters/setters for all SVG-related React props
  static SvgProps feFlood() => SvgProps(react.feFlood);

  /// Returns a new [SvgPropsMixin] that renders a `<feFuncA>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncA() => SvgProps(react.feFuncA);

  /// Returns a new [SvgPropsMixin] that renders a `<feFuncB>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncB() => SvgProps(react.feFuncB);

  /// Returns a new [SvgPropsMixin] that renders a `<feFuncG>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncG() => SvgProps(react.feFuncG);

  /// Returns a new [SvgPropsMixin] that renders a `<feFuncR>` tag with getters/setters for all SVG-related React props
  static SvgProps feFuncR() => SvgProps(react.feFuncR);

  /// Returns a new [SvgPropsMixin] that renders a `<feGaussianBlur>` tag with getters/setters for all SVG-related React props
  static SvgProps feGaussianBlur() => SvgProps(react.feGaussianBlur);

  /// Returns a new [SvgPropsMixin] that renders a `<feImage>` tag with getters/setters for all SVG-related React props
  static SvgProps feImage() => SvgProps(react.feImage);

  /// Returns a new [SvgPropsMixin] that renders a `<feMerge>` tag with getters/setters for all SVG-related React props
  static SvgProps feMerge() => SvgProps(react.feMerge);

  /// Returns a new [SvgPropsMixin] that renders a `<feMergeNode>` tag with getters/setters for all SVG-related React props
  static SvgProps feMergeNode() => SvgProps(react.feMergeNode);

  /// Returns a new [SvgPropsMixin] that renders a `<feMorphology>` tag with getters/setters for all SVG-related React props
  static SvgProps feMorphology() => SvgProps(react.feMorphology);

  /// Returns a new [SvgPropsMixin] that renders a `<feOffset>` tag with getters/setters for all SVG-related React props
  static SvgProps feOffset() => SvgProps(react.feOffset);

  /// Returns a new [SvgPropsMixin] that renders a `<fePointLight>` tag with getters/setters for all SVG-related React props
  static SvgProps fePointLight() => SvgProps(react.fePointLight);

  /// Returns a new [SvgPropsMixin] that renders a `<feSpecularLighting>` tag with getters/setters for all SVG-related React props
  static SvgProps feSpecularLighting() => SvgProps(react.feSpecularLighting);

  /// Returns a new [SvgPropsMixin] that renders a `<feSpotLight>` tag with getters/setters for all SVG-related React props
  static SvgProps feSpotLight() => SvgProps(react.feSpotLight);

  /// Returns a new [SvgPropsMixin] that renders a `<feTile>` tag with getters/setters for all SVG-related React props
  static SvgProps feTile() => SvgProps(react.feTile);

  /// Returns a new [SvgPropsMixin] that renders a `<feTurbulence>` tag with getters/setters for all SVG-related React props
  static SvgProps feTurbulence() => SvgProps(react.feTurbulence);

  /// Returns a new [SvgPropsMixin] that renders a `<filter>` tag with getters/setters for all SVG-related React props
  static SvgProps filter() => SvgProps(react.filter);

  /// Returns a new [SvgPropsMixin] that renders a `<font>` tag with getters/setters for all SVG-related React props
  static SvgProps font() => SvgProps(react.font);

  /// Returns a new [SvgPropsMixin] that renders a `<font-face>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFace() => SvgProps(react.fontFace);

  /// Returns a new [SvgPropsMixin] that renders a `<font-face-format>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceFormat() => SvgProps(react.fontFaceFormat);

  /// Returns a new [SvgPropsMixin] that renders a `<font-face-name>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceName() => SvgProps(react.fontFaceName);

  /// Returns a new [SvgPropsMixin] that renders a `<font-face-src>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceSrc() => SvgProps(react.fontFaceSrc);

  /// Returns a new [SvgPropsMixin] that renders a `<font-face-uri>` tag with getters/setters for all SVG-related React props
  static SvgProps fontFaceUri() => SvgProps(react.fontFaceUri);

  /// Returns a new [SvgPropsMixin] that renders a `<foreignObject>` tag with getters/setters for all SVG-related React props
  static SvgProps foreignObject() => SvgProps(react.foreignObject);

  /// Returns a new [SvgPropsMixin] that renders a `<g>` tag with getters/setters for all SVG-related React props
  static SvgProps g() => SvgProps(react.g);

  /// Returns a new [SvgPropsMixin] that renders a `<glyph>` tag with getters/setters for all SVG-related React props
  static SvgProps glyph() => SvgProps(react.glyph);

  /// Returns a new [SvgPropsMixin] that renders a `<glyphRef>` tag with getters/setters for all SVG-related React props
  static SvgProps glyphRef() => SvgProps(react.glyphRef);

  /// Returns a new [SvgPropsMixin] that renders a `<hatch>` tag with getters/setters for all SVG-related React props
  static SvgProps hatch() => SvgProps(react.hatch);

  /// Returns a new [SvgPropsMixin] that renders a `<hatchpath>` tag with getters/setters for all SVG-related React props
  static SvgProps hatchpath() => SvgProps(react.hatchpath);

  /// Returns a new [SvgPropsMixin] that renders a `<hkern>` tag with getters/setters for all SVG-related React props
  static SvgProps hkern() => SvgProps(react.hkern);

  /// Returns a new [SvgPropsMixin] that renders an `<iframe>` tag with getters/setters for all SVG-related React props
  static SvgProps svgIframe() => SvgProps(react.iframe);

  /// Returns a new [SvgPropsMixin] that renders an `<image>` tag with getters/setters for all SVG-related React props
  static SvgProps image() => SvgProps(react.image);

  /// Returns a new [SvgPropsMixin] that renders a `<line>` tag with getters/setters for all SVG-related React props
  static SvgProps line() => SvgProps(react.line);

  /// Returns a new [SvgPropsMixin] that renders a `<linearGradient>` tag with getters/setters for all SVG-related React props
  static SvgProps linearGradient() => SvgProps(react.linearGradient);

  /// Returns a new [SvgPropsMixin] that renders a `<marker>` tag with getters/setters for all SVG-related React props
  static SvgProps marker() => SvgProps(react.marker);

  /// Returns a new [SvgPropsMixin] that renders a `<mask>` tag with getters/setters for all SVG-related React props
  static SvgProps mask() => SvgProps(react.mask);

  /// Returns a new [SvgPropsMixin] that renders a `<mesh>` tag with getters/setters for all SVG-related React props
  static SvgProps mesh() => SvgProps(react.mesh);

  /// Returns a new [SvgPropsMixin] that renders a `<meshgradient>` tag with getters/setters for all SVG-related React props
  static SvgProps meshgradient() => SvgProps(react.meshgradient);

  /// Returns a new [SvgPropsMixin] that renders a `<meshpatch>` tag with getters/setters for all SVG-related React props
  static SvgProps meshpatch() => SvgProps(react.meshpatch);

  /// Returns a new [SvgPropsMixin] that renders a `<meshrow>` tag with getters/setters for all SVG-related React props
  static SvgProps meshrow() => SvgProps(react.meshrow);

  /// Returns a new [SvgPropsMixin] that renders a `<metadata>` tag with getters/setters for all SVG-related React props
  static SvgProps metadata() => SvgProps(react.metadata);

  /// Returns a new [SvgPropsMixin] that renders a `<missing-glyph>` tag with getters/setters for all SVG-related React props
  static SvgProps missingGlyph() => SvgProps(react.missingGlyph);

  /// Returns a new [SvgPropsMixin] that renders a `<mpath>` tag with getters/setters for all SVG-related React props
  static SvgProps mpath() => SvgProps(react.mpath);

  /// Returns a new [SvgPropsMixin] that renders a `<path>` tag with getters/setters for all SVG-related React props
  static SvgProps path() => SvgProps(react.path);

  /// Returns a new [SvgPropsMixin] that renders a `<pattern>` tag with getters/setters for all SVG-related React props
  static SvgProps pattern() => SvgProps(react.pattern);

  /// Returns a new [SvgPropsMixin] that renders a `<polygon>` tag with getters/setters for all SVG-related React props
  static SvgProps polygon() => SvgProps(react.polygon);

  /// Returns a new [SvgPropsMixin] that renders a `<polyline>` tag with getters/setters for all SVG-related React props
  static SvgProps polyline() => SvgProps(react.polyline);

  /// Returns a new [SvgPropsMixin] that renders a `<radialGradient>` tag with getters/setters for all SVG-related React props
  static SvgProps radialGradient() => SvgProps(react.radialGradient);

  /// Returns a new [SvgPropsMixin] that renders a `<rect>` tag with getters/setters for all SVG-related React props
  static SvgProps rect() => SvgProps(react.rect);

  /// Returns a new [SvgPropsMixin] that renders a `<script>` tag with getters/setters for all SVG-related React props
  static SvgProps svgScript() => SvgProps(react.script);

  /// Returns a new [SvgPropsMixin] that renders a `<set>` tag with getters/setters for all SVG-related React props
  static SvgProps svgSet() => SvgProps(react.svgSet);

  /// Returns a new [SvgPropsMixin] that renders a `<solidcolor>` tag with getters/setters for all SVG-related React props
  static SvgProps solidcolor() => SvgProps(react.solidcolor);

  /// Returns a new [SvgPropsMixin] that renders a `<stop>` tag with getters/setters for all SVG-related React props
  static SvgProps stop() => SvgProps(react.stop);

  /// Returns a new [SvgPropsMixin] that renders a `<style>` tag with getters/setters for all SVG-related React props
  static SvgProps svgStyle() => SvgProps(react.style);

  /// Returns a new [SvgPropsMixin] that renders a `<svg>` tag with getters/setters for all SVG-related React props
  static SvgProps svg() => SvgProps(react.svg);

  /// Returns a new [SvgPropsMixin] that renders a `<switch>` tag with getters/setters for all SVG-related React props
  static SvgProps svgSwitch() => SvgProps(react.svgSwitch);

  /// Returns a new [SvgPropsMixin] that renders a `<symbol>` tag with getters/setters for all SVG-related React props
  static SvgProps symbol() => SvgProps(react.symbol);

  /// Returns a new [SvgPropsMixin] that renders a `<text>` tag with getters/setters for all SVG-related React props
  static SvgProps text() => SvgProps(react.text);

  /// Returns a new [SvgPropsMixin] that renders a `<textPath>` tag with getters/setters for all SVG-related React props
  static SvgProps textPath() => SvgProps(react.textPath);

  /// Returns a new [SvgPropsMixin] that renders a `<title>` tag with getters/setters for all SVG-related React props
  static SvgProps svgTitle() => SvgProps(react.title);

  /// Returns a new [SvgPropsMixin] that renders a `<tref>` tag with getters/setters for all SVG-related React props
  static SvgProps tref() => SvgProps(react.tref);

  /// Returns a new [SvgPropsMixin] that renders a `<tspan>` tag with getters/setters for all SVG-related React props
  static SvgProps tspan() => SvgProps(react.tspan);

  /// Returns a new [SvgPropsMixin] that renders an `<unknown>` tag with getters/setters for all SVG-related React props
  static SvgProps unknown() => SvgProps(react.unknown);

  /// Returns a new [SvgPropsMixin] that renders an `<use>` tag with getters/setters for all SVG-related React props
  static SvgProps use() => SvgProps(react.use);

  /// Returns a new [SvgPropsMixin] that renders a `<video>` tag with getters/setters for all SVG-related React props
  static SvgProps svgVideo() => SvgProps(react.video);

  /// Returns a new [SvgPropsMixin] that renders a `<view>` tag with getters/setters for all SVG-related React props
  static SvgProps view() => SvgProps(react.view);

  /// Returns a new [SvgPropsMixin] that renders a `<vkern>` tag with getters/setters for all SVG-related React props
  static SvgProps vkern() => SvgProps(react.vkern);
}
