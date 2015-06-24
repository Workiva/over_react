/// [ComponentDefinition]-based api with typed props for react-dart DOM components.
part of w_ui_platform.ui_core;

/// A component builder with typed props for built-in DOM components.
class DomComponentDefinition extends ComponentDefinition with DomProps, ReactProps {
  DomComponentDefinition(ReactComponentFactory componentFactory, [Map props]) : super(componentFactory, props);
}

typedef DomComponentDefinition DomComponentDefinitionFactory();

class Dom {
  /// Returns a DomComponentDefinition of nodeName: <a>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition a() => new DomComponentDefinition(react.a);
  /// Returns a DomComponentDefinition of nodeName: <abbr>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition abbr() => new DomComponentDefinition(react.abbr);
  /// Returns a DomComponentDefinition of nodeName: <address>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition address() => new DomComponentDefinition(react.address);
  /// Returns a DomComponentDefinition of nodeName: <area>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition area() => new DomComponentDefinition(react.area);
  /// Returns a DomComponentDefinition of nodeName: <article>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition article() => new DomComponentDefinition(react.article);
  /// Returns a DomComponentDefinition of nodeName: <aside>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition aside() => new DomComponentDefinition(react.aside);
  /// Returns a DomComponentDefinition of nodeName: <audio>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition audio() => new DomComponentDefinition(react.audio);
  /// Returns a DomComponentDefinition of nodeName: <b>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition b() => new DomComponentDefinition(react.b);
  /// Returns a DomComponentDefinition of nodeName: <base>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition base() => new DomComponentDefinition(react.base);
  /// Returns a DomComponentDefinition of nodeName: <bdi>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition bdi() => new DomComponentDefinition(react.bdi);
  /// Returns a DomComponentDefinition of nodeName: <bdo>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition bdo() => new DomComponentDefinition(react.bdo);
  /// Returns a DomComponentDefinition of nodeName: <big>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition big() => new DomComponentDefinition(react.big);
  /// Returns a DomComponentDefinition of nodeName: <blockquote>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition blockquote() => new DomComponentDefinition(react.blockquote);
  /// Returns a DomComponentDefinition of nodeName: <body>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition body() => new DomComponentDefinition(react.body);
  /// Returns a DomComponentDefinition of nodeName: <br>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition br() => new DomComponentDefinition(react.br);
  /// Returns a DomComponentDefinition of nodeName: <button>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition button() => new DomComponentDefinition(react.button);
  /// Returns a DomComponentDefinition of nodeName: <canvas>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition canvas() => new DomComponentDefinition(react.canvas);
  /// Returns a DomComponentDefinition of nodeName: <caption>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition caption() => new DomComponentDefinition(react.caption);
  /// Returns a DomComponentDefinition of nodeName: <cite>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition cite() => new DomComponentDefinition(react.cite);
  /// Returns a DomComponentDefinition of nodeName: <code>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition code() => new DomComponentDefinition(react.code);
  /// Returns a DomComponentDefinition of nodeName: <col>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition col() => new DomComponentDefinition(react.col);
  /// Returns a DomComponentDefinition of nodeName: <colgroup>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition colgroup() => new DomComponentDefinition(react.colgroup);
  /// Returns a DomComponentDefinition of nodeName: <data>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition data() => new DomComponentDefinition(react.data);
  /// Returns a DomComponentDefinition of nodeName: <datalist>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition datalist() => new DomComponentDefinition(react.datalist);
  /// Returns a DomComponentDefinition of nodeName: <dd>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition dd() => new DomComponentDefinition(react.dd);
  /// Returns a DomComponentDefinition of nodeName: <del>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition del() => new DomComponentDefinition(react.del);
  /// Returns a DomComponentDefinition of nodeName: <details>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition details() => new DomComponentDefinition(react.details);
  /// Returns a DomComponentDefinition of nodeName: <dfn>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition dfn() => new DomComponentDefinition(react.dfn);
  /// Returns a DomComponentDefinition of nodeName: <dialog>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition dialog() => new DomComponentDefinition(react.dialog);
  /// Returns a DomComponentDefinition of nodeName: <div>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition div() => new DomComponentDefinition(react.div);
  /// Returns a DomComponentDefinition of nodeName: <dl>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition dl() => new DomComponentDefinition(react.dl);
  /// Returns a DomComponentDefinition of nodeName: <dt>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition dt() => new DomComponentDefinition(react.dt);
  /// Returns a DomComponentDefinition of nodeName: <em>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition em() => new DomComponentDefinition(react.em);
  /// Returns a DomComponentDefinition of nodeName: <embed>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition embed() => new DomComponentDefinition(react.embed);
  /// Returns a DomComponentDefinition of nodeName: <fieldset>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition fieldset() => new DomComponentDefinition(react.fieldset);
  /// Returns a DomComponentDefinition of nodeName: <figcaption>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition figcaption() => new DomComponentDefinition(react.figcaption);
  /// Returns a DomComponentDefinition of nodeName: <figure>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition figure() => new DomComponentDefinition(react.figure);
  /// Returns a DomComponentDefinition of nodeName: <footer>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition footer() => new DomComponentDefinition(react.footer);
  /// Returns a DomComponentDefinition of nodeName: <form>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition form() => new DomComponentDefinition(react.form);
  /// Returns a DomComponentDefinition of nodeName: <h1>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition h1() => new DomComponentDefinition(react.h1);
  /// Returns a DomComponentDefinition of nodeName: <h2>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition h2() => new DomComponentDefinition(react.h2);
  /// Returns a DomComponentDefinition of nodeName: <h3>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition h3() => new DomComponentDefinition(react.h3);
  /// Returns a DomComponentDefinition of nodeName: <h4>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition h4() => new DomComponentDefinition(react.h4);
  /// Returns a DomComponentDefinition of nodeName: <h5>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition h5() => new DomComponentDefinition(react.h5);
  /// Returns a DomComponentDefinition of nodeName: <h6>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition h6() => new DomComponentDefinition(react.h6);
  /// Returns a DomComponentDefinition of nodeName: <head>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition head() => new DomComponentDefinition(react.head);
  /// Returns a DomComponentDefinition of nodeName: <header>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition header() => new DomComponentDefinition(react.header);
  /// Returns a DomComponentDefinition of nodeName: <hr>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition hr() => new DomComponentDefinition(react.hr);
  /// Returns a DomComponentDefinition of nodeName: <html>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition html() => new DomComponentDefinition(react.html);
  /// Returns a DomComponentDefinition of nodeName: <i>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition i() => new DomComponentDefinition(react.i);
  /// Returns a DomComponentDefinition of nodeName: <iframe>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition iframe() => new DomComponentDefinition(react.iframe);
  /// Returns a DomComponentDefinition of nodeName: <img>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition img() => new DomComponentDefinition(react.img);
  /// Returns a DomComponentDefinition of nodeName: <input>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition input() => new DomComponentDefinition(react.input);
  /// Returns a DomComponentDefinition of nodeName: <ins>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition ins() => new DomComponentDefinition(react.ins);
  /// Returns a DomComponentDefinition of nodeName: <kbd>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition kbd() => new DomComponentDefinition(react.kbd);
  /// Returns a DomComponentDefinition of nodeName: <keygen>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition keygen() => new DomComponentDefinition(react.keygen);
  /// Returns a DomComponentDefinition of nodeName: <label>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition label() => new DomComponentDefinition(react.label);
  /// Returns a DomComponentDefinition of nodeName: <legend>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition legend() => new DomComponentDefinition(react.legend);
  /// Returns a DomComponentDefinition of nodeName: <li>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition li() => new DomComponentDefinition(react.li);
  /// Returns a DomComponentDefinition of nodeName: <link>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition link() => new DomComponentDefinition(react.link);
  /// Returns a DomComponentDefinition of nodeName: <main>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition main() => new DomComponentDefinition(react.main);
  /// Returns a DomComponentDefinition of nodeName: <map>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition map() => new DomComponentDefinition(react.map);
  /// Returns a DomComponentDefinition of nodeName: <mark>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition mark() => new DomComponentDefinition(react.mark);
  /// Returns a DomComponentDefinition of nodeName: <menu>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition menu() => new DomComponentDefinition(react.menu);
  /// Returns a DomComponentDefinition of nodeName: <menuitem>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition menuitem() => new DomComponentDefinition(react.menuitem);
  /// Returns a DomComponentDefinition of nodeName: <meta>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition meta() => new DomComponentDefinition(react.meta);
  /// Returns a DomComponentDefinition of nodeName: <meter>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition meter() => new DomComponentDefinition(react.meter);
  /// Returns a DomComponentDefinition of nodeName: <nav>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition nav() => new DomComponentDefinition(react.nav);
  /// Returns a DomComponentDefinition of nodeName: <noscript>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition noscript() => new DomComponentDefinition(react.noscript);
  /// Returns a DomComponentDefinition of nodeName: <object>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition object() => new DomComponentDefinition(react.object);
  /// Returns a DomComponentDefinition of nodeName: <ol>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition ol() => new DomComponentDefinition(react.ol);
  /// Returns a DomComponentDefinition of nodeName: <optgroup>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition optgroup() => new DomComponentDefinition(react.optgroup);
  /// Returns a DomComponentDefinition of nodeName: <option>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition option() => new DomComponentDefinition(react.option);
  /// Returns a DomComponentDefinition of nodeName: <output>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition output() => new DomComponentDefinition(react.output);
  /// Returns a DomComponentDefinition of nodeName: <p>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition p() => new DomComponentDefinition(react.p);
  /// Returns a DomComponentDefinition of nodeName: <param>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition param() => new DomComponentDefinition(react.param);
  /// Returns a DomComponentDefinition of nodeName: <picture>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition picture() => new DomComponentDefinition(react.picture);
  /// Returns a DomComponentDefinition of nodeName: <pre>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition pre() => new DomComponentDefinition(react.pre);
  /// Returns a DomComponentDefinition of nodeName: <progress>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition progress() => new DomComponentDefinition(react.progress);
  /// Returns a DomComponentDefinition of nodeName: <q>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition q() => new DomComponentDefinition(react.q);
  /// Returns a DomComponentDefinition of nodeName: <rp>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition rp() => new DomComponentDefinition(react.rp);
  /// Returns a DomComponentDefinition of nodeName: <rt>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition rt() => new DomComponentDefinition(react.rt);
  /// Returns a DomComponentDefinition of nodeName: <ruby>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition ruby() => new DomComponentDefinition(react.ruby);
  /// Returns a DomComponentDefinition of nodeName: <s>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition s() => new DomComponentDefinition(react.s);
  /// Returns a DomComponentDefinition of nodeName: <samp>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition samp() => new DomComponentDefinition(react.samp);
  /// Returns a DomComponentDefinition of nodeName: <script>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition script() => new DomComponentDefinition(react.script);
  /// Returns a DomComponentDefinition of nodeName: <section>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition section() => new DomComponentDefinition(react.section);
  /// Returns a DomComponentDefinition of nodeName: <select>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition select() => new DomComponentDefinition(react.select);
  /// Returns a DomComponentDefinition of nodeName: <small>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition small() => new DomComponentDefinition(react.small);
  /// Returns a DomComponentDefinition of nodeName: <source>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition source() => new DomComponentDefinition(react.source);
  /// Returns a DomComponentDefinition of nodeName: <span>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition span() => new DomComponentDefinition(react.span);
  /// Returns a DomComponentDefinition of nodeName: <strong>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition strong() => new DomComponentDefinition(react.strong);
  /// Returns a DomComponentDefinition of nodeName: <style>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition style() => new DomComponentDefinition(react.style);
  /// Returns a DomComponentDefinition of nodeName: <sub>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition sub() => new DomComponentDefinition(react.sub);
  /// Returns a DomComponentDefinition of nodeName: <summary>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition summary() => new DomComponentDefinition(react.summary);
  /// Returns a DomComponentDefinition of nodeName: <sup>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition sup() => new DomComponentDefinition(react.sup);
  /// Returns a DomComponentDefinition of nodeName: <table>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition table() => new DomComponentDefinition(react.table);
  /// Returns a DomComponentDefinition of nodeName: <tbody>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition tbody() => new DomComponentDefinition(react.tbody);
  /// Returns a DomComponentDefinition of nodeName: <td>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition td() => new DomComponentDefinition(react.td);
  /// Returns a DomComponentDefinition of nodeName: <textarea>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition textarea() => new DomComponentDefinition(react.textarea);
  /// Returns a DomComponentDefinition of nodeName: <tfoot>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition tfoot() => new DomComponentDefinition(react.tfoot);
  /// Returns a DomComponentDefinition of nodeName: <th>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition th() => new DomComponentDefinition(react.th);
  /// Returns a DomComponentDefinition of nodeName: <thead>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition thead() => new DomComponentDefinition(react.thead);
  /// Returns a DomComponentDefinition of nodeName: <time>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition time() => new DomComponentDefinition(react.time);
  /// Returns a DomComponentDefinition of nodeName: <title>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition title() => new DomComponentDefinition(react.title);
  /// Returns a DomComponentDefinition of nodeName: <tr>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition tr() => new DomComponentDefinition(react.tr);
  /// Returns a DomComponentDefinition of nodeName: <track>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition track() => new DomComponentDefinition(react.track);
  /// Returns a DomComponentDefinition of nodeName: <u>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition u() => new DomComponentDefinition(react.u);
  /// Returns a DomComponentDefinition of nodeName: <ul>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition ul() => new DomComponentDefinition(react.ul);
  /// Returns a DomComponentDefinition of nodeName: <variable>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition variable() => new DomComponentDefinition(react.variable);
  /// Returns a DomComponentDefinition of nodeName: <video>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition video() => new DomComponentDefinition(react.video);
  /// Returns a DomComponentDefinition of nodeName: <wbr>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition wbr() => new DomComponentDefinition(react.wbr);

