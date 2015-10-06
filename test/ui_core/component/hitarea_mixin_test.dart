library hitarea_mixin_test;

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' show ReactComponentFactory;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:web_skin_dart/ui_components.dart';
import 'package:web_skin_dart/ui_core.dart';
import 'package:test/test.dart';

import '../../test_util/custom_matchers.dart';
import '../../test_util/react_util.dart';
import '../../test_util/validation_util_helpers.dart';

getHitArea(instance) => getRef(instance, 'hitarea');

main() {
  group('HitAreaMixin', () {
    test('renders with appropriate base CSS classes and node name', () {
      var renderedNode = renderAndGetDom(HitAreaTest());
      expect(renderedNode, hasExactClasses('hitarea'));
      expect(renderedNode, hasNodeName('DIV'));
    });

    group('renders with the appropriate node name when domNodeFactory is', () {
      test('Dom.button', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..domNodeFactory = Dom.button);
        expect(renderedNode, hasNodeName('BUTTON'));
      });

      test('Dom.div', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..domNodeFactory = Dom.div);
        expect(renderedNode, hasNodeName('DIV'));
      });

      test('Dom.a', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..domNodeFactory = Dom.a);
        expect(renderedNode, hasNodeName('A'));
      });
    });

    group('renders with the appropriate CSS classes and html attributes when isActive is', () {
      test('true', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..isActive = true);
        // Using hasClasses() because only the active class matters for this test
        expect(renderedNode, hasClasses('active'));
        expect(renderedNode, hasAttr('aria-selected', equals('true')));
      });

      test('false', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..isActive = false);
        expect(renderedNode, excludesClasses('active'));
        expect(renderedNode, hasAttr('aria-selected', isNull));
      });

      group('true and', () {
        group('isNavItem is', () {
          test('true', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isNavItem = true
              ..isActive = true);
            expect(renderedNode, excludesClasses('active'));
            expect(renderedNode, hasAttr('aria-selected', 'true'));
          });

          test('false', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isNavItem = false
              ..isActive = true);
            expect(renderedNode, hasExactClasses('hitarea active'));
            expect(renderedNode, hasAttr('aria-selected', 'true'));
          });
        });

        group('isNavDropdown', () {
          test('true', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isNavDropdown = true
              ..isActive = true);
            expect(renderedNode, excludesClasses('active'));
            expect(renderedNode, hasAttr('aria-selected', 'true'));
          });

          test('false', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isNavDropdown = false
              ..isActive = true);
            expect(renderedNode, hasExactClasses('hitarea active'));
            expect(renderedNode, hasAttr('aria-selected', 'true'));
          });
        });
      });

      group('false and', () {
        test('isNavItem is true', () {
          var renderedNode = renderAndGetDom(HitAreaTest()
            ..isNavItem = true
            ..isActive = true);
          expect(renderedNode, excludesClasses('active'));
          expect(renderedNode, hasAttr('aria-selected', 'true'));
        });

        test('isNavDropdown is true', () {
          var renderedNode = renderAndGetDom(HitAreaTest()
            ..isNavDropdown = true
            ..isActive = true);
          expect(renderedNode, excludesClasses('active'));
          expect(renderedNode, hasAttr('aria-selected', 'true'));
        });
      });
    });

    group('isDisabled prop', () {
      group('renders with appropriate CSS classes and html attributes when isDisabled is', () {
        group('true on', () {
          test('a <button> element', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isDisabled = true
              ..domNodeFactory = Dom.button);
            expect(renderedNode, hasExactClasses('hitarea disabled'));
            expect(renderedNode, hasAttr('disabled', isNull));
          });

          test('a <div> element', () {
            var renderedNode = renderAndGetDom(HitAreaTest()..isDisabled = true);
            expect(renderedNode, isNot(hasAttr('disabled', '')));
            expect(renderedNode, hasExactClasses('hitarea disabled'));
            expect(renderedNode, hasAttr('aria-disabled', 'true'));
          });

          test('an <a> element', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isDisabled = true
              ..domNodeFactory = Dom.a);
            expect(renderedNode, isNot(hasAttr('disabled', '')));
            expect(renderedNode, hasExactClasses('hitarea disabled'));
            expect(renderedNode, hasAttr('aria-disabled', 'true'));
          });
        });

        group('false', () {
          test('a <button> element', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isDisabled = false
              ..domNodeFactory = Dom.button);
            expect(renderedNode, excludesClasses('disabled'));
            expect(renderedNode, isNot(hasAttr('disabled', '')));
          });

          test('a <div> element', () {
            var renderedNode = renderAndGetDom(HitAreaTest()..isDisabled = false);
            expect(renderedNode, isNot(hasAttr('disabled', '')));
            expect(renderedNode, hasExactClasses('hitarea'));
            expect(renderedNode, isNot(hasAttr('aria-disabled', 'true')));
          });

          test('an <a> element', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isDisabled = false
              ..domNodeFactory = Dom.a);
            expect(renderedNode, isNot(hasAttr('disabled', '')));
            expect(renderedNode, hasExactClasses('hitarea'));
            expect(renderedNode, isNot(hasAttr('aria-disabled', 'true')));
          });
        });
      });
    });

    group('renders an <a> when', () {
      test('href is set', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..href = '/url');
        expect(renderedNode, hasNodeName('A'));
      });

      test('target is set', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..target = '_blank');
        expect(renderedNode, hasNodeName('A'));
      });

      test('href is set and domNodeFactory is set to something other than Dom.a', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..domNodeFactory = Dom.div
          ..href = '/url');
        expect(renderedNode, hasNodeName('A'));
      });

      test('target is set and domNodeFactory is set to something other than Dom.a', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..domNodeFactory = Dom.div
          ..target = '_blank');
        expect(renderedNode, hasNodeName('A'));
      });
    });

    group('renders with correct html attributes when the rendered node is', () {
      test('a <a>', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..name = 'someName'
          ..id = 'someId'
          ..type = HitAreaButtonType.BUTTON
          ..domNodeFactory = Dom.a);

        expect(renderedNode, hasNodeName('A'));
        expect(renderedNode, hasAttr('name', 'someName'));
        expect(renderedNode, hasAttr('type', isNull));
        expect(renderedNode, hasAttr('id', 'someId'));
      });

      test('a <button>', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..name = 'someName'
          ..id = 'someId'
          ..type = HitAreaButtonType.BUTTON
          ..domNodeFactory = Dom.button);

        expect(renderedNode, hasNodeName('BUTTON'));
        expect(renderedNode, hasAttr('name', 'someName'));
        expect(renderedNode, hasAttr('type', 'button'));
        expect(renderedNode, hasAttr('id', 'someId'));
      });

      test('a <div>', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..name = 'someName'
          ..id = 'someId'
          ..type = HitAreaButtonType.BUTTON
          ..domNodeFactory = Dom.div);

        expect(renderedNode, hasNodeName('DIV'));
        expect(renderedNode, hasAttr('name', isNull));
        expect(renderedNode, hasAttr('type', isNull));
        expect(renderedNode, hasAttr('id', 'someId'));
        expect(renderedNode, hasAttr('tabIndex', '0'));
      });
    });

    group('renders with the appropriate role attribute when the role prop is', () {
      group('set and domNodeFactory is', () {
        test('Dom.a', () {
          var renderedNode = renderAndGetDom(HitAreaTest()
            ..role = 'tab'
            ..domNodeFactory = Dom.a);

          expect(renderedNode, hasAttr('role', 'tab'));
        });

        test('Dom.div', () {
          var renderedNode = renderAndGetDom(HitAreaTest()
            ..role = 'tab'
            ..domNodeFactory = Dom.div);

          expect(renderedNode, hasAttr('role', 'tab'));
        });

        test('Dom.button', () {
          var renderedNode = renderAndGetDom(HitAreaTest()
            ..role = 'tab'
            ..domNodeFactory = Dom.button);

          expect(renderedNode, hasAttr('role', isNull));
        });
      });

      group('not set and domNodeFactory is', () {
        test('Dom.a', () {
          var renderedNode = renderAndGetDom(HitAreaTest()..domNodeFactory = Dom.a);

          expect(renderedNode, hasAttr('role', 'button'));
        });

        test('Dom.div', () {
          var renderedNode = renderAndGetDom(HitAreaTest()..domNodeFactory = Dom.div);

          expect(renderedNode, hasAttr('role', 'button'));
        });

        test('Dom.button', () {
          var renderedNode = renderAndGetDom(HitAreaTest()..domNodeFactory = Dom.button);

          expect(renderedNode, hasAttr('role', isNull));
        });
      });
    });

    group('handles keyUp correctly', () {
      bool clicked;
      var instance;
      bool keyUpOccurred;
      setUp(() {
        clicked = false;
        keyUpOccurred = false;

        instance = (HitAreaTest()
          ..eventKey = '123'
          ..onClick = (event) {
            clicked = true;
          }
          ..onKeyUp = (event) {
            keyUpOccurred = true;
          }
        );
      });

      tearDown(() {
        tearDownAttachedNodes();
      });

      group('when spacebar key is pressed and isDisabled is', () {
        test('false', () {
          var renderedInstance = renderAttachedToDocument(instance);
          react_test_utils.Simulate.keyUp(getHitArea(renderedInstance), {'key': ' '});
          expect(keyUpOccurred, isTrue, reason: 'keyUp was not invoked');
          expect(clicked, isTrue, reason: 'click was not invoked');
        });

        test('true', () {
          instance.isDisabled = true;
          var renderedInstance = renderAttachedToDocument(instance);
          react_test_utils.Simulate.keyUp(getHitArea(renderedInstance), {'key': ' '});
          expect(keyUpOccurred, isTrue, reason: 'keyUp was not invoked');
          expect(clicked, isFalse, reason: 'click was incorrectly invoked');
        });
      });

      test('when non-spacebar key is pressed', () {
        var renderedInstance = renderAttachedToDocument(instance);
        react_test_utils.Simulate.keyUp(getHitArea(renderedInstance), {'key': 'B'});
        expect(keyUpOccurred, isTrue, reason: 'keyUp was not invoked');
        expect(clicked, isFalse, reason: 'click was incorrectly invoked');
      });
    });

    group('handles keyPress correctly', () {
      bool clicked;
      bool keyPressOccurred;
      var instance;
      setUp(() {
        clicked = false;
        keyPressOccurred = false;

        instance = (HitAreaTest()
          ..eventKey = '123'
          ..onClick = (event) {
            clicked = true;
          }
          ..onKeyPress = (event) {
            keyPressOccurred = true;
          }
        );
      });

      tearDown(() {
        tearDownAttachedNodes();
      });

      group('when enter key is pressed and isDisabled is', () {
        test('true', () {
          instance.isDisabled = true;
          var renderedInstance = renderAttachedToDocument(instance);
          react_test_utils.Simulate.keyPress(getHitArea(renderedInstance), {'key': 'Enter'});
          expect(keyPressOccurred, isTrue, reason: 'keyPress was not invoked');
          expect(clicked, isFalse, reason: 'click was incorrectly invoked');
        });

        test('false', () {
          var renderedInstance = renderAttachedToDocument(instance);
          react_test_utils.Simulate.keyPress(getHitArea(renderedInstance), {'key': 'Enter'});
          expect(keyPressOccurred, isTrue, reason: 'keyPress was not invoked');
          expect(clicked, isTrue, reason: 'click was not invoked');
        });
      });

      test('when non-enter key is pressed', () {
        var renderedInstance = renderAttachedToDocument(instance);
        react_test_utils.Simulate.keyPress(getHitArea(renderedInstance), {'key': 'B'});
        expect(keyPressOccurred, isTrue, reason: 'keyPress was not invoked');
        expect(clicked, isFalse, reason: 'click was incorrectly invoked');
      });
    });

    group('handles keyDown correctly', () {
      var instance;
      bool keyDownOccurred;
      react.SyntheticKeyboardEvent event;

      setUp(() {
        keyDownOccurred = false;
        event = null;

        instance = (HitAreaTest()
          ..eventKey = '123'
          ..onKeyDown = (e) {
            keyDownOccurred = true;
            event = e;
          }
        );
      });

      tearDown(() {
        tearDownAttachedNodes();
      });

      test('when spacebar key is pressed', () {
        var renderedInstance = renderAttachedToDocument(instance);
        react_test_utils.Simulate.keyDown(getHitArea(renderedInstance), {'key': ' '});
        expect(keyDownOccurred, isTrue, reason: 'keyDown was not invoked');
        expect(event.defaultPrevented, isTrue, reason: 'default was not prevented');
      });

      test('when non-spacebar key is pressed', () {
        var renderedInstance = renderAttachedToDocument(instance);
        react_test_utils.Simulate.keyDown(getHitArea(renderedInstance), {'key': 'B'});
        expect(keyDownOccurred, isTrue, reason: 'keyDown was not invoked');
        expect(event.defaultPrevented, anyOf(isNull, isFalse), reason: 'default was incorrectly prevented');
      });
    });

    group('handles clicks correctly:', () {
      group('when onSelect is', () {
        test('set', () {
          bool onSelectCalled = false;
          String selectedKey;
          var instance = (HitAreaTest()
            ..eventKey = '123'
            ..onSelect = (event, key) {
              selectedKey = key;
              onSelectCalled = true;
            }
          )();
          var renderedInstance = render(instance);
          click(getHitArea(renderedInstance));
          expect(onSelectCalled, isTrue);
          expect(selectedKey, equals('123'));
        });

        test('not set', () {
          var instance = (HitAreaTest()
            ..eventKey = '123');
          var renderedInstance = render(instance);
          try {
            click(getHitArea(renderedInstance));
          } catch (e) {
            fail(e);
          }
        });
      });

      group('when onClick', () {
        test('set', () {
          bool onSelectCalled = false;
          var instance = (HitAreaTest()
            ..eventKey = '123'
            ..onClick = (event) {
              onSelectCalled = true;
            }
          )();
          var renderedInstance = render(instance);
          click(getHitArea(renderedInstance));
          expect(onSelectCalled, isTrue);
        });

        test('not set', () {
          var instance = (HitAreaTest());
          var renderedInstance = render(instance);
          try {
            click(getHitArea(renderedInstance));
          } catch (e) {
            fail(e);
          }
        });
      });

      group('when isDisabled is true and onSelect is', () {
        test('set', () {
          bool onSelectCalled = false;
          String selectedKey;
          var instance = (HitAreaTest()
            ..isDisabled = true
            ..eventKey = '123'
            ..onSelect = (event, key) {
              selectedKey = key;
              onSelectCalled = true;
            }
          )();
          var renderedInstance = render(instance);
          click(getHitArea(renderedInstance));
          expect(onSelectCalled, isFalse);
          expect(selectedKey, isNull);
        });

        test('not set', () {
          var instance = (HitAreaTest()
            ..isDisabled = true
            ..eventKey = '123');
          var renderedInstance = render(instance);
          try {
            click(getHitArea(renderedInstance));
          } catch (e) {
            fail(e);
          }
        });
      });

      group('when isDisabled is true and onClick is', () {
        test('set', () {
          bool onSelectCalled = false;
          var instance = (HitAreaTest()
            ..isDisabled = true
            ..eventKey = '123'
            ..onClick = (event) {
              onSelectCalled = true;
            }
          )();
          var renderedInstance = render(instance);
          click(getHitArea(renderedInstance));
          expect(onSelectCalled, isFalse);
        });

        test('not set', () {
          var instance = (HitAreaTest()..isDisabled = true);
          var renderedInstance = render(instance);
          try {
            click(getHitArea(renderedInstance));
          } catch (e) {
            fail(e);
          }
        });
      });

      test('when both `onClick` and `onSelect` are set and `onClick` returns `true`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        String selectedKey;
        var instance = (HitAreaTest()
          ..eventKey = '123'
          ..onClick = (event) {
            onClickCalled = true;
            return true;
          }
          ..onSelect = (event, key) {
            selectedKey = key;
            onSelectCalled = true;
          }
        )();
        var renderedInstance = render(instance);
        click(getHitArea(renderedInstance));
        expect(onClickCalled, isTrue);
        expect(onSelectCalled, isTrue);
        expect(selectedKey, equals('123'));
      });

      test('when both `onSelect` and `onClick` are set and `onClick` returns `false`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        String selectedKey;
        var instance = (MenuItem()
          ..eventKey = '123'
          ..onClick = (event) {
            onClickCalled = true;
            return false;
          }
          ..onSelect = (event, key) {
            selectedKey = key;
            onSelectCalled = true;
          }
        )();
        var renderedInstance = render(instance);
        click(getHitArea(renderedInstance));
        expect(onClickCalled, isTrue);
        expect(onSelectCalled, isFalse);
        expect(selectedKey, isNull);
      });
    });

    group('validates', () {
      bool warningsWereEnabled;
      setUp(() {
        warningsWereEnabled = ValidationUtil.WARNINGS_ENABLED;
        ValidationUtil.WARNINGS_ENABLED = false;
        startRecordingValidationWarnings();
      });

      tearDown(() {
        ValidationUtil.WARNINGS_ENABLED = warningsWereEnabled;
        stopRecordingValidationWarnings();
      });

      group('the `domNodeFactory` prop,', () {
        test('warning when it is set to Dom.a and href and target are null', () {
          render(HitAreaTest()..domNodeFactory = Dom.a);
          verifyValidationWarning(contains('You are explicitly requesting that a `<a>` element is rendered via your React'));
        });

        test('not warning when it is set to Dom.a and href or target are not null', () {
          render(HitAreaTest()
            ..domNodeFactory = Dom.a
            ..href = 'link'
          );
          rejectValidationWarning(contains('You are explicitly requesting that a `<a>` element is rendered via your React'));
        });
      });

      group('the `href` and `target` prop', () {
        test('warning when `href` is set and domNodeFactory is something other than Dom.a', () {
          render(HitAreaTest()
            ..domNodeFactory = Dom.div
            ..href = '#');
          verifyValidationWarning(contains('You are providing a DomComponentDefinitionFactory that is not a Dom.a'));
        });

        test('warning when `target` is set and domNodeFactory is something other than Dom.a', () {
          render(HitAreaTest()
            ..domNodeFactory = Dom.div
            ..target = '_blank');
          verifyValidationWarning(contains('You are providing a DomComponentDefinitionFactory that is not a Dom.a'));
        });
      });

      group('the `href` prop', () {
        test('warning when it is set to \'#\'', () {
          render(HitAreaTest()..href = '#');
          verifyValidationWarning(contains('You are using an `href` attribute with a value of `#`.'));
        });

        test('not warning when it is set to something other than \'#\'', () {
          render(HitAreaTest()..href = 'link');
          rejectValidationWarning(contains('You are using an `href` attribute with a value of `#`.'));
        });
      });
    });
  });
}

HitAreaTestDefinition HitAreaTest() => new HitAreaTestDefinition({});

class HitAreaTestDefinition extends BaseComponentDefinition with HitAreaProps {
  HitAreaTestDefinition(Map props) : super(_HitAreaTestComponentFactory, props);
}

ReactComponentFactory _HitAreaTestComponentFactory = react.registerComponent(() => new _HitAreaTest());
class _HitAreaTest extends BaseComponent<HitAreaTestDefinition> with HitAreaMixin<HitAreaTestDefinition> {
  @override
  Map getDefaultProps() => (newProps()
    ..addProps(HitAreaMixin.defaultProps)
  );

  @override
  render() {
    return renderHitArea(copyProps(), tProps.children);
  }

  @override
  HitAreaTestDefinition typedPropsFactory(Map propsMap) => new HitAreaTestDefinition(propsMap);
}
