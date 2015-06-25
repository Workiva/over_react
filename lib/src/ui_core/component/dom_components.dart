/// [ComponentDefinition]-based api with typed props for react-dart DOM components.
part of w_ui_platform.ui_core;


class DomPropsMapView extends MapView with DomProps {
  /// Create a new instance backed by the specified map.
  DomPropsMapView(Map map) : super(map);

  /// The props to be manipulated via the getters/setters.
  /// In this case, it's the current MapView object.
  @override
  Map get props => this;
}

DomPropsMapView domProps([Map backingMap]) => new DomPropsMapView(backingMap == null ? {} : backingMap);

/// A component builder with typed props for built-in DOM components.
class DomComponentDefinition extends ComponentDefinition with DomProps, ReactProps {
  DomComponentDefinition(ReactComponentFactory componentFactory, [Map props]) : super(componentFactory, props);
}

typedef DomComponentDefinition DomComponentDefinitionFactory();

class Dom {
  static DomComponentDefinition a() => new DomComponentDefinition(react.a);
  static DomComponentDefinition abbr() => new DomComponentDefinition(react.abbr);
  static DomComponentDefinition address() => new DomComponentDefinition(react.address);
  static DomComponentDefinition area() => new DomComponentDefinition(react.area);
  static DomComponentDefinition article() => new DomComponentDefinition(react.article);
  static DomComponentDefinition aside() => new DomComponentDefinition(react.aside);
  static DomComponentDefinition audio() => new DomComponentDefinition(react.audio);
  static DomComponentDefinition b() => new DomComponentDefinition(react.b);
  static DomComponentDefinition base() => new DomComponentDefinition(react.base);
  static DomComponentDefinition bdi() => new DomComponentDefinition(react.bdi);
  static DomComponentDefinition bdo() => new DomComponentDefinition(react.bdo);
  static DomComponentDefinition big() => new DomComponentDefinition(react.big);
  static DomComponentDefinition blockquote() => new DomComponentDefinition(react.blockquote);
  static DomComponentDefinition body() => new DomComponentDefinition(react.body);
  static DomComponentDefinition br() => new DomComponentDefinition(react.br);
  static DomComponentDefinition button() => new DomComponentDefinition(react.button);
  static DomComponentDefinition canvas() => new DomComponentDefinition(react.canvas);
  static DomComponentDefinition caption() => new DomComponentDefinition(react.caption);
  static DomComponentDefinition cite() => new DomComponentDefinition(react.cite);
  static DomComponentDefinition code() => new DomComponentDefinition(react.code);
  static DomComponentDefinition col() => new DomComponentDefinition(react.col);
  static DomComponentDefinition colgroup() => new DomComponentDefinition(react.colgroup);
  static DomComponentDefinition data() => new DomComponentDefinition(react.data);
  static DomComponentDefinition datalist() => new DomComponentDefinition(react.datalist);
  static DomComponentDefinition dd() => new DomComponentDefinition(react.dd);
  static DomComponentDefinition del() => new DomComponentDefinition(react.del);
  static DomComponentDefinition details() => new DomComponentDefinition(react.details);
  static DomComponentDefinition dfn() => new DomComponentDefinition(react.dfn);
  static DomComponentDefinition dialog() => new DomComponentDefinition(react.dialog);
  static DomComponentDefinition div() => new DomComponentDefinition(react.div);
  static DomComponentDefinition dl() => new DomComponentDefinition(react.dl);
  static DomComponentDefinition dt() => new DomComponentDefinition(react.dt);
  static DomComponentDefinition em() => new DomComponentDefinition(react.em);
  static DomComponentDefinition embed() => new DomComponentDefinition(react.embed);
  static DomComponentDefinition fieldset() => new DomComponentDefinition(react.fieldset);
  static DomComponentDefinition figcaption() => new DomComponentDefinition(react.figcaption);
  static DomComponentDefinition figure() => new DomComponentDefinition(react.figure);
  static DomComponentDefinition footer() => new DomComponentDefinition(react.footer);
  static DomComponentDefinition form() => new DomComponentDefinition(react.form);
  static DomComponentDefinition h1() => new DomComponentDefinition(react.h1);
  static DomComponentDefinition h2() => new DomComponentDefinition(react.h2);
  static DomComponentDefinition h3() => new DomComponentDefinition(react.h3);
  static DomComponentDefinition h4() => new DomComponentDefinition(react.h4);
  static DomComponentDefinition h5() => new DomComponentDefinition(react.h5);
  static DomComponentDefinition h6() => new DomComponentDefinition(react.h6);
  static DomComponentDefinition head() => new DomComponentDefinition(react.head);
  static DomComponentDefinition header() => new DomComponentDefinition(react.header);
  static DomComponentDefinition hr() => new DomComponentDefinition(react.hr);
  static DomComponentDefinition html() => new DomComponentDefinition(react.html);
  static DomComponentDefinition i() => new DomComponentDefinition(react.i);
  static DomComponentDefinition iframe() => new DomComponentDefinition(react.iframe);
  static DomComponentDefinition img() => new DomComponentDefinition(react.img);
  static DomComponentDefinition input() => new DomComponentDefinition(react.input);
  static DomComponentDefinition ins() => new DomComponentDefinition(react.ins);
  static DomComponentDefinition kbd() => new DomComponentDefinition(react.kbd);
  static DomComponentDefinition keygen() => new DomComponentDefinition(react.keygen);
  static DomComponentDefinition label() => new DomComponentDefinition(react.label);
  static DomComponentDefinition legend() => new DomComponentDefinition(react.legend);
  static DomComponentDefinition li() => new DomComponentDefinition(react.li);
  static DomComponentDefinition link() => new DomComponentDefinition(react.link);
  static DomComponentDefinition main() => new DomComponentDefinition(react.main);
  static DomComponentDefinition map() => new DomComponentDefinition(react.map);
  static DomComponentDefinition mark() => new DomComponentDefinition(react.mark);
  static DomComponentDefinition menu() => new DomComponentDefinition(react.menu);
  static DomComponentDefinition menuitem() => new DomComponentDefinition(react.menuitem);
  static DomComponentDefinition meta() => new DomComponentDefinition(react.meta);
  static DomComponentDefinition meter() => new DomComponentDefinition(react.meter);
  static DomComponentDefinition nav() => new DomComponentDefinition(react.nav);
  static DomComponentDefinition noscript() => new DomComponentDefinition(react.noscript);
  static DomComponentDefinition object() => new DomComponentDefinition(react.object);
  static DomComponentDefinition ol() => new DomComponentDefinition(react.ol);
  static DomComponentDefinition optgroup() => new DomComponentDefinition(react.optgroup);
  static DomComponentDefinition option() => new DomComponentDefinition(react.option);
  static DomComponentDefinition output() => new DomComponentDefinition(react.output);
  static DomComponentDefinition p() => new DomComponentDefinition(react.p);
  static DomComponentDefinition param() => new DomComponentDefinition(react.param);
  static DomComponentDefinition picture() => new DomComponentDefinition(react.picture);
  static DomComponentDefinition pre() => new DomComponentDefinition(react.pre);
  static DomComponentDefinition progress() => new DomComponentDefinition(react.progress);
  static DomComponentDefinition q() => new DomComponentDefinition(react.q);
  static DomComponentDefinition rp() => new DomComponentDefinition(react.rp);
  static DomComponentDefinition rt() => new DomComponentDefinition(react.rt);
  static DomComponentDefinition ruby() => new DomComponentDefinition(react.ruby);
  static DomComponentDefinition s() => new DomComponentDefinition(react.s);
  static DomComponentDefinition samp() => new DomComponentDefinition(react.samp);
  static DomComponentDefinition script() => new DomComponentDefinition(react.script);
  static DomComponentDefinition section() => new DomComponentDefinition(react.section);
  static DomComponentDefinition select() => new DomComponentDefinition(react.select);
  static DomComponentDefinition small() => new DomComponentDefinition(react.small);
  static DomComponentDefinition source() => new DomComponentDefinition(react.source);
  static DomComponentDefinition span() => new DomComponentDefinition(react.span);
  static DomComponentDefinition strong() => new DomComponentDefinition(react.strong);
  static DomComponentDefinition style() => new DomComponentDefinition(react.style);
  static DomComponentDefinition sub() => new DomComponentDefinition(react.sub);
  static DomComponentDefinition summary() => new DomComponentDefinition(react.summary);
  static DomComponentDefinition sup() => new DomComponentDefinition(react.sup);
  static DomComponentDefinition table() => new DomComponentDefinition(react.table);
  static DomComponentDefinition tbody() => new DomComponentDefinition(react.tbody);
  static DomComponentDefinition td() => new DomComponentDefinition(react.td);
  static DomComponentDefinition textarea() => new DomComponentDefinition(react.textarea);
  static DomComponentDefinition tfoot() => new DomComponentDefinition(react.tfoot);
  static DomComponentDefinition th() => new DomComponentDefinition(react.th);
  static DomComponentDefinition thead() => new DomComponentDefinition(react.thead);
  static DomComponentDefinition time() => new DomComponentDefinition(react.time);
  static DomComponentDefinition title() => new DomComponentDefinition(react.title);
  static DomComponentDefinition tr() => new DomComponentDefinition(react.tr);
  static DomComponentDefinition track() => new DomComponentDefinition(react.track);
  static DomComponentDefinition u() => new DomComponentDefinition(react.u);
  static DomComponentDefinition ul() => new DomComponentDefinition(react.ul);
  static DomComponentDefinition variable() => new DomComponentDefinition(react.variable);
  static DomComponentDefinition video() => new DomComponentDefinition(react.video);
  static DomComponentDefinition wbr() => new DomComponentDefinition(react.wbr);

