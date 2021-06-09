// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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

@TestOn('browser')
library dom_components_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

main() {
  group('Dom component:', () {
    var expectedMethodsOnDom = <UiFactory /* dom method */, String /* method name */>{
      Dom.a: 'a', Dom.abbr: 'abbr', Dom.address: 'address', Dom.area: 'area', Dom.article: 'article',
      Dom.aside: 'aside', Dom.audio: 'audio', Dom.b: 'b', Dom.base: 'base', Dom.bdi: 'bdi', Dom.bdo: 'bdo',
      Dom.big: 'big', Dom.blockquote: 'blockquote', Dom.body: 'body', Dom.br: 'br', Dom.button: 'button',
      Dom.canvas: 'canvas', Dom.caption: 'caption', Dom.cite: 'cite', Dom.code: 'code', Dom.col: 'col',
      Dom.colgroup: 'colgroup', Dom.data: 'data', Dom.datalist: 'datalist', Dom.dd: 'dd', Dom.del: 'del',
      Dom.details: 'details', Dom.dfn: 'dfn', Dom.dialog: 'dialog', Dom.div: 'div', Dom.dl: 'dl', Dom.dt: 'dt',
      Dom.em: 'em', Dom.embed: 'embed', Dom.fieldset: 'fieldset', Dom.figcaption: 'figcaption', Dom.figure: 'figure',
      Dom.footer: 'footer', Dom.form: 'form', Dom.h1: 'h1', Dom.h2: 'h2', Dom.h3: 'h3', Dom.h4: 'h4', Dom.h5: 'h5',
      Dom.h6: 'h6', Dom.head: 'head', Dom.header: 'header', Dom.hr: 'hr', Dom.html: 'html', Dom.i: 'i',
      Dom.iframe: 'iframe', Dom.img: 'img', Dom.input: 'input', Dom.ins: 'ins', Dom.kbd: 'kbd', Dom.keygen: 'keygen',
      Dom.label: 'label', Dom.legend: 'legend', Dom.li: 'li', Dom.link: 'link', Dom.main: 'main', Dom.map: 'map',
      Dom.mark: 'mark', Dom.menu: 'menu', Dom.menuitem: 'menuitem', Dom.meta: 'meta', Dom.meter: 'meter',
      Dom.nav: 'nav', Dom.noscript: 'noscript', Dom.object: 'object', Dom.ol: 'ol', Dom.optgroup: 'optgroup',
      Dom.option: 'option', Dom.output: 'output', Dom.p: 'p', Dom.param: 'param', Dom.picture: 'picture',
      Dom.pre: 'pre', Dom.progress: 'progress', Dom.q: 'q', Dom.rp: 'rp', Dom.rt: 'rt', Dom.ruby: 'ruby', Dom.s: 's',
      Dom.samp: 'samp', Dom.script: 'script', Dom.section: 'section', Dom.select: 'select', Dom.small: 'small',
      Dom.source: 'source', Dom.span: 'span', Dom.strong: 'strong', Dom.style: 'style', Dom.sub: 'sub',
      Dom.summary: 'summary', Dom.sup: 'sup', Dom.table: 'table', Dom.tbody: 'tbody', Dom.td: 'td',
      Dom.textarea: 'textarea', Dom.tfoot: 'tfoot', Dom.th: 'th', Dom.thead: 'thead', Dom.time: 'time',
      Dom.title: 'title', Dom.tr: 'tr', Dom.track: 'track', Dom.u: 'u', Dom.ul: 'ul', Dom.variable: 'variable',
      Dom.video: 'video', Dom.wbr: 'wbr',
       // SVG
      Dom.svgA: 'svgA', Dom.altGlyph: 'altGlyph', Dom.altGlyphDef: 'altGlyphDef', Dom.altGlyphItem: 'altGlyphItem',
      Dom.animate: 'animate', Dom.animateColor: 'animateColor', Dom.animateMotion: 'animateMotion',
      Dom.animateTransform: 'animateTransform', Dom.svgAudio: 'svgAudio', Dom.svgCanvas: 'svgCanvas', Dom.circle: 'circle',
      Dom.clipPath: 'clipPath', Dom.colorProfile: 'colorProfile', Dom.cursor: 'cursor', Dom.defs: 'defs', Dom.desc: 'desc',
      Dom.discard: 'discard', Dom.ellipse: 'ellipse', Dom.feBlend: 'feBlend', Dom.feColorMatrix: 'feColorMatrix',
      Dom.feComponentTransfer: 'feComponentTransfer', Dom.feComposite: 'feComposite', Dom.feConvolveMatrix: 'feConvolveMatrix',
      Dom.feDiffuseLighting: 'feDiffuseLighting', Dom.feDisplacementMap: 'feDisplacementMap',
      Dom.feDistantLight: 'feDistantLight', Dom.feDropShadow: 'feDropShadow', Dom.feFlood: 'feFlood', Dom.feFuncA: 'feFuncA',
      Dom.feFuncB: 'feFuncB', Dom.feFuncG: 'feFuncG', Dom.feFuncR: 'feFuncR', Dom.feGaussianBlur: 'feGaussianBlur',
      Dom.feImage: 'feImage', Dom.feMerge: 'feMerge', Dom.feMergeNode: 'feMergeNode', Dom.feMorphology: 'feMorphology',
      Dom.feOffset: 'feOffset', Dom.fePointLight: 'fePointLight', Dom.feSpecularLighting: 'feSpecularLighting',
      Dom.feSpotLight: 'feSpotLight', Dom.feTile: 'feTile', Dom.feTurbulence: 'feTurbulence', Dom.filter: 'filter',
      Dom.font: 'font', Dom.fontFace: 'fontFace', Dom.fontFaceFormat: 'fontFaceFormat', Dom.fontFaceName: 'fontFaceName',
      Dom.fontFaceSrc: 'fontFaceSrc', Dom.fontFaceUri: 'fontFaceUri', Dom.foreignObject: 'foreignObject', Dom.g: 'g',
      Dom.glyph: 'glyph', Dom.glyphRef: 'glyphRef', Dom.hatch: 'hatch', Dom.hatchpath: 'hatchpath', Dom.hkern: 'hkern',
      Dom.svgIframe: 'svgIframe', Dom.image: 'image', Dom.line: 'line', Dom.linearGradient: 'linearGradient',
      Dom.marker: 'marker', Dom.mask: 'mask', Dom.mesh: 'mesh', Dom.meshgradient: 'meshgradient', Dom.meshpatch: 'meshpatch',
      Dom.meshrow: 'meshrow', Dom.metadata: 'metadata', Dom.missingGlyph: 'missingGlyph', Dom.mpath: 'mpath', Dom.path: 'path',
      Dom.pattern: 'pattern', Dom.polygon: 'polygon', Dom.polyline: 'polyline', Dom.radialGradient: 'radialGradient',
      Dom.rect: 'rect', Dom.svgScript: 'svgScript', Dom.svgSet: 'svgSet', Dom.solidcolor: 'solidcolor', Dom.stop: 'stop',
      Dom.svgStyle: 'svgStyle', Dom.svg: 'svg', Dom.svgSwitch: 'svgSwitch', Dom.symbol: 'symbol', Dom.text: 'text',
      Dom.textPath: 'textPath', Dom.svgTitle: 'svgTitle', Dom.tref: 'tref', Dom.tspan: 'tspan', Dom.unknown: 'unknown',
      Dom.use: 'use', Dom.svgVideo: 'svgVideo', Dom.view: 'view', Dom.vkern: 'vkern',
    };

    expectedMethodsOnDom.forEach((method, methodName) {
      String expectedTagName = methodName;
      if (expectedTagName == 'variable') expectedTagName = 'var';
      if (expectedTagName == 'svgSet') expectedTagName = 'set';
      if (expectedTagName == 'svgSwitch') expectedTagName = 'switch';
      if (expectedTagName == 'colorProfile') expectedTagName = 'color-profile';
      if (expectedTagName == 'fontFace') expectedTagName = 'font-face';
      if (expectedTagName == 'fontFaceFormat') expectedTagName = 'font-face-format';
      if (expectedTagName == 'fontFaceName') expectedTagName = 'font-face-name';
      if (expectedTagName == 'fontFaceSrc') expectedTagName = 'font-face-src';
      if (expectedTagName == 'fontFaceUri') expectedTagName = 'font-face-uri';
      if (expectedTagName == 'missingGlyph') expectedTagName = 'missing-glyph';
      if (expectedTagName.startsWith(RegExp('svg.'))) expectedTagName = expectedTagName.substring(3);

      test('Dom.$methodName() generates the correct type', () {
        final component = method()();
        expect(component.type, equalsIgnoringCase(expectedTagName));
      });
    });

    group('typing:', () {
      final DomProps dom = Dom.div();
      final SvgProps svg = Dom.circle();

      test('DomProps is a subtype of `UiProps` exported by over_react.dart', () {
        expect(dom, isA<UiProps>());
      });

      test('SvgProps is a subtype of `UiProps` exported by over_react.dart', () {
        expect(svg, isA<UiProps>());
      });

      test('SvgProps is a subtype of `DomProps`', () {
        expect(svg, isA<DomProps>());
      });
    });
  });
}
