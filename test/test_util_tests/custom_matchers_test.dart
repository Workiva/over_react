library custom_matchers_test;

import 'dart:html';

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';

/// Main entry point for CustomMatchers testing
main() {
  group('CustomMatcher', () {
    Element testElement;

    setUp(() {
      testElement = new Element.div();
    });

    group('hasClasses', () {
      group('passes when', () {
        test('the element has the exact classes', () {
          testElement.className = 'class1 class2';
          shouldPass(testElement, hasClasses('class1 class2'));
        });

        test('the element has the exact classes (specified as an Iterable)', () {
          testElement.className = 'class1 class2';
          shouldPass(testElement, hasClasses(['class1', 'class2']));
        });

        test('the element has the exact classes with duplication', () {
          testElement.className = 'class1 class1 class2';
          shouldPass(testElement, hasClasses('class1 class2'));
        });

        test('the element has extraneous classes', () {
          testElement.className = 'class1 class2 class3';
          shouldPass(testElement, hasClasses('class1 class2'));
        });
      });

      group('fails when', () {
        test('the element has only some classes', () {
          testElement.className = 'class1';
          shouldFail(testElement, hasClasses('class1 class2'),
              'Expected: Element that has the classes: {class1, class2}'
              ' Actual: DivElement:<div>'
              ' Which: has className with value \'class1\' which is missing classes: {class2}'
          );
        });

        test('the element has no classes', () {
          testElement.className = '';
          shouldFail(testElement, hasClasses('class1 class2'),
              'Expected: Element that has the classes: {class1, class2}'
              ' Actual: DivElement:<div>'
              ' Which: has className with value \'\' which is missing classes: {class1, class2}'
          );
        });
      });

      test('throws an error when an invalid, non-class value is passed to the matcher', () {
        expect(() {
          hasClasses(new Object());
        }, throwsArgumentError);
      });
    });

    group('hasExactClasses', () {
      group('passes when', () {
        test('the element has the exact classes', () {
          testElement.className = 'class1 class2';
          shouldPass(testElement, hasExactClasses('class1 class2'));
        });

        test('the element has the exact classes (specified as an Iterable)', () {
          testElement.className = 'class1 class2';
          shouldPass(testElement, hasExactClasses(['class1', 'class2']));
        });
      });

      group('fails when', () {
        test('the element has the exact classes with duplication', () {
          testElement.className = 'class1 class1 class2';
          shouldFail(testElement, hasExactClasses('class1 class2'),
              'Expected: Element that has ONLY the classes: {class1, class2}'
              ' Actual: DivElement:<div>'
              ' Which: has className with value \'class1 class1 class2\' which has extraneous classes: [class1]'
          );
        });

        test('the element has extraneous classes', () {
          testElement.className = 'class1 class2 class3';
          shouldFail(testElement, hasExactClasses('class1 class2'),
              'Expected: Element that has ONLY the classes: {class1, class2}'
              ' Actual: DivElement:<div>'
              ' Which: has className with value \'class1 class2 class3\' which has extraneous classes: [class3]'
          );
        });

        test('the element has only some classes', () {
          testElement.className = 'class1';
          shouldFail(testElement, hasExactClasses('class1 class2'),
              'Expected: Element that has ONLY the classes: {class1, class2}'
              ' Actual: DivElement:<div>'
              ' Which: has className with value \'class1\' which is missing classes: {class2}'
          );
        });

        test('the element has no classes', () {
          testElement.className = '';
          shouldFail(testElement, hasExactClasses('class1 class2'),
              'Expected: Element that has ONLY the classes: {class1, class2}'
              ' Actual: DivElement:<div>'
              ' Which: has className with value \'\' which is missing classes: {class1, class2}'
          );
        });
      });

      test('throws an error when an invalid, non-class value is passed to the matcher', () {
        expect(() {
          hasExactClasses(new Object());
        }, throwsArgumentError);
      });
    });

    group('excludesClasses', () {
      group('passes when', () {
        test('the element has none of the excluded classes', () {
          testElement.className = 'class1';
          shouldPass(testElement, excludesClasses('class2 class3'));
        });
      });

      group('fails when', () {
        test('the element has some of the excluded classes', () {
          testElement.className = 'class1 class2';
          shouldFail(testElement, excludesClasses('class2 class3'),
            'Expected: Element that does not have the classes: {class2, class3}'
            ' Actual: DivElement:<div>'
            ' Which: has className with value \'class1 class2\' which has unwanted classes: {class2}'
          );
        });

        test('the element has some of the excluded classes (specified as an Iterable)', () {
          testElement.className = 'class1 class2';
          shouldFail(testElement, excludesClasses(['class2', 'class3']),
            'Expected: Element that does not have the classes: {class2, class3}'
            ' Actual: DivElement:<div>'
            ' Which: has className with value \'class1 class2\' which has unwanted classes: {class2}'
          );
        });

        test('the element has all of the excluded classes', () {
          testElement.className = 'class1 class2 class3';
          shouldFail(testElement, excludesClasses('class2 class3'),
              'Expected: Element that does not have the classes: {class2, class3}'
              ' Actual: DivElement:<div>'
              ' Which: has className with value \'class1 class2 class3\' which has unwanted classes: {class2, class3}'
          );
        });
      });

      test('throws an error when an invalid, non-class value is passed to the matcher', () {
        expect(() {
          excludesClasses(new Object());
        }, throwsArgumentError);
      });
    });

    group('hasAttr', () {
      test('should pass when the element has the attribute set to the correct value', () {
        testElement.setAttribute('index', '1');
        shouldPass(testElement, hasAttr('index', '1'));
      });

      test('should fail when the element has the attribute set to the wrong value', () {
        testElement.setAttribute('index', '-1');
        shouldFail(testElement, hasAttr('index', '1'),
            'Expected: Element with "index" attribute that equals \'1\''
            ' Actual: DivElement:<div> Which: has attributes with value \'-1\' which is different.'
            ' Expected: 1'
            ' Actual: -1'
            ' ^ Differ at offset 0'
        );
      });
    });

    group('hasNodeName', () {
      test('should pass when the element has the nodeName', () {
        shouldPass(testElement, hasNodeName('DIV'));
        shouldPass(testElement, hasNodeName('div'));
      });

      test('should fail when the element has a different nodeName', () {
        shouldFail(testElement, hasNodeName('SPAN'),
            'Expected: Element with nodeName that is \'SPAN\' ignoring case'
            ' Actual: DivElement:<div>'
            ' Which: has nodeName with value \'DIV\''
        );
        shouldFail(testElement, hasNodeName('span'),
            'Expected: Element with nodeName that is \'span\' ignoring case'
            ' Actual: DivElement:<div>'
            ' Which: has nodeName with value \'DIV\''
        );
      });
    });

    group('isFocused:', () {
      group('attached node:', () {
        List<Element> allAttachedNodes = [];
        Element makeAttachedNode() {
          var node = new DivElement()..tabIndex = 1;
          document.body.append(node);

          allAttachedNodes.add(node);

          return node;
        }

        Element attachedNode;

        setUp(() {
          attachedNode = makeAttachedNode();
        });

        tearDown(() {
          allAttachedNodes.forEach((node) => node.remove());
          allAttachedNodes.clear();
        });

        test('passes when an attached node is focused', () {
          attachedNode.focus();
          shouldPass(attachedNode, isFocused);
        });

        test('fails when the node is not focused', () {
          shouldFail(attachedNode, isFocused,
              contains('Which: is not focused; there is no element currently focused')
          );
        });

        test('fails when the node is not focused, but another node is instead', () {
          var otherNode = makeAttachedNode();
          otherNode.focus();

          shouldFail(attachedNode, isFocused,
              contains('Which: is not focused; the currently focused element is ')
          );

          otherNode.remove();
        });
      });

      group('provides a useful failure message when', () {
        test('the node is not attached to the DOM, and thus cannot be focused', () {
          var detachedNode = new DivElement();
          shouldFail(detachedNode, isFocused, contains(
              'Which: is not attached to the document, and thus cannot be focused.'
              ' If testing with React, you can use `renderAttachedToDocument`.'
          ));
        });

        test('the matched item is not an element', () {
          shouldFail(null, isFocused,
              contains('Which: is not a valid Element.')
          );
        });
      });
    });
  });
}

/// Utility for asserting that [matcher] will fail on [value].
///
/// Copyright (c) 2012, the Dart project authors.
void shouldFail(value, Matcher matcher, expected) {
  var failed = false;
  try {
    expect(value, matcher);
  } on TestFailure catch (err) {
    failed = true;

    var _errorString = err.message;

    if (expected is String) {
      expect(_errorString, equalsIgnoringWhitespace(expected));
    } else {
      expect(_errorString.replaceAll('\n', ''), expected);
    }
  }

  expect(failed, isTrue, reason: 'Expected to fail.');
}

/// Utility for asserting that [matcher] will pass on [value].
///
/// Copyright (c) 2012, the Dart project authors.
void shouldPass(value, Matcher matcher) {
  expect(value, matcher);
}
