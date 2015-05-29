library react_wrappers;

import 'package:unittest/unittest.dart';
import 'package:react/react_client.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:w_ui_platform/ui_core.dart';

import '../../test_util/react_util.dart';

/// Main entry point for button group testing
main() {
  group('cloneElement', () {
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
        var original = TestComponentFactory(testProps, testChildren);
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
        var original = TestComponentFactory(testProps, testChildren);
        var clone = cloneElement(original, testPropsToAdd);

        var renderedClone = render(clone);

        // Verify all props are equal.
        Map cloneDartProps = getDartComponent(renderedClone).props;
        expect(cloneDartProps, equals(expectedPropsMerge));
      });
    });

    group('updates the "key" and "ref" props properly', () {
      const Map originalKeyRefProps = const {
        'key': 'original',
        'ref': 'original'
      };

      const Map overrideKeyRefProps = const {
        'key': 'clone',
        'ref': 'clone'
      };

      test('for a plain React JS component', () {
        var original = (Dom.div()..addProps(originalKeyRefProps))(testChildren);
        var clone = cloneElement(original, overrideKeyRefProps);

        // Verify that "key" and "ref" are overridden according to React
        expect(clone['key'], equals(overrideKeyRefProps['key']));
        expect(clone['ref'], equals(overrideKeyRefProps['ref']));
      });

      test('for a Dart component', () {
        var original, clone;

        var holder = RenderingContainerComponentFactory({
          'renderer': () {
            original = TestComponentFactory(originalKeyRefProps, testChildren);
            clone = cloneElement(original, overrideKeyRefProps);

            return clone;
          }
        });
        var renderedHolder = render(holder);

        // We want to do the following line... but test utils are currently broken.
        // TODO swap out when https://github.com/cleandart/react-dart/pull/55 merges and gets released.
        // var renderedClone = react_test_utils.findRenderedComponentWithType(renderedHolder, TestComponentFactory);
        var renderedClone = getRef(renderedHolder, 'clone');
        // If we can't get the element by ref here, then it probably didn't work...
        expect(renderedClone, isNotNull);

        // Verify that "key" and "ref" are overridden according to React
        expect(clone['key'], equals(overrideKeyRefProps['key']));
        expect(clone['ref'], equals(overrideKeyRefProps['ref']));

        // Verify that the "key" and "ref" props are overridden according the Dart component.
        Map cloneDartProps = getDartComponent(renderedClone).props;
        expect(cloneDartProps['key'], equals(overrideKeyRefProps['key']));
        expect(cloneDartProps['ref'], equals(overrideKeyRefProps['ref']));
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
        var original = TestComponentFactory(testProps, testChildren);
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

/// Helper component for testing a Dart (react-dart) React component with cloneElement.
ReactComponentFactory TestComponentFactory = react.registerComponent(() => new TestComponent());
class TestComponent extends react.Component {
  @override
  render() => Dom.div()();
}

/// Helper component that renders whatever you tell it to. Necessary for rendering components with the 'ref' prop.
ReactComponentFactory RenderingContainerComponentFactory = react.registerComponent(() => new RenderingContainerComponent());
class RenderingContainerComponent extends react.Component {
  @override
  render() => props['renderer']();
}
