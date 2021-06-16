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
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart' hide createRef, forwardRef;
import 'package:over_react/react_dom.dart' as react_dom;
import 'package:react/react_test_utils.dart' as react_test_utils;
import 'package:test/test.dart';

import '../../test_util/component2/one_level_wrapper2.dart';
import '../../test_util/component2/two_level_wrapper2.dart';
import '../../test_util/one_level_wrapper.dart';
import '../../test_util/test_util.dart';
import '../../test_util/two_level_wrapper.dart';

/// Main entry point for react wrappers testing
main() {
  group('Dart wrappers for React:', () {
    group('cloneElement()', () {
      const List testChildren = ['child1', 'child2'];

      const Map testProps = {
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

        test('for a Dart Component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original);

          // If these objects are equal, then they proxy the same JS props object.
          expect(clone.props, isNot(original.props));

          Map originalProps = JsBackedMap.backedBy(original.props);
          Map cloneProps = JsBackedMap.backedBy(clone.props);

          // Verify all props (including children, excluding react-dart internals) are equal.
          Map originalShallowProps = Map.from(originalProps);
          Map clonePropsShallowProps = Map.from(cloneProps);
          originalShallowProps.remove('internal');
          clonePropsShallowProps.remove('internal');
          expect(originalShallowProps, clonePropsShallowProps);

          // Verify react-dart internal props are equal.
          final originalInternal = originalProps['internal'] as ReactDartComponentInternal ; // ignore: deprecated_member_use
          final clonePropsInternal = cloneProps['internal'] as ReactDartComponentInternal ; // ignore: deprecated_member_use
          expect(originalInternal.props, clonePropsInternal.props);

          var dartRendered = getDartComponent(render(original));
          var dartRenderedClone = getDartComponent(render(clone));

          expect(dartRenderedClone, isNot(same(dartRendered)));
          expect(dartRenderedClone.props, dartRendered.props);
        });

        test('for a Dart Component2', () {
          var original = TestComponent2Factory(testProps, testChildren);
          var clone = cloneElement(original);

          // If these objects are equal, then they proxy the same JS props object.
          expect(clone.props, isNot(original.props));

          Map originalProps = JsBackedMap.backedBy(original.props);
          Map cloneProps = JsBackedMap.backedBy(clone.props);

          // Verify all props (including children, excluding react-dart internals) are equal.
          Map originalShallowProps = Map.from(originalProps);
          Map clonePropsShallowProps = Map.from(cloneProps);
          expect(originalShallowProps, clonePropsShallowProps);

          var dartRendered = getDartComponent(render(original));
          var dartRenderedClone = getDartComponent(render(clone));

          expect(dartRenderedClone, isNot(same(dartRendered)));
          expect(dartRenderedClone.props, dartRendered.props);
        });
      });

      group('returns a clone with added/overridden props', () {
        const Map testPropsToAdd = {
          'originalPropToOverride': 'clone',
          'propToAdd': 'clone'
        };

        const Map expectedPropsMerge = {
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

        test('for a Dart Component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original, testPropsToAdd);

          var renderedClone = render(clone);

          // Verify all props are equal.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps, expectedPropsMerge);
        });

        test('for a Dart Component2', () {
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
          const Map testPropsToAdd = {
            'style': {'width': '100rem'}
          };

          test('for DOM components', () {
            var original = (Dom.div()..addProps(testProps))(testChildren);
            var clone = cloneElement(original, testPropsToAdd);

            var renderedClone = react_test_utils.renderIntoDocument(clone);
            var renderedCloneNode = findDomNode(renderedClone);

            expect(renderedCloneNode.style.width, '100rem');
          });

          test('for JS composite components', () {
            var original = testJsComponentFactory(testProps, testChildren) as ReactElement;
            var clone = cloneElement(original, testPropsToAdd);

            final renderedClone = react_test_utils.renderIntoDocument(clone) as ReactComponent;
            var props = renderedClone.props as PlainObjectPropsMap; // ignore: avoid_as

            var convertedStyle = props.style;
            expect(convertedStyle.width, '100rem');
          });

          group(', except', () {
            test('for a Dart Component', () {
              var original = TestComponentFactory(testProps, testChildren);
              var clone = cloneElement(original, testPropsToAdd);

              var renderedClone = react_test_utils.renderIntoDocument(clone);
              Map cloneProps = getDartComponent(renderedClone).props;

              var style = cloneProps['style'];
              expect(style, same(testPropsToAdd['style']), reason: 'style should be the same object passed in, unaltered');
            });

            test('for a Dart Component2', () {
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
              var original = testJsComponentFactory(testProps, testChildren) as ReactElement;
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

            test('for a Dart Component', () {
              var original = TestComponentFactory(testProps, testChildren);
              var clone = cloneElement(original, testPropsToAdd);

              var renderedClone = react_test_utils.renderIntoDocument(clone);
              Map cloneProps = getDartComponent(renderedClone).props;

              expect(() {
                // Retrieve the callback passed to the component.
                final callback = cloneProps['onClick'] as Function;
                // Call the method with one arg.
                callback(null);
              }, returnsNormally, reason: 'should not throw due to mismatched arguments or otherwise');
              expect(onClickWasCalled, isTrue, reason: 'event handler that was added via cloning was not called');
              expect(onClickWasCalled, isTrue, reason: 'event handler that was added via cloning was not called');
            });

            test('for a Dart Component2', () {
              var original = TestComponent2Factory(testProps, testChildren);
              var clone = cloneElement(original, testPropsToAdd);

              var renderedClone = react_test_utils.renderIntoDocument(clone);
              Map cloneProps = getDartComponent(renderedClone).props;

              expect(() {
                // Retrieve the callback passed to the component.
                final callback = cloneProps['onClick'] as Function;
                // Call the method with one arg.
                callback(null);
              }, returnsNormally, reason: 'should not throw due to mismatched arguments or otherwise');
              expect(onClickWasCalled, isTrue, reason: 'event handler that was added via cloning was not called');
            });
          });
        });
      });

      group('updates the "key" and "ref" props properly', () {
        // ignore: unused_local_variable
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

        test('for a Dart Component', () {
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
          expect(originalRefCalled, isFalse);

          var renderedClone = react_test_utils.findRenderedComponentWithTypeV2(renderedHolder, TestComponentFactory);

          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps, isNot(anyOf(contains('key'), contains('ref'))),
              reason: '"key" and "ref" should not be visible to the rendered cloned component');
        });

        test('for a Dart Component2', () {
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
          expect(originalRefCalled, isFalse);
        });
      });

      group('returns a clone with replaced children', () {
        const List testOverrideChildren = ['child3', 'child4'];

        test('for a plain React JS component', () {
          var original = (Dom.div()..addProps(testProps))(testChildren);
          var clone = cloneElement(original, null, testOverrideChildren);

          Map cloneProps = unconvertJsProps(clone);

          expect(cloneProps['children'], testOverrideChildren);
        });

        test('for a Dart Component', () {
          var original = TestComponentFactory(testProps, testChildren);
          var clone = cloneElement(original, null, testOverrideChildren);

          var renderedClone = render(clone);

          // Verify that children are overridden according to React
          var clonePropsChildren = getJsChildren(renderedClone);
          expect(clonePropsChildren, testOverrideChildren);

          // Verify that children are overridden according to the Dart component.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps['children'], testOverrideChildren);
        });

        test('for a Dart Component2', () {
          var original = TestComponent2Factory(testProps, testChildren);
          var clone = cloneElement(original, null, testOverrideChildren);

          var renderedClone = render(clone);

          // Verify that children are overridden according to React
          var clonePropsChildren = getJsChildren(renderedClone);
          expect(clonePropsChildren, testOverrideChildren);

          // Verify that children are overridden according to the Dart component.
          Map cloneDartProps = getDartComponent(renderedClone).props;
          expect(cloneDartProps['children'], testOverrideChildren);
        });
      });

      test('preserves callback refs correctly', () {
        var flag = false;
        dynamic runtimeType;
        callbackRef(instance) {
          flag = true;
          runtimeType = instance.runtimeType;
        }

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
          final instance = render(TestComponentFactory({})) as ReactComponent;
          expect(isValidElement(instance), isFalse);
        });

        test('a ReactComponent from Dart Component2', () {
          final instance = render(TestComponent2Factory({})) as ReactComponent;
          expect(isValidElement(instance), isFalse);
        });
      });
    });

    group('isDomElement()', () {
      group('returns expected result when given', (){
        test('a DOM component', () {
          expect(isDomElement(Dom.div()()), isTrue);
        });

        test('a Dart Component', () {
          expect(isDomElement(TestComponentFactory({})), isFalse);
        });

        test('a Dart Component2', () {
          expect(isDomElement(TestComponent2Factory({})), isFalse);
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
        final instance = TestComponentFactory({});
        expect(isDartComponent(instance), isTrue);
      });

      test('returns true for an unrendered instance (ReactElement) of a Dart Component2', () {
        final instance = TestComponent2Factory({});
        expect(isDartComponent(instance), isTrue);
      });

      test('returns false for an unrendered instance (ReactElement) of a JS composite component', () {
        final instance = testJsComponentFactory({});
        expect(isDartComponent(instance), isFalse);
      });

      test('returns false for an unrendered instance (ReactElement) of a DOM component', () {
        ReactElement instance = Dom.div()();
        expect(isDartComponent(instance), isFalse);
      });

      test('returns true for a mounted instance (ReactComponent) of a Dart Component', () {
        var renderedInstance = render(TestComponentFactory({}));
        expect(isDartComponent(renderedInstance), isTrue);
      });

      test('returns true for a mounted instance (ReactComponent) of a Dart Component2', () {
        var renderedInstance = render(TestComponent2Factory({}));
        expect(isDartComponent(renderedInstance), isTrue);
      });

      test('returns false for a mounted instance (ReactComponent) of a JS composite component', () {
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
        expect(getDartComponent(renderedInstance), isA<WrapperComponent>());
      });

      test('returns the correct Dart Component2 that is rendered', () {
        var renderedInstance = render(TestComponent2Factory({}));
        expect(getDartComponent(renderedInstance), isA<TestComponent2>());
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
        }, tags: 'ddc');

        test('does not when passed a ReactElement in JS', () {
          ReactElement instance = Wrapper()();
          expect(() => getDartComponent(instance), isNot(prints(messageMatcher)));
        }, tags: 'no-ddc');

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
      const List testChildren = ['child1', 'child2'];
      const Map<String, dynamic> testStyle = {'background': 'white'};

      test('returns props for a composite JS component ReactElement', () {
        final instance = testJsComponentFactory({
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
        final renderedInstance = render(testJsComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren)) as ReactComponent;

        expect(getProps(renderedInstance), {
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        });
      });

      test('returns props for a composite JS ReactComponent, even when the props change', () {
        var mountNode = DivElement();
        var renderedInstance = react_dom.render(testJsComponentFactory({
          'jsProp': 'js',
          'style': testStyle,
        }, testChildren) as ReactElement, mountNode) as ReactComponent;

        expect(getProps(renderedInstance), {
          'jsProp': 'js',
          'style': testStyle,
          'children': testChildren
        });

        renderedInstance = react_dom.render(testJsComponentFactory({
          'jsProp': 'other js',
          'style': testStyle,
        }, testChildren) as ReactElement, mountNode) as ReactComponent;

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

      {
        void sharedGetPropsTests({@required bool isComponent2}) {
          final factory = isComponent2 ? TestComponent2Factory : TestComponentFactory;

          group('returns props for a Dart ${isComponent2 ? 'Component2' : 'Component'}', () {
            test('ReactElement', () {
              final instance = factory({
                'dartProp': 'dart',
                'style': testStyle,
              }, testChildren);

              expect(getProps(instance), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('ReactComponent', () {
              final renderedInstance = render(factory({
                'dartProp': 'dart',
                'style': testStyle,
              }, testChildren)) as ReactComponent;

              expect(getProps(renderedInstance), {
                'dartProp': 'dart',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('ReactComponent, even when the props change', () {
              final jacket = mount(factory({
                'jsProp': 'js',
                'style': testStyle,
              }, testChildren));
              expect(getProps(jacket.getInstance()), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });

              jacket.rerender(factory({
                'jsProp': 'other js',
                'style': testStyle,
              }, testChildren));
              expect(getProps(jacket.getInstance()), {
                'jsProp': 'other js',
                'style': testStyle,
                'children': testChildren
              });
            });
          });
        }

        sharedGetPropsTests(isComponent2: false);
        sharedGetPropsTests(isComponent2: true);
      }

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
              final instance = testJsComponentFactory({
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
              final renderedInstance = render(OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              )) as ReactComponent;

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when there are multiple levels of wrappers', () {
              final renderedInstance = render(TwoLevelWrapper()(
                OneLevelWrapper()(
                  testJsComponentFactory({
                    'jsProp': 'js',
                    'style': testStyle,
                  }, testChildren)
                )
              )) as ReactComponent;

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'jsProp': 'js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('even when props change', () {
              var mountNode = DivElement();
              var renderedInstance = react_dom.render(OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              ), mountNode) as ReactComponent;

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
              ), mountNode) as ReactComponent;

              expect(getProps(renderedInstance, traverseWrappers: true), {
                'jsProp': 'other js',
                'style': testStyle,
                'children': testChildren
              });
            });

            test('except when traverseWrappers is false', () {
              final renderedInstance = render(OneLevelWrapper()(
                testJsComponentFactory({
                  'jsProp': 'js',
                  'style': testStyle,
                }, testChildren)
              )) as ReactComponent;

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

          {
            void sharedGetPropsWrapperTests({@required bool isComponent2, @required bool isRendered}) {
              final testComponentFactory = isComponent2 ? TestComponentFactory : TestComponent2Factory;
              final oneLevelWrapperFactory = isComponent2 ? OneLevelWrapper : OneLevelWrapper2;
              final twoLevelWrapperFactory = isComponent2 ? TwoLevelWrapper : TwoLevelWrapper2;

              group('Dart ${isComponent2 ? 'Component2' : 'Component'} ${isRendered ? 'ReactComponent' : 'ReactElement'}', () {
                test('', () {
                  final instance = oneLevelWrapperFactory()(
                    testComponentFactory({
                      'dartProp': 'dart',
                      'style': testStyle,
                    }, testChildren),
                  );

                  final getPropsArg = isRendered ? render(instance) : instance;
                  expect(getProps(getPropsArg, traverseWrappers: true), {
                    'dartProp': 'dart',
                    'style': testStyle,
                    'children': testChildren
                  });
                });

                test('even when there are multiple levels of wrappers', () {
                  final instance = twoLevelWrapperFactory()(
                    oneLevelWrapperFactory()(
                      testComponentFactory({
                        'dartProp': 'dart',
                        'style': testStyle,
                      }, testChildren),
                    ),
                  );

                  final getPropsArg = isRendered ? render(instance) : instance;
                  expect(getProps(getPropsArg, traverseWrappers: true), {
                    'dartProp': 'dart',
                    'style': testStyle,
                    'children': testChildren
                  });
                });

                test('except when the top level component is not a wrapper', () {
                  final instance = testComponentFactory({
                    'dartProp': 'dart',
                    'style': testStyle,
                  }, testChildren);

                  final getPropsArg = isRendered ? render(instance) : instance;
                  expect(getProps(getPropsArg, traverseWrappers: true), {
                    'dartProp': 'dart',
                    'style': testStyle,
                    'children': testChildren
                  });
                });

                test('except when traverseWrappers is false', () {
                  final instance = oneLevelWrapperFactory()(
                    testComponentFactory({
                      'dartProp': 'dart',
                      'style': testStyle,
                    }, testChildren)
                  );

                  final getPropsArg = isRendered ? render(instance) : instance;
                  expect(getProps(getPropsArg), {'children': anything});
                });

                if (isRendered) {
                  test('even when props change', () {
                    final jacket = mount(oneLevelWrapperFactory()(
                      testComponentFactory({
                        'dartProp': 'dart',
                        'style': testStyle,
                      }, testChildren)
                    ));

                    expect(getProps(jacket.getInstance(), traverseWrappers: true), {
                      'dartProp': 'dart',
                      'style': testStyle,
                      'children': testChildren
                    });

                    jacket.rerender(oneLevelWrapperFactory()(
                      testComponentFactory({
                        'dartProp': 'other dart',
                        'style': testStyle,
                      }, testChildren)
                    ));

                    expect(getProps(jacket.getInstance(), traverseWrappers: true), {
                      'dartProp': 'other dart',
                      'style': testStyle,
                      'children': testChildren
                    });
                  });
                }
              });
            }

            sharedGetPropsWrapperTests(isComponent2: false, isRendered: false);
            sharedGetPropsWrapperTests(isComponent2: false, isRendered: true);
            sharedGetPropsWrapperTests(isComponent2: true, isRendered: false);
            sharedGetPropsWrapperTests(isComponent2: true, isRendered: true);
          }
        });
      });

      {
        void sharedGetPropsUnmodifiableTests(factory, {Matcher modificationThrowsMatcher = throwsUnsupportedError}) {
          test('returns props as an unmodifiable map', () {
            final renderedInstance = render(factory({
              'dartProp': 'dart'
            })) as ReactComponent;

            expect(() => getProps(renderedInstance)['style'] = testStyle, modificationThrowsMatcher);
          });

          group('caches the returned unmodifiable map for ReactElements', () {
            test('in dart2js and the Dart VM', () {
              final element = factory({
                'dartProp': 'dart'
              });

              var result1 = getProps(element);
              var result2 = getProps(element);

              expect(result1, containsPair('dartProp', 'dart'), reason: 'test setup sanity check');
              expect(result2, same(result1), reason: 'should have returned the same object');
            }, tags: 'no-ddc');

            test('unless the runtime is the DDC', () {
              final element = factory({
                'dartProp': 'dart'
              });

              var result1 = getProps(element);
              var result2 = getProps(element);

              expect(result1, containsPair('dartProp', 'dart'), reason: 'test setup sanity check');
              expect(result2, isNot(same(result1)),
                  reason: 'if this test fails, then it\'s possible that the bug was fixed in'
                          ' a newer version of the Dart SDK, and this test can be removed!');
            }, tags: 'ddc');
          });
        }

        group('for a JS component', () {
          sharedGetPropsUnmodifiableTests(testJsComponentFactory);
        });

        group('for a Dart Component', () {
          sharedGetPropsUnmodifiableTests(TestComponentFactory);
        });

        group('for a Dart Component2', () {
          sharedGetPropsUnmodifiableTests(
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
        List calls;
        dynamic ref;
        TestJacket jacket;
        dynamic expectedRefValue;

        setUp(() {
          calls = [];
        });

        tearDown(() {
          ref = null;
          expectedRefValue = null;
          jacket = null;
        });

        void sharedTests(void Function() _runExpectations) {
          // _runExpectations needs to be called before the test block, and not in a tearDown,
          // so that component isn't unmounted by the time the expectations are called.

          group('and the provided instance is', () {
            void Function() runExpectations;

            setUp(() {
              runExpectations = expectAsync0(() {
                expect(expectedRefValue, isNotNull);
                _runExpectations();
              }, reason: 'each test case must call runExpectations');
            });

            test('a Dart Component', () {
              var instanceWithRef = TestComponentFactory({'ref': ref});
              var chainedRef = chainRef(instanceWithRef, (ref) {
                calls.add(['chained ref', ref]);
              });

              jacket = mount(cloneElement(instanceWithRef, {'ref': chainedRef}));
              expectedRefValue = jacket.getDartInstance();
              // ignore: deprecated_member_use
              expect(expectedRefValue, isA<react.Component>(), reason: 'test setup sanity check');

              runExpectations();
            });

            test('a Dart Component2', () {
              var instanceWithRef = TestComponent2Factory({'ref': ref});
              var chainedRef = chainRef(instanceWithRef, (ref) {
                calls.add(['chained ref', ref]);
              });

              jacket = mount(cloneElement(instanceWithRef, {'ref': chainedRef}));
              expectedRefValue = jacket.getDartInstance();
              expect(expectedRefValue, isA<react.Component2>(), reason: 'test setup sanity check');

              runExpectations();
            });

            test('a JS composite component', () {
              var instanceWithRef = testJsComponentFactoryProxy({'ref': ref});
              var chainedRef = chainRef(instanceWithRef, (ref) {
                calls.add(['chained ref', ref]);
              });

              jacket = mount(cloneElement(instanceWithRef, {'ref': chainedRef}));
              expectedRefValue = jacket.getInstance();

              runExpectations();
            });

            test('a DOM component', () {
              var instanceWithRef = (Dom.div()..ref = ref)();
              var chainedRef = chainRef(instanceWithRef, (ref) {
                calls.add(['chained ref', ref]);
              });

              jacket = mount(cloneElement(instanceWithRef, domProps()..ref = chainedRef));
              expectedRefValue = jacket.getNode();

              runExpectations();
            });
          });
        }

        group('when the existing ref is a callback ref', () {
          setUp(() {
            ref = (ref) {
              calls.add(['original ref', ref]);
            };
          });

          sharedTests(() {
            expect(calls, [
              ['original ref', expectedRefValue],
              ['chained ref', expectedRefValue],
            ]);
          });
        });

        group('when the existing ref is an object ref', () {
          setUp(() {
            ref = createRef();
          });

          sharedTests(() {
            expect((ref as Ref).current, expectedRefValue, reason: 'should have updated the original ref');
            expect(calls, [
              ['chained ref', expectedRefValue],
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
          expect(component, isA<react.Component>(), reason: 'test setup sanity check');

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
          expect(component, isA<react.Component>(), reason: 'test setup sanity check');

          expect(calls, [
            ['original ref', component],
          ]);
        });
      });

      test('throws when the provided instance has a String ref', () {
        expect(() {
          chainRef(TestComponentFactory({'ref': 'foo'}), (_) {});
        }, throwsArgumentError);
      });
    });
  });
}

/// Helper component for testing a Dart (react-dart) React component with cloneElement.
final TestComponentFactory = react.registerComponent(() => TestComponent()) as ReactDartComponentFactoryProxy; // ignore: deprecated_member_use
// ignore: deprecated_member_use
class TestComponent extends react.Component {
  @override
  render() => Dom.div()();
}

/// Helper component for testing a Dart (react-dart) React component (version 2) with cloneElement.
final TestComponent2Factory = react.registerComponent2(() => TestComponent2());

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
final RenderingContainerComponentFactory = react.registerComponent(() => RenderingContainerComponent()) as ReactDartComponentFactoryProxy; // ignore: deprecated_member_use

// ignore: deprecated_member_use
class RenderingContainerComponent extends react.Component {
  @override
  render() => props['renderer']();
}

// TODO update over_react_test's testJsComponentFactory with this implementation
/// A factory for a JS composite component, for use in testing.
// ignore: deprecated_member_use
final testJsComponentFactoryProxy = ReactJsComponentFactoryProxy(React.createClass(ReactClassConfig(
  displayName: 'testJsComponent',
  render: allowInterop(() => Dom.div()('test js component')),
)));
