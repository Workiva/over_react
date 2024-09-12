@TestOn('browser')
@JS()
library rmui.test.unit.component.lazy_test;

import 'dart:convert';
import 'dart:html';

import 'package:js/js.dart';
import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart' hide lazy;
import 'package:react_testing_library/matchers.dart';
import 'package:react_testing_library/react_testing_library.dart';

import 'package:test/test.dart';
import 'package:over_react/components.dart' as components;

import '../util/ref_test_cases.dart';

part 'lazy_test.over_react.g.dart';

main() {
  enableTestMode();
    group('lazy wrapped', () {
  group('JS component', () {
    sharedPropConversionTests(LazyTestJs, isJsComponent: true);
      });
group('Dart component', () {
    sharedPropConversionTests(LazyTestDart);
});
    });

}

sharedPropConversionTests(UiFactory<TestJsProps> builder, { bool isJsComponent = false }) {
    group('prop conversions', () {

test('a custom Dart Map prop', () async {
          final renderErrors = [];

          // Use an ErrorBoundary to detect errors on render, since otherwise
          // React will just unmount the tree without throwing.
          await expectLater(() async {
            render((Suspense()..fallback=Dom.div()('Loading'))((components.ErrorBoundary()
              ..onComponentDidCatch = ((error, _) => renderErrors.add(error))
              ..shouldLogErrors = false
              ..fallbackUIRenderer =
                  ((_, __) => Dom.span()('An error occurred during render'))
              )(
                (builder()
                  ..component = (isJsComponent ? ExpectsDartMapProp.elementType : ExpectsDartMapProp)
                  ..addProps(ExpectsDartMapProp()..dartMapProp = {'foo': 'bar'})
                  ..addTestId('componentRoot'))(),
                ),
              ),
            );
            // if (!isJsComponent) {
            await waitForElementToBeRemoved(() => screen.getByText('Loading'));
            // } else {
            // await screen.findByText('An error occurred during render');
            // }
            // Use prints as an easy way to swallow `print` calls and
            // prevent RTL from forwarding console errors to the test output,
            // since React error boundary logging is pretty noisy.
            // TODO instead, disable logging in this rtl.render call once that option is available: FED-1641
          }, prints(anything));

          expect(renderErrors, [
            //  if (isJsComponent)
            // isA<Object>().havingToStringValue(anyOf(
            //   // DDC error message
            //   matches(RegExp(
            //       r"Expected a value of type 'Map[^']*', but got one of type '(Native|Legacy)JavaScriptObject'")),
            //   // dart2js error message
            //   matches(RegExp(
            //       r"type '(Unknown|Plain)JavaScriptObject' is not a subtype of type 'Map[^']*'")),
            // )),
          ]);
//  if (!isJsComponent) {
          // These are the expectations we'd use if this case didn't error:
          final node = screen.getByTestId('componentRoot');
          expect(node, hasAttribute('data-dart-map-prop', jsonEncode({'foo': 'bar'})));
//  }
        }, tags: ['js-interop-tradeoff']);
        group('and a ref is set on that component', () {
          group('which eventually ends up on a non-Dart component', () {
            final testCaseCollection = RefTestCaseCollection<Element>();

            group('and is passed in via a forwarded "ref" prop as a', () {
              for (final testCaseName in testCaseCollection.allTestCaseNames) {
                test(testCaseName, () async {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((Suspense()..fallback='Loading')((builder()
                    ..addTestId('test-js-component')
                    ..component = (isJsComponent ? BasicForwardRef.elementType : BasicForwardRef)
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

                  render((Suspense()..fallback='Loading')((builder()
                  ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                    ..addTestId('test-js-component')
                    ..inputComponent = (isJsComponent ? BasicForwardRef.elementType : BasicForwardRef)
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

                  render((Suspense()..fallback='Loading')((builder()
                  ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                    ..addTestId('test-js-component')
                    ..buttonComponent = (isJsComponent ? BasicForwardRef.elementType : BasicForwardRef)
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

// GREG LOOK HERE
                  render((Suspense()..fallback='Loading')((builder()
                    ..addTestId('test-js-component')
                    ..component = (isJsComponent ? ClassComponent.elementType : ClassComponent)
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

                  render((Suspense()..fallback='Loading')((builder()
                  ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                    ..addTestId('test-js-component')
                    ..inputComponent = (isJsComponent ? ClassComponent.elementType : ClassComponent)
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

                  render((Suspense()..fallback='Loading')((builder()
                    ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                    ..addTestId('test-js-component')
                    ..buttonComponent = (isJsComponent ? ClassComponent.elementType : ClassComponent)
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
}

UiFactory<TestJsProps> LazyTestJs = lazy(() async => TestJs,
_$TestJsConfig, // ignore: undefined_identifier
//useJsFactoryProxy: true,
);

UiFactory<TestJsProps> LazyTestDart = lazy(() async => TestDart,
_$TestDartConfig, // ignore: undefined_identifier
);

//
// Matcher convenience functions
//

Matcher sameOrSameAllowInterop(Function f) =>
    anyOf(same(allowInterop(f)), same(f));

extension on TypeMatcher<Ref> {
  Matcher havingJsRef(dynamic matcher) =>
      having((ref) => ref.jsRef, 'jsRef', matcher);
}

extension on TypeMatcher<Context> {
  Matcher havingJsThis(dynamic matcher) =>
      having((ref) => ref.jsThis, 'jsThis', matcher);
}

extension on TypeMatcher<Object> {
  Matcher havingToStringValue(dynamic matcher) =>
      having((o) => o.toString(), 'toString() value', matcher);
}

extension on TypeMatcher<ReactComponent> {
  Matcher havingDartComponent(dynamic matcher) =>
      having((ref) => ref.dartComponent, 'dartComponent', matcher);
}

//
// Runtime type verification
//

/// Verifies the runtime type of object, throwing a cast error if it does not match.
///
/// Even though [object] typed as [T], we'll verify it explicitly in case
/// the type-check at the function call site gets compiled out.
void verifyType<T>(T? object) {
  if (T == Object || T == dynamic || T == Null) {
    throw ArgumentError.value(T, 'T', 'must be more specific');
  }

  if (object is! T) {
    // Try to get Dart to throw a real type error by explicitly casting.
    // ignore: unnecessary_statements, unnecessary_cast
    object as T;

    // The above `as` should always fail, but may not if the cast gets compiled out,
    // or if there are edge cases in the type system cases where this seemingly-incorrect cast works.
    //
    // Explicitly throw an error so that this case doesn't go unnoticed.
    throw UnexpectedSuccessfulCastError(
        'Casting ${Error.safeToString(object)} to type $T should have failed, but did not for some reason.'
        ' Check the implementation of verifyType.');
  }
}

class UnexpectedSuccessfulCastError extends Error {
  final String message;

  UnexpectedSuccessfulCastError(this.message);

  @override
  String toString() => message;
}

//
// Test components for use as JS `component` prop
//

mixin ExpectsDartMapPropProps on UiProps {
  Map? dartMapProp;
}

UiFactory<ExpectsDartMapPropProps> ExpectsDartMapProp = uiForwardRef(
  (props, ref) {
    verifyType<Map>(props.dartMapProp);

    return (Dom.div()
      ..addProps(props)
      // Use the prop in a way that would fail if it wasn't the correct type
      ..['data-dart-map-prop'] = jsonEncode(props.dartMapProp)
      ..ref = ref)(props.children);
  },
  _$ExpectsDartMapPropConfig, // ignore: undefined_identifier
);

mixin ExpectsDartStylePropProps on UiProps {}

UiFactory<ExpectsDartStylePropProps> ExpectsDartStyleProp = uiForwardRef(
  (props, ref) {
    verifyType<Map<String, dynamic>>(props.style);

    return (Dom.div()
      ..addProps(props)
      ..style = {
        // Use the prop in a way that would fail if it wasn't the correct type
        ...props.style!,
      })(props.children);
  },
  _$ExpectsDartStylePropConfig, // ignore: undefined_identifier
);

mixin ExpectsListChildrenPropProps on UiProps {}

UiFactory<ExpectsListChildrenPropProps> ExpectsListChildrenProp = uiForwardRef(
  (props, ref) {
    verifyType<List>(props.children);

    return (Dom.div()..addProps(props))(
      // Use the prop in a way that would fail if it wasn't the correct type
      props.children!.map((child) => child),
    );
  },
  _$ExpectsListChildrenPropConfig, // ignore: undefined_identifier
);

//
// Other test components
//

UiFactory<ClassComponentProps> ClassComponent =
    castUiFactory(_$ClassComponent); // ignore: undefined_identifier

mixin ClassComponentProps on UiProps {}

class ClassComponentComponent extends UiComponent2<ClassComponentProps> {
  @override
  render() {
    return (Dom.div()..addProps(props))(props.children);
  }
}

mixin BasicForwardRefProps on UiProps {}

const basicForwardRefAttribute = 'data-basic-forward-ref';
UiFactory<BasicForwardRefProps> BasicForwardRef = uiForwardRef(
  (props, ref) {
    return (Dom.span()
      ..addProps(props)
      ..[basicForwardRefAttribute] = ''
      ..ref = ref)(props.children);
  },
  _$BasicForwardRefConfig, // ignore: undefined_identifier
);

mixin DartTestJsWrapperPropsMixin on UiProps {
  void Function(DartTestJsWrapperProps props)? onRender;
}

class DartTestJsWrapperProps = UiProps
    with TestJsProps, DartTestJsWrapperPropsMixin;

UiFactory<DartTestJsWrapperProps> DartTestJsWrapper = uiForwardRef(
  (props, ref) {
    props.onRender?.call(props);

    return (TestJs()
      ..addProps(props.getPropsToForward(exclude: {DartTestJsWrapperPropsMixin}))
      ..ref = ref)(props.children);
  },
  _$DartTestJsWrapperConfig, // ignore: undefined_identifier
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


final defaultMessageContext = createContextInit('default context value');

@Props(keyNamespace: '')
class TestDartProps = UiProps with TestJsProps;

UiFactory<TestDartProps> TestDart = uiForwardRef(
  (props, ref) {

      final buttonProps = props.buttonProps ?? const {};
      final listOfProps = props.listOfProps ?? const [{}];
      final inputRef = props.inputRef;
      final buttonComponent = props.buttonComponent ?? Dom.button;
      final inputComponent = props.inputComponent ?? Dom.input;
      final component = props.component ?? Dom.span;
      final children = props.children;
      final messageContext = defaultMessageContext;

    final message = useContext(messageContext);
    return Dom.div()(
      (buttonComponent()..addProps(buttonProps))(),
      (Dom.li()..addProps(listOfProps[0] ?? {}))(),
      (inputComponent()..addProps(Dom.input()..type = 'text')..ref = inputRef)(),
      (component()..addProps(props.getPropsToForward(exclude: {TestJsProps}))..ref = ref)(children),
      (Dom.div()..role = 'alert')(message),
    );
  },
  _$TestDartConfig, // ignore: undefined_identifier
);
