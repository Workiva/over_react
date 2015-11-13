library dom_util_test;

import 'dart:html';

import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_components.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Main entry point for DomUtil testing
main() {
  test('triggerTransitionEnd correctly dispatches a transitionEnd event', () async {
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

    test('expect when the target is not attached to the document', () {
      var renderedInstance = render((Dom.div()..onClick = ((_) => flag = true))());

      expect(() => triggerDocumentClick(findDomNode(renderedInstance)), throws);
      expect(flag, isFalse);
    });
  });
}
