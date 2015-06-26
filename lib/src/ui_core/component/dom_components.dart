/// [ComponentDefinition]-based api with typed props for react-dart DOM components.
part of w_ui_platform.ui_core;

/// A MapView with the typed getters/setters for all DOM-related React props.
class DomPropsMapView extends MapView with DomProps {
  /// Create a new instance backed by the specified map.
  DomPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}

/// Returns a new [DomPropsMapView], optionally backed by a specified Map.
///
/// Convenient for adding DOM props inline to non-DOM components:
/// <pre>
/// <!>  ..addProps(domProps()..style = {'display': 'none'})
/// <!>  ..addProps(domProps()
/// <!>    ..id = 'myComponent'
/// <!>    ..title = 'tooltip for my component'
/// <!>  )
/// </pre>
/// <!-- use pre tags and HTML markup until WebStorm fully supports Dart doc comment markdown -->
DomPropsMapView domProps([Map backingMap]) => new DomPropsMapView(backingMap == null ? {} : backingMap);

/// A component builder with typed props for built-in DOM components.
class DomComponentDefinition extends ComponentDefinition with DomProps, ReactProps {
  DomComponentDefinition(ReactComponentFactory componentFactory, [Map props]) : super(componentFactory, props);
}

typedef DomComponentDefinition DomComponentDefinitionFactory();

