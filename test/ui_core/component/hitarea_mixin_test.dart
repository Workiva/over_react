library hitarea_mixin_test;

import 'package:test/test.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' show ReactComponentFactory;
import 'package:w_ui_platform/ui_core.dart';
import 'package:w_ui_platform/ui_components.dart';

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

    group('renders with the appropriate node name when domNodeName is', () {
      test('DomNodeName.BUTTON', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..domNodeName = DomNodeName.BUTTON);
        expect(renderedNode, hasNodeName('BUTTON'));
      });

      test('DomNodeName.DIV', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..domNodeName = DomNodeName.DIV);
        expect(renderedNode, hasNodeName('DIV'));
      });

      test('DomNodeName.A', () {
        var renderedNode = renderAndGetDom(HitAreaTest()..domNodeName = DomNodeName.A);
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
              ..domNodeName = DomNodeName.BUTTON);
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
              ..domNodeName = DomNodeName.A);
            expect(renderedNode, isNot(hasAttr('disabled', '')));
            expect(renderedNode, hasExactClasses('hitarea disabled'));
            expect(renderedNode, hasAttr('aria-disabled', 'true'));
          });
        });

        group('false', () {
          test('a <button> element', () {
            var renderedNode = renderAndGetDom(HitAreaTest()
              ..isDisabled = false
              ..domNodeName = DomNodeName.BUTTON);
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
              ..domNodeName = DomNodeName.A);
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

      test('href is set and domNodeName is set to something other than DomNodeName.A', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..domNodeName = DomNodeName.DIV
          ..href = '/url');
        expect(renderedNode, hasNodeName('A'));
      });

      test('target is set and domNodeName is set to something other than DomNodeName.A', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..domNodeName = DomNodeName.DIV
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
          ..domNodeName = DomNodeName.A);

        expect(renderedNode, hasNodeName('A'));
        expect(renderedNode, hasAttr('name', 'someName'));
        expect(renderedNode, hasAttr('type', isNull));
        expect(renderedNode, hasAttr('id', 'someId'));
        expect(renderedNode, hasAttr('role', 'button'));
      });

      test('a <button>', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..name = 'someName'
          ..id = 'someId'
          ..type = HitAreaButtonType.BUTTON
          ..domNodeName = DomNodeName.BUTTON);

        expect(renderedNode, hasNodeName('BUTTON'));
        expect(renderedNode, hasAttr('name', 'someName'));
        expect(renderedNode, hasAttr('type', 'button'));
        expect(renderedNode, hasAttr('id', 'someId'));
        expect(renderedNode, hasAttr('role', isNull));
      });

      test('a <div>', () {
        var renderedNode = renderAndGetDom(HitAreaTest()
          ..name = 'someName'
          ..id = 'someId'
          ..type = HitAreaButtonType.BUTTON
          ..domNodeName = DomNodeName.DIV);

        expect(renderedNode, hasNodeName('DIV'));
        expect(renderedNode, hasAttr('name', isNull));
        expect(renderedNode, hasAttr('type', isNull));
        expect(renderedNode, hasAttr('id', 'someId'));
        expect(renderedNode, hasAttr('role', 'button'));
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
          String selectedKey;
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
          String selectedKey;
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

      group('the `domNodeName` prop,', () {
        test('warning when it is set to DomNodeName.A and href and target are null', () {
          render(HitAreaTest()..domNodeName = DomNodeName.A);
          verifyValidationWarning(contains('You are explicitly requesting that a `<a>` element is rendered via your React'));
        });

        test('not warning when it is set to DomNodeName.A and href or target are not null', () {
          render(HitAreaTest()
            ..domNodeName = DomNodeName.A
            ..href = 'link'
          );
          rejectValidationWarning(contains('You are explicitly requesting that a `<a>` element is rendered via your React'));
        });
      });

      group('the `href` and `target` prop', () {
        test('warning when `href` is set and domNodeName is something other than DomNodeName.A', () {
          render(HitAreaTest()
            ..domNodeName = DomNodeName.DIV
            ..href = '#');
          verifyValidationWarning(contains('You are explicitly requesting that a'));
        });

        test('warning when `target` is set and domNodeName is something other than DomNodeName.A', () {
          render(HitAreaTest()
            ..domNodeName = DomNodeName.DIV
            ..target = '_blank');
          verifyValidationWarning(contains('You are explicitly requesting that a'));
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