  // SVG Elements
  static DomComponentDefinition circle() => new DomComponentDefinition(react.circle);
  static DomComponentDefinition g() => new DomComponentDefinition(react.g);
  static DomComponentDefinition defs() => new DomComponentDefinition(react.defs);
  static DomComponentDefinition ellipse() => new DomComponentDefinition(react.ellipse);
  static DomComponentDefinition line() => new DomComponentDefinition(react.line);
  static DomComponentDefinition linearGradient() => new DomComponentDefinition(react.linearGradient);
  static DomComponentDefinition mask() => new DomComponentDefinition(react.mask);
  static DomComponentDefinition path() => new DomComponentDefinition(react.path);
  static DomComponentDefinition pattern() => new DomComponentDefinition(react.pattern);
  static DomComponentDefinition polygon() => new DomComponentDefinition(react.polygon);
  static DomComponentDefinition polyline() => new DomComponentDefinition(react.polyline);
  static DomComponentDefinition radialGradient() => new DomComponentDefinition(react.radialGradient);
  static DomComponentDefinition rect() => new DomComponentDefinition(react.rect);
  static DomComponentDefinition svg() => new DomComponentDefinition(react.svg);
  static DomComponentDefinition stop() => new DomComponentDefinition(react.stop);
  static DomComponentDefinition text() => new DomComponentDefinition(react.text);
  static DomComponentDefinition tspan() => new DomComponentDefinition(react.tspan);
}
