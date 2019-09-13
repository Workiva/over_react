// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

@JS()
library react_wrappers_test;

import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';

import '../../test_util/one_level_wrapper.dart';
import '../../test_util/test_util.dart';
import '../../test_util/two_level_wrapper.dart';

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
          expect(clone.props, isNot(original.props));

          Map originalProps = unconvertJsProps(original);
          Map cloneProps = unconvertJsProps(clone);

          // Verify all props (children included) are equal.
          expect(cloneProps, originalProps);
        });

        test('for a Dart component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original);

          // If these objects are equal, then they proxy the same JS props object.
          expect(clone.props, isNot(original.props));

          Map originalProps = unconvertJsProps(original);
          Map cloneProps = unconvertJsProps(clone);

          // Verify all props (including children, excluding react-dart internals) are equal.
          Map originalShallowProps = new Map.from(originalProps);
          Map clonePropsShallowProps = new Map.from(cloneProps);
          originalShallowProps.remove('internal');
          clonePropsShallowProps.remove('internal');
          expect(originalShallowProps, clonePropsShallowProps);

          // Verify react-dart internal props are equal.
          ReactDartComponentInternal originalInternal = originalProps['internal'];
          ReactDartComponentInternal clonePropsInternal = cloneProps['internal'];
          expect(originalInternal.props, clonePropsInternal.props);

          var dartRendered = getDartComponent(render(original));
          var dartRenderedClone = getDartComponent(render(clone));

          expect(dartRenderedClone, isNot(same(dartRendered)));
          expect(dartRenderedClone.props, dartRendered.props);
        });

        test('for a Dart component version 2', () {
          var original = TestComponent2Factory(testProps, testChildren);
          var clone = cloneElement(original);

          // If these objects are equal, then they proxy the same JS props object.
          expect(clone.props, isNot(original.props));

          Map originalProps = unconvertJsProps(original);
          Map cloneProps = unconvertJsProps(clone);

          // Verify all props (including children, excluding react-dart internals) are equal.
          Map originalShallowProps = new Map.from(originalProps);
          Map clonePropsShallowProps = new Map.from(cloneProps);
          expect(originalShallowProps, clonePropsShallowProps);

          var dartRendered = getDartComponent(render(original));
          var dartRenderedClone = getDartComponent(render(clone));

          expect(dartRenderedClone, isNot(same(dartRendered)));
          expect(dartRenderedClone.props, dartRendered.props);
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

          Map cloneProps = unconvertJsProps(clone);

          // Verify all props (children included) are equal.
          expect(cloneProps, expectedPropsMerge);
        });

        test('for a Dart component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original, testPropsToAdd);

          var renderedClone = render(clone);

          // Verify all props are equal.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps, expectedPropsMerge);
        });

        test('for a Dart component version 2', () {
          var original = TestComponent2Factory(testProps, testChildren);
          var clone = cloneElement(original, testPropsToAdd);

          var renderedClone = render(clone);

          // Verify all props are equal.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps, expectedPropsMerge);
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

            expect(renderedCloneNode.style.width, '100rem');
          });

          test('for JS composite components', () {
            var original = testJsComponentFactory(testProps, testChildren);
            var clone = cloneElement(original, testPropsToAdd);

            ReactComponent renderedClone = react_test_utils.renderIntoDocument(clone);
            var props = renderedClone.props as PlainObjectPropsMap; // ignore: avoid_as

            var convertedStyle = props.style;
            expect(convertedStyle.width, '100rem');
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

            test('for Dart components version 2', () {
              var original = TestComponent2Factory(testProps, testChildren);
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
              Map cloneProps = unconvertJsProps(renderedClone);

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
              expect(onClickWasCalled, isTrue, reason: 'event handler that was added via cloning was not called');
            });

            test('for Dart components version 2', () {
              var original = TestComponent2Factory(testProps, testChildren);
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
        var originalRefCalled = false;
        var cloneRefCalled = false;
        Map originalKeyRefProps = {
          'key': 'original',
          'ref': (ref) { originalRefCalled = true; }
        };

        Map overrideKeyRefProps = {
          'key': 'clone',
          'ref': allowInterop((ref) { cloneRefCalled = true; })
        };

        tearDown((){
          originalRefCalled = false;
          cloneRefCalled = false;
        });

        test('for a plain React JS component', () {
          var original = (Dom.div()..addProps(originalKeyRefProps))(testChildren);
          var clone = cloneElement(original, overrideKeyRefProps);

          // Verify that "key" and "ref" are overridden according to React
          expect(clone.key, overrideKeyRefProps['key']);
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
          expect(clone.key, overrideKeyRefProps['key']);
          expect(cloneRefCalled, isTrue);

          var renderedClone = react_test_utils.findRenderedComponentWithTypeV2(renderedHolder, TestComponentFactory);

          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps, isNot(anyOf(contains('key'), contains('ref'))),
              reason: '"key" and "ref" should not be visible to the rendered cloned component');
        });

        test('for a Dart component version 2', () {
          ReactElement original;
          ReactElement clone;

          // The 'ref' property can only be used from within a render() method, so use RenderingContainerComponent
          // to clone and render the test component.
          var holder = RenderingContainerComponentFactory({
            'renderer': () {
              original = TestComponent2Factory(originalKeyRefProps, testChildren);
              clone = cloneElement(original, overrideKeyRefProps);

              return clone;
            }
          });
          render(holder);

          // Verify that "key" and "ref" are overridden according to React
          expect(clone.key, overrideKeyRefProps['key']);
          expect(cloneRefCalled, isTrue);
        });
      });

      group('returns a clone with replaced children', () {
        const List testOverrideChildren = const ['child3', 'child4'];

        test('for a plain React JS component', () {
          var original = (Dom.div()..addProps(testProps))(testChildren);
          var clone = cloneElement(original, null, testOverrideChildren);

          Map cloneProps = unconvertJsProps(clone);

          expect(cloneProps['children'], testOverrideChildren);
        });

        test('for a Dart component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original, null, testOverrideChildren);

          var renderedClone = render(clone);

          // Verify that children are overridden according to React
          Map cloneProps = unconvertJsProps(renderedClone);
          expect(cloneProps['children'], testOverrideChildren);

          // Verify that children are overridden according to the Dart component.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps['children'], testOverrideChildren);
        });

        test('for a Dart component version 2', () {
          var original = TestComponent2Factory(testProps, testChildren);
          var clone = cloneElement(original, null, testOverrideChildren);

          var renderedClone = render(clone);

          // Verify that children are overridden according to React
          Map cloneProps = unconvertJsProps(renderedClone);
          expect(cloneProps['children'], testOverrideChildren);

          // Verify that children are overridden according to the Dart component.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps['children'], testOverrideChildren);
        });
      });

      test('preserves callback refs correctly', () {
        var flag = false;
        var runtimeType;
        var callbackRef = (instance) {
          flag = true;
          runtimeType = instance.runtimeType;
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
        expect(runtimeType, TestComponent);
      });

      test('throws an argument error if element is null', (){
        expect(() => cloneElement(null), throwsArgumentError,
            reason: 'To ensure a consumer friendly error message, the '
                'function should short circuit and provide the Argument Error.');
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
          expect(isValidElement(newObject()), isFalse);
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

    test('getInstanceKey returns the key set on a ReactElement', () {
      ReactElement instance = (Dom.div()..key = 'foo')();
      expect(getInstanceKey(instance), 'foo');
    });

    test('getInstanceRef returns the ref set on a ReactElement', () {
      ReactElement instance = (Dom.div()..ref = 'foo')();
      expect(getInstanceRef(instance), 'foo');
    });

    group('isDartComponent', () {
      test('returns true for an unrendered instance (ReactElement) of a Dart Component', () {
        ReactElement instance = TestComponentFactory({});
        expect(isDartComponent(instance), isTrue);
      });

      test('returns true for an unrendered instance (ReactElement) of a Dart Component2', () {
        ReactElement instance = TestComponent2Factory({});
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

      test('returns true for an mounted instance (ReactComponent) of a Dart Component', () {
        var renderedInstance = render(TestComponentFactory({}));
        expect(isDartComponent(renderedInstance), isTrue);
      });

      test('returns true for an mounted instance (ReactComponent) of a Dart Component2', () {
        var renderedInstance = render(TestComponent2Factory({}));
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

      test('throws ArgumentError when passed null', () {
        expect(() => isDartComponent(null), throwsArgumentError);
      });
    });

    group('getDartComponent', () {
      test('returns the correct Dart Component that is rendered', () {
        var renderedInstance = render(Wrapper());
        expect(getDartComponent(renderedInstance), const TypeMatcher<WrapperComponent>());
      });

      test('returns the correct Dart Component2 that is rendered', () {
        var renderedInstance = render(TestComponent2Factory({}));
        expect(getDartComponent(renderedInstance), const TypeMatcher<TestComponent2>());
      });

      test('returns null for a JS composite component', () {
        var renderedInstance = render(testJsComponentFactory());
        expect(getDartComponent(renderedInstance), isNull);
      });

      test('returns null for a DOM component', () {
        var renderedInstance = render(Dom.div());
        expect(getDartComponent(renderedInstance), isNull);
      });

      test('returns null for a ReactElement', () {
        ReactElement instance = Wrapper()();
        expect(getDartComponent(instance), isNull);
      });

      group('', () {
        final messageMatcher = contains('react-dart 4.0 no longer supports retrieving Dart components');

        test('warns when passed a ReactElement', () {
          ReactElement instance = Wrapper()();
          expect(() => getDartComponent(instance), prints(messageMatcher));
        }, testOn: 'dart-vm');

        test('does not when passed a ReactElement in JS', () {
          ReactElement instance = Wrapper()();
          expect(() => getDartComponent(instance), isNot(prints(messageMatcher)));
        }, testOn: 'js', tags: 'no-ddc');

        test('does not warn when passed a ReactComponent', () {
          var renderedInstance = render(Wrapper());
          expect(() => getDartComponent(renderedInstance), isNot(prints(messageMatcher)));
        });

        test('does not warn when passed a DOM component', () {
          var renderedInstance = render(Dom.div());
          expect(() => getDartComponent(renderedInstance), isNot(prints(messageMatcher)));
        });
      });
    });

    group('getProps', () {
      const List testChildren = const ['child1', 'child2'];
      const Map<String, dynamic> testStyle = const {'background': 'white'};

      test('returns props for a composite JS component ReactElement', () {
        ReactElement instance = testJsComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren);

        expect(getProps(instance), {
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a composite JS ReactComponent', () {
        ReactComponent renderedInstance = render(testJsComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren));

        expect(getProps(renderedInstance), {
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a composite JS ReactComponent, even when the props change', () {
        var mountNode = new DivElement();
        ReactComponent renderedInstance = react_dom.render(testJsComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren), mountNode);

        expect(getProps(renderedInstance), {
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        });

        renderedInstance = react_dom.render(testJsComponentFactory({
          'jsProp': 'other js',
          'style': testStyle,
        }, testChildren), mountNode);

        expect(getProps(renderedInstance), {
          'jsProp': 'other js',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a DOM component ReactElement', () {
        ReactElement instance = (Dom.div()
          ..addProp('domProp', 'dom')
          ..style = testStyle
        )(testChildren);

        expect(getProps(instance), {
          'domProp': 'dom',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a Dart Component ReactElement', () {
        ReactElement instance = TestComponentFactory({
          'dartProp': 'dart',
          'style': testStyle,
        }, testChildren);

        expect(getProps(instance), {
          'dartProp': 'dart',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a Dart Component2 ReactElement', () {
        ReactElement instance = TestComponent2Factory({
          'dartProp': 'dart',
          'style': testStyle,
        }, testChildren);

        expect(getProps(instance), {
          'dartProp': 'dart',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a Dart Component ReactComponent', () {
        ReactComponent renderedInstance = render(TestComponentFactory({
          'dartProp': 'dart',
          'style': testStyle,
        }, testChildren));

        expect(getProps(renderedInstance), {
          'dartProp': 'dart',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a Dart Component2 ReactComponent', () {
        ReactComponent renderedInstance = render(TestComponent2Factory({
          'dartProp': 'dart',
          'style': testStyle,
        }, testChildren));

        expect(getProps(renderedInstance), {
          'dartProp': 'dart',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a Dart component ReactComponent, even when the props change', () {
        final jacket = mount(TestComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren));
        expect(getProps(jacket.getInstance()), {
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        });

        jacket.rerender(TestComponentFactory({
          'jsProp': 'other js',
          'style': testStyle,
        }, testChildren));
        expect(getProps(jacket.getInstance()), {
          'jsProp': 'other js',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a Dart component ReactComponent, even when the props change', () {
        final jacket = mount(TestComponent2Factory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren));
        expect(getProps(jacket.getInstance()), {
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        });

        jacket.rerender(TestComponent2Factory({
          'jsProp': 'other js',
          'style': testStyle,
        }, testChildren));
        expect(getProps(jacket.getInstance()), {
          'jsProp': 'other js',
          'style': testStyle,
          'children': testChildren
        });
      });

      group('traverses children of Wrapper components', () {
        group('and returns props for a', () {
          group('composite JS ReactElement', () {
            test('', () {
              ReactElement instance = OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              );

              expect(getProps(instance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when there are multiple levels of wrappers', () {
              ReactElement instance = TwoLevelWrapper()(
                OneLevelWrapper()(
                  testJsComponentFactory({
                    'jsProp': 'js',
                    'style': testStyle,
                  }, testChildren)
                )
              );

              expect(getProps(instance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when the top level component is not a wrapper', () {
              ReactElement instance = testJsComponentFactory({
                'jsProp': 'js',
                'style': testStyle,
              }, testChildren);

              expect(getProps(instance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when traverseWrappers is false', () {
              ReactElement instance = OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              );

              expect(getProps(instance), {'children': anything});
            });
          });

          group('composite JS ReactComponent', () {
            test('', () {
              ReactComponent renderedInstance = render(OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              ));

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when there are multiple levels of wrappers', () {
              ReactComponent renderedInstance = render(TwoLevelWrapper()(
                OneLevelWrapper()(
                  testJsComponentFactory({
                    'jsProp': 'js',
                    'style': testStyle,
                  }, testChildren)
                )
              ));

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when props change', () {
              var mountNode = new DivElement();
              ReactComponent renderedInstance = react_dom.render(OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              ), mountNode);

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });

              renderedInstance = react_dom.render(OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'other js',
                  'style': testStyle,
                }, testChildren)
              ), mountNode);

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'jsProp': 'other js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when traverseWrappers is false', () {
              ReactComponent renderedInstance = render(OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              ));

              expect(getProps(renderedInstance), {'children': anything});
            });
          });

          group('DOM component ReactElement', () {
            test('', () {
              ReactElement instance = OneLevelWrapper()(
                (Dom.div()
                  ..addProp('domProp', 'dom')
                  ..style = testStyle
                )(testChildren)
              );

              expect(getProps(instance, traverseWrappers: true), {
                'domProp': 'dom',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when there are multiple levels of wrappers', () {
              ReactElement instance = TwoLevelWrapper()(
                OneLevelWrapper()(
                  (Dom.div()
                    ..addProp('domProp', 'dom')
                    ..style = testStyle
                  )(testChildren)
                )
              );

              expect(getProps(instance, traverseWrappers: true), {
                'domProp': 'dom',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when the top level component is not a wrapper', () {
              ReactElement instance = (Dom.div()
                ..addProp('domProp', 'dom')
                ..style = testStyle
              )(testChildren);

              expect(getProps(instance, traverseWrappers: true), {
                'domProp': 'dom',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when traverseWrappers is false', () {
              ReactElement instance = OneLevelWrapper()(
                (Dom.div()
                  ..addProp('domProp', 'dom')
                  ..style = testStyle
                )(testChildren)
              );

              expect(getProps(instance), {'children': anything});
            });
          });

          group('Dart component ReactElement', () {
            test('', () {
              ReactElement instance = OneLevelWrapper()(
                TestComponentFactory({
                  'dartProp': 'dart',
                  'style': testStyle,
                }, testChildren)
              );

              expect(getProps(instance, traverseWrappers: true), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when there are multiple levels of wrappers', () {
              ReactElement instance = TwoLevelWrapper()(
                OneLevelWrapper()(
                  TestComponentFactory({
                    'dartProp': 'dart',
                    'style': testStyle,
                  }, testChildren)
                )
              );

              expect(getProps(instance, traverseWrappers: true), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when the top level component is not a wrapper', () {
              ReactElement instance = TestComponentFactory({
                'dartProp': 'dart',
                'style': testStyle,
              }, testChildren);

              expect(getProps(instance, traverseWrappers: true), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when traverseWrappers is false', () {
              ReactElement instance = OneLevelWrapper()(
                TestComponentFactory({
                  'dartProp': 'dart',
                  'style': testStyle,
                }, testChildren)
              );

              expect(getProps(instance), {'children': anything});
            });
          });

          group('Dart component ReactComponent', () {
            test('', () {
              ReactComponent renderedInstance = render(OneLevelWrapper()(
                TestComponentFactory({
                  'dartProp': 'dart',
                  'style': testStyle,
                }, testChildren)
              ));

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when there are multiple levels of wrappers', () {
              ReactComponent renderedInstance = render(TwoLevelWrapper()(
                OneLevelWrapper()(
                  TestComponentFactory({
                    'dartProp': 'dart',
                    'style': testStyle,
                  }, testChildren)
                )
              ));

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when props change', () {
              var mountNode = new DivElement();
              ReactComponent renderedInstance = react_dom.render(OneLevelWrapper()(
                TestComponentFactory({
                  'dartProp': 'dart',
                  'style': testStyle,
                }, testChildren)
              ), mountNode);

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });

              renderedInstance = react_dom.render(OneLevelWrapper()(
                TestComponentFactory({
                  'dartProp': 'other dart',
                  'style': testStyle,
                }, testChildren)
              ), mountNode);

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'dartProp': 'other dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('expect when the top level component is not a wrapper', () {
              ReactComponent renderedInstance = render(TestComponentFactory({
                'dartProp': 'dart',
                'style': testStyle,
              }, testChildren));

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when traverseWrappers is false', () {
              ReactComponent renderedInstance = render(OneLevelWrapper()(
                TestComponentFactory({
                  'dartProp': 'dart',
                  'style': testStyle,
                }, testChildren)
              ));

              expect(getProps(renderedInstance), {'children': anything});
            });
          });
        });
      });

      {
        void sharedTests(factory, {Matcher modificationThrowsMatcher = throwsUnsupportedError}) {
          test('returns props as an unmodifiable map', () {
            ReactComponent renderedInstance = render(factory({
              'dartProp': 'dart'
            }));

            expect(() => getProps(renderedInstance)['style'] = testStyle, modificationThrowsMatcher);
          });

          group('caches the returned unmodifiable map for ReactElements', () {
            test('in dart2js and the Dart VM', () {
              ReactElement element = factory({
                'dartProp': 'dart'
              });

              var result1 = getProps(element);
              var result2 = getProps(element);

              expect(result1, containsPair('dartProp', 'dart'), reason: 'test setup sanity check');
              expect(result2, same(result1), reason: 'should have returned the same object');
            }, tags: 'no-ddc');

            test('unless the runtime is the DDC', () {
              ReactElement element = factory({
                'dartProp': 'dart'
              });

              var result1 = getProps(element);
              var result2 = getProps(element);

              expect(result1, containsPair('dartProp', 'dart'), reason: 'test setup sanity check');
              expect(result2, isNot(same(result1)),
                  reason: 'if this test fails, then it\'s possible that the bug was fixed in'
                          ' a newer version of the Dart SDK, and this test can be removed!');
            }, tags: 'ddc',
                // Tests run in `ddev coverage` don't respect tags and show up as the 'vm' platform
                // so we can use this to disable certain browser tests during coverage.
                // Workaround for https://github.com/Workiva/dart_dev/issues/200
                testOn: '!vm');
          });
        }

        group('for JS component', () {
          sharedTests(testJsComponentFactory);
        });

        group('for Dart Component', () {
          sharedTests(TestComponentFactory);
        });

        group('for Dart Component2', () {
          sharedTests(
            TestComponent2Factory,
            // TODO uncomment once https://github.com/dart-lang/sdk/issues/15432 is fixed and we don't need an UnmodifiableMapView
            // modificationThrowsMatcher: throwsA(hasToStringValue(contains('object is not extensible'))),
          );
        });
      }

      group('throws when passed', () {
        test('a JS ReactComponent and traverseWrappers is true', () {
          var renderedInstance = render(testJsComponentFactory({}));
          expect(() => getProps(renderedInstance, traverseWrappers: true), throwsArgumentError);
        });

        test('a DOM ReactComponent (Element)', () {
          var renderedInstance = render(Dom.div());
          expect(() => getProps(renderedInstance), throwsArgumentError);
        });

        test('an empty JS object', () {
          expect(() => getProps(newObject()), throwsArgumentError);
        });

        test('a String', () {
          expect(() => getProps('string'), throwsA(anything));
        });

        test('null', () {
          expect(() => getProps(null), throwsArgumentError);
        });
      });
    });

    group('chainRef', () {
      group('returns a ref that chains with the existing ref', () {
        group('when the provided instance is', () {
          test('a Dart component', () {
            var calls = [];

            var instanceWithRef = TestComponentFactory({'ref': (ref) {
              calls.add(['original ref', ref]);
            }});

            var chainedRef = chainRef(instanceWithRef, (ref) {
              calls.add(['chained ref', ref]);
            });

            var renderedInstance = react_test_utils.renderIntoDocument(
                cloneElement(instanceWithRef, {'ref': chainedRef})
            );
            var component = getDartComponent(renderedInstance);
            // ignore: deprecated_member_use
            expect(component, const TypeMatcher<react.Component>(), reason: 'test setup sanity check');

            expect(calls, [
              ['original ref', component],
              ['chained ref', component],
            ]);
          });

          // TODO: 3.0.0 this is failing on Dart 2 dart2js tests only.
          test('a JS composite component', () {
            var calls = [];

            var instanceWithRef = testJsComponentFactory({'ref': (ref) {
              calls.add(['original ref', ref]);
            }});

            var chainedRef = chainRef(instanceWithRef, (ref) {
              calls.add(['chained ref', ref]);
            });

            var renderedInstance = react_test_utils.renderIntoDocument(
                cloneElement(instanceWithRef, {'ref': chainedRef})
            );

            expect(calls, [
              ['original ref', renderedInstance],
              ['chained ref', renderedInstance],
            ]);
          });

          // TODO: 3.0.0 this is failing on Dart 2 dart2js tests only.
          test('a DOM component', () {
            var calls = [];

            var instanceWithRef = (Dom.div()..ref = (ref) {
              calls.add(['original ref', ref]);
            })();

            var chainedRef = chainRef(instanceWithRef, (ref) {
              calls.add(['chained ref', ref]);
            });

            var renderedInstance = react_test_utils.renderIntoDocument(
                cloneElement(instanceWithRef, domProps()..ref = chainedRef)
            );
            var renderedNode = findDomNode(renderedInstance);

            expect(calls, [
              ['original ref', renderedNode],
              ['chained ref', renderedNode],
            ]);
          });
        });

        test('when the provided instance has no ref', () {
          var calls = [];

          var instanceWithoutRef = TestComponentFactory({});

          var chainedRef = chainRef(instanceWithoutRef, (ref) {
            calls.add(['chained ref', ref]);
          });

          var renderedInstance = react_test_utils.renderIntoDocument(
              cloneElement(instanceWithoutRef, {'ref': chainedRef})
          );
          var component = getDartComponent(renderedInstance);
          // ignore: deprecated_member_use
          expect(component, const TypeMatcher<react.Component>(), reason: 'test setup sanity check');

          expect(calls, [
            ['chained ref', component],
          ]);
        });

        test('when the provided ref is null', () {
          var calls = [];

          var instanceWithRef = TestComponentFactory({'ref': (ref) {
            calls.add(['original ref', ref]);
          }});

          var chainedRef = chainRef(instanceWithRef, null);

          var renderedInstance = react_test_utils.renderIntoDocument(
              cloneElement(instanceWithRef, {'ref': chainedRef})
          );
          var component = getDartComponent(renderedInstance);
          // ignore: deprecated_member_use
          expect(component, const TypeMatcher<react.Component>(), reason: 'test setup sanity check');

          expect(calls, [
            ['original ref', component],
          ]);
        });
      });

      group('throws when the provided instance', () {
        void noopRef(_) {}

        test('has a String ref', () {
          var instanceWithStringRef = TestComponentFactory({'ref': 'foo'});

          expect(() {
            chainRef(instanceWithStringRef, noopRef);
          }, throwsArgumentError);
        });

        test('has an invalid ref', () {
          var instanceWithInvalidRef = TestComponentFactory({'ref': new Object()});

          expect(() {
            chainRef(instanceWithInvalidRef, noopRef);
          }, throwsArgumentError);
        });
      });
    });
  });
}

/// Helper component for testing a Dart (react-dart) React component with cloneElement.
final TestComponentFactory = react.registerComponent(() => new TestComponent());
// ignore: deprecated_member_use
class TestComponent extends react.Component {
  @override
  render() => Dom.div()();
}

/// Helper component for testing a Dart (react-dart) React component (version 2) with cloneElement.
final TestComponent2Factory = react.registerComponent2(() => new TestComponent2());

class TestComponent2 extends react.Component2 {
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

/// Helper component that renders whatever you tell it to. Necessary for rendering components with the 'ref' prop.
final RenderingContainerComponentFactory = react.registerComponent(() => new RenderingContainerComponent());

// ignore: deprecated_member_use
class RenderingContainerComponent extends react.Component {
  @override
  render() => props['renderer']();
}
