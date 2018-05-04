// Copyright 2018 Workiva Inc.
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

library render_test;

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:test/test.dart';

import 'fixtures/dummy_composite_component.dart';

main() {
  group('`react_dom.render`', () {
    var renderedInstance;
    Element mountNode;

    setUp(() {
      mountNode = new DivElement();
      document.body.append(mountNode);
    });

    tearDown(() {
      mountNode.remove();
      mountNode = null;
      renderedInstance = null;
    });

    group('mounts and renders', () {
      group('a composite component into the DOM', () {
        int componentDidMountCount;
        int componentDidUpdateCount;

        setUp(() {
          componentDidMountCount = 0;
          componentDidUpdateCount = 0;

          renderedInstance = react_dom.render((TestCompositeComponent()
            ..onComponentDidMount = () { componentDidMountCount++; }
            ..onComponentDidUpdate = () { componentDidUpdateCount++; }
          )(), mountNode);
        });

        test('', () {
          expect(componentDidMountCount, 1);
        });

        test('and returns a `Component` reference', () {
          expect(renderedInstance, isNotNull);
        });

        test('within the provided `mountNode`', () {
          expect(findDomNode(renderedInstance), mountNode.children.single);
        });

        test('and re-renders it when `react_dom.render` is called again for the same mountNode', () {
          react_dom.render((TestCompositeComponent()
            ..onComponentDidMount = () { componentDidMountCount++; }
            ..onComponentDidUpdate = () { componentDidUpdateCount++; }
          )(), mountNode);

          expect(componentDidMountCount, 1);
          expect(componentDidUpdateCount, 1);
        });
      });

      group('a Dom component into the DOM', () {
        setUp(() {
          renderedInstance = react_dom.render(Dom.div()('oh hai'), mountNode);
        });

        test('and returns an `Element` reference', () {
          expect(renderedInstance, const isInstanceOf<Element>());
        });

        test('within the provided `mountNode`', () {
          expect(renderedInstance, mountNode.children.single);
        });
      });
    });

    test('returns null when null is provided', () {
      renderedInstance = react_dom.render(null, mountNode);

      expect(mountNode.children, isEmpty);
    });
  });
}
