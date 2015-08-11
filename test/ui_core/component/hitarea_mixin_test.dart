library hitarea_mixin_test;

import 'package:test/test.dart';
import '../../test_util/react_util.dart';
import '../../test_util/zone.dart';
import 'package:react/react.dart' as react;
import 'package:w_ui_platform/ui_core.dart';
import 'package:w_ui_platform/ui_components.dart';

import '../../test_util/custom_matchers.dart';

renderAndGetHitArea(definition) => getHitArea(render(definition));

getHitArea(instance) => findDomNode(getRef(instance, 'hitarea'));

main() {
  group('HitAreaMixin', () {
    int warningCount;

    setUp(() {
      // Perform setup needed for using 'zonedExpect'.
      storeZone();

      // prevent component warnings from printing to console
      ValidationUtil.WARNINGS_ENABLED = false;
      warningCount = ValidationUtil.WARNING_COUNT;
    });

    tearDown(() {
      // restore component validation warnings
      ValidationUtil.WARNINGS_ENABLED = true;
    });

    group('isActive prop', () {
      group('renders with apprpriate CSS classes and html attributes when ', () {
        test('true', () {
          var renderedNode = renderAndGetHitArea(MenuItem()..isActive = true);
          // Using hasClasses() because only the active class matters for this test
          expect(renderedNode, hasClasses('active'));
          expect(renderedNode, hasAttr('aria-selected', equals('true')));
        });

        test('false', () {
          var renderedNode = renderAndGetHitArea(MenuItem()..isActive = false);
          expect(renderedNode, excludesClasses('active'));
          expect(renderedNode, hasAttr('aria-selected', isNull));
        });

        test('not set', () {
          var renderedNode = renderAndGetHitArea(MenuItem());
          expect(renderedNode, excludesClasses('active'));
          expect(renderedNode, hasAttr('aria-selected', isNull));
        });
      });

      group('should set `defaultChecked` prop for', () {
        test('checkbox elements', () {
          var renderedNode = renderAndGetHitArea((MenuItem()
            ..isActive = true
            ..type = ClickableDomInputType.CHECKBOX
            ..id = 'checkbox1'
          ));
          expect(renderedNode.defaultChecked, isTrue);
        });

        test('radio elements', () {
          var renderedNode = renderAndGetHitArea((MenuItem()
            ..isActive = true
            ..type = ClickableDomInputType.RADIO
            ..id = 'radio1'
          ));
          expect(renderedNode.defaultChecked, isTrue);
        });
      });
    });

    group('isDisabled prop', () {
      test('renders with `disabled` prop false by default', () {
        var renderedNode = renderAndGetHitArea((MenuItem()));
        expect(renderedNode, isNot(hasAttr('disabled', '')));
      });
      test('when `true` should set `disabled` prop for non-`A` elements', () {
        var renderedNode = renderAndGetHitArea((MenuItem()..isDisabled = true));
        expect(renderedNode, hasAttr('disabled', ''));
      });

      group('renders with appropriate CSS classes when isDisabled is', () {
        group('not set on', () {
          test('an <a> element', () {
            var renderedNode = renderAndGetHitArea(MenuItem()..href = '/url');
            expect(renderedNode, excludesClasses('disabled'));
          });

          test('a non-<a> element', () {
            var renderedNode = renderAndGetHitArea(MenuItem());
            expect(renderedNode, excludesClasses('disabled'));
          });
        });

        group('true on', () {
          test('an <a> element', () {
            var renderedNode = renderAndGetHitArea(MenuItem()
              ..isDisabled = true
              ..href = '/url');
            // Using hasClasses() because only the disabled class matters for this test
            expect(renderedNode, hasClasses('disabled'));
          });

          test('a non-<a> element', () {
            var renderedNode = renderAndGetHitArea(MenuItem()..isDisabled = true);
            expect(renderedNode, excludesClasses('disabled'));
          });
        });

        group('false', () {
          test('an <a> element', () {
            var renderedNode = renderAndGetHitArea(MenuItem()
              ..isDisabled = false
              ..href = '/url');
            expect(renderedNode, excludesClasses('disabled'));
          });

          test('a non-<a> element', () {
            var renderedNode = renderAndGetHitArea(MenuItem()..isDisabled = false);
            expect(renderedNode, excludesClasses('disabled'));
          });
        });
      });

      test('sets `aria-disabled` html attribute to make disabled hitarea accessible when isDisabled is true', () {
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..href = '/url'
          ..isDisabled = true
        ));
        expect(renderedNode, hasAttr('aria-disabled', 'true'));
      });
    });

    group('isNavItem prop', () {
      test('renders hitarea without nav-item CSS classes', () {
        var renderedNode = renderAndGetHitArea((MenuItem()..isNavItem = true));
        // Using hasClasses() because only the hitarea class matters for this test
        expect(renderedNode, hasClasses('hitarea'));
        expect(renderedNode, excludesClasses('nav-item'));
      });

      test('causes `getValidatedHitAreaProps` to add the "navItem" prop when \'true\' ', () {
        var instance = new HitAreaTestComponent()..tProps.isNavItem = true;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.navItem, isTrue);
      });

      test('does not apply the \'active\' class to hitarea when \'true\'', () {
        // isNavItem not specified
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(renderedNode, excludesClasses('active'));
      });

      test('sets `aria-selected` prop to make active hitarea accessible when \'true\'', () {
        // isNavItem not specified
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(renderedNode, hasAttr('aria-selected', 'true'));
      });
    });

    group('isNavDropdown prop', () {
      test('renders hitarea without nav-item or nav-item CSS classes', () {
        var renderedNode = renderAndGetHitArea(MenuItem()..isNavDropdown = true);
        // Using hasClasses() because only the hitarea class matters for this test
        expect(renderedNode, hasClasses('hitarea'));
        expect(renderedNode, excludesClasses('nav-item'));
      });

      test('causes `getValidatedHitAreaProps` to add the \'navItem\' and \'navDropdown\' props when \'true\'', () {
        var instance = new HitAreaTestComponent()..tProps.isNavDropdown = true;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.navItem, isTrue);
        expect(hitAreaProps.navDropdown, isTrue);
      });

      test('does not apply the \'active\' class when \'true\'', () {
        // isNavItem not specified
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(renderedNode, excludesClasses(['active']));
      });

      test('when "true" should set `aria-selected` prop to make active hitarea accessible', () {
        // isNavItem not specified
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(renderedNode.getAttribute('aria-selected'), equals('true'));
      });
    });

    group('type prop set to', () {
      group('checkbox', () {
        test('sets `role` html attribute to "button"', () {
          var renderedNode = renderAndGetHitArea((MenuItem()
            ..id = 'test_hitarea_component2'
            ..type = ClickableDomInputType.CHECKBOX
          ));
          expect(renderedNode, hasAttr('role', 'button'));
        });

        test('warns the consumer if `id` prop is not set', () {
          renderAndGetHitArea((MenuItem()..type = ClickableDomInputType.CHECKBOX));
          expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
        });

        test('should add a `inputId` prop and set it to null (when `id` prop is not set)', () {
          var instance = new HitAreaTestComponent()..tProps.type = ClickableDomInputType.CHECKBOX;
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.inputId, isNull);
        });

        test('should add a `inputRef` prop and set it equal to the `type` prop', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..type = ClickableDomInputType.CHECKBOX
            ..id = 'test_hitarea_component_3';
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.inputRef, equals(instance.tProps.type));
        });

        test('should add a `inputId` prop and set it equal to the `id` prop with a _{type} suffix', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..type = ClickableDomInputType.CHECKBOX
            ..id = 'test_hitarea_component_3';
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.inputId, equals("${hitAreaProps['id']}_${hitAreaProps['type']}"));
        });

        test('should add a `buttonRef` prop and set it equal to the `inputRef` prop with a "_button" suffix', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..type = ClickableDomInputType.CHECKBOX
            ..id = 'test_hitarea_component_3';
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.buttonRef, equals("${hitAreaProps.inputRef}_button"));
        });
      });

      group('radio', () {
        test('should set `role` prop to "button"', () {
          var renderedNode = renderAndGetHitArea((MenuItem()
            ..id = 'test_hitarea_component'
            ..type = ClickableDomInputType.RADIO
          ));
          expect(renderedNode, hasAttr('role', 'button'));
        });

        test('should warn the consumer if `id` prop is not set', () {
          renderAndGetHitArea((MenuItem()
            ..type = ClickableDomInputType.RADIO
            ..name = 'test_hitarea_radio_group'
          ));
          expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
        });

        test('should warn the consumer if `name` prop is not set', () {
          renderAndGetHitArea((MenuItem()
            ..type = ClickableDomInputType.RADIO
            ..id = 'test_hitarea_component'
          ));
          expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
        });

        test('should add a `inputId` prop and set it to null (when `id` prop is not set)', () {
          var instance = new HitAreaTestComponent();
          instance.tProps.type = ClickableDomInputType.RADIO;
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.inputId, isNull);
        });

        test('should add a `inputRef` prop and set it equal to the `type` prop', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..type = ClickableDomInputType.RADIO
            ..id = 'test_hitarea_component_3'
            ..name = 'test_hitarea_component_3_group';
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.inputRef, equals(instance.tProps.type));
        });

        test('should add a `inputId` prop and set it equal to the `id` prop with a _{type} suffix', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..type = ClickableDomInputType.RADIO
            ..id = 'test_hitarea_component_3'
            ..name = 'test_hitarea_component_3_group';
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.inputId, equals("${hitAreaProps['id']}_${hitAreaProps['type']}"));
        });

        test('should add a `buttonRef` prop and set it equal to the `inputRef` prop with a "_button" suffix', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..type = ClickableDomInputType.RADIO
            ..id = 'test_hitarea_component_3'
            ..name = 'test_hitarea_component_3_group';
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.buttonRef, equals("${hitAreaProps.inputRef}_button"));
        });
      });
    });

    group('defaultChecked prop being set', () {
      test('adds the `active` class and `aria-selected` html attribute for checkbox elements', () {
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..type = ClickableDomInputType.CHECKBOX
          ..id = 'checkbox1'
          ..isActive = false
          ..addProps(domProps()..defaultChecked = true)
        ));
        expect(renderedNode.checked, isTrue);
        expect(renderedNode.defaultChecked, isTrue);
        expect(renderedNode, hasClasses('active'));
        expect(renderedNode, hasAttr('aria-selected', 'true'));
      });

      test('adds the `active` class and `aria-selected` html attribute for radio elements', () {
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..isActive = false
          ..type = ClickableDomInputType.RADIO
          ..id = 'radio1'
          ..addProps(domProps()..defaultChecked = true)
        ));
        expect(renderedNode.checked, isTrue);
        expect(renderedNode.defaultChecked, isTrue);
        expect(renderedNode, hasClasses('active'));
        expect(renderedNode, hasAttr('aria-selected', 'true'));
      });
    });

    group('checked prop being set', () {
      test('adds the `active` class and `aria-selected` html attribute for checkbox elements', () {
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..type = ClickableDomInputType.CHECKBOX
          ..id = 'checkbox1'
          ..isActive = false
          ..addProps(domProps()..checked = true)
        ));
        expect(renderedNode.checked, isTrue);
        expect(renderedNode.defaultChecked, isTrue);
        expect(renderedNode, hasClasses('active'));
        expect(renderedNode, hasAttr('aria-selected', 'true'));
      });

      test('adds the `active` class and `aria-selected` html attribute for radio elements', () {
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..isActive = false
          ..type = ClickableDomInputType.RADIO
          ..id = 'radio1'
          ..addProps(domProps()..checked = true)
        ));
        expect(renderedNode.checked, isTrue);
        expect(renderedNode.defaultChecked, isTrue);
        expect(renderedNode, hasClasses('active'));
        expect(renderedNode, hasAttr('aria-selected', 'true'));
      });
    });

    group('with anchor elements', () {
      test('sets `role` prop to "button" when `href` prop is "#"', () {
        var renderedNode = renderAndGetHitArea((MenuItem()..href = "#"));
        expect(renderedNode, hasAttr('role', 'button'));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('sets `role` prop to "button" when no `href`, `target` or `name` prop is set', () {
        var renderedNode = renderAndGetHitArea((MenuItem()..domNodeName = DomNodeName.A));
        expect(renderedNode, hasAttr('role', 'button'));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
    });

    group('renders', () {
      group('an input when type is', () {
        test('checkbox', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..id = 'test_id_1'
            ..type = ClickableDomInputType.CHECKBOX;
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.renderer, equals(HitAreaRenderer.INPUT));
        });

        test('radio', () {
          var instance = new HitAreaTestComponent();
          instance.tProps
            ..id = 'test_id_1'
            ..type = ClickableDomInputType.RADIO;
          var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
          expect(hitAreaProps.renderer, equals(HitAreaRenderer.INPUT));
        });
      });

      test('a `div` element by default', () {
        // We do not want HitAreaMixin to render a <button> by default because this does not allow
        // elements nested within it to receive click events.
        var instance = new HitAreaTestComponent();
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.DIV));
      });

      test('an `a` element when domNodeName == `DomNodeName.A`', () {
        var instance = new HitAreaTestComponent()..tProps.domNodeName = DomNodeName.A;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });

      test('an `a` element when href prop is present', () {
        var instance = new HitAreaTestComponent()..tProps.href = '/url';
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });

      test('an `a` element when href and domNodeName are present', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..href = '/url'
          ..domNodeName = DomNodeName.INPUT;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });

      test('`a` element when target prop is present', () {
        var instance = new HitAreaTestComponent()..tProps.target = '_blank';
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });

      test('a `button` when prop type == DomInputType.SUBMIT', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.INPUT
          ..type = ClickableDomInputType.SUBMIT;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });

      test('a `button` when prop type == DomInputType.RESET', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.INPUT
          ..type = ClickableDomInputType.RESET;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(hitAreaProps.type, equals(ClickableDomInputType.RESET));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });

      test('a `button` when prop type == DomInputType.BUTTON', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.INPUT
          ..type = ClickableDomInputType.BUTTON;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(hitAreaProps.type, equals(ClickableDomInputType.BUTTON));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });

      test('with type specified by the type prop even when domNodeName is changed', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.INPUT
          ..type = ClickableDomInputType.SUBMIT;
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(hitAreaProps.type, equals(ClickableDomInputType.SUBMIT));
      });
    });

    // Tests for invalid props
    group('when domNodeName == DomNodeName.DIV, but has invalid props', () {
      test('should render "a" when href prop is present', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.DIV
          ..href = '/url';
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });

      test('should render "a" when target prop is present', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.DIV
          ..target = '_blank';
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
    });

    group('domNodeName is DomNodeName.BUTTON, but has invalid props', () {
      test('should render "a" when href prop is present', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.BUTTON
          ..href = '/url';
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });

      test('should render "a" when target prop is present', () {
        var instance = new HitAreaTestComponent();
        instance.tProps
          ..domNodeName = DomNodeName.BUTTON
          ..target = '_blank';
        var hitAreaProps = instance.getValidatedHitAreaProps(instance.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
    });

    // Tests for html attributes
    group('renders with correct html attribute:', () {
      test('role prop set to "button" when type prop == DomNodeNode.DIV', () {
        var renderedNode = renderAndGetHitArea((MenuItem()..domNodeName = DomNodeName.DIV));
        expect(renderedNode, hasAttr('role', 'button'));
      });

      group('type, ', () {
        test('not set by default', () {
          var renderedNode = renderAndGetHitArea(MenuItem());
          expect(renderedNode, hasAttr('type', isNull));
        });
      });
    });

    group('handles clicks correctly:', () {
      test('should fire callback defined in `onSelect` prop', () {
        bool onSelectCalled = false;
        var instance = (MenuItem()
          ..eventKey = '123'
          ..onSelect = (event, key, href, target) {
                zonedExpect(key, equals('123'));
                onSelectCalled = true;
              }
        )();
        var renderedInstance = render(instance);
        var buttonRef = getRef(renderedInstance, 'hitarea');
        click(buttonRef);
        expect(onSelectCalled, isTrue);
      });

      test('should fire callback defined in `onClick` prop', () {
        bool onClickCalled = false;
        var instance = (MenuItem()
          ..onClick = (event) {
                zonedExpect(event is react.SyntheticEvent, isTrue);
                onClickCalled = true;
              }
        )();
        var renderedInstance = render(instance);
        var buttonRef = getRef(renderedInstance, 'hitarea');
        click(buttonRef);
        expect(onClickCalled, isTrue);
      });

      test('should NOT fire callback defined in `onClick` prop when `isDisabled == true`', () {
        bool onClickCalled = false;
        var instance = (MenuItem()
          ..href = '/url'
          ..isDisabled = true
          ..onClick = (event) {
                onClickCalled = true;
              }
        )();
        var renderedInstance = render(instance);
        var anchorRef = getRef(renderedInstance, 'hitarea');
        click(anchorRef);
        expect(onClickCalled, isFalse);
      });

      test('should fire both `onClick` and `onSelect` callbacks if `onClick` callback returns `true`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var instance = (MenuItem()
          ..eventKey = '123'
          ..onClick = (event) {
                zonedExpect(event is react.SyntheticEvent, isTrue);
                onClickCalled = true;
                return true;
              }
          ..onSelect = (event, key, href, target) {
                zonedExpect(key, equals('123'));
                onSelectCalled = true;
              }
        )();
        var renderedInstance = render(instance);
        var buttonRef = getRef(renderedInstance, 'hitarea');
        click(buttonRef);
        expect(onClickCalled, isTrue);
        expect(onSelectCalled, isTrue);
      });

      test('should not call `onSelect` callback if `onClick` callback returns `false`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var instance = (MenuItem()
          ..eventKey = '123'
          ..onClick = (event) {
                zonedExpect(event is react.SyntheticEvent, isTrue);
                onClickCalled = true;
                return false;
              }
          ..onSelect = (event, key, href, target) {
                zonedExpect(key, equals('123'));
                onSelectCalled = true;
              }
        )();
        var renderedInstance = render(instance);
        var buttonRef = getRef(renderedInstance, 'hitarea');
        click(buttonRef);
        expect(onClickCalled, isTrue);
        expect(onSelectCalled, isFalse);
      });

      test('should fire both `onClick` and `onSelect` callbacks if `onClick` callback does not return a value', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var instance = (MenuItem()
          ..eventKey = '123'
          ..onClick = (event) {
                zonedExpect(event is react.SyntheticEvent, isTrue);
                onClickCalled = true;
              }
          ..onSelect = (event, key, href, target) {
                zonedExpect(key, equals('123'));
                onSelectCalled = true;
              }
        )();
        var renderedInstance = render(instance);
        var buttonRef = getRef(renderedInstance, 'hitarea');
        click(buttonRef);
        expect(onClickCalled, isTrue);
        expect(onSelectCalled, isTrue);
      });

      test('should not fire `onClick` or `onSelect` callbacks if `isDisabled` prop is set to `true`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var instance = (MenuItem()
          ..isDisabled = true
          ..eventKey = '123'
          ..onClick = (event) {
                zonedExpect(event is react.SyntheticEvent, isTrue);
                onClickCalled = true;
              }
          ..onSelect = (event, key, href, target) {
                zonedExpect(key, equals('123'));
                onSelectCalled = true;
              }
        )();
        var renderedInstance = render(instance);
        var buttonRef = getRef(renderedInstance, 'hitarea');
        click(buttonRef);
        expect(onClickCalled, isFalse);
        expect(onSelectCalled, isFalse);
      });
    });

    group('_validateTypeForNonFormElem', () {
      test('should send a warning message to the console', () {
        renderAndGetHitArea((MenuItem()
          ..domNodeName = DomNodeName.DIV
          ..type = ClickableDomInputType.SUBMIT
        ));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });

      test('should add a data- prefixed attribute equal to the invalid `type`', () {
        var renderedNode = renderAndGetHitArea((MenuItem()
          ..domNodeName = DomNodeName.DIV
          ..type = ClickableDomInputType.SUBMIT
        ));
        expect(renderedNode, hasAttr('data-wsr-invalid-type', 'submit')); // TODO: What should we use in place of `wsr`?
      });
    });

    // TODO: Test isClickable method
  });
}

class HitAreaTestComponentDefinition extends BaseComponentDefinition with HitAreaProps {
  HitAreaTestComponentDefinition(Map props) : super(null, props);
}

class HitAreaTestComponent extends BaseComponent<HitAreaTestComponentDefinition> with HitAreaMixin<HitAreaTestComponentDefinition> {
  HitAreaTestComponent():super() {
    props = getDefaultProps();
  }

  @override
  Map getDefaultProps() => (newProps()
    ..addProps(HitAreaMixin.defaultProps)
  );
  @override
  HitAreaTestComponentDefinition typedPropsFactory(Map propsMap) => new HitAreaTestComponentDefinition(propsMap);

  render() {
    return renderHitArea(copyProps(), tProps.children);
  }
}