class Dom {
  /// Returns a new [DomComponentDefinition] that renders an `<a>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition a() => new DomComponentDefinition(react.a);
  /// Returns a new [DomComponentDefinition] that renders an `<abbr>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition abbr() => new DomComponentDefinition(react.abbr);
  /// Returns a new [DomComponentDefinition] that renders an `<address>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition address() => new DomComponentDefinition(react.address);
  /// Returns a new [DomComponentDefinition] that renders an `<area>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition area() => new DomComponentDefinition(react.area);
  /// Returns a new [DomComponentDefinition] that renders an `<article>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition article() => new DomComponentDefinition(react.article);
  /// Returns a new [DomComponentDefinition] that renders an `<aside>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition aside() => new DomComponentDefinition(react.aside);
  /// Returns a new [DomComponentDefinition] that renders an `<audio>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition audio() => new DomComponentDefinition(react.audio);
  /// Returns a new [DomComponentDefinition] that renders a `<b>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition b() => new DomComponentDefinition(react.b);
  /// Returns a new [DomComponentDefinition] that renders a `<base>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition base() => new DomComponentDefinition(react.base);
  /// Returns a new [DomComponentDefinition] that renders a `<bdi>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition bdi() => new DomComponentDefinition(react.bdi);
  /// Returns a new [DomComponentDefinition] that renders a `<bdo>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition bdo() => new DomComponentDefinition(react.bdo);
  /// Returns a new [DomComponentDefinition] that renders a `<big>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition big() => new DomComponentDefinition(react.big);
  /// Returns a new [DomComponentDefinition] that renders a `<blockquote>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition blockquote() => new DomComponentDefinition(react.blockquote);
  /// Returns a new [DomComponentDefinition] that renders a `<body>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition body() => new DomComponentDefinition(react.body);
  /// Returns a new [DomComponentDefinition] that renders a `<br>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition br() => new DomComponentDefinition(react.br);
  /// Returns a new [DomComponentDefinition] that renders a `<button>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition button() => new DomComponentDefinition(react.button);
  /// Returns a new [DomComponentDefinition] that renders a `<canvas>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition canvas() => new DomComponentDefinition(react.canvas);
  /// Returns a new [DomComponentDefinition] that renders a `<caption>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition caption() => new DomComponentDefinition(react.caption);
  /// Returns a new [DomComponentDefinition] that renders a `<cite>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition cite() => new DomComponentDefinition(react.cite);
  /// Returns a new [DomComponentDefinition] that renders a `<code>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition code() => new DomComponentDefinition(react.code);
  /// Returns a new [DomComponentDefinition] that renders a `<col>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition col() => new DomComponentDefinition(react.col);
  /// Returns a new [DomComponentDefinition] that renders a `<colgroup>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition colgroup() => new DomComponentDefinition(react.colgroup);
  /// Returns a new [DomComponentDefinition] that renders a `<data>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition data() => new DomComponentDefinition(react.data);
  /// Returns a new [DomComponentDefinition] that renders a `<datalist>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition datalist() => new DomComponentDefinition(react.datalist);
  /// Returns a new [DomComponentDefinition] that renders a `<dd>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition dd() => new DomComponentDefinition(react.dd);
  /// Returns a new [DomComponentDefinition] that renders a `<del>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition del() => new DomComponentDefinition(react.del);
  /// Returns a new [DomComponentDefinition] that renders a `<details>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition details() => new DomComponentDefinition(react.details);
  /// Returns a new [DomComponentDefinition] that renders a `<dfn>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition dfn() => new DomComponentDefinition(react.dfn);
  /// Returns a new [DomComponentDefinition] that renders a `<dialog>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition dialog() => new DomComponentDefinition(react.dialog);
  /// Returns a new [DomComponentDefinition] that renders a `<div>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition div() => new DomComponentDefinition(react.div);
  /// Returns a new [DomComponentDefinition] that renders a `<dl>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition dl() => new DomComponentDefinition(react.dl);
  /// Returns a new [DomComponentDefinition] that renders a `<dt>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition dt() => new DomComponentDefinition(react.dt);
  /// Returns a new [DomComponentDefinition] that renders an `<em>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition em() => new DomComponentDefinition(react.em);
  /// Returns a new [DomComponentDefinition] that renders an `<embed>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition embed() => new DomComponentDefinition(react.embed);
  /// Returns a new [DomComponentDefinition] that renders a `<fieldset>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition fieldset() => new DomComponentDefinition(react.fieldset);
  /// Returns a new [DomComponentDefinition] that renders a `<figcaption>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition figcaption() => new DomComponentDefinition(react.figcaption);
  /// Returns a new [DomComponentDefinition] that renders a `<figure>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition figure() => new DomComponentDefinition(react.figure);
  /// Returns a new [DomComponentDefinition] that renders a `<footer>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition footer() => new DomComponentDefinition(react.footer);
  /// Returns a new [DomComponentDefinition] that renders a `<form>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition form() => new DomComponentDefinition(react.form);
  /// Returns a new [DomComponentDefinition] that renders a `<h1>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition h1() => new DomComponentDefinition(react.h1);
  /// Returns a new [DomComponentDefinition] that renders a `<h2>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition h2() => new DomComponentDefinition(react.h2);
  /// Returns a new [DomComponentDefinition] that renders a `<h3>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition h3() => new DomComponentDefinition(react.h3);
  /// Returns a new [DomComponentDefinition] that renders a `<h4>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition h4() => new DomComponentDefinition(react.h4);
  /// Returns a new [DomComponentDefinition] that renders a `<h5>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition h5() => new DomComponentDefinition(react.h5);
  /// Returns a new [DomComponentDefinition] that renders a `<h6>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition h6() => new DomComponentDefinition(react.h6);
  /// Returns a new [DomComponentDefinition] that renders a `<head>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition head() => new DomComponentDefinition(react.head);
  /// Returns a new [DomComponentDefinition] that renders a `<header>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition header() => new DomComponentDefinition(react.header);
  /// Returns a new [DomComponentDefinition] that renders a `<hr>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition hr() => new DomComponentDefinition(react.hr);
  /// Returns a new [DomComponentDefinition] that renders a `<html>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition html() => new DomComponentDefinition(react.html);
  /// Returns a new [DomComponentDefinition] that renders an `<i>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition i() => new DomComponentDefinition(react.i);
  /// Returns a new [DomComponentDefinition] that renders an `<iframe>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition iframe() => new DomComponentDefinition(react.iframe);
  /// Returns a new [DomComponentDefinition] that renders an `<img>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition img() => new DomComponentDefinition(react.img);
  /// Returns a new [DomComponentDefinition] that renders an `<input>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition input() => new DomComponentDefinition(react.input);
  /// Returns a new [DomComponentDefinition] that renders an `<ins>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition ins() => new DomComponentDefinition(react.ins);
  /// Returns a new [DomComponentDefinition] that renders a `<kbd>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition kbd() => new DomComponentDefinition(react.kbd);
  /// Returns a new [DomComponentDefinition] that renders a `<keygen>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition keygen() => new DomComponentDefinition(react.keygen);
  /// Returns a new [DomComponentDefinition] that renders a `<label>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition label() => new DomComponentDefinition(react.label);
  /// Returns a new [DomComponentDefinition] that renders a `<legend>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition legend() => new DomComponentDefinition(react.legend);
  /// Returns a new [DomComponentDefinition] that renders a `<li>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition li() => new DomComponentDefinition(react.li);
  /// Returns a new [DomComponentDefinition] that renders a `<link>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition link() => new DomComponentDefinition(react.link);
  /// Returns a new [DomComponentDefinition] that renders a `<main>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition main() => new DomComponentDefinition(react.main);
  /// Returns a new [DomComponentDefinition] that renders a `<map>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition map() => new DomComponentDefinition(react.map);
  /// Returns a new [DomComponentDefinition] that renders a `<mark>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition mark() => new DomComponentDefinition(react.mark);
  /// Returns a new [DomComponentDefinition] that renders a `<menu>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition menu() => new DomComponentDefinition(react.menu);
  /// Returns a new [DomComponentDefinition] that renders a `<menuitem>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition menuitem() => new DomComponentDefinition(react.menuitem);
  /// Returns a new [DomComponentDefinition] that renders a `<meta>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition meta() => new DomComponentDefinition(react.meta);
  /// Returns a new [DomComponentDefinition] that renders a `<meter>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition meter() => new DomComponentDefinition(react.meter);
  /// Returns a new [DomComponentDefinition] that renders a `<nav>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition nav() => new DomComponentDefinition(react.nav);
  /// Returns a new [DomComponentDefinition] that renders a `<noscript>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition noscript() => new DomComponentDefinition(react.noscript);
  /// Returns a new [DomComponentDefinition] that renders an `<object>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition object() => new DomComponentDefinition(react.object);
  /// Returns a new [DomComponentDefinition] that renders an `<ol>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition ol() => new DomComponentDefinition(react.ol);
  /// Returns a new [DomComponentDefinition] that renders an `<optgroup>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition optgroup() => new DomComponentDefinition(react.optgroup);
  /// Returns a new [DomComponentDefinition] that renders an `<option>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition option() => new DomComponentDefinition(react.option);
  /// Returns a new [DomComponentDefinition] that renders an `<output>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition output() => new DomComponentDefinition(react.output);
  /// Returns a new [DomComponentDefinition] that renders a `<p>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition p() => new DomComponentDefinition(react.p);
  /// Returns a new [DomComponentDefinition] that renders a `<param>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition param() => new DomComponentDefinition(react.param);
  /// Returns a new [DomComponentDefinition] that renders a `<picture>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition picture() => new DomComponentDefinition(react.picture);
  /// Returns a new [DomComponentDefinition] that renders a `<pre>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition pre() => new DomComponentDefinition(react.pre);
  /// Returns a new [DomComponentDefinition] that renders a `<progress>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition progress() => new DomComponentDefinition(react.progress);
  /// Returns a new [DomComponentDefinition] that renders a `<q>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition q() => new DomComponentDefinition(react.q);
  /// Returns a new [DomComponentDefinition] that renders a `<rp>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition rp() => new DomComponentDefinition(react.rp);
  /// Returns a new [DomComponentDefinition] that renders a `<rt>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition rt() => new DomComponentDefinition(react.rt);
  /// Returns a new [DomComponentDefinition] that renders a `<ruby>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition ruby() => new DomComponentDefinition(react.ruby);
  /// Returns a new [DomComponentDefinition] that renders a `<s>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition s() => new DomComponentDefinition(react.s);
  /// Returns a new [DomComponentDefinition] that renders a `<samp>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition samp() => new DomComponentDefinition(react.samp);
  /// Returns a new [DomComponentDefinition] that renders a `<script>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition script() => new DomComponentDefinition(react.script);
  /// Returns a new [DomComponentDefinition] that renders a `<section>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition section() => new DomComponentDefinition(react.section);
  /// Returns a new [DomComponentDefinition] that renders a `<select>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition select() => new DomComponentDefinition(react.select);
  /// Returns a new [DomComponentDefinition] that renders a `<small>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition small() => new DomComponentDefinition(react.small);
  /// Returns a new [DomComponentDefinition] that renders a `<source>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition source() => new DomComponentDefinition(react.source);
  /// Returns a new [DomComponentDefinition] that renders a `<span>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition span() => new DomComponentDefinition(react.span);
  /// Returns a new [DomComponentDefinition] that renders a `<strong>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition strong() => new DomComponentDefinition(react.strong);
  /// Returns a new [DomComponentDefinition] that renders a `<style>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition style() => new DomComponentDefinition(react.style);
  /// Returns a new [DomComponentDefinition] that renders a `<sub>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition sub() => new DomComponentDefinition(react.sub);
  /// Returns a new [DomComponentDefinition] that renders a `<summary>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition summary() => new DomComponentDefinition(react.summary);
  /// Returns a new [DomComponentDefinition] that renders a `<sup>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition sup() => new DomComponentDefinition(react.sup);
  /// Returns a new [DomComponentDefinition] that renders a `<table>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition table() => new DomComponentDefinition(react.table);
  /// Returns a new [DomComponentDefinition] that renders a `<tbody>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition tbody() => new DomComponentDefinition(react.tbody);
  /// Returns a new [DomComponentDefinition] that renders a `<td>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition td() => new DomComponentDefinition(react.td);
  /// Returns a new [DomComponentDefinition] that renders a `<textarea>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition textarea() => new DomComponentDefinition(react.textarea);
  /// Returns a new [DomComponentDefinition] that renders a `<tfoot>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition tfoot() => new DomComponentDefinition(react.tfoot);
  /// Returns a new [DomComponentDefinition] that renders a `<th>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition th() => new DomComponentDefinition(react.th);
  /// Returns a new [DomComponentDefinition] that renders a `<thead>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition thead() => new DomComponentDefinition(react.thead);
  /// Returns a new [DomComponentDefinition] that renders a `<time>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition time() => new DomComponentDefinition(react.time);
  /// Returns a new [DomComponentDefinition] that renders a `<title>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition title() => new DomComponentDefinition(react.title);
  /// Returns a new [DomComponentDefinition] that renders a `<tr>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition tr() => new DomComponentDefinition(react.tr);
  /// Returns a new [DomComponentDefinition] that renders a `<track>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition track() => new DomComponentDefinition(react.track);
  /// Returns a new [DomComponentDefinition] that renders an `<u>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition u() => new DomComponentDefinition(react.u);
  /// Returns a new [DomComponentDefinition] that renders an `<ul>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition ul() => new DomComponentDefinition(react.ul);
  /// Returns a new [DomComponentDefinition] that renders a `<var>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition variable() => new DomComponentDefinition(react.variable);
  /// Returns a new [DomComponentDefinition] that renders a `<video>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition video() => new DomComponentDefinition(react.video);
  /// Returns a new [DomComponentDefinition] that renders a `<wbr>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition wbr() => new DomComponentDefinition(react.wbr);

