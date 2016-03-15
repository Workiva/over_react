library react_wrappers_test;

import 'dart:html';
import 'dart:js';

import 'package:test/test.dart';
import 'package:react/react_client.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

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

      group('properly converts props for', () {
        group('style Maps', () {
          const Map testPropsToAdd = const {
            'style': const {'width': '100rem'}
          };

          test('for DOM components', () {
            var original = (Dom.div()..addProps(testProps))(testChildren);
            var clone = cloneElement(original, testPropsToAdd);

            var renderedClone = react_test_utils.renderIntoDocument(clone);
            var renderedCloneNode = findDomNode(renderedClone);

            expect(renderedCloneNode.style.width, equals('100rem'));
          });

          test('for JS composite components', () {
            var original = testJsComponentFactory.apply([testProps, testChildren]);
            var clone = cloneElement(original, testPropsToAdd);

            var renderedClone = react_test_utils.renderIntoDocument(clone);
            Map cloneProps = getJsProps(renderedClone);

            var convertedStyle = cloneProps['style'];
            expect(convertedStyle, new isInstanceOf<JsObject>(), reason: 'style should have been converted to a JS map for React JS consumption');
            expect(convertedStyle['width'], equals('100rem'));
          });

          group(', except', () {
            test('for Dart components', () {
              var original = TestComponentFactory(testProps, testChildren);
              var clone = cloneElement(original, testPropsToAdd);

              var renderedClone = react_test_utils.renderIntoDocument(clone);
              Map cloneProps = getDartComponent(renderedClone).props;

              var style = cloneProps['style'];
              expect(style, same(testPropsToAdd['style']), reason: 'style should be the same object passed in, unaltered');
            });
          });
        });

        group('event callbacks', () {
          Map testPropsToAdd;
          bool onClickWasCalled;

          setUp(() {
            onClickWasCalled = false;

            testPropsToAdd = {
              'onClick': (_) {
                onClickWasCalled = true;
              }
            };
          });

          test('for DOM components', () {
            var original = (Dom.div()..addProps(testProps))(testChildren);
            var clone = cloneElement(original, testPropsToAdd);

            var renderedClone = react_test_utils.renderIntoDocument(clone);

            expect(() {
              react_test_utils.Simulate.click(renderedClone);
            }, returnsNormally, reason: 'should not throw due to mismatched arguments or otherwise');
            expect(onClickWasCalled, isTrue, reason: 'event handler that was added via cloning was not called');
          });

          group(', except', () {
            test('for JS composite components', () {
              var original = testJsComponentFactory.apply([testProps, testChildren]);
              var clone = cloneElement(original, testPropsToAdd);

              var renderedClone = react_test_utils.renderIntoDocument(clone);
              Map cloneProps = getJsProps(renderedClone);

              expect(() {
                // Retrieve an automatically JS-proxied version of the callback passed to the component.
                var callback = cloneProps['onClick'];
                // Call the method with one arg.
                callback(null);
              }, returnsNormally, reason: 'should not throw due to mismatched arguments or otherwise');
              expect(onClickWasCalled, isTrue, reason: 'event handler that was added via cloning was not called');
            });

            test('for Dart components', () {
              var original = TestComponentFactory(testProps, testChildren);
              var clone = cloneElement(original, testPropsToAdd);

              var renderedClone = react_test_utils.renderIntoDocument(clone);
              Map cloneProps = getDartComponent(renderedClone).props;

              expect(() {
                // Retrieve the callback passed to the component.
                Function callback = cloneProps['onClick'];
                // Call the method with one arg.
                callback(null);
              }, returnsNormally, reason: 'should not throw due to mismatched arguments or otherwise');
              expect(onClickWasCalled, isTrue, reason: 'event handler that was added via cloning was not called');
            });
          });
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

          var renderedClone = react_test_utils.findRenderedComponentWithType(renderedHolder, TestComponentFactory);

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

      test('preserves callback refs correctly', () {
        var flag = false;
        var callbackRef = (instance) {
          flag = true;
          expect(instance.runtimeType, equals(TestComponent));
        };

        // The 'ref' property can only be used from within a render() method, so use RenderingContainerComponent
        // to clone and render the test component.
        var holder = RenderingContainerComponentFactory({
          'renderer': () {
            var original = TestComponentFactory({'ref': callbackRef}, testChildren);
            var clone = cloneElement(original, {});

            return clone;
          }
        });

        render(holder);

        expect(flag, isTrue);
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

    group('isDomComponent()', () {
      group('returns expected result when given', (){
        test('a DOM component', () {
          expect(isDomComponent(Dom.div()()), isTrue);
        });

        test('a Dart component', () {
          expect(isDomComponent(TestComponentFactory({})), isFalse);
        });

        test('a JS composite component', () {
          expect(isDomComponent(testJsComponentFactory.apply([])), isFalse);
        });

        test('null', () {
          expect(isDomComponent(null), isFalse);
        });

        test('a String', () {
          expect(isDomComponent('Test String'), isFalse);
        });
      });
    });

    group('isMounted', () {
      test('returns true for a component that has been mounted', () {
        var mountNode = new DivElement();
        var renderedInstance = react.render(react.div({}), mountNode);
        expect(isMounted(renderedInstance), isTrue);
      });

      test('returns false for a component that has been umounted', () {
        var mountNode = new DivElement();
        var renderedInstance = react.render(react.div({}), mountNode);
        react.unmountComponentAtNode(mountNode);
        expect(isMounted(renderedInstance), isFalse);
      });
    });

    group('getDartComponent', () {
      test('returns the correct Dart component that is rendered', () {
        var renderedInstance = render(Button());
        expect(getDartComponent(renderedInstance), new isInstanceOf<ButtonComponent>());
      });

      test('returns null is JS Object is not Dart based', () {
        var renderedInstance = render(Dom.div());
        expect(getDartComponent(renderedInstance), isNull);
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

JsFunction _testJsComponentFactory;
JsFunction get testJsComponentFactory {
  if (_testJsComponentFactory == null) {
    JsObject React = context['React'];

    var componentClass = React.callMethod('createClass', [new JsObject.jsify({
      'displayName': 'testJsComponent',
      'render': () => Dom.div()('test js component')
    })]);

    _testJsComponentFactory = React.callMethod('createFactory', [componentClass]);
  }

  return _testJsComponentFactory;
}
