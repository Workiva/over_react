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
      var shallowInstance = renderShallow(Test()());
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
      test('the topmost JsObject that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div()(
          (Dom.div()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('value'))('Nested Descendant')
          )
        ));

        var descendant = getByTestId(renderedInstance, 'value');

        expect(findDomNode(descendant).text, equals('First Descendant'));
      });

      test('the topmost JsObject that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Dom.div()(
          (Dom.div()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(findDomNode(descendant).text, equals('Nested Descendant'));
      });

      test('the topmost JsObject that has the `data-test-id` prop set to \'null\' when the user searches for \'null\'', () {
        var renderedInstance = render(Dom.div()(
          (Dom.div()..addTestId('null'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('null'))('Nested Descendant')
          )
        ));

        var descendant = getByTestId(renderedInstance, 'null');

        expect(findDomNode(descendant).text, equals('First Descendant'));
      });

      group('the topmost JsObject that has the appropriate value for the `data-test-id` prop key when cloned, a testId is added, and then', () {
        test('the old testId is called', () {
          var instance = (Dom.div()..addTestId('testId1'))('Nested Descendant');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(Dom.div()(
            clonedInstance,
            Dom.div()('Nested Descendant 2')
          ));

          var descendant = getByTestId(renderedInstance, 'testId1');

          expect(findDomNode(descendant).text, equals('Nested Descendant'));
        });

        test('the new testId is called', () {
          var instance = (Dom.div()..addTestId('testId1'))('Nested Descendant');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(Dom.div()(
            clonedInstance,
            Dom.div()('Nested Descendant 2')
          ));

          var descendant = getByTestId(renderedInstance, 'testId2');

          expect(findDomNode(descendant).text, equals('Nested Descendant'));
        });
      });

      group('the topmost JsObject that has the appropriate value for a custom prop key when cloned and', () {
        test('the old testId is called', () {
          var instance = (Dom.div()..addTestId('testId1', key: 'data-custom-id'))('Nested Descendant');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(Dom.div()(
            clonedInstance,
            Dom.div()('Nested Descendant 2')
          ));

          var descendant = getByTestId(renderedInstance, 'testId1', key: 'data-custom-id');

          expect(findDomNode(descendant).text, equals('Nested Descendant'));
        });

        test('the new testId is called', () {
          var instance = (Dom.div()..addTestId('testId1', key: 'data-custom-id'))('Nested Descendant');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(Dom.div()(
            clonedInstance,
            Dom.div()('Nested Descendant 2')
          ));

          var descendant = getByTestId(renderedInstance, 'testId2', key: 'data-custom-id');

          expect(findDomNode(descendant).text, equals('Nested Descendant'));
        });
      });

      test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div());

        var descendant = getByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });

      test('null if the user searches for a test ID of \'null\' when no test ID is set', () {
        var renderedInstance = render(Dom.div());

        var descendant = getByTestId(renderedInstance, 'null');

        expect(descendant, isNull);
      });

      test('null if the user searches for a test ID of `null` when the test ID is set to \'null\'', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('null'))()
        ));

        var descendant = getByTestId(renderedInstance, null);

        expect(descendant, isNull);
      });
    });

    group('getDomByTestId returns', () {
      test('the topmost Element that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div()(
          (Dom.div()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('value'))('Nested Descendant')
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'value');

        expect(descendant, findDomNode(renderedInstance).children[0]);
      });

      test('the topmost Element that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Dom.div()(
          (Dom.div()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(descendant, findDomNode(renderedInstance).children[1].children[0]);
      });

      test('the topmost Element that has the value \'null\' for the `data-test-id` prop key when the user searches for \'null\'', () {
        var renderedInstance = render(Dom.div()(
          (Dom.div()..addTestId('null'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('null'))
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'null');

        expect(descendant, findDomNode(renderedInstance).children[0]);
      });

      group('the topmost Element that has the appropriate value for the `data-test-id` prop key when cloned, a testId is added, and then', () {
        test('the old testId is called', () {
          var instance = (Dom.div()..addTestId('testId1'))();
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(Dom.div()(clonedInstance));

          var descendant = getDomByTestId(renderedInstance, 'testId1');

          expect(descendant, findDomNode(renderedInstance).children[0]);
        });

        test('the new testId is called', () {
          var instance = (Dom.div()..addTestId('testId1'))();
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(Dom.div()(clonedInstance));

          var descendant = getDomByTestId(renderedInstance, 'testId2');

          expect(descendant, findDomNode(renderedInstance).children[0]);
        });
      });

      group('the topmost Element that has the appropriate value for the custom prop when cloned and', () {
        test('the old testId is called', () {
          var instance = (Dom.div()..addTestId('testId1', key: 'data-custom-id'))();
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(Dom.div()(clonedInstance));

          var descendant = getDomByTestId(renderedInstance, 'testId1', key: 'data-custom-id');

          expect(descendant, findDomNode(renderedInstance).children[0]);
        });

        test('the new testId is called', () {
          var instance = (Dom.div()..addTestId('testId1', key: 'data-custom-id'))();
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(Dom.div()(clonedInstance));

          var descendant = getDomByTestId(renderedInstance, 'testId2', key: 'data-custom-id');

          expect(descendant, findDomNode(renderedInstance).children[0]);
        });
      });

      test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div());

        var descendant = getDomByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });

      test('null if the user searches for \'null\' when no test ID is set', () {
        var renderedInstance = render(Dom.div());

        var descendant = getDomByTestId(renderedInstance, 'null');

        expect(descendant, isNull);
      });

      test('null if the user searches for `null` when a test ID is set to \'null\'', () {
        var renderedInstance = (Dom.div()(
          (Test()..addTestId('null'))()
        ));

        var descendant = getDomByTestId(renderedInstance, null);

        expect(descendant, isNull);
      });
    });

    group('getComponentByTestId returns', () {
      test('the topmost react.Component that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Test()..addTestId('value'))('Nested Descendant')
          )
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value');

        expect(descendant, getDartComponent(getByTestId(renderedInstance, 'value')));
      });

      test('the topmost react.Component that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Test()..addTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(descendant, getDartComponent(getByTestId(renderedInstance, 'value', key: 'data-custom-id')));
      });

      test('the topmost react.Component that has the value \'null\' for the `data-test-id` prop key when the user searches for \'null\'', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('null'))('First Descendant'),
          Dom.div()(
            (Test()..addTestId('null'))('Nested Descendant')
          )
        ));

        var descendant = getComponentByTestId(renderedInstance, 'null');

        expect(descendant, getDartComponent(getByTestId(renderedInstance, 'null')));
      });

      group('the topmost react.Component that has the appropriate value for the `data-test-id` prop key when cloned, a testId is added, and', () {
        test('the old testId is called', () {
          var instance = (Test()..addTestId('testId1'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(clonedInstance);

          var descendant = getComponentByTestId(renderedInstance, 'testId1');

          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId1')));
        });

        test('the new testId is called', () {
          var instance = (Test()..addTestId('testId1'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(clonedInstance);

          var descendant = getComponentByTestId(renderedInstance, 'testId2');

          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId2')));
        });
      });

      group('the topmost react.Component that has the appropriate value for a custom prop key when cloned and', () {
        test('the old testId is called', () {
          var instance = (Test()..addTestId('testId1', key: 'data-custom-id'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(clonedInstance);

          var descendant = getComponentByTestId(renderedInstance, 'testId1', key: 'data-custom-id');

          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId1', key: 'data-custom-id')));
        });

        test('the old testId is called', () {
          var instance = (Test()..addTestId('testId1', key: 'data-custom-id'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(clonedInstance);

          var descendant = getComponentByTestId(renderedInstance, 'testId2', key: 'data-custom-id');

          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId2', key: 'data-custom-id')));
        });
      });

      test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('otherValue'))()
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });

      test('null if the user searches for \'null\' when no test ID is set', () {
        var renderedInstance = render(Dom.div()(
          Test()()
        ));

        var descendant = getComponentByTestId(renderedInstance, 'null');

        expect(descendant, isNull);
      });

      test('null if the user searches for `null` when a test ID is set to \'null\'', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('null'))()
        ));

        var descendant = getComponentByTestId(renderedInstance, null);

        expect(descendant, isNull);
      });
    });

    group('getPropsByTestId returns', () {
      test('the props map of the topmost JsObject that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div()(
          (Test()
            ..id = 'test_id'
            ..addTestId('value')
          )('First Descendant'),
          Dom.div()(
            (Test()..addTestId('value'))('Nested Descendant')
          )
        ));

        var props = getPropsByTestId(renderedInstance, 'value');

        expect(props, equals(getProps(getByTestId(renderedInstance, 'value'))));
      });

      test('the props map of the topmost JsObject that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Test()
              ..id = 'test_id'
              ..addTestId('value', key: 'data-custom-id')
            )('Nested Descendant')
          )
        ));

        var props = getPropsByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(props, equals(getProps(getByTestId(renderedInstance, 'value', key: 'data-custom-id'))));
      });

      test('the props map of the topmost JsObject that has the value \'null\' for the `data-test-id` prop key when the user searches for \'null\'', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('null'))('First Descendant'),
          Dom.div()(
            (Test()..addTestId('null'))('Nested Descendant')
          )
        ));

        var props = getPropsByTestId(renderedInstance, 'null');

        expect(props, equals(getProps(getByTestId(renderedInstance, 'null'))));
      });

      group('the props map of the topmost JsObject that has the appropriate value for the `data-test-id` prop key when cloned, a testId is added, and', () {
        test('the old testId is called', () {
          var instance = (Test()..addTestId('testId1'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(clonedInstance);

          var props = getPropsByTestId(renderedInstance, 'testId1');

          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId1'))));
        });

        test('the new testId is called', () {
          var instance = (Test()..addTestId('testId1'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2'));
          var renderedInstance = render(clonedInstance);

          var props = getPropsByTestId(renderedInstance, 'testId2');

          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId2'))));
        });
      });

      group('the props map of the topmost JsObject that has the appropriate value for a custom prop key when cloned and', () {
        test('the old testId is called', () {
          var instance = (Test()..addTestId('testId1', key: 'data-custom-id'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(clonedInstance);

          var props = getPropsByTestId(renderedInstance, 'testId1', key: 'data-custom-id');

          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId1', key: 'data-custom-id'))));
        });

        test('the props map of the topmost JsObject that has the appropriate value for a custom prop key when cloned and the new testId is called', () {
          var instance = (Test()..addTestId('testId1', key: 'data-custom-id'))('Nonclone');
          var clonedInstance = cloneElement(instance, domProps(getProps(instance))..addTestId('testId2', key: 'data-custom-id'));
          var renderedInstance = render(clonedInstance);

          var props = getPropsByTestId(renderedInstance, 'testId2', key: 'data-custom-id');

          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId2', key: 'data-custom-id'))));
        });
      });

      test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('otherValue'))()
        ));

        var props = getPropsByTestId(renderedInstance, 'value');

        expect(props, isNull);
      });

      test('null if the user searches for \'null\' when no test ID is set', () {
        var renderedInstance = render(Dom.div()(
          Test()()
        ));

        var props = getPropsByTestId(renderedInstance, 'null');

        expect(props, isNull);
      });

      test('null if the user searches for `null` when a test ID is set to \'null\'', () {
        var renderedInstance = render(Dom.div()(
          (Test()..addTestId('null'))()
        ));

        var props = getPropsByTestId(renderedInstance, null);

        expect(props, isNull);
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