  // SVG Elements
  /// Returns a new [DomComponentDefinition] that renders a `<circle>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition circle() => new DomComponentDefinition(react.circle);
  /// Returns a new [DomComponentDefinition] that renders a `<g>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition g() => new DomComponentDefinition(react.g);
  /// Returns a new [DomComponentDefinition] that renders a `<defs>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition defs() => new DomComponentDefinition(react.defs);
  /// Returns a new [DomComponentDefinition] that renders an `<ellipse>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition ellipse() => new DomComponentDefinition(react.ellipse);
  /// Returns a new [DomComponentDefinition] that renders a `<line>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition line() => new DomComponentDefinition(react.line);
  /// Returns a new [DomComponentDefinition] that renders a `<linearGradient>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition linearGradient() => new DomComponentDefinition(react.linearGradient);
  /// Returns a new [DomComponentDefinition] that renders a `<mask>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition mask() => new DomComponentDefinition(react.mask);
  /// Returns a new [DomComponentDefinition] that renders a `<path>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition path() => new DomComponentDefinition(react.path);
  /// Returns a new [DomComponentDefinition] that renders a `<pattern>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition pattern() => new DomComponentDefinition(react.pattern);
  /// Returns a new [DomComponentDefinition] that renders a `<polygon>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition polygon() => new DomComponentDefinition(react.polygon);
  /// Returns a new [DomComponentDefinition] that renders a `<polyline>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition polyline() => new DomComponentDefinition(react.polyline);
  /// Returns a new [DomComponentDefinition] that renders a `<radialGradient>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition radialGradient() => new DomComponentDefinition(react.radialGradient);
  /// Returns a new [DomComponentDefinition] that renders a `<rect>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition rect() => new DomComponentDefinition(react.rect);
  /// Returns a new [DomComponentDefinition] that renders a `<svg>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition svg() => new DomComponentDefinition(react.svg);
  /// Returns a new [DomComponentDefinition] that renders a `<stop>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition stop() => new DomComponentDefinition(react.stop);
  /// Returns a new [DomComponentDefinition] that renders a `<text>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition text() => new DomComponentDefinition(react.text);
  /// Returns a new [DomComponentDefinition] that renders a `<tspan>` tag with getters/setters for all DOM-related React props
  static DomComponentDefinition tspan() => new DomComponentDefinition(react.tspan);
}
