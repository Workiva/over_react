@TestOn('browser')
@JS()
library rmui.test.unit.component.lazy_test;

import 'dart:html';

import 'package:js/js.dart';
import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart' hide lazy;
import 'package:react_testing_library/matchers.dart';
import 'package:react_testing_library/react_testing_library.dart';

import 'package:test/test.dart';
import 'package:over_react/components.dart' as components;

import '../util/prop_conversion_test.dart';
import '../util/ref_test_cases.dart';

part 'lazy_test.over_react.g.dart';

main() {
  enableTestMode();

  group('lazy', () {
    group('prop conversions', () {

test('a custom Dart Map prop', () async {
          final renderErrors = [];

          // Use an ErrorBoundary to detect errors on render, since otherwise
          // React will just unmount the tree without throwing.
          await expectLater(() async {
            render((Suspense()..fallback='Loading')((components.ErrorBoundary()
              ..onComponentDidCatch = ((error, _) => renderErrors.add(error))
              ..shouldLogErrors = false
              ..fallbackUIRenderer =
                  ((_, __) => Dom.span()('An error occurred during render'))
              )(
                (LazyTestJS()
                  ..component = ExpectsDartMapProp.elementType
                  ..addProps(ExpectsDartMapProp()..dartMapProp = {'foo': 'bar'})
                  ..addTestId('componentRoot'))(),
                ),
              ),
            );
            await screen.findByText('An error occurred during render', timeout: Duration(seconds: 5));
            // Use prints as an easy way to swallow `print` calls and
            // prevent RTL from forwarding console errors to the test output,
            // since React error boundary logging is pretty noisy.
            // TODO instead, disable logging in this rtl.render call once that option is available: FED-1641
          }, prints(anything));

          expect(renderErrors, [
            isA<Object>().havingToStringValue(anyOf(
              // DDC error message
              matches(RegExp(
                  r"Expected a value of type 'Map[^']*', but got one of type '(Native|Legacy)JavaScriptObject'")),
              // dart2js error message
              matches(RegExp(
                  r"type '(Unknown|Plain)JavaScriptObject' is not a subtype of type 'Map[^']*'")),
            )),
          ]);

          // These are the expectations we'd use if this case didn't error:
          // final node = view.getByTestId('componentRoot');
          // expect(node, hasAttribute('data-dart-map-prop', jsonEncode({'foo': 'bar'})));
        }, tags: ['js-interop-tradeoff']);
        group('and a ref is set on that component', () {
          group('which eventually ends up on a non-Dart component', () {
            final testCaseCollection = RefTestCaseCollection<Element>();

            group('and is passed in via a forwarded "ref" prop as a', () {
              for (final testCaseName in testCaseCollection.allTestCaseNames) {
                test(testCaseName, () async {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((Suspense()..fallback='Loading')((LazyTestJS()
                    ..addTestId('test-js-component')
                    ..component = BasicForwardRef.elementType
                    ..ref = testCase.ref)()));
                  await screen.findByTestId('test-js-component');
                  expect(testCase.getCurrent(), isA<Element>());
                  expect(testCase.getCurrent(),
                      hasAttribute(basicForwardRefAttribute),
                      reason:
                          'test setup: ref should have been forwarded to the element we expect');
                });
              }
            });

            group(
                'and is passed in via a custom "ref" prop (with conversion) as a',
                () {
              for (final testCaseName in testCaseCollection.allTestCaseNames) {
                test(testCaseName, () async {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((Suspense()..fallback='Loading')((LazyTestJS()
                  ..component = Dom.div.elementType
                    ..addTestId('test-js-component')
                    ..inputComponent = BasicForwardRef.elementType
                    ..inputRef = testCase.ref)()));
                  await screen.findByTestId('test-js-component');
                  expect(testCase.getCurrent(), isA<Element>());
                  expect(testCase.getCurrent(),
                      hasAttribute(basicForwardRefAttribute),
                      reason:
                          'test setup: ref should have been forwarded to the element we expect');
                });
              }
            });

            group(
                'and is passed in via a "ref" prop in a nested props Map (with conversion) as a',
                () {
              for (final testCaseName in testCaseCollection.allTestCaseNames) {
                test(testCaseName, () async {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((Suspense()..fallback='Loading')((LazyTestJS()
                  ..component = Dom.div.elementType
                    ..addTestId('test-js-component')
                    ..buttonComponent = BasicForwardRef.elementType
                    ..buttonProps = (domProps()..ref = testCase.ref))()));
                  await screen.findByTestId('test-js-component');
                  expect(testCase.getCurrent(), isA<Element>());
                  expect(testCase.getCurrent(),
                      hasAttribute(basicForwardRefAttribute),
                      reason:
                          'test setup: ref should have been forwarded to the element we expect');
                });
              }
            });
          });

          group('which eventually ends up on a Dart class component', () {
            final testCaseCollection =
                RefTestCaseCollection<ClassComponentComponent>();

            setUpAll(() {
              // Make sure the special cases we're concerned about are included in this set of test cases:
              void assertSingleMetaWhere(bool Function(RefTestCaseMeta) test) {
                expect(testCaseCollection.allTestCaseMetas.where(test).toList(),
                    hasLength(1));
              }

              assertSingleMetaWhere(
                  (m) => !m.isJs && m.kind.isCallback && m.isStronglyTyped);
              assertSingleMetaWhere(
                  (m) => !m.isJs && m.kind.isCallback && !m.isStronglyTyped);
              assertSingleMetaWhere(
                  (m) => !m.isJs && m.kind.isObject && m.isStronglyTyped);
              assertSingleMetaWhere(
                  (m) => !m.isJs && m.kind.isObject && !m.isStronglyTyped);
            });

            void forEachTestCase(
                void Function(String testCaseName, bool isDartCallbackCase,
                    bool isDartRefObjectCase, bool isTyped) callback) {
              for (final testCaseName in testCaseCollection.allTestCaseNames) {
                final meta =
                    testCaseCollection.testCaseMetaByName(testCaseName);
                final isDartCallbackCase = !meta.isJs && meta.kind.isCallback;
                final isDartRefObjectCase = !meta.isJs && meta.kind.isObject;
                final isTyped = meta.isStronglyTyped;

                callback(testCaseName, isDartCallbackCase, isDartRefObjectCase,
                    isTyped);
              }
            }

            group('and is passed in via a forwarded "ref" prop as a', () {
              forEachTestCase((testCaseName, isDartCallbackCase,
                  isDartRefObjectCase, isTyped) {
                if (isDartCallbackCase && isTyped) {
                  // Bail since we know typed Dart callback refs will fail with a runtime type error since the JS  ReactComponent
                  // will be passed in instead of the Dart instance; this behavior will be tested in the untyped Dart callback ref test case.
                  return;
                }

                test(testCaseName, () async {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((Suspense()..fallback='Loading')((LazyTestJS()
                  ..component = Dom.div.elementType
                    ..addTestId('test-js-component')
                    ..component = ClassComponent.elementType
                    ..ref = testCase.ref)()));
                  await screen.findByTestId('test-js-component');
                  if (isDartRefObjectCase) {
                    expect(
                        testCase.getCurrent(), isA<ClassComponentComponent>());
                  } else {
                    expect(
                        testCase.getCurrent(),
                        isA<ReactComponent>().havingDartComponent(
                            isA<ClassComponentComponent>()));
                  }
                }, tags: [
                  if (isDartCallbackCase) 'js-interop-tradeoff',
                ]);
              });
            });

            group(
                'and is passed in via a custom "ref" prop (with conversion) as a',
                () {
              forEachTestCase((testCaseName, isDartCallbackCase,
                  isDartRefObjectCase, isTyped) {
                if (isDartCallbackCase && isTyped) {
                  // Bail since we know typed Dart callback refs will fail with a runtime type error since the JS  ReactComponent
                  // will be passed in instead of the Dart instance; this behavior will be tested in the untyped Dart callback ref test case.
                  return;
                }

                test(testCaseName, () async {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((Suspense()..fallback='Loading')((LazyTestJS()
                  ..component = Dom.div.elementType
                    ..addTestId('test-js-component')
                    ..inputComponent = ClassComponent.elementType
                    ..inputRef = testCase.ref)()));
                  await screen.findByTestId('test-js-component');
                  if (isDartRefObjectCase) {
                    expect(
                        testCase.getCurrent(), isA<ClassComponentComponent>());
                  } else {
                    expect(
                        testCase.getCurrent(),
                        isA<ReactComponent>().havingDartComponent(
                            isA<ClassComponentComponent>()));
                  }
                }, tags: [
                  if (isDartCallbackCase) 'js-interop-tradeoff',
                ]);
              });
            });

            // This is the one case where Dart (and unfortunately, JS) callback refs actually get the class component
            group(
                'and is passed in via a "ref" prop in a nested props Map (with conversion) as a',
                () {
              forEachTestCase((testCaseName, isDartCallbackCase,
                  isDartRefObjectCase, isTyped) {
                final isJsCallbackCase =
                    testCaseName == RefTestCaseCollection.jsCallbackRefCaseName;

                test(testCaseName, () async {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((Suspense()..fallback='Loading')((LazyTestJS()
                    ..component = Dom.div.elementType
                    ..addTestId('test-js-component')
                    ..buttonComponent = ClassComponent.elementType
                    ..buttonProps = (domProps()..ref = testCase.ref))()));
                  await screen.findByTestId('test-js-component');
                  // JS callbacks look the same to generateJsProps as Dart callback refs do,
                  // so they get the Dart component as well. // TODO investigate, decide how concerned we should be about this
                  if (isDartRefObjectCase ||
                      isDartCallbackCase ||
                      isJsCallbackCase) {
                    expect(
                        testCase.getCurrent(), isA<ClassComponentComponent>());
                  } else {
                    expect(
                        testCase.getCurrent(),
                        isA<ReactComponent>().havingDartComponent(
                            isA<ClassComponentComponent>()));
                  }
                }, tags: [
                  if (isJsCallbackCase) 'js-interop-tradeoff',
                ]);
              });
            });
          });
        });
  });
  });
}

