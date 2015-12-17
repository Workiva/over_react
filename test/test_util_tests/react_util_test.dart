library react_util_test;

import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

/// Main entry point for ReactUtil testing
main() {
  group('ReactUtil', () {
    test('renderShallow renders a shallow instance of a component', () {
      var shallowInstance = renderShallow(ShallowTest()());
      expect(shallowInstance['type'], 'div', reason: 'should be the div ReactElement returned by render()');
      expect(shallowInstance['props']['isRenderResult'], isTrue, reason: 'should be the div ReactElement returned by render()');
    });

    test('renderAttachedToDocument renders the component into the document and [renderAttachedToDocument] removes those attached nodes', () {
      expect(document.body.children, isEmpty);

      var renderedInstance = renderAttachedToDocument(Dom.div());

      expect(document.body.children[0].children.contains(findDomNode(renderedInstance)), isTrue,
          reason: 'The component should have been rendered into the container div.');

      tearDownAttachedNodes();

      expect(isMounted(renderedInstance), isFalse,
          reason: 'The React instance should have been unmounted.');

      expect(document.body.children, isEmpty,
          reason: 'All attached mount points should have been removed.');
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

    group('getByTestId returns', () {
      test('a JsObject that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstace = render(Dom.div()(
          (Dom.div()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Dom.div()..testId = 'value')('Nested Descendant')
          )
        ));

        var descendant = getByTestId(renderedInstace, 'value');

        expect(findDomNode(descendant).text, equals('First Descendant'));
      });

      test('null if no decendant has the appropiate value for the `data-test-id` prop key', () {
        var renderedInstace = render(Dom.div());

        var descendant = getByTestId(renderedInstace, 'value');

        expect(descendant, isNull);
      });
    });

    group('getDomByTestId returns', () {
      test('an Element that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstace = render(Dom.div()(
          (Dom.div()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Dom.div()..testId = 'value')('Nested Descendant')
          )
        ));

        var descendant = getDomByTestId(renderedInstace, 'value');

        expect(descendant, findDomNode(renderedInstace).children[0]);
      });

      test('null if no decendant has the appropiate value for the `data-test-id` prop key', () {
        var renderedInstace = render(Dom.div());

        var descendant = getDomByTestId(renderedInstace, 'value');

        expect(descendant, isNull);
      });
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

    group('isMounted', () {
      test('returns true for a component that has been mounted', () {
        var mountNode = new DivElement();
        var renderedInstance = react.render(react.div({}), mountNode);
        expect(isMounted(renderedInstance), isTrue);
      });

      test('returns false for a component that has been umounted', () {
        var mountNode = new DivElement();
        var renderedInstance = react.render(react.div({}), mountNode);
        react.unmountComponentAtNode(mountNode);
        expect(isMounted(renderedInstance), isFalse);
      });
    });

    group('unmount:', () {
      group('unmounts a React instance specified', () {
        test('by its rendered instance', () {
          var mountNode = new DivElement();
          var instance = react.render(react.div({}), mountNode);
          expect(isMounted(instance), isTrue);

          unmount(instance);
          expect(isMounted(instance), isFalse);
        });

        test('by its mount node', () {
          var mountNode = new DivElement();
          var instance = react.render(react.div({}), mountNode);
          expect(isMounted(instance), isTrue);

          unmount(mountNode);
          expect(isMounted(instance), isFalse);
        });
      });

      group('gracefully handles', () {
        test('`null`', () {
          expect(() {
            unmount(null);
          }, isNot(throws));
        });

        test('a non-mounted React instance', () {
          var mountNode = new DivElement();
          var instance = react.render(react.div({}), mountNode);
          react.unmountComponentAtNode(mountNode);

          expect(isMounted(instance), isFalse);

          expect(() {
            unmount(instance);
          }, isNot(throws));
        });
      });

      test('throws when an invalid value is passed in', () {
        expect(() {
          unmount(new Object());
        }, throwsArgumentError);
      });
    });
  });
}

@Factory()
UiFactory<ShallowTestProps> ShallowTest;

@Props()
class ShallowTestProps extends UiProps {}

@Component()
class ShallowTestComponent extends UiComponent<ShallowTestProps> {
  render() => (Dom.div()..addProp('isRenderResult', true))();
}
