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

import 'dart:html';

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

  group('closest', () {
    group('returns the closest node that matches the given selector', () {
      test('when the child matches the target selector in addition to its parent', () {
        var parent = new DivElement()..className = 'target-class';
        var child = new DivElement()..className = 'target-class';
        parent.append(child);

        expect(closest(child, '.target-class'), child);
      });

      test('when the parent matches the target selector in addition to its grandparent', () {
        var grandparent = new DivElement()..className = 'target-class';
        var parent = new DivElement()..className = 'target-class';
        var child = new DivElement();
        grandparent.append(parent);
        parent.append(child);

        expect(closest(child, '.target-class'), parent);
      });

      test('when only the granparent matches the target selector', () {
        var grandparent = new DivElement()..className = 'target-class';
        var parent = new DivElement();
        var child = new DivElement();
        grandparent.append(parent);
        parent.append(child);

        expect(closest(child, '.target-class'), grandparent);
      });

      test('when an `upperBound` is set that includes the matching ancestor', () {
        var grandparent = new DivElement()..className = 'target-class';
        var parent = new DivElement();
        var child = new DivElement();
        grandparent.append(parent);
        parent.append(child);

        expect(closest(child, '.target-class', upperBound: grandparent), grandparent);
      });

      test('when an `upperBound` is set the same as `lowerBound`, which matches', () {
        var element = new DivElement()..className = 'target-class';
        expect(closest(element, '.target-class', upperBound: element), element);
      });
    });

    group('returns null', () {
      test('when there are no matching elements', () {
        var grandparent = new DivElement();
        var parent = new DivElement();
        var child = new DivElement();
        grandparent.append(parent);
        parent.append(child);

        expect(closest(child, '.target-class'), isNull);
      });

      test('when an `upperBound` is set to exclude any matching elements', () {
        var grandparent = new DivElement()..className = 'target-class';
        var parent = new DivElement();
        var child = new DivElement();
        grandparent.append(parent);
        parent.append(child);

        expect(closest(child, '.target-class', upperBound: parent), isNull);
      });
    });
  });

  group('getActiveElement returns the correct value when the active element is', () {
    test('a valid element other than document.body', () async {
      var activeElement = new DivElement()..tabIndex = 1;
      document.body.children.add(activeElement);

      await triggerFocus(activeElement);

      expect(getActiveElement(), activeElement);
      activeElement.remove();
    });

    test('document.body', () {
      document.body.focus();

      expect(getActiveElement(), isNull);
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
