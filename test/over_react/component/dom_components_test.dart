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
@Tags(const ['mirrors'])
library dom_components_test;

// Tell dart2js that this library only needs to reflect the specified types.
// This speeds up compilation and makes JS output much smaller.
@MirrorsUsed(targets: const [
  'over_react.dom_components.Dom'
])
import 'dart:mirrors';

import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:test/test.dart';

main() {
  group('Dom component:', () {
    const expectedStaticMethods = const<Symbol>[
      // DOM
      #a, #abbr, #address, #area, #article, #aside, #audio, #b, #base, #bdi, #bdo, #big, #blockquote, #body, #br,
      #button, #canvas, #caption, #cite, #code, #col, #colgroup, #data, #datalist, #dd, #del, #details, #dfn, #dialog,
      #div, #dl, #dt, #em, #embed, #fieldset, #figcaption, #figure, #footer, #form, #h1, #h2, #h3, #h4, #h5, #h6,
      #head, #header, #hr, #html, #i, #iframe, #img, #input, #ins, #kbd, #keygen, #label, #legend, #li, #link, #main,
      #map, #mark, #menu, #menuitem, #meta, #meter, #nav, #noscript, #object, #ol, #optgroup, #option, #output, #p,
      #param, #picture, #pre, #progress, #q, #rp, #rt, #ruby, #s, #samp, #script, #section, #select, #small, #source,
      #span, #strong, #style, #sub, #summary, #sup, #table, #tbody, #td, #textarea, #tfoot, #th, #thead, #time,
      #title, #tr, #track, #u, #ul, #variable, #video, #wbr,
      // SVG
      #svgA, #altGlyph, #altGlyphDef, #altGlyphItem, #animate, #animateColor, #animateMotion, #animateTransform,
      #svgAudio, #svgCanvas, #circle, #clipPath, #colorProfile, #cursor, #defs, #desc, #discard, #ellipse, #feBlend,
      #feColorMatrix, #feComponentTransfer, #feComposite, #feConvolveMatrix, #feDiffuseLighting, #feDisplacementMap,
      #feDistantLight, #feDropShadow, #feFlood, #feFuncA, #feFuncB, #feFuncG, #feFuncR, #feGaussianBlur, #feImage,
      #feMerge, #feMergeNode, #feMorphology, #feOffset, #fePointLight, #feSpecularLighting, #feSpotLight, #feTile,
      #feTurbulence, #filter, #font, #fontFace, #fontFaceFormat, #fontFaceName, #fontFaceSrc, #fontFaceUri,
      #foreignObject, #g, #glyph, #glyphRef, #hatch, #hatchpath, #hkern, #svgIframe, #image, #line, #linearGradient,
      #marker, #mask, #mesh, #meshgradient, #meshpatch, #meshrow, #metadata, #missingGlyph, #mpath, #path, #pattern,
      #polygon, #polyline, #radialGradient, #rect, #svgScript, #svgSet, #solidcolor, #stop, #svgStyle, #svg,
      #svgSwitch, #symbol, #text, #textPath, #svgTitle, #tref, #tspan, #unknown, #use, #svgVideo, #view, #vkern,
    ];

    List<Symbol> methods = [];
    ClassMirror domClassMirror;

    setUpAll(() {
      domClassMirror = reflectClass(Dom);

      // staticMembers is not implemented for the DDC and will throw is this test is loaded even if it's not run.
      try {
        methods = domClassMirror.staticMembers.values.map((m) => m.simpleName).toList();

        expect(methods, isNotEmpty, reason: 'should have properly reflected the static members.');
      } catch(e) {}

      if (methods.isNotEmpty) {
        expect(methods, unorderedEquals(expectedStaticMethods), reason: '`expectedStaticMethods` needs to be updated');
      }
    });

    for (var element in expectedStaticMethods) {
      String name = MirrorSystem.getName(element);
      String expectedTagName = name;
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
      if (expectedTagName.startsWith(new RegExp('svg.'))) expectedTagName = expectedTagName.substring(3);

      test('Dom.$name generates the correct type', () {
        DomProps builder = domClassMirror.invoke(element, []).reflectee;
        ReactElement component = builder();
        expect(component.type, equalsIgnoringCase(expectedTagName));
      });
    }

    group('typing:', () {
      final DomProps dom = Dom.div();
      final SvgProps svg = Dom.circle();

      test('DomProps is a subtype of `UiProps` exported by over_react.dart', () {
        expect(dom, const isInstanceOf<UiProps>());
      });

      test('SvgProps is a subtype of `UiProps` exported by over_react.dart', () {
        expect(svg, const isInstanceOf<UiProps>());
      });

      test('SvgProps is a subtype of `DomProps`', () {
        expect(svg, const isInstanceOf<DomProps>());
      });
    });
  });
}
