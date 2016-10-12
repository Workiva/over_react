library test_util_dom_util_test;

import 'dart:html';

import 'package:test/test.dart';
import '../test_util/test_util.dart';
import 'package:over_react/over_react.dart';

/// Main entry point for DomUtil testing
main() {
  test('triggerTransitionEnd correctly dispatches a transitionend event', () async {
    var flag = false;

    document.body.onTransitionEnd.listen((Event event) {
      flag = true;
    });

    await triggerTransitionEnd(document.body);

    expect(flag, isTrue);
  });

  group('triggerDocumentClick correctly dispatches a click event', () {
    var flag;

    setUp((){
      flag = false;
    });

    test('when the target is attached to the document', () {
      var renderedInstance = renderAttachedToDocument((Dom.div()..onClick = ((_) => flag = true))());

      triggerDocumentClick(findDomNode(renderedInstance));

      expect(flag, isTrue);

      tearDownAttachedNodes();
    });

    test('and throws when the target is not attached to the document', () {
      var renderedInstance = render((Dom.div()..onClick = ((_) => flag = true))());

      expect(() => triggerDocumentClick(findDomNode(renderedInstance)), throwsArgumentError);
      expect(flag, isFalse);
    });
  });

  group('triggerFocus correctly dispatches a focus event', () {
    var flag;

    setUp((){
      flag = false;
    });

    test('when the target is attached to the document', () async {
      var renderedInstance = renderAttachedToDocument((Dom.div()
        ..onFocus = ((_) => flag = true)
        ..tabIndex = '1'
      )());

      await triggerFocus(findDomNode(renderedInstance));

      expect(flag, isTrue);

      tearDownAttachedNodes();
    });

    test('and throws when the target is not attached to the document', () {
      var renderedInstance = render((Dom.div()..onFocus = ((_) => flag = true))());

      expect(() => triggerFocus(findDomNode(renderedInstance)), throwsArgumentError);
      expect(flag, isFalse);
    });
  });
}
