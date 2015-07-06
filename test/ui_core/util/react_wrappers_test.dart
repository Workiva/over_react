library react_wrappers_test;

import 'package:test/test.dart';
import 'package:react/react_client.dart';
import 'package:react/react.dart' as react;
import 'package:w_ui_platform/ui_core.dart';
import 'package:w_ui_platform/ui_components.dart';

import '../../test_util/react_util.dart';

/// Main entry point for react wrappers testing
main() {
  group('Dart wrappers for React:', () {
    group('cloneElement()', () {
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

          Map originalProps = getJsProps(original);
          Map cloneProps = getJsProps(clone);

          // Verify all props (children included) are equal.
          expect(cloneProps, equals(originalProps));
        });

        test('for a Dart component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original);

          // If these JsObject are equal, then they proxy the same JS props object.
          expect(clone[PROPS], isNot(equals(original[PROPS])));

          Map originalProps = getJsProps(original);
          Map cloneProps = getJsProps(clone);

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

          // The 'ref' property can only be used from within a render() method, so use RenderingContainerComponent
          // to clone and render the test component.
          var holder = RenderingContainerComponentFactory({
            'renderer': () {
              original = TestComponentFactory(originalKeyRefProps, testChildren);
              clone = cloneElement(original, overrideKeyRefProps);

              return clone;
            }
          });
          var renderedHolder = render(holder);

          // Verify that "key" and "ref" are overridden according to React
          expect(clone['key'], equals(overrideKeyRefProps['key']));
          expect(clone['ref'], equals(overrideKeyRefProps['ref']));

          var renderedClone = findRenderedDOMComponentWithType(renderedHolder, TestComponentFactory);

          // Verify that the "key" and "ref" props are overridden according to the Dart component.
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

          // Verify that children are overridden according to the Dart component.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps['children'], equals(testOverrideChildren));
        });
      });
    });

    group('isValidElement()', () {
      group('returns expected result when given', (){
        test('null', () {
          expect(isValidElement(null), isFalse);
        });

        test('a String', () {
          expect(isValidElement('Test String'), isFalse);
        });

        test('a List', () {
          expect(isValidElement(['item1', 'item2']), isFalse);
        });

        test('a ReactComponent', () {
          expect(isValidElement(Dom.div()()), isTrue);
        });
      });
    });

    group('isComponentOfType()', () {
      group('returns expected result when given', (){
        test('null', () {
          expect(isComponentOfType(null, Icon().componentFactory), isFalse);
        });

        test('a component and a component factory for a different component', () {
          expect(isComponentOfType(MenuItem()(), Icon().componentFactory), isFalse);
        });

        test('a component and its component factory', () {
          expect(isComponentOfType(Icon()(), Icon().componentFactory), isTrue);
        });
      });
    });

    group('isValidElementOfType()', () {
      group('returns expected result when given', (){
        test('null', () {
          expect(isValidElementOfType(null, Icon().componentFactory), isFalse);
        });

        test('a String', () {
          expect(isValidElementOfType('Test String', Icon().componentFactory), isFalse);
        });

        test('a List', () {
          expect(isValidElementOfType(['item1', 'item2'], Icon().componentFactory), isFalse);
        });

        test('a ReactComponent', () {
          expect(isValidElementOfType(Dom.div()(), Dom.div().componentFactory), isTrue);
        });
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

