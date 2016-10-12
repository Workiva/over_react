/// [UiComponent]-based api with typed props for react-dart DOM components.
part of over_react;

/// A MapView with the typed getters/setters for all CSS-class-related props.
class CssClassPropsMapView extends MapView with CssClassPropsMixin {
  /// Create a new instance backed by the specified map.
  CssClassPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}

/// A MapView with the typed getters/setters for all aria props.
class AriaPropsMapView extends MapView with AriaPropsMixin {
  /// Create a new instance backed by the specified map.
  AriaPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
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
DomProps domProps([Map backingMap]) => new DomProps(null, backingMap);

/// Returns a new [AriaPropsMapView], optionally backed by a specified Map.
///
/// Convenient for adding aria props inline to DOM and non-DOM components:
/// <pre>
/// <!>  ..addProps(ariaProps()..disabled = true)
/// <!>  ..addProps(ariaProps()
/// <!>    ..expanded = false
/// <!>    ..labelledby = 'label-btn'
/// <!>  )
/// </pre>
/// <!-- use pre tags and HTML markup until WebStorm fully supports Dart doc comment markdown -->
AriaPropsMapView ariaProps([Map backingMap]) => new AriaPropsMapView(backingMap == null ? {} : backingMap);

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
  /// Returns a new [SvgPropsMixin] that renders a `<circle>` tag with getters/setters for all SVG-related React props
  static SvgProps circle() => new SvgProps(react.circle);
  /// Returns a new [SvgPropsMixin] that renders a `<g>` tag with getters/setters for all SVG-related React props
  static SvgProps g() => new SvgProps(react.g);
  /// Returns a new [SvgPropsMixin] that renders a `<defs>` tag with getters/setters for all SVG-related React props
  static SvgProps defs() => new SvgProps(react.defs);
  /// Returns a new [SvgPropsMixin] that renders an `<ellipse>` tag with getters/setters for all SVG-related React props
  static SvgProps ellipse() => new SvgProps(react.ellipse);
  /// Returns a new [SvgPropsMixin] that renders a `<line>` tag with getters/setters for all SVG-related React props
  static SvgProps line() => new SvgProps(react.line);
  /// Returns a new [SvgPropsMixin] that renders a `<linearGradient>` tag with getters/setters for all SVG-related React props
  static SvgProps linearGradient() => new SvgProps(react.linearGradient);
  /// Returns a new [SvgPropsMixin] that renders a `<mask>` tag with getters/setters for all SVG-related React props
  static SvgProps mask() => new SvgProps(react.mask);
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
  /// Returns a new [SvgPropsMixin] that renders a `<svg>` tag with getters/setters for all SVG-related React props
  static SvgProps svg() => new SvgProps(react.svg);
  /// Returns a new [SvgPropsMixin] that renders a `<stop>` tag with getters/setters for all SVG-related React props
  static SvgProps stop() => new SvgProps(react.stop);
  /// Returns a new [SvgPropsMixin] that renders a `<text>` tag with getters/setters for all SVG-related React props
  static SvgProps text() => new SvgProps(react.text);
  /// Returns a new [SvgPropsMixin] that renders a `<tspan>` tag with getters/setters for all SVG-related React props
  static SvgProps tspan() => new SvgProps(react.tspan);
}
