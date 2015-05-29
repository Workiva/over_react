library react_wrappers;

import 'package:unittest/unittest.dart';
import 'package:react/react_client.dart';
import 'package:react/react.dart' as react;
import 'package:w_ui_platform/ui_core.dart';

import '../../test_util/react_util.dart';
import '../../test_util/custom_matchers.dart';

import 'dart:html';
import 'dart:js';

/// Main entry point for button group testing
main() {
  solo_group('cloneElement', () {
    const List testChildren = const ['child1', 'child2'];

    const Map testProps = const {
      'originalProp': 'original',
      'originalPropToOverride': 'original'
    };

    group('returns a clone', () {
      test('for a plain React JS component', () {
        var original = (Dom.div()..addProps(testProps))(testChildren);
        var clone = cloneElement(original);

        // If these JsObject are equal, then they proxy the same JS props object.
        expect(clone[PROPS], isNot(equals(original[PROPS])));

        Map originalProps = getJsProps(clone);
        Map cloneProps = getJsProps(original);

        // Verify all props (children included) are equal.
        expect(cloneProps, equals(originalProps));
      });

      test('for a Dart component', () {
        var original = CloneWithPropsTestComponentFactory(testProps, testChildren);
        var clone = cloneElement(original);

        // If these JsObject are equal, then they proxy the same JS props object.
        expect(clone[PROPS], isNot(equals(original[PROPS])));

        Map originalProps = getJsProps(clone);
        Map cloneProps = getJsProps(original);

        // Verify all props (children and react-dart internals included) are equal.
        expect(cloneProps, equals(originalProps));

        var dartRendered = getDartComponent(render(original));
        var dartRenderedClone = getDartComponent(render(clone));

        expect(dartRenderedClone, isNot(same(dartRendered)));
        expect(dartRenderedClone.props, equals(dartRendered.props));
      });
    });

    group('returns a clone with added/overridden props', () {
      const Map testPropsToAdd = const {
        'originalPropToOverride': 'clone',
        'propToAdd': 'clone'
      };

      const Map expectedPropsMerge = const {
        'originalProp': 'original',
        'originalPropToOverride': 'clone',
        'propToAdd': 'clone',

        'children': testChildren
      };

      test('for a plain React JS component', () {
        var original = (Dom.div()..addProps(testProps))(testChildren);
        var clone = cloneElement(original, testPropsToAdd);

        Map cloneProps = getJsProps(clone);

        // Verify all props (children included) are equal.
        expect(cloneProps, equals(expectedPropsMerge));
      });

      test('for a Dart component', () {
        var original = CloneWithPropsTestComponentFactory(testProps, testChildren);
        var clone = cloneElement(original, testPropsToAdd);

        var renderedClone = render(clone);

        // Verify all props are equal.
        Map cloneDartProps = getDartComponent(renderedClone).props;
        expect(cloneDartProps, equals(expectedPropsMerge));
      });
    });

    group('returns a clone with replaced children', () {
      const List testOverrideChildren = const ['child3', 'child4'];

      test('for a plain React JS component', () {
        var original = (Dom.div()..addProps(testProps))(testChildren);
        var clone = cloneElement(original, null, testOverrideChildren);

        Map cloneProps = getJsProps(clone);

        expect(cloneProps['children'], equals(testOverrideChildren));
      });

      test('for a Dart component', () {
        var original = CloneWithPropsTestComponentFactory(testProps, testChildren);
        var clone = cloneElement(original, null, testOverrideChildren);

        var renderedClone = render(clone);

        // Verify that children are overridden according to React
        Map cloneProps = getJsProps(renderedClone);
        expect(cloneProps['children'], equals(testOverrideChildren));

        // Verify that children are overridden according the Dart component.
        Map cloneDartProps = getDartComponent(renderedClone).props;
        expect(cloneDartProps['children'], equals(testOverrideChildren));
      });
    });
  });
}

ReactComponentFactory CloneWithPropsTestComponentFactory = react.registerComponent(() => new CloneWithPropsTestComponent());
class CloneWithPropsTestComponent extends react.Component {
  @override
  render() {
    return Dom.div()();
  }
}
