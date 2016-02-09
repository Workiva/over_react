library dom_util_test;

import 'dart:html';
import 'dart:js';

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../../wsd_test_util/key_down_util.dart';

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

  group('getJsForm returns', () {
    test('JsObject HTMLFormElement when given a dart FormElement', () {
      FormElement dartForm = new FormElement();
      var HTMLFormElement = getJsForm(dartForm);

      // Assert that it is a JsObject
      expect(HTMLFormElement is JsObject, isTrue);
      // Check for the existence of a known key on the HTMLFormElement object
      expect(HTMLFormElement['elements'], isNotNull);
    });
  });

  group('getFormElements returns', () {
    JsObject renderedInstance;
    FormElement formElementNode;
    var formElements;

    tearDown(() {
      renderedInstance = null;
      formElementNode = null;
      formElements = null;
    });

    group('a List', () {
      test('that is empty when no children `Element`s exist', () {
        formElementNode = renderAndGetDom(Dom.form()());

        // The rest of this test is pointless if this expectation is not met
        expect(formElementNode is FormElement, isTrue);

        formElements = getFormElements(formElementNode);

        expect(formElements is List, isTrue);
        expect(formElements, isEmpty);
      });

      test('that is empty when no children `InputElement`s exist', () {
        formElementNode = renderAndGetDom(Dom.form()(
          Dom.div()(),
          Dom.div()()
        ));

        // The rest of this test is pointless if this expectation is not met
        expect(formElementNode is FormElement, isTrue);

        formElements = getFormElements(formElementNode);

        expect(formElements is List, isTrue);
        expect(formElements, isEmpty);
      });

      group('of descendant form control elements', () {
        setUp(() {
          renderedInstance = render(Dom.form()(
            (Dom.input()..testId = 'firstInput')(),
            (Dom.input()..testId = 'secondInput')()
          ));

          formElementNode = findDomNode(renderedInstance);

          // The rest of the tests are pointless if this expectation is not met
          expect(formElementNode is FormElement, isTrue);

          formElements = getFormElements(formElementNode);

          expect(formElements is List, isTrue);
        });

        test('of the correct length', () {
          expect(formElements.length, equals(2));
        });

        test('with the expected values', () {
          expect(formElements, equals([
            getDomByTestId(renderedInstance, 'firstInput'),
            getDomByTestId(renderedInstance, 'secondInput'),
          ]));
        });
      });
    });
  });
}

@Factory()
UiFactory<DomTestProps> DomTest;

@Props()
class DomTestProps extends UiProps with HitAreaPropsMixin {}

@Component()
class DomTestComponent extends UiComponent<DomTestProps> with HitAreaMixin<DomTestProps> {
  @override
  Map getDefaultProps() => (newProps()
    ..addProps(HitAreaMixin.defaultProps)
  );

  @override
  render() {
    return Dom.div()(
      (Dom.div()..testId = 'innerComponent')()
    );
  }
}