  // SVG Elements
  /// Returns a DomComponentDefinition of nodeName: <circle>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition circle() => new DomComponentDefinition(react.circle);
  /// Returns a DomComponentDefinition of nodeName: <g>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition g() => new DomComponentDefinition(react.g);
  /// Returns a DomComponentDefinition of nodeName: <defs>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition defs() => new DomComponentDefinition(react.defs);
  /// Returns a DomComponentDefinition of nodeName: <ellipse>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition ellipse() => new DomComponentDefinition(react.ellipse);
  /// Returns a DomComponentDefinition of nodeName: <line>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition line() => new DomComponentDefinition(react.line);
  /// Returns a DomComponentDefinition of nodeName: <linearGradient>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition linearGradient() => new DomComponentDefinition(react.linearGradient);
  /// Returns a DomComponentDefinition of nodeName: <mask>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition mask() => new DomComponentDefinition(react.mask);
  /// Returns a DomComponentDefinition of nodeName: <path>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition path() => new DomComponentDefinition(react.path);
  /// Returns a DomComponentDefinition of nodeName: <pattern>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition pattern() => new DomComponentDefinition(react.pattern);
  /// Returns a DomComponentDefinition of nodeName: <polygon>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition polygon() => new DomComponentDefinition(react.polygon);
  /// Returns a DomComponentDefinition of nodeName: <polyline>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition polyline() => new DomComponentDefinition(react.polyline);
  /// Returns a DomComponentDefinition of nodeName: <radialGradient>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition radialGradient() => new DomComponentDefinition(react.radialGradient);
  /// Returns a DomComponentDefinition of nodeName: <rect>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition rect() => new DomComponentDefinition(react.rect);
  /// Returns a DomComponentDefinition of nodeName: <svg>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition svg() => new DomComponentDefinition(react.svg);
  /// Returns a DomComponentDefinition of nodeName: <stop>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition stop() => new DomComponentDefinition(react.stop);
  /// Returns a DomComponentDefinition of nodeName: <text>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition text() => new DomComponentDefinition(react.text);
  /// Returns a DomComponentDefinition of nodeName: <tspan>, which can have any attribute of [DomProps] added to it.
  static DomComponentDefinition tspan() => new DomComponentDefinition(react.tspan);
}
