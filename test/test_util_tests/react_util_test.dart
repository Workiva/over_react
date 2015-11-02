library react_util_test;

import 'dart:html';

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Main entry point for ReactUtil testing
main() {
  group('ReactUtil', () {
    test('renderAttachedToDocument renders the component into the document', () {
      expect(document.body.children, isEmpty);

      var renderedInstance = renderAttachedToDocument(Dom.div());

      expect(document.body.children[0].children.contains(findDomNode(renderedInstance)), isTrue,
          reason: 'The component should have been rendered into the container div.');
    });

    group('getRef', () {
      test('returns the JsObject if the ref exists', () {
        var renderedInstance = render(RenderingContainerComponentFactory({'renderer': Dom.div()..ref = 'childDiv'}));

        var ref = getRef(renderedInstance, 'childDiv');
        expect(ref, isNotNull);
      });

      test('returns null if the ref doesn\'t exist', () {
        var renderedInstance = render(RenderingContainerComponentFactory({'renderer': Dom.div()}));

        var ref = getRef(renderedInstance, 'childDiv');
        expect(ref, isNull);
      });
    });

    test('click simulates a click on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onClick = (evt) => flag = true)());

      click(renderedInstance);

      expect(flag, isTrue);
    });

    test('simulateMouseEnter simulates a MouseEnter on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onMouseEnter = (evt) => flag = true));

      simulateMouseEnter(findDomNode(renderedInstance));

      expect(flag, isTrue);
    });

    test('simulateMouseLeave simulates a MouseLeave on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onMouseLeave = (evt) => flag = true));

      simulateMouseLeave(findDomNode(renderedInstance));

      expect(flag, isTrue);
    });

    test('findDescendantsWithProp returns the descendants with the propKey', () {
      var renderedInstance = render(Dom.div()([
        (Dom.div()..disabled = true)(),
        Dom.div()([
          (Dom.div()..disabled = true)()
        ])
      ]));

      var descendants = findDescendantsWithProp(renderedInstance, 'disabled');
      expect(descendants.length, equals(2));
    });

    test('setProps sets a subset of a component\'s props', () {
      var renderedInstance = render(Dom.div()..tabIndex = -1);

      setProps(renderedInstance, {'className': 'class1'});

      expect(getProps(renderedInstance)['className'], equals('class1'));
      expect(getProps(renderedInstance)['tabIndex'], equals(-1));
    });
  });
}
