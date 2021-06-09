// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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

@TestOn('browser')
library unmount_test;

import 'dart:html';

import 'package:over_react/react_dom.dart' as react_dom;
import 'package:test/test.dart';

import 'fixtures/dummy_composite_component.dart';

main() {
  group('`react_dom.unmountComponentAtNode`', () {
    Element mountNode;
    bool unmountComponentAtNodeReturnValue;

    setUp(() {
      mountNode = DivElement();
      document.body.append(mountNode);
    });

    tearDown(() {
      mountNode.remove();
      mountNode = null;
    });

    group('when called on a mountNode that has a mounted component:', () {
      int componentDidMountCount;
      bool componentWillUnmount;

      setUp(() {
        componentDidMountCount = 0;
        componentWillUnmount = false;

        react_dom.render((TestCompositeComponent()
          ..onComponentDidMount = () { componentDidMountCount++; }
          ..onComponentWillUnmount = () { componentWillUnmount = true; }
        )(), mountNode);

        expect(componentDidMountCount, 1, reason: 'test setup sanity check');

        unmountComponentAtNodeReturnValue = react_dom.unmountComponentAtNode(mountNode);
      });

      test('unmounts the component', () {
        expect(componentWillUnmount, isTrue);
      });

      test('removes the rendered component from the DOM', () {
        expect(mountNode.children, isEmpty);
      });

      test('returns true', () {
        expect(unmountComponentAtNodeReturnValue, isTrue);
      });
    });

    test('returns false when called on a mountNode that does not have a mounted component', () {
      expect(react_dom.unmountComponentAtNode(mountNode), isFalse);
    });
  });
}
