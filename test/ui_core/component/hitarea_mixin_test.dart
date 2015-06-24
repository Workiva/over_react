import 'package:test/test.dart';
import '../../test_util/react_util.dart';
import '../../test_util/zone.dart';
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:react/react.dart';
import 'package:w_ui_platform/ui_core.dart';
import 'package:w_ui_platform/ui_components.dart';

import '../../test_util/custom_matchers.dart';
import 'dart:js';

render(definition) => renderDefinition(definition).firstChild;

main() {
  group('HitAreaMixin', () {
    // shared vars
    int warningCount;
    var hitarea;
    HitAreaTestComponent component;

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
      hitarea = null;
      component = null;
    });

    //
    // isActive
    //
    group('isActive prop', () {
      test('renders with appropriate CSS classes', () {
        // value not specified
        hitarea = render((MenuItem()));
        expect(hitarea, excludesClasses(['active']));
        // value = false
        hitarea = render((MenuItem()..isActive = false));
        expect(hitarea, excludesClasses(['active']));
        // value = true
        hitarea = render((MenuItem()..isActive = true));
        expect(hitarea, hasClasses(['active']));
      });
      test('should set `aria-selected` prop to make active hitarea accessible', () {
        hitarea = render((MenuItem()..isActive = true));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
      });
      test('should set `defaultChecked` prop for checkbox/radio elements', () {
        hitarea = render((MenuItem()
            ..isActive = true
            ..type = ClickableDomInputType.CHECKBOX
            ..id = 'checkbox1'
        ));
        expect(hitarea.defaultChecked, equals(true));
        hitarea = render((MenuItem()
            ..isActive = true
            ..type = ClickableDomInputType.RADIO
            ..id = 'radio1'
        ));
        expect(hitarea.defaultChecked, equals(true));
      });
    });

    //
    // isDisabled
    //
    group('isDisabled prop', () {
      test('renders with `disabled` prop false by default', () {
        // false by default
        hitarea = render((MenuItem()));
        expect(hitarea.disabled, equals(false));
      });
      test('when `true` should set `disabled` prop for non-`A` elements', () {
        hitarea = render((MenuItem()
          ..isDisabled = true));
        expect(hitarea.disabled, equals(true));
      });
      test('renders with appropriate CSS classes', () {
        // value not specified
        hitarea = render((MenuItem()));
        expect(hitarea, excludesClasses(['disabled']));
        expect(hitarea, excludesClasses(['disabled']));
        // value = false
        hitarea = render((MenuItem()
          ..isDisabled = false));
        expect(hitarea, excludesClasses(['disabled']));
        // value = true (<A> elements)
        hitarea = render((MenuItem()
          ..isDisabled = true
          ..href = '/url'));
        expect(hitarea, hasClasses(['disabled']));
        // value = true (non-<A> elements)
        hitarea = render((MenuItem()
          ..isDisabled = true));
        expect(hitarea, excludesClasses(['disabled']));
      });
      test('should set `aria-disabled` prop to make disabled hitarea accessible when `disabled` CSS class is applied', () {
        hitarea = render((MenuItem()
          ..href = '/url'
          ..isDisabled = true
        ));
        expect(hitarea.getAttribute('aria-disabled'), equals('true'));
      });
    });

    //
    // isNavItem
    //
    group('isNavItem prop', () {
      test('renders hitarea without nav-item CSS classes', () {
        hitarea = render((MenuItem()..isNavItem = true));
        expect(hitarea, hasClasses(['hitarea']));
        expect(hitarea, excludesClasses(['nav-item']));
      });
      test('when "true" should cause `getValidatedHitAreaProps` to add the "navItem" prop', () {
        component = new HitAreaTestComponent();
        component.tProps.isNavItem = true;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.navItem, equals(true));
      });
      test('when "true" should not apply "active" class to hitarea', () {
        // isNavItem not specified
        hitarea = render((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(hitarea, excludesClasses(['active']));
      });
      test('when "true" should set `aria-selected` prop to make active hitarea accessible', () {
        // isNavItem not specified
        hitarea = render((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
      });
    });

    //
    // isNavDropdown
    //
    group('isNavDropdown prop', () {
      test('renders hitarea without nav-item or nav-item CSS classes', () {
        hitarea = render((MenuItem()..isNavDropdown = true));
        expect(hitarea, hasClasses(['hitarea']));
        expect(hitarea, excludesClasses(['nav-item']));
      });
      test('when "true" should cause `getValidatedHitAreaProps` to add the "navItem" and "navDropdown" props', () {
        component = new HitAreaTestComponent();
        component.tProps.isNavDropdown = true;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.navItem, equals(true));
        expect(hitAreaProps.navDropdown, equals(true));
      });
      test('when "true" should not apply "active" class', () {
        // isNavItem not specified
        hitarea = render((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(hitarea, excludesClasses(['active']));
      });
      test('when "true" should set `aria-selected` prop to make active hitarea accessible', () {
        // isNavItem not specified
        hitarea = render((MenuItem()
          ..href = '/url'
          ..isNavItem = true
          ..isActive = true
        ));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
      });
    });

    //
    // checkbox elements
    //
    group('with `type` prop set to "checkbox"', () {
      test('should set `role` prop to "button"', () {
        hitarea = render((MenuItem()
          ..id = 'test_hitarea_component2'
          ..type = ClickableDomInputType.CHECKBOX
        ));
        expect(hitarea.getAttribute('role'), equals('button'));
      });
      test('should warn the consumer if `id` prop is not set', () {
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.CHECKBOX
        ));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should add a `inputId` prop and set it to null (when `id` prop is not set)', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.CHECKBOX;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.inputId, isNull);
      });
      test('should add a `inputRef` prop and set it equal to the `type` prop', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.CHECKBOX;
        component.tProps.id = 'test_hitarea_component_3';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.inputRef, equals(component.tProps.type));
      });
      test('should add a `inputId` prop and set it equal to the `id` prop with a _{type} suffix', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.CHECKBOX;
        component.tProps.id = 'test_hitarea_component_3';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.inputId, equals("${hitAreaProps['id']}_${hitAreaProps['type']}"));
      });
      test('should add a `buttonRef` prop and set it equal to the `inputRef` prop with a "_button" suffix', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.CHECKBOX;
        component.tProps.id = 'test_hitarea_component_3';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.buttonRef, equals("${hitAreaProps.inputRef}_button"));
      });
    });

    //
    // radio elements
    //
    group('with `type` prop set to "radio"', () {
      test('should set `role` prop to "button"', () {
        hitarea = render((MenuItem()
          ..id = 'test_hitarea_component'
          ..type = ClickableDomInputType.RADIO
        ));
        expect(hitarea.getAttribute('role'), equals('button'));
      });
      test('should warn the consumer if `id` prop is not set', () {
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.RADIO
          ..name = 'test_hitarea_radio_group'
        ));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should warn the consumer if `name` prop is not set', () {
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.RADIO
          ..id = 'test_hitarea_component'
        ));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should add a `inputId` prop and set it to null (when `id` prop is not set)', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.RADIO;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.inputId, isNull);
      });
      test('should add a `inputRef` prop and set it equal to the `type` prop', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.RADIO;
        component.tProps.id = 'test_hitarea_component_3';
        component.tProps.name = 'test_hitarea_component_3_group';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.inputRef, equals(component.tProps.type));
      });
      test('should add a `inputId` prop and set it equal to the `id` prop with a _{type} suffix', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.RADIO;
        component.tProps.id = 'test_hitarea_component_3';
        component.tProps.name = 'test_hitarea_component_3_group';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.inputId, equals("${hitAreaProps['id']}_${hitAreaProps['type']}"));
      });
      test('should add a `buttonRef` prop and set it equal to the `inputRef` prop with a "_button" suffix', () {
        component = new HitAreaTestComponent();
        component.tProps.type = ClickableDomInputType.RADIO;
        component.tProps.id = 'test_hitarea_component_3';
        component.tProps.name = 'test_hitarea_component_3_group';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.buttonRef, equals("${hitAreaProps.inputRef}_button"));
      });
    });

    //
    // checked/defaultChecked props
    //
    group('when `checked` or `defaultChecked` prop is set', () {
      test('should add `active` class and `aria-selected` attribute for checkbox/radio elements', () {
        // checkbox
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.CHECKBOX
          ..id = 'checkbox1'
          ..isActive = false
          ..addProp('checked', true)
        ));
        expect(hitarea.checked, equals(true));
        expect(hitarea.defaultChecked, equals(true));
        expect(hitarea, hasClasses(['active']));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
        // radio
        hitarea = render((MenuItem()
          ..isActive = false
          ..type = ClickableDomInputType.RADIO
          ..id = 'radio1'
          ..addProp('defaultChecked', true)
        ));
        expect(hitarea.defaultChecked, equals(true));
        expect(hitarea, hasClasses(['active']));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
      });
    });
    group('when `checked` prop is set', () {
      test('should set defaultChecked prop for checkbox/radio elements', () {
        // checkbox
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.CHECKBOX
          ..id = 'checkbox1'
          ..addProp('checked', true)
        ));
        expect(hitarea.checked, equals(true));
        expect(hitarea.defaultChecked, equals(true));
        // radio
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.RADIO
          ..id = 'radio1'
          ..addProp('checked', true)
        ));
        expect(hitarea.checked, equals(true));
        expect(hitarea.defaultChecked, equals(true));
        expect(hitarea, hasClasses(['active']));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
      });
      test('should add `active` class and `aria-selected` attribute for checkbox/radio elements', () {
        // checkbox
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.CHECKBOX
          ..id = 'checkbox1'
          ..addProp('checked', true)
        ));
        expect(hitarea.checked, equals(true));
        expect(hitarea.defaultChecked, equals(true));
        expect(hitarea, hasClasses(['active']));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
        // radio
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.RADIO
          ..id = 'radio1'
          ..addProp('checked', true)
        ));
        expect(hitarea.defaultChecked, equals(true));
        expect(hitarea, hasClasses(['active']));
        expect(hitarea.getAttribute('aria-selected'), equals('true'));
      });
    });

    //
    // anchor elements
    //
    group('with anchor elements', () {
      test('should set `role` prop to "button" when `href` prop is "#"', () {
        hitarea = render((MenuItem()
            ..href = "#"
        ));
        expect(hitarea.getAttribute('role'), equals('button'));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should set `role` prop to "button" when no `href`, `target` or `name` prop is set', () {
        hitarea = render((MenuItem()
          ..domNodeName = DomNodeName.A
        ));
        expect(hitarea.getAttribute('role'), equals('button'));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
    });

    //
    // renderer assignment
    //
    group('renderer assigned', () {
      test('should render an `input` when type is "checkbox" or "radio"', () {
        component = new HitAreaTestComponent();
        component.tProps.id = 'test_id_1';
        // checkbox
        component.tProps.type = ClickableDomInputType.CHECKBOX;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.INPUT));
        // radio
        component.tProps.type = ClickableDomInputType.RADIO;
        hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.INPUT));
      });
      test('should render a `button` element by default', () {
        component = new HitAreaTestComponent();
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
      });
      test('should render an `a` element when domNodeName == `DomNodeName.A`', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.A;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });
      test('should render an `a` element when href prop is present', () {
        component = new HitAreaTestComponent();
        component.tProps.href = '/url';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });
      test('should overrides domNodeName value when href is set', () {
        component = new HitAreaTestComponent();
        component.tProps.href = '/url';
        component.tProps.domNodeName = DomNodeName.INPUT;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });
      test('should render an `a` element when target prop is present', () {
        component = new HitAreaTestComponent();
        component.tProps.target = '_blank';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
      });
      test('should render `button` when prop type == DomInputType.SUBMIT', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.INPUT;
        component.tProps.type = ClickableDomInputType.SUBMIT;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should render `button` when prop type == DomInputType.RESET', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.INPUT;
        component.tProps.type = ClickableDomInputType.RESET;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(hitAreaProps.type, equals(ClickableDomInputType.RESET));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should render `button` when prop type == DomInputType.BUTTON', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.INPUT;
        component.tProps.type = ClickableDomInputType.BUTTON;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(hitAreaProps.type, equals(ClickableDomInputType.BUTTON));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('type prop should pass through even when domNodeName is changed', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.INPUT;
        component.tProps.type = ClickableDomInputType.SUBMIT;
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.BUTTON));
        expect(hitAreaProps.type, equals(ClickableDomInputType.SUBMIT));
      });
    });

    //
    // invalid props
    //
    group('when domNodeName == DomNodeName.DIV, but has invalid props', () {
      test('should render "a" when href prop is present', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.DIV;
        component.tProps.href = '/url';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should render "a" when target prop is present', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.DIV;
        component.tProps.target = '_blank';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
    });
    group('when domNodeName == DomNodeName.BUTTON, but has invalid props', () {
      test('should render "a" when href prop is present', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.BUTTON;
        component.tProps.href = '/url';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should render "a" when target prop is present', () {
        component = new HitAreaTestComponent();
        component.tProps.domNodeName = DomNodeName.BUTTON;
        component.tProps.target = '_blank';
        var hitAreaProps = component.getValidatedHitAreaProps(component.props, []);
        expect(hitAreaProps.renderer, equals(HitAreaRenderer.ANCHOR));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
    });
    group('role prop', () {
      test('should be set to "button" when domNodeName == DomNodeName.DIV', () {
        hitarea = render((MenuItem()
          ..domNodeName = DomNodeName.DIV
        ));
        expect(hitarea.getAttribute('role'), equals('button'));
      });
    });
    group('type prop', () {
      test('should be set to "button" by default', () {
        hitarea = render((MenuItem()
        ));
        expect(hitarea.type, equals('button'));
      });
      test('should be set to "button" when type prop == DomInputType.BUTTON', () {
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.BUTTON
        ));
        expect(hitarea.type, equals('button'));
      });
      test('should be set to "submit" when type prop == DomInputType.SUBMIT', () {
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.SUBMIT
        ));
        expect(hitarea.type, equals('submit'));
      });
      test('should be set to "reset" when type prop == DomInputType.RESET', () {
        hitarea = render((MenuItem()
          ..type = ClickableDomInputType.RESET
        ));
        expect(hitarea.type, equals('reset'));
      });
    });

    //
    // click handling
    //
    group('handleClick', () {
      test('should fire callback defined in `onSelect` prop', () {
        bool onSelectCalled = false;
        var hitarea = (MenuItem()
          ..eventKey = '123'
          ..onSelect = (event, key, href, target) {
            zonedExpect(key, equals('123'));
            onSelectCalled = true;
          }
        )();
        JsObject reactInstance = react_test_utils.renderIntoDocument(hitarea);
        JsObject renderedDOMComponent = react_test_utils.findRenderedDOMComponentWithTag(reactInstance, "button");
        react_test_utils.Simulate.click(renderedDOMComponent);
        expect(onSelectCalled, equals(true));
      });
      test('should fire callback defined in `onClick` prop', () {
        bool onClickCalled = false;
        var hitarea = (MenuItem()
          ..onClick = (event) {
            zonedExpect(event is SyntheticEvent, equals(true));
            onClickCalled = true;
          }
        )();
        JsObject reactInstance = react_test_utils.renderIntoDocument(hitarea);
        JsObject renderedDOMComponent = react_test_utils.findRenderedDOMComponentWithTag(reactInstance, "button");
        react_test_utils.Simulate.click(renderedDOMComponent);
        expect(onClickCalled, equals(true));
      });
      test('should NOT fire callback defined in `onClick` prop when `isDisabled == true`', () {
        bool onClickCalled = false;
        var hitarea = (MenuItem()
          ..href = '/url'
          ..isDisabled = true
          ..onClick = (event) {
            onClickCalled = true;
          }
        )();
        JsObject reactInstance = react_test_utils.renderIntoDocument(hitarea);
        JsObject renderedDOMComponent = react_test_utils.findRenderedDOMComponentWithTag(reactInstance, "a");
        react_test_utils.Simulate.click(renderedDOMComponent);
        expect(onClickCalled, equals(false));
      });
      test('should fire both `onClick` and `onSelect` callbacks if `onClick` callback returns `true`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var hitarea = (MenuItem()
          ..eventKey = '123'
          ..onClick = (event) {
            zonedExpect(event is SyntheticEvent, equals(true));
            onClickCalled = true;
            return true;
          }
          ..onSelect = (event, key, href, target) {
            zonedExpect(key, equals('123'));
            onSelectCalled = true;
          }
        )();
        JsObject reactInstance = react_test_utils.renderIntoDocument(hitarea);
        JsObject renderedDOMComponent = react_test_utils.findRenderedDOMComponentWithTag(reactInstance, "button");
        react_test_utils.Simulate.click(renderedDOMComponent);
        expect(onClickCalled, equals(true));
        expect(onSelectCalled, equals(true));
      });
      test('should not call `onSelect` callback if `onClick` callback returns `false`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var hitarea = (MenuItem()
          ..eventKey = '123'
          ..onClick = (event) {
            zonedExpect(event is SyntheticEvent, equals(true));
            onClickCalled = true;
            return false;
          }
          ..onSelect = (event, key, href, target) {
            zonedExpect(key, equals('123'));
            onSelectCalled = true;
          }
        )();
        JsObject reactInstance = react_test_utils.renderIntoDocument(hitarea);
        JsObject renderedDOMComponent = react_test_utils.findRenderedDOMComponentWithTag(reactInstance, "button");
        react_test_utils.Simulate.click(renderedDOMComponent);
        expect(onClickCalled, equals(true));
        expect(onSelectCalled, equals(false));
      });
      test('should fire both `onClick` and `onSelect` callbacks if `onClick` callback does not return a value', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var hitarea = (MenuItem()
          ..eventKey = '123'
          ..onClick = (event) {
            zonedExpect(event is SyntheticEvent, equals(true));
            onClickCalled = true;
          }
          ..onSelect = (event, key, href, target) {
            zonedExpect(key, equals('123'));
            onSelectCalled = true;
          }
        )();
        JsObject reactInstance = react_test_utils.renderIntoDocument(hitarea);
        JsObject renderedDOMComponent = react_test_utils.findRenderedDOMComponentWithTag(reactInstance, "button");
        react_test_utils.Simulate.click(renderedDOMComponent);
        expect(onClickCalled, equals(true));
        expect(onSelectCalled, equals(true));
      });
      test('should not fire `onClick` or `onSelect` callbacks if `isDisabled` prop is set to `true`', () {
        bool onClickCalled = false;
        bool onSelectCalled = false;
        var hitarea = (MenuItem()
          ..isDisabled = true
          ..eventKey = '123'
          ..onClick = (event) {
            zonedExpect(event is SyntheticEvent, equals(true));
            onClickCalled = true;
          }
          ..onSelect = (event, key, href, target) {
            zonedExpect(key, equals('123'));
            onSelectCalled = true;
          }
        )();
        JsObject reactInstance = react_test_utils.renderIntoDocument(hitarea);
        JsObject renderedDOMComponent = react_test_utils.findRenderedDOMComponentWithTag(reactInstance, "button");
        react_test_utils.Simulate.click(renderedDOMComponent);
        expect(onClickCalled, equals(false));
        expect(onSelectCalled, equals(false));
      });
    });

    //
    // _validateTypeForNonFormElem
    //
    group('_validateTypeForNonFormElem', () {
      test('should send a warning message to the console', () {
        hitarea = render((MenuItem()
          ..domNodeName = DomNodeName.DIV
          ..type = ClickableDomInputType.SUBMIT
        ));
        expect(ValidationUtil.WARNING_COUNT, greaterThan(warningCount));
      });
      test('should add a data- prefixed attribute equal to the invalid `type`', () {
        hitarea = render((MenuItem()
          ..domNodeName = DomNodeName.DIV
          ..type = ClickableDomInputType.SUBMIT
        ));
        expect(hitarea.getAttribute('data-wsr-invalid-type'), equals('submit')); // TODO: What should we use in place of `wsr`?
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
