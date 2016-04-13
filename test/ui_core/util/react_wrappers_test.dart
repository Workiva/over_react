library react_wrappers_test;

import 'dart:html';

import 'package:js/js.dart';
import 'package:test/test.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/js_interop_helpers.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:web_skin_dart/test_util.dart';
import 'package:web_skin_dart/ui_core.dart';
import 'package:web_skin_dart/ui_components.dart';

import '../../wsd_test_util/test_js_component.dart';

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

          // If these objects are equal, then they proxy the same JS props object.
          expect(clone.props, isNot(equals(original.props)));

          Map originalProps = getJsProps(original);
          Map cloneProps = getJsProps(clone);

          // Verify all props (children included) are equal.
          expect(cloneProps, equals(originalProps));
        });

        test('for a Dart component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original);

          // If these objects are equal, then they proxy the same JS props object.
          expect(clone.props, isNot(equals(original.props)));

          Map originalProps = getJsProps(original);
          Map cloneProps = getJsProps(clone);

          // Verify all props (including children, excluding react-dart internals) are equal.
          Map originalShallowProps = new Map.from(originalProps);
          Map clonePropsShallowProps = new Map.from(cloneProps);
          originalShallowProps.remove('internal');
          clonePropsShallowProps.remove('internal');
          expect(originalShallowProps, equals(clonePropsShallowProps));

          // Verify react-dart internal props are equal.
          ReactDartComponentInternal originalInternal = originalProps['internal'];
          ReactDartComponentInternal clonePropsInternal = cloneProps['internal'];
          expect(originalInternal.props, equals(clonePropsInternal.props));

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
            var original = testJsComponentFactory(testProps, testChildren);
            var clone = cloneElement(original, testPropsToAdd);

            ReactComponent renderedClone = react_test_utils.renderIntoDocument(clone);
            PlainObjectPropsMap props = (renderedClone.props as PlainObjectPropsMap);

            var convertedStyle = props.style;
            expect(convertedStyle.width, equals('100rem'));
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
              var original = testJsComponentFactory(testProps, testChildren);
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
          expect(clone.key, equals(overrideKeyRefProps['key']));
          expect(clone.ref, equals(overrideKeyRefProps['ref']));
        });

        test('for a Dart component', () {
          ReactElement original;
          ReactElement clone;

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
          expect(clone.key, equals(overrideKeyRefProps['key']));
          expect(clone.ref, equals(overrideKeyRefProps['ref']));

          var renderedClone = react_test_utils.findRenderedComponentWithType(renderedHolder, TestComponentFactory);

          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps, isNot(anyOf(contains('key'), contains('ref'))),
              reason: '"key" and "ref" should not be visible to the rendered cloned component');
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

        test('a plain JS object', () {
          expect(isValidElement(new EmptyObject()), isFalse);
        });

        test('a ReactElement', () {
          ReactElement instance = Dom.div()();
          expect(isValidElement(instance), isTrue);
        });

        test('a ReactComponent', () {
          ReactComponent instance = render(TestComponentFactory({}));
          expect(isValidElement(instance), isFalse);
        });
      });
    });

    group('isDomElement()', () {
      group('returns expected result when given', (){
        test('a DOM component', () {
          expect(isDomElement(Dom.div()()), isTrue);
        });

        test('a Dart component', () {
          expect(isDomElement(TestComponentFactory({})), isFalse);
        });

        test('a JS composite component', () {
          expect(isDomElement(testJsComponentFactory()), isFalse);
        });

        test('null', () {
          expect(isDomElement(null), isFalse);
        });

        test('a String', () {
          expect(isDomElement('Test String'), isFalse);
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

    test('getInstanceKey returns the key set on a ReactElement', () {
      ReactElement instance = (Dom.div()..key = 'foo')();
      expect(getInstanceKey(instance), equals('foo'));
    });

    test('getInstanceRef returns the ref set on a ReactElement', () {
      ReactElement instance = (Dom.div()..ref = 'foo')();
      expect(getInstanceRef(instance), equals('foo'));
    });

    group('isDartComponent', () {
      test('returns true for an unrendered instance (ReactElement) of a Dart component', () {
        ReactElement instance = TestComponentFactory({});
        expect(isDartComponent(instance), isTrue);
      });

      test('returns false for an unrendered instance (ReactElement) of a JS composite component', () {
        ReactElement instance = testJsComponentFactory({});
        expect(isDartComponent(instance), isFalse);
      });

      test('returns false for an unrendered instance (ReactElement) of a DOM component', () {
        ReactElement instance = Dom.div()();
        expect(isDartComponent(instance), isFalse);
      });

      test('returns true for an mounted instance (ReactComponent) of a Dart component', () {
        var renderedInstance = render(TestComponentFactory({}));
        expect(isDartComponent(renderedInstance), isTrue);
      });

      test('returns false for an mounted instance (ReactComponent) of a JS composite component', () {
        var renderedInstance = render(testJsComponentFactory({}));
        expect(isDartComponent(renderedInstance), isFalse);
      });

      test('returns false for an mounted instance (ReactComponent) of a DOM component', () {
        var renderedInstance = render(Dom.div());
        expect(isDartComponent(renderedInstance), isFalse);
      });
    });

    group('getDartComponent', () {
      test('returns the correct Dart component that is rendered', () {
        var renderedInstance = render(Button());
        expect(getDartComponent(renderedInstance), new isInstanceOf<ButtonComponent>());
      });

      test('returns null for a JS composite component', () {
        var renderedInstance = render(testJsComponentFactory());
        expect(getDartComponent(renderedInstance), isNull);
      });

      test('returns null for a DOM component', () {
        var renderedInstance = render(Dom.div());
        expect(getDartComponent(renderedInstance), isNull);
      });
    });

    group('getProps', () {
      const List testChildren = const ['child1', 'child2'];
      const Map testStyle = const {'background': 'white'};

      test('returns props for a composite JS component ReactElement', () {
        ReactElement instance = render(testJsComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren));

        expect(getProps(instance), equals({
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        }));
      });

      test('returns props for a composite JS ReactComponent', () {
        ReactComponent renderedInstance = render(testJsComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren));

        expect(getProps(renderedInstance), equals({
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        }));
      });

      test('returns props for a DOM component ReactElement', () {
        ReactElement instance = (Dom.div()
          ..addProp('domProp', 'dom')
          ..style = testStyle
        )(testChildren);

        expect(getProps(instance), equals({
          'domProp': 'dom',
          'style': testStyle,
          'children': testChildren
        }));
      });

      test('returns props for a Dart component ReactElement', () {
        ReactElement instance = render(TestComponentFactory({
          'dartProp': 'dart',
          'style': testStyle,
        }, testChildren));

        expect(getProps(instance), equals({
          'dartProp': 'dart',
          'style': testStyle,
          'children': testChildren
        }));
      });

      test('returns props for a Dart component ReactComponent', () {
        ReactComponent renderedInstance = render(TestComponentFactory({
          'dartProp': 'dart',
          'style': testStyle,
        }, testChildren));

        expect(getProps(renderedInstance), equals({
          'dartProp': 'dart',
          'style': testStyle,
          'children': testChildren
        }));
      });

      group('throws when passed', () {
        test('a DOM ReactComponent (Element)', () {
          var renderedInstance = render(Dom.div());
          expect(() => getProps(renderedInstance), throwsArgumentError);
        });

        test('an empty JS object', () {
          expect(() => getProps(new EmptyObject()), throwsArgumentError);
        });

        test('a String', () {
          expect(() => getProps('string'), throwsArgumentError);
        });

        test('null', () {
          expect(() => getProps(null), throwsArgumentError);
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

@JS()
@anonymous
class PlainObjectPropsMap {
  external PlainObjectStyleMap get style;
}

@JS()
@anonymous
class PlainObjectStyleMap {
  external get width;
}
