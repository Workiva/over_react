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

library dom_util_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

import '../../test_util/test_util.dart';

/// Main entry point for DomUtil testing
main() {
  group('isOrContains returns', () {
    group('true when', () {
      test('root is the other element', () {
        var rootNode = renderAndGetDom(Dom.div());

        expect(isOrContains(rootNode, rootNode), isTrue);
      });

      test('root contains the other element', () {
        var rootInstance = render(DomTest());
        var rootNode = findDomNode(rootInstance);
        var otherNode = getDomByTestId(rootInstance, 'innerComponent');

        expect(isOrContains(rootNode, otherNode), isTrue);
      });
    });

    group('false when', () {
      test('root is null', () {
        var otherNode = renderAndGetDom(Dom.div()());

        expect(isOrContains(null, otherNode), isFalse);
      });

      test('other is null', () {
        var rootNode = renderAndGetDom(Dom.div()());

        expect(isOrContains(rootNode, null), isFalse);
      });

      test('root and other is null', () {
        expect(isOrContains(null, null), isFalse);
      });

      test('root is not, or does not contain, the other element', () {
        var rootNode = renderAndGetDom(Dom.div()());
        var otherNode = renderAndGetDom(Dom.div()());

        expect(isOrContains(rootNode, otherNode), isFalse);
      });
    });
  });
}

@Factory()
UiFactory<DomTestProps> DomTest;

@Props()
class DomTestProps extends UiProps {}

@Component()
class DomTestComponent extends UiComponent<DomTestProps> {
  @override
  render() {
    return Dom.div()(
      (Dom.div()..addTestId('innerComponent'))()
    );
  }
}
