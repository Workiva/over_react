library react_util_test;

import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart';
import 'package:test/test.dart';
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';

import '../wsd_test_util/test_js_component.dart';

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

    group('click', () {
      test('simulates a click on a component', () {
        var flag = false;
        var renderedInstance = render((Dom.div()..onClick = (evt) => flag = true)());

        click(renderedInstance);

        expect(flag, isTrue);
      });

      test('simulates a click on a component with additional event data', () {
        var flag = false;
        react.SyntheticMouseEvent event;
        var renderedInstance = render((Dom.div()
          ..onClick = (evt) {
            flag = true;
            event = evt;
          }
        )());

        click(renderedInstance, {'shiftKey': true, 'metaKey': true, 'button': 5});

        expect(flag, isTrue);
        expect(event.shiftKey, isTrue);
        expect(event.metaKey, isTrue);
        expect(event.button, equals(5));
      });
    });

    test('change simulates change on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onChange = (evt) => flag = true)());

      change(renderedInstance);

      expect(flag, isTrue);
    });

    test('focus simulates focus on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onFocus = (evt) => flag = true)());

      focus(renderedInstance);

      expect(flag, isTrue);
    });

    test('blur simulates blur on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onBlur = (evt) => flag = true)());

      blur(renderedInstance);

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

    test('mouseEnter simulates a mouseEnter on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onMouseEnter = (evt) => flag = true)());

      mouseEnter(renderedInstance);

      expect(flag, isTrue);
    });

    test('mouseLeave simulates a mouseLeave on a component', () {
      var flag = false;
      var renderedInstance = render((Dom.div()..onMouseLeave = (evt) => flag = true)());

      mouseLeave(renderedInstance);

      expect(flag, isTrue);
    });

    test('defaultTestIdKey is equal to the default key used by addTestId', () {
      var renderedInstance = render((Test()
        ..addTestId('testTestId')
      )());
      var props = getProps(renderedInstance);

      expect(props[defaultTestIdKey], equals('testTestId'));
    });

    group('getByTestId returns', () {
      sharedTests({bool shallow}) {
        testSpecificRender(ReactElement instance) =>
            shallow ? renderShallow(instance) : render(instance);

        group('the single descendant that has the appropriate value for the `data-test-id` prop key when it is a', () {
          const String targetFlagProp = 'data-name';

          const Map testProps = const {
            'data-test-id': 'value',
            'data-name': 'target',
          };

          test('DOM component', () {
            var renderedInstance = testSpecificRender(Wrapper()(
              (Dom.div()..addProps(testProps))()
            ));

            var descendant = getByTestId(renderedInstance, 'value');
            expect(descendant, hasProp(targetFlagProp, 'target'));
          });

          test('Dart component', () {
            var renderedInstance = testSpecificRender(Wrapper()(
              (Test()..addProps(testProps))()
            ));

            var descendant = getByTestId(renderedInstance, 'value');
            expect(descendant, hasProp(targetFlagProp, 'target'));
          });

          test('JS composite component', () {
            var renderedInstance = testSpecificRender(Wrapper()(
              testJsComponentFactory(testProps)
            ));

            var descendant = getByTestId(renderedInstance, 'value');
            expect(descendant, hasProp(targetFlagProp, 'target'));
          });
        });

        test('the topmost descendant that has the appropriate value for the `data-test-id` prop key', () {
          var renderedInstance = testSpecificRender(Wrapper()(
            (Dom.div()
              ..addTestId('value')
              ..addProp('data-name', 'First Descendant')
            )(),
            Dom.div()(
              (Dom.div()
                ..addTestId('value')
                ..addProp('data-name', 'Nested Descendant')
              )()
            )
          ));

          var descendant = getByTestId(renderedInstance, 'value');

          expect(descendant, hasProp('data-name', 'First Descendant'));
        });

        test('the topmost descendant that has the appropriate value for the custom prop key', () {
          var renderedInstance = testSpecificRender(Wrapper()(
            (Dom.div()
              ..addTestId('value')
              ..addProp('data-name', 'First Descendant')
            )(),
            Dom.div()(
              (Dom.div()
                ..addTestId('value', key: 'data-custom-id')
                ..addProp('data-name', 'Nested Descendant')
              )()
            )
          ));

          var descendant = getByTestId(renderedInstance, 'value', key: 'data-custom-id');

          expect(descendant, hasProp('data-name', 'Nested Descendant'));
        });

        test('the topmost descendant that has the `data-test-id` prop set to \'null\' when the user searches for \'null\'', () {
          var renderedInstance = testSpecificRender(Wrapper()(
            (Dom.div()
              ..addTestId('null')
              ..addProp('data-name', 'First Descendant')
            )(),
            Dom.div()(
              (Dom.div()
                ..addTestId('null')
                ..addProp('data-name', 'Nested Descendant')
              )()
            )
          ));

          var descendant = getByTestId(renderedInstance, 'null');

          expect(descendant, hasProp('data-name', 'First Descendant'));
        });

        group('the topmost descendant that has the appropriate value for the `data-test-id` prop key when cloned, a testId is added, and then', () {
          test('the old testId is called', () {
            var renderedInstance = testSpecificRender(Wrapper()(
              (Dom.div()
                ..addTestId('testId1')
                ..addTestId('testId2')
                ..addProp('data-name', 'Nested Descendant')
              )(
                Dom.div()('Nested Descendant 2')
              )
            ));

            var descendant = getByTestId(renderedInstance, 'testId1');
            expect(descendant, hasProp('data-name', 'Nested Descendant'));
          });

          test('the new testId is called', () {
            var renderedInstance = testSpecificRender(Wrapper()(
              (Dom.div()
                ..addTestId('testId1')
                ..addTestId('testId2')
                ..addProp('data-name', 'Nested Descendant')
              )(
                Dom.div()('Nested Descendant 2')
              )
            ));

            var descendant = getByTestId(renderedInstance, 'testId2');
            expect(descendant, hasProp('data-name', 'Nested Descendant'));
          });
        });

        group('the topmost descendant that has the appropriate value for a custom prop key when cloned and', () {
          test('the old testId is called', () {
            var renderedInstance = testSpecificRender(Wrapper()(
              (Dom.div()
                ..addTestId('testId1', key: 'data-custom-id')
                ..addTestId('testId2', key: 'data-custom-id')
                ..addProp('data-name', 'Nested Descendant')
              )(),
              Dom.div()('Nested Descendant 2')
            ));

            var descendant = getByTestId(renderedInstance, 'testId1', key: 'data-custom-id');
            expect(descendant, hasProp('data-name', 'Nested Descendant'));
          });

          test('the new testId is called', () {
            var renderedInstance = testSpecificRender(Wrapper()(
              (Dom.div()
                ..addTestId('testId1', key: 'data-custom-id')
                ..addTestId('testId2', key: 'data-custom-id')
                ..addProp('data-name', 'Nested Descendant')
              )(),
              Dom.div()('Nested Descendant 2')
            ));

            var descendant = getByTestId(renderedInstance, 'testId2', key: 'data-custom-id');
            expect(descendant, hasProp('data-name', 'Nested Descendant'));
          });
        });

        test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
          var renderedInstance = testSpecificRender(Wrapper()());

          var descendant = getByTestId(renderedInstance, 'value');

          expect(descendant, isNull);
        });

        test('null if the user searches for a test ID of \'null\' when no test ID is set', () {
          var renderedInstance = testSpecificRender(Wrapper()());

          var descendant = getByTestId(renderedInstance, 'null');

          expect(descendant, isNull);
        });

        test('null if the user searches for a test ID of `null` when the test ID is set to \'null\'', () {
          var renderedInstance = testSpecificRender(Wrapper()(
            (Test()..addTestId('null'))()
          ));

          var descendant = getByTestId(renderedInstance, null);

          expect(descendant, isNull);
        });
      }

      group('(rendered component)', () {
        sharedTests(shallow: false);
      });

      group('(shallow-rendered component)', () {
        sharedTests(shallow: true);
      });
    });

    group('getDomByTestId returns', () {
      test('the topmost Element that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Dom.div()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('value'))('Nested Descendant')
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'value');

        expect(descendant, findDomNode(renderedInstance).children[0]);
      });

      test('the topmost Element that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Wrapper()(
          (Dom.div()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(descendant, findDomNode(renderedInstance).children[1].children[0]);
      });

      test('the topmost Element that has the value \'null\' for the `data-test-id` prop key when the user searches for \'null\'', () {
        var renderedInstance = render(Wrapper()(
          (Dom.div()..addTestId('null'))('First Descendant'),
          Dom.div()(
            (Dom.div()..addTestId('null'))()
          )
        ));

        var descendant = getDomByTestId(renderedInstance, 'null');

        expect(descendant, findDomNode(renderedInstance).children[0]);
      });

      group('the topmost Element that has the appropriate value for the `data-test-id` prop key when cloned, a testId is added, and then', () {
        test('the old testId is called', () {
          var renderedInstance = render(Wrapper()(
            (Dom.div()
              ..addTestId('testId1')
              ..addTestId('testId2')
            )()
          ));

          var descendant = getDomByTestId(renderedInstance, 'testId1');
          expect(descendant, findDomNode(renderedInstance).children[0]);
        });

        test('the new testId is called', () {
          var renderedInstance = render(Wrapper()(
            (Dom.div()
              ..addTestId('testId1')
              ..addTestId('testId2')
            )()
          ));

          var descendant = getDomByTestId(renderedInstance, 'testId2');
          expect(descendant, findDomNode(renderedInstance).children[0]);
        });
      });

      group('the topmost Element that has the appropriate value for the custom prop when cloned and', () {
        test('the old testId is called', () {
          var renderedInstance = render(Wrapper()(
            (Dom.div()
              ..addTestId('testId1', key: 'data-custom-id')
              ..addTestId('testId2', key: 'data-custom-id')
            )()
          ));

          var descendant = getDomByTestId(renderedInstance, 'testId1', key: 'data-custom-id');
          expect(descendant, findDomNode(renderedInstance).children[0]);
        });

        test('the new testId is called', () {
          var renderedInstance = render(Wrapper()(
            (Dom.div()
              ..addTestId('testId1', key: 'data-custom-id')
              ..addTestId('testId2', key: 'data-custom-id')
            )()
          ));

          var descendant = getDomByTestId(renderedInstance, 'testId2', key: 'data-custom-id');
          expect(descendant, findDomNode(renderedInstance).children[0]);
        });
      });

      test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper());

        var descendant = getDomByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });

      test('null if the user searches for \'null\' when no test ID is set', () {
        var renderedInstance = render(Wrapper());

        var descendant = getDomByTestId(renderedInstance, 'null');

        expect(descendant, isNull);
      });

      test('null if the user searches for `null` when a test ID is set to \'null\'', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('null'))()
        ));

        var descendant = getDomByTestId(renderedInstance, null);

        expect(descendant, isNull);
      });
    });

    group('getComponentByTestId returns', () {
      test('the topmost react.Component that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Test()..addTestId('value'))('Nested Descendant')
          )
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value');

        expect(descendant, getDartComponent(getByTestId(renderedInstance, 'value')));
      });

      test('the topmost react.Component that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('value'))('First Descendant'),
          Dom.div()(
            (Test()..addTestId('value', key: 'data-custom-id'))('Nested Descendant')
          )
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value', key: 'data-custom-id');

        expect(descendant, getDartComponent(getByTestId(renderedInstance, 'value', key: 'data-custom-id')));
      });

      test('the topmost react.Component that has the value \'null\' for the `data-test-id` prop key when the user searches for \'null\'', () {
        var renderedInstance = render(Wrapper()(
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
          var renderedInstance = render((Test()
            ..addTestId('testId1')
            ..addTestId('testId2')
          )());

          var descendant = getComponentByTestId(renderedInstance, 'testId1');
          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId1')));
        });

        test('the new testId is called', () {
          var renderedInstance = render((Test()
            ..addTestId('testId1')
            ..addTestId('testId2')
          )());

          var descendant = getComponentByTestId(renderedInstance, 'testId2');
          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId2')));
        });
      });

      group('the topmost react.Component that has the appropriate value for a custom prop key when cloned and', () {
        test('the old testId is called', () {
          var renderedInstance = render((Test()
            ..addTestId('testId1', key: 'data-custom-id')
            ..addTestId('testId2', key: 'data-custom-id')
          )());

          var descendant = getComponentByTestId(renderedInstance, 'testId1', key: 'data-custom-id');
          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId1', key: 'data-custom-id')));
        });

        test('the old testId is called', () {
          var renderedInstance = render((Test()
            ..addTestId('testId1', key: 'data-custom-id')
            ..addTestId('testId2', key: 'data-custom-id')
          )());

          var descendant = getComponentByTestId(renderedInstance, 'testId2', key: 'data-custom-id');
          expect(descendant, getDartComponent(getByTestId(renderedInstance, 'testId2', key: 'data-custom-id')));
        });
      });

      test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('otherValue'))()
        ));

        var descendant = getComponentByTestId(renderedInstance, 'value');

        expect(descendant, isNull);
      });

      test('null if the user searches for \'null\' when no test ID is set', () {
        var renderedInstance = render(Wrapper()(
          Test()()
        ));

        var descendant = getComponentByTestId(renderedInstance, 'null');

        expect(descendant, isNull);
      });

      test('null if the user searches for `null` when a test ID is set to \'null\'', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('null'))()
        ));

        var descendant = getComponentByTestId(renderedInstance, null);

        expect(descendant, isNull);
      });
    });

    group('getPropsByTestId returns', () {
      test('the props map of the topmost descendant that has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
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

      test('the props map of the topmost descendant that has the appropriate value for the custom prop key', () {
        var renderedInstance = render(Wrapper()(
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

      test('the props map of the topmost descendant that has the value \'null\' for the `data-test-id` prop key when the user searches for \'null\'', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('null'))('First Descendant'),
          Dom.div()(
            (Test()..addTestId('null'))('Nested Descendant')
          )
        ));

        var props = getPropsByTestId(renderedInstance, 'null');

        expect(props, equals(getProps(getByTestId(renderedInstance, 'null'))));
      });

      group('the props map of the topmost descendant that has the appropriate value for the `data-test-id` prop key when cloned, a testId is added, and', () {
        test('the old testId is called', () {
          var renderedInstance = ((Test()
            ..addTestId('testId1')
            ..addTestId('testId2')
          )());

          var props = getPropsByTestId(renderedInstance, 'testId1');
          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId1'))));
        });

        test('the new testId is called', () {
          var renderedInstance = ((Test()
            ..addTestId('testId1')
            ..addTestId('testId2')
          )());

          var props = getPropsByTestId(renderedInstance, 'testId2');
          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId2'))));
        });
      });

      group('the props map of the topmost descendant that has the appropriate value for a custom prop key when cloned and', () {
        test('the old testId is called', () {
          var renderedInstance = ((Test()
            ..addTestId('testId1', key: 'data-custom-id')
            ..addTestId('testId2', key: 'data-custom-id')
          )());

          var props = getPropsByTestId(renderedInstance, 'testId1', key: 'data-custom-id');
          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId1', key: 'data-custom-id'))));
        });

        test('the props map of the topmost descendant that has the appropriate value for a custom prop key when cloned and the new testId is called', () {
          var renderedInstance = ((Test()
            ..addTestId('testId1', key: 'data-custom-id')
            ..addTestId('testId2', key: 'data-custom-id')
          )());

          var props = getPropsByTestId(renderedInstance, 'testId2', key: 'data-custom-id');
          expect(props, equals(getProps(getByTestId(renderedInstance, 'testId2', key: 'data-custom-id'))));
        });
      });

      test('null if no descendant has the appropriate value for the `data-test-id` prop key', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('otherValue'))()
        ));

        var props = getPropsByTestId(renderedInstance, 'value');

        expect(props, isNull);
      });

      test('null if the user searches for \'null\' when no test ID is set', () {
        var renderedInstance = render(Wrapper()(
          Test()()
        ));

        var props = getPropsByTestId(renderedInstance, 'null');

        expect(props, isNull);
      });

      test('null if the user searches for `null` when a test ID is set to \'null\'', () {
        var renderedInstance = render(Wrapper()(
          (Test()..addTestId('null'))()
        ));

        var props = getPropsByTestId(renderedInstance, null);

        expect(props, isNull);
      });
    });

    test('findDescendantsWithProp returns the descendants with the specified propKey', () {
      var renderedInstance = render(Wrapper()([
        (Dom.div()..addProp('data-name', 'top-level DOM'))(),
        (Test()..addProp('data-name', 'top-level Dart'))(),
        testJsComponentFactory({'data-name': 'top-level JS composite'}),

        Dom.div()([
          (Dom.div()..addProp('data-name', 'nested DOM'))(),
          (Test()..addProp('data-name', 'nested Dart'))(),
          testJsComponentFactory({'data-name': 'nested JS composite'}),
        ])
      ]));

      var descendants = findDescendantsWithProp(renderedInstance, 'data-name');
      expect(descendants, [
        hasProp('data-name', 'top-level DOM'),
        hasProp('data-name', 'top-level Dart'),
        hasProp('data-name', 'top-level JS composite'),
        hasProp('data-name', 'nested DOM'),
        hasProp('data-name', 'nested Dart'),
        hasProp('data-name', 'nested JS composite'),
      ]);
    });

    group('unmount:', () {
      group('unmounts a React instance specified', () {
        test('by its rendered instance', () {
          var mountNode = new DivElement();
          var instance = react_dom.render(Wrapper()(), mountNode);
          expect(isMounted(instance), isTrue);

          unmount(instance);
          expect(isMounted(instance), isFalse);
        });

        test('by its mount node', () {
          var mountNode = new DivElement();
          var ref;
          react_dom.render(react.div({'ref': ((instance) => ref = instance)}), mountNode);
          expect(ref, isNotNull);

          unmount(mountNode);
          expect(ref, isNull);
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
          var ref;
          var instance = react_dom.render(react.div({'ref': ((instance) => ref = instance)}), mountNode);
          react_dom.unmountComponentAtNode(mountNode);

          expect(ref, isNull);

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
  @override
  render() => (Dom.div()..addProp('isRenderResult', true))();
}
