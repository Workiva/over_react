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
DomProps domProps([Map backingMap]) => new DomProps(null, backingMap);

typedef DomProps DomPropsFactory();

class DomProps extends component_base.UiProps with DomPropsMixin, ReactPropsMixin {
  // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
  DomProps(this.componentFactory, [Map props]) : this.props = props ?? ({});

  @override
  final ReactDomComponentFactoryProxy componentFactory;
  @override
  final Map props;
}

class SvgProps extends component_base.UiProps with DomPropsMixin, ReactPropsMixin, SvgPropsMixin implements DomProps {
  // Wrap Map literal in parens to work around https://github.com/dart-lang/sdk/issues/24410
  SvgProps(this.componentFactory, [Map props]) : this.props = props ?? ({});

  @override
  final ReactDomComponentFactoryProxy componentFactory;
  @override
  final Map props;
}

/// A class that provides namespacing for static DOM component factory methods, much like `React.DOM` in React JS.
abstract class Dom {
  /// Returns a new [DomPropsMixin] that renders an `<a>` tag with getters/setters for all DOM-related React props
  static DomProps a() => new DomProps(react.a);
  /// Returns a new [DomPropsMixin] that renders an `<abbr>` tag with getters/setters for all DOM-related React props
  static DomProps abbr() => new DomProps(react.abbr);
  /// Returns a new [DomPropsMixin] that renders an `<address>` tag with getters/setters for all DOM-related React props
  static DomProps address() => new DomProps(react.address);
  /// Returns a new [DomPropsMixin] that renders an `<area>` tag with getters/setters for all DOM-related React props
  static DomProps area() => new DomProps(react.area);
  /// Returns a new [DomPropsMixin] that renders an `<article>` tag with getters/setters for all DOM-related React props
  static DomProps article() => new DomProps(react.article);
  /// Returns a new [DomPropsMixin] that renders an `<aside>` tag with getters/setters for all DOM-related React props
  static DomProps aside() => new DomProps(react.aside);
  /// Returns a new [DomPropsMixin] that renders an `<audio>` tag with getters/setters for all DOM-related React props
  static DomProps audio() => new DomProps(react.audio);
  /// Returns a new [DomPropsMixin] that renders a `<b>` tag with getters/setters for all DOM-related React props
  static DomProps b() => new DomProps(react.b);
  /// Returns a new [DomPropsMixin] that renders a `<base>` tag with getters/setters for all DOM-related React props
  static DomProps base() => new DomProps(react.base);
  /// Returns a new [DomPropsMixin] that renders a `<bdi>` tag with getters/setters for all DOM-related React props
  static DomProps bdi() => new DomProps(react.bdi);
  /// Returns a new [DomPropsMixin] that renders a `<bdo>` tag with getters/setters for all DOM-related React props
  static DomProps bdo() => new DomProps(react.bdo);
  /// Returns a new [DomPropsMixin] that renders a `<big>` tag with getters/setters for all DOM-related React props
  static DomProps big() => new DomProps(react.big);
  /// Returns a new [DomPropsMixin] that renders a `<blockquote>` tag with getters/setters for all DOM-related React props
  static DomProps blockquote() => new DomProps(react.blockquote);
  /// Returns a new [DomPropsMixin] that renders a `<body>` tag with getters/setters for all DOM-related React props
  static DomProps body() => new DomProps(react.body);
  /// Returns a new [DomPropsMixin] that renders a `<br>` tag with getters/setters for all DOM-related React props
  static DomProps br() => new DomProps(react.br);
  /// Returns a new [DomPropsMixin] that renders a `<button>` tag with getters/setters for all DOM-related React props
  static DomProps button() => new DomProps(react.button);
  /// Returns a new [DomPropsMixin] that renders a `<canvas>` tag with getters/setters for all DOM-related React props
  static DomProps canvas() => new DomProps(react.canvas);
  /// Returns a new [DomPropsMixin] that renders a `<caption>` tag with getters/setters for all DOM-related React props
  static DomProps caption() => new DomProps(react.caption);
  /// Returns a new [DomPropsMixin] that renders a `<cite>` tag with getters/setters for all DOM-related React props
  static DomProps cite() => new DomProps(react.cite);
  /// Returns a new [DomPropsMixin] that renders a `<code>` tag with getters/setters for all DOM-related React props
  static DomProps code() => new DomProps(react.code);
  /// Returns a new [DomPropsMixin] that renders a `<col>` tag with getters/setters for all DOM-related React props
  static DomProps col() => new DomProps(react.col);
  /// Returns a new [DomPropsMixin] that renders a `<colgroup>` tag with getters/setters for all DOM-related React props
  static DomProps colgroup() => new DomProps(react.colgroup);
  /// Returns a new [DomPropsMixin] that renders a `<data>` tag with getters/setters for all DOM-related React props
  static DomProps data() => new DomProps(react.data);
  /// Returns a new [DomPropsMixin] that renders a `<datalist>` tag with getters/setters for all DOM-related React props
  static DomProps datalist() => new DomProps(react.datalist);
  /// Returns a new [DomPropsMixin] that renders a `<dd>` tag with getters/setters for all DOM-related React props
  static DomProps dd() => new DomProps(react.dd);
  /// Returns a new [DomPropsMixin] that renders a `<del>` tag with getters/setters for all DOM-related React props
  static DomProps del() => new DomProps(react.del);
  /// Returns a new [DomPropsMixin] that renders a `<details>` tag with getters/setters for all DOM-related React props
  static DomProps details() => new DomProps(react.details);
  /// Returns a new [DomPropsMixin] that renders a `<dfn>` tag with getters/setters for all DOM-related React props
  static DomProps dfn() => new DomProps(react.dfn);
  /// Returns a new [DomPropsMixin] that renders a `<dialog>` tag with getters/setters for all DOM-related React props
  static DomProps dialog() => new DomProps(react.dialog);
  /// Returns a new [DomPropsMixin] that renders a `<div>` tag with getters/setters for all DOM-related React props
  static DomProps div() => new DomProps(react.div);
  /// Returns a new [DomPropsMixin] that renders a `<dl>` tag with getters/setters for all DOM-related React props
  static DomProps dl() => new DomProps(react.dl);
  /// Returns a new [DomPropsMixin] that renders a `<dt>` tag with getters/setters for all DOM-related React props
  static DomProps dt() => new DomProps(react.dt);
  /// Returns a new [DomPropsMixin] that renders an `<em>` tag with getters/setters for all DOM-related React props
  static DomProps em() => new DomProps(react.em);
  /// Returns a new [DomPropsMixin] that renders an `<embed>` tag with getters/setters for all DOM-related React props
  static DomProps embed() => new DomProps(react.embed);
  /// Returns a new [DomPropsMixin] that renders a `<fieldset>` tag with getters/setters for all DOM-related React props
  static DomProps fieldset() => new DomProps(react.fieldset);
  /// Returns a new [DomPropsMixin] that renders a `<figcaption>` tag with getters/setters for all DOM-related React props
  static DomProps figcaption() => new DomProps(react.figcaption);
  /// Returns a new [DomPropsMixin] that renders a `<figure>` tag with getters/setters for all DOM-related React props
  static DomProps figure() => new DomProps(react.figure);
  /// Returns a new [DomPropsMixin] that renders a `<footer>` tag with getters/setters for all DOM-related React props
  static DomProps footer() => new DomProps(react.footer);
  /// Returns a new [DomPropsMixin] that renders a `<form>` tag with getters/setters for all DOM-related React props
  static DomProps form() => new DomProps(react.form);
  /// Returns a new [DomPropsMixin] that renders a `<h1>` tag with getters/setters for all DOM-related React props
  static DomProps h1() => new DomProps(react.h1);
  /// Returns a new [DomPropsMixin] that renders a `<h2>` tag with getters/setters for all DOM-related React props
  static DomProps h2() => new DomProps(react.h2);
  /// Returns a new [DomPropsMixin] that renders a `<h3>` tag with getters/setters for all DOM-related React props
  static DomProps h3() => new DomProps(react.h3);
  /// Returns a new [DomPropsMixin] that renders a `<h4>` tag with getters/setters for all DOM-related React props
  static DomProps h4() => new DomProps(react.h4);
  /// Returns a new [DomPropsMixin] that renders a `<h5>` tag with getters/setters for all DOM-related React props
  static DomProps h5() => new DomProps(react.h5);
  /// Returns a new [DomPropsMixin] that renders a `<h6>` tag with getters/setters for all DOM-related React props
  static DomProps h6() => new DomProps(react.h6);
  /// Returns a new [DomPropsMixin] that renders a `<head>` tag with getters/setters for all DOM-related React props
  static DomProps head() => new DomProps(react.head);
  /// Returns a new [DomPropsMixin] that renders a `<header>` tag with getters/setters for all DOM-related React props
  static DomProps header() => new DomProps(react.header);
  /// Returns a new [DomPropsMixin] that renders a `<hr>` tag with getters/setters for all DOM-related React props
  static DomProps hr() => new DomProps(react.hr);
  /// Returns a new [DomPropsMixin] that renders a `<html>` tag with getters/setters for all DOM-related React props
  static DomProps html() => new DomProps(react.html);
  /// Returns a new [DomPropsMixin] that renders an `<i>` tag with getters/setters for all DOM-related React props
  static DomProps i() => new DomProps(react.i);
  /// Returns a new [DomPropsMixin] that renders an `<iframe>` tag with getters/setters for all DOM-related React props
  static DomProps iframe() => new DomProps(react.iframe);
  /// Returns a new [DomPropsMixin] that renders an `<img>` tag with getters/setters for all DOM-related React props
  static DomProps img() => new DomProps(react.img);
  /// Returns a new [DomPropsMixin] that renders an `<input>` tag with getters/setters for all DOM-related React props
  static DomProps input() => new DomProps(react.input);
  /// Returns a new [DomPropsMixin] that renders an `<ins>` tag with getters/setters for all DOM-related React props
  static DomProps ins() => new DomProps(react.ins);
  /// Returns a new [DomPropsMixin] that renders a `<kbd>` tag with getters/setters for all DOM-related React props
  static DomProps kbd() => new DomProps(react.kbd);
  /// Returns a new [DomPropsMixin] that renders a `<keygen>` tag with getters/setters for all DOM-related React props
  static DomProps keygen() => new DomProps(react.keygen);
  /// Returns a new [DomPropsMixin] that renders a `<label>` tag with getters/setters for all DOM-related React props
  static DomProps label() => new DomProps(react.label);
  /// Returns a new [DomPropsMixin] that renders a `<legend>` tag with getters/setters for all DOM-related React props
  static DomProps legend() => new DomProps(react.legend);
  /// Returns a new [DomPropsMixin] that renders a `<li>` tag with getters/setters for all DOM-related React props
  static DomProps li() => new DomProps(react.li);
  /// Returns a new [DomPropsMixin] that renders a `<link>` tag with getters/setters for all DOM-related React props
  static DomProps link() => new DomProps(react.link);
  /// Returns a new [DomPropsMixin] that renders a `<main>` tag with getters/setters for all DOM-related React props
  static DomProps main() => new DomProps(react.main);
  /// Returns a new [DomPropsMixin] that renders a `<map>` tag with getters/setters for all DOM-related React props
  static DomProps map() => new DomProps(react.map);
  /// Returns a new [DomPropsMixin] that renders a `<mark>` tag with getters/setters for all DOM-related React props
  static DomProps mark() => new DomProps(react.mark);
  /// Returns a new [DomPropsMixin] that renders a `<menu>` tag with getters/setters for all DOM-related React props
  static DomProps menu() => new DomProps(react.menu);
  /// Returns a new [DomPropsMixin] that renders a `<menuitem>` tag with getters/setters for all DOM-related React props
  static DomProps menuitem() => new DomProps(react.menuitem);
  /// Returns a new [DomPropsMixin] that renders a `<meta>` tag with getters/setters for all DOM-related React props
  static DomProps meta() => new DomProps(react.meta);
  /// Returns a new [DomPropsMixin] that renders a `<meter>` tag with getters/setters for all DOM-related React props
  static DomProps meter() => new DomProps(react.meter);
  /// Returns a new [DomPropsMixin] that renders a `<nav>` tag with getters/setters for all DOM-related React props
  static DomProps nav() => new DomProps(react.nav);
  /// Returns a new [DomPropsMixin] that renders a `<noscript>` tag with getters/setters for all DOM-related React props
  static DomProps noscript() => new DomProps(react.noscript);
  /// Returns a new [DomPropsMixin] that renders an `<object>` tag with getters/setters for all DOM-related React props
  static DomProps object() => new DomProps(react.object);
  /// Returns a new [DomPropsMixin] that renders an `<ol>` tag with getters/setters for all DOM-related React props
  static DomProps ol() => new DomProps(react.ol);
  /// Returns a new [DomPropsMixin] that renders an `<optgroup>` tag with getters/setters for all DOM-related React props
  static DomProps optgroup() => new DomProps(react.optgroup);
  /// Returns a new [DomPropsMixin] that renders an `<option>` tag with getters/setters for all DOM-related React props
  static DomProps option() => new DomProps(react.option);
  /// Returns a new [DomPropsMixin] that renders an `<output>` tag with getters/setters for all DOM-related React props
  static DomProps output() => new DomProps(react.output);
  /// Returns a new [DomPropsMixin] that renders a `<p>` tag with getters/setters for all DOM-related React props
  static DomProps p() => new DomProps(react.p);
  /// Returns a new [DomPropsMixin] that renders a `<param>` tag with getters/setters for all DOM-related React props
  static DomProps param() => new DomProps(react.param);
  /// Returns a new [DomPropsMixin] that renders a `<picture>` tag with getters/setters for all DOM-related React props
  static DomProps picture() => new DomProps(react.picture);
  /// Returns a new [DomPropsMixin] that renders a `<pre>` tag with getters/setters for all DOM-related React props
  static DomProps pre() => new DomProps(react.pre);
  /// Returns a new [DomPropsMixin] that renders a `<progress>` tag with getters/setters for all DOM-related React props
  static DomProps progress() => new DomProps(react.progress);
  /// Returns a new [DomPropsMixin] that renders a `<q>` tag with getters/setters for all DOM-related React props
  static DomProps q() => new DomProps(react.q);
  /// Returns a new [DomPropsMixin] that renders a `<rp>` tag with getters/setters for all DOM-related React props
  static DomProps rp() => new DomProps(react.rp);
  /// Returns a new [DomPropsMixin] that renders a `<rt>` tag with getters/setters for all DOM-related React props
  static DomProps rt() => new DomProps(react.rt);
  /// Returns a new [DomPropsMixin] that renders a `<ruby>` tag with getters/setters for all DOM-related React props
  static DomProps ruby() => new DomProps(react.ruby);
  /// Returns a new [DomPropsMixin] that renders a `<s>` tag with getters/setters for all DOM-related React props
  static DomProps s() => new DomProps(react.s);
  /// Returns a new [DomPropsMixin] that renders a `<samp>` tag with getters/setters for all DOM-related React props
  static DomProps samp() => new DomProps(react.samp);
  /// Returns a new [DomPropsMixin] that renders a `<script>` tag with getters/setters for all DOM-related React props
  static DomProps script() => new DomProps(react.script);
  /// Returns a new [DomPropsMixin] that renders a `<section>` tag with getters/setters for all DOM-related React props
  static DomProps section() => new DomProps(react.section);
  /// Returns a new [DomPropsMixin] that renders a `<select>` tag with getters/setters for all DOM-related React props
  static DomProps select() => new DomProps(react.select);
  /// Returns a new [DomPropsMixin] that renders a `<small>` tag with getters/setters for all DOM-related React props
  static DomProps small() => new DomProps(react.small);
  /// Returns a new [DomPropsMixin] that renders a `<source>` tag with getters/setters for all DOM-related React props
  static DomProps source() => new DomProps(react.source);
  /// Returns a new [DomPropsMixin] that renders a `<span>` tag with getters/setters for all DOM-related React props
  static DomProps span() => new DomProps(react.span);
  /// Returns a new [DomPropsMixin] that renders a `<strong>` tag with getters/setters for all DOM-related React props
  static DomProps strong() => new DomProps(react.strong);
  /// Returns a new [DomPropsMixin] that renders a `<style>` tag with getters/setters for all DOM-related React props
  static DomProps style() => new DomProps(react.style);
  /// Returns a new [DomPropsMixin] that renders a `<sub>` tag with getters/setters for all DOM-related React props
  static DomProps sub() => new DomProps(react.sub);
  /// Returns a new [DomPropsMixin] that renders a `<summary>` tag with getters/setters for all DOM-related React props
  static DomProps summary() => new DomProps(react.summary);
  /// Returns a new [DomPropsMixin] that renders a `<sup>` tag with getters/setters for all DOM-related React props
  static DomProps sup() => new DomProps(react.sup);
  /// Returns a new [DomPropsMixin] that renders a `<table>` tag with getters/setters for all DOM-related React props
  static DomProps table() => new DomProps(react.table);
  /// Returns a new [DomPropsMixin] that renders a `<tbody>` tag with getters/setters for all DOM-related React props
  static DomProps tbody() => new DomProps(react.tbody);
  /// Returns a new [DomPropsMixin] that renders a `<td>` tag with getters/setters for all DOM-related React props
  static DomProps td() => new DomProps(react.td);
  /// Returns a new [DomPropsMixin] that renders a `<textarea>` tag with getters/setters for all DOM-related React props
  static DomProps textarea() => new DomProps(react.textarea);
  /// Returns a new [DomPropsMixin] that renders a `<tfoot>` tag with getters/setters for all DOM-related React props
  static DomProps tfoot() => new DomProps(react.tfoot);
  /// Returns a new [DomPropsMixin] that renders a `<th>` tag with getters/setters for all DOM-related React props
  static DomProps th() => new DomProps(react.th);
  /// Returns a new [DomPropsMixin] that renders a `<thead>` tag with getters/setters for all DOM-related React props
  static DomProps thead() => new DomProps(react.thead);
  /// Returns a new [DomPropsMixin] that renders a `<time>` tag with getters/setters for all DOM-related React props
  static DomProps time() => new DomProps(react.time);
  /// Returns a new [DomPropsMixin] that renders a `<title>` tag with getters/setters for all DOM-related React props
  static DomProps title() => new DomProps(react.title);
  /// Returns a new [DomPropsMixin] that renders a `<tr>` tag with getters/setters for all DOM-related React props
  static DomProps tr() => new DomProps(react.tr);
  /// Returns a new [DomPropsMixin] that renders a `<track>` tag with getters/setters for all DOM-related React props
  static DomProps track() => new DomProps(react.track);
  /// Returns a new [DomPropsMixin] that renders an `<u>` tag with getters/setters for all DOM-related React props
  static DomProps u() => new DomProps(react.u);
  /// Returns a new [DomPropsMixin] that renders an `<ul>` tag with getters/setters for all DOM-related React props
  static DomProps ul() => new DomProps(react.ul);
  /// Returns a new [DomPropsMixin] that renders a `<var>` tag with getters/setters for all DOM-related React props
  static DomProps variable() => new DomProps(react.variable);
  /// Returns a new [DomPropsMixin] that renders a `<video>` tag with getters/setters for all DOM-related React props
  static DomProps video() => new DomProps(react.video);
  /// Returns a new [DomPropsMixin] that renders a `<wbr>` tag with getters/setters for all DOM-related React props
  static DomProps wbr() => new DomProps(react.wbr);

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
