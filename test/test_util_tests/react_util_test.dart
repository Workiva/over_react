library react_util_test;

import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../wsd_test_util/wrapper_component.dart';

/// Main entry point for ReactUtil testing
main() {
  group('ReactUtil', () {
    test('renderShallow renders a shallow instance of a component', () {
      var shallowInstance = renderShallow(Test()());
      expect(shallowInstance.type, 'div', reason: 'should be the div ReactElement returned by render()');
      expect(getProps(shallowInstance), containsPair('isRenderResult', true), reason: 'should be the div ReactElement returned by render()');
    });

    test('renderAttachedToDocument renders the component into the document and [renderAttachedToDocument] removes those attached nodes', () {
      expect(document.body.children, isEmpty);

      var renderedInstance = renderAttachedToDocument(Wrapper());

      expect(document.body.children[0].children.contains(findDomNode(renderedInstance)), isTrue,
          reason: 'The component should have been rendered into the container div.');

      tearDownAttachedNodes();

      expect(isMounted(renderedInstance), isFalse,
          reason: 'The React instance should have been unmounted.');

      expect(document.body.children, isEmpty,
          reason: 'All attached mount points should have been removed.');
    });

    group('getRef', () {
      test('returns the ref if it exists', () {
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

    test('keyDown simulates a keyDown on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onKeyDown = (evt) => flag = true)());

      keyDown(renderedInstance);

      expect(flag, isTrue);
    });

    test('keyUp simulates a keyDown on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onKeyUp = (evt) => flag = true)());

      keyUp(renderedInstance);

      expect(flag, isTrue);
    });

    test('keyPress simulates a keyPress on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onKeyPress = (evt) => flag = true)());

      keyPress(renderedInstance);

      expect(flag, isTrue);
    });

    test('mouseMove simulates a mouseMove on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onMouseMove = (evt) => flag = true)());

      mouseMove(renderedInstance);

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
      test('the topmost descendant that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Dom.div()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Dom.div()..testId = 'value')('Nested Descendant')
          )
        ));

        var descendant = getByTestId(renderedInstance, 'value');

        expect(findDomNode(descendant).text, equals('First Descendant'));
      });

      test('the topmost descendant that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Wrapper()(
          (Dom.div()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Dom.div()..setTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(findDomNode(descendant).text, equals('Nested Descendant'));
      });

      test('null if no decendant has the appropiate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper());

        var descendant = getByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });
    });

    group('getDomByTestId returns', () {
      test('the topmost ELement that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Dom.div()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Dom.div()..testId = 'value')('Nested Descendant')
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'value');

        expect(descendant, findDomNode(renderedInstance).children[0]);
      });

      test('the topmost Element that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Wrapper()(
          (Dom.div()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Dom.div()..setTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(descendant, findDomNode(renderedInstance).children[1].children[0]);
      });

      test('null if no decendant has the appropiate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper());

        var descendant = getDomByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });
    });

    group('getComponentByTestId returns', () {
      test('the topmost react.Component that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Test()..testId = 'value')('Nested Descendant')
          )
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value');

        expect(descendant, getDartComponent(getByTestId(renderedInstance, 'value')));
      });

      test('the topmost react.Component that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Test()..setTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(descendant, getDartComponent(getByTestId(renderedInstance, 'value', key: 'data-custom-id')));
      });

      test('null if no decendant has the appropiate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..testId = 'otherValue')()
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });
    });

    group('getPropsByTestId returns', () {
      test('the props map of the topmost descendant that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()
            ..id = 'test_id'
            ..testId = 'value'
          )('First Descendant'),
          Dom.div()(
            (Test()..testId = 'value')('Nested Descendant')
          )
        ));

        var props = getPropsByTestId(renderedInstance, 'value');

        expect(props, equals(getProps(getByTestId(renderedInstance, 'value'))));
      });

      test('the props map of the topmost descendant that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..testId = 'value')('First Descendant'),
          Dom.div()(
            (Test()
              ..id = 'test_id'
              ..setTestId('value', key: 'data-custom-id')
            )('Nested Descendant')
          )
        ));

        var props = getPropsByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(props, equals(getProps(getByTestId(renderedInstance, 'value', key: 'data-custom-id'))));
      });

      test('null if no decendant has the appropiate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..testId = 'otherValue')()
        ));

        var props = getPropsByTestId(renderedInstance, 'value');

        expect(props, isNull);
      });
    });

    test('findDescendantsWithProp returns the descendants with the propKey', () {
      var renderedInstance = render(Wrapper()([
        (Dom.div()..disabled = true)(),
        Dom.div()([
          (Dom.div()..disabled = true)()
        ])
      ]));

      var descendants = findDescendantsWithProp(renderedInstance, 'disabled');
      expect(descendants.length, equals(2));
    });

    test('setProps sets a subset of a component\'s props', () {
      var renderedInstance = render(Wrapper()..tabIndex = -1);

      setProps(renderedInstance, {'className': 'class1'});

      expect(getProps(renderedInstance)['className'], equals('class1'));
      expect(getProps(renderedInstance)['tabIndex'], equals(-1));
    });

    group('unmount:', () {
      group('unmounts a React instance specified', () {
        test('by its rendered instance', () {
          var mountNode = new DivElement();
          var instance = react.render(Wrapper()(), mountNode);
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
          }, returnsNormally);
        });

        test('a non-mounted React instance', () {
          var mountNode = new DivElement();
          var instance = react.render(react.div({}), mountNode);
          react.unmountComponentAtNode(mountNode);

          expect(isMounted(instance), isFalse);

          expect(() {
            unmount(instance);
          }, returnsNormally);
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
UiFactory<TestProps> Test;

@Props()
class TestProps extends UiProps {}

@Component()
class TestComponent extends UiComponent<TestProps> {
  render() => (Dom.div()..addProp('isRenderResult', true))();
}