UiFactory<TestJsProps> LazyTestJS = lazy(() async => TestJs,
_$TestJsConfig, // ignore: undefined_identifier
);

//
// OverReact bindings for a JS test component
// to assert correct behavior in more functional-style cases.
//

@Props(keyNamespace: '')
mixin TestJsProps on UiProps {
  @Accessor(key: 'buttonProps')
  JsMap? _$raw$buttonProps;

  Map? get buttonProps => unjsifyMapProp(_$raw$buttonProps);
  set buttonProps(Map? value) => _$raw$buttonProps = jsifyMapProp(value);

  @Accessor(key: 'listOfProps')
  List<dynamic>? _$raw$listOfProps;

  List<Map?>? get listOfProps => unjsifyMapListProp(_$raw$listOfProps);
  set listOfProps(List<Map?>? value) => _$raw$listOfProps = jsifyMapListProp(value);

  @Accessor(key: 'inputRef')
  dynamic _$raw$inputRef;

  dynamic get inputRef => unjsifyRefProp(_$raw$inputRef);
  set inputRef(dynamic value) => _$raw$inputRef = jsifyRefProp(value);

  @Accessor(key: 'messageContext')
  ReactContext? _$raw$messageContext;

  Context<String?>? get messageContext => unjsifyContextProp(_$raw$messageContext);
  set messageContext(Context<String?>? value) => _$raw$messageContext = jsifyContextProp(value);

  dynamic /*ElementType*/ component;
  dynamic /*ElementType*/ inputComponent;
  dynamic /*ElementType*/ buttonComponent;
}

UiFactory<TestJsProps> TestJs = uiJsComponent(
  ReactJsComponentFactoryProxy(_TestJs),
  _$TestJsConfig, // ignore: undefined_identifier
);

@JS('TestJsComponent')
external ReactClass get _TestJs;
