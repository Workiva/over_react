@TestOn('browser')
@JS()
library rmui.test.unit.component.lazy_test;

import 'dart:convert';
import 'dart:html';

import 'package:js/js.dart';
import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart' hide lazy, createRef;
import 'package:react_testing_library/matchers.dart';
import 'package:react_testing_library/react_testing_library.dart';

import 'package:test/test.dart';
import 'package:over_react/components.dart' as components;

import '../../../example/builder/src/function_component.dart';
import '../component_declaration/builder_integration_tests/new_boilerplate/function_component_test.dart';
import '../util/prop_conversion_test.dart';
import '../util/ref_test_cases.dart';

part 'lazy_test.over_react.g.dart';

main() {
  enableTestMode();

  group('lazy', () {
    group('with UiProps', () {
      test('renders a component from end to end, successfully reading props via typed getters', () {
        render(
          (Suspense()..fallback = (Dom.div()('loading')))(
            (SimpleLazy()..id = '1')(),
          ),
        );

        final node = screen.findByTestId('simple-lazy');

        expect(node, isA<DivElement>());
        expect(node, hasTextContent('id: 1'));
      });

      group('initializes the factory variable with a function', () {
        test('that returns a new props class implementation instance', () {
          final instance = SimpleLazy();
          expect(instance, isA<UiProps>());
          expect(instance, isA<Map>());
        });

        test('that returns a new props class implementation instance backed by an existing map', () {
          Map existingMap = {'key': 'test'};
          final props = SimpleLazy(existingMap);

          expect(props.key, equals('test'));

          props.key = 'modified';
          expect(props.key, equals('modified'));
          expect(existingMap['key'], equals('modified'));
        });
      });

      test('generates prop getters/setters with the prop name as the key by default', () {
        expect(Simple()..key = 'test', containsPair('key', 'test'));
        expect(SimpleLazy()..id = '2', containsPair('id', '2'));
      });
    });

    group('does not throw an error when', () {
      test('config is null, IF it only expects GenericUiProps', () {
        testLazy() => lazy(
            () async => uiFunction<UiProps>(
                  (props) => (Dom.div()..addTestId('testId3'))('id: ${props.id}'),
                  UiFactoryConfig(),
                ),
            null);
        expect(testLazy, returnsNormally);
        expect(testLazy(), isA<UiFactory<UiProps>>());
      });
    });

    group('throws an error when', () {
      test('props factory is not provided when using custom props class', () {
        expect(
            () => lazy(
                  () async => uiFunction<TestProps>(
                    (props) => Dom.div()(),
                    UiFactoryConfig(displayName: 'Foo'),
                  ),
                  UiFactoryConfig(displayName: 'Foo'),
                ),
            throwsArgumentError);
      });

      test('config not the correct type', () {
        expect(
            () => lazy(
                  () async => uiFunction<UiProps>(
                    (props) => (Dom.div()..addTestId('testId3'))('id: ${props.id}'),
                    UiFactoryConfig(),
                  ),
                  'foo',
                ),
            throwsArgumentError);
      });
    });

    group('initializes the factory variable with a function', () {
      test('that returns a new props class implementation instance', () {
        final instance = lazy(() async => TestDart, _$TestDartConfig)();
        expect(instance, isA<TestDartProps>());
        expect(instance, isA<Map>());
      });

      test('that returns a new props class implementation instance backed by an existing map', () {
        Map existingMap = {'stringProp': 'test'};
        final factory = lazy(() async => TestDart, _$TestDartConfig);
        final props = factory(existingMap);

        expect(props.stringProp, equals('test'));

        props.stringProp = 'modified';
        expect(props.stringProp, equals('modified'));
        expect(existingMap['stringProp'], equals('modified'));
      });
    });

    group('wrapped', () {
      group('JS component', () {
        test('has correct map prop conversion', () async {
          // The map should be a Js object, not a Dart Map
          final ref = createRef<Element>();
          final renderErrors = [];
          bool mapPropFunctionCalled = false;
          bool functionPropCalled = false;

          render((components.ErrorBoundary()
            ..onComponentDidCatch = ((error, _) {
              renderErrors.add(error);
            })
            ..shouldLogErrors = false
            ..fallbackUIRenderer = ((_, __) => Dom.span()('An error occurred during render'))
          )(
            (Suspense()
              ..fallback = (Dom.div()..addTestId('suspense'))(
                'I am a fallback UI that will show while we load the lazy component! The load time is artificially inflated to last an additional 5 seconds just to prove it\'s working!',
              )
            )(
              (LazyJsTypeTester()
                ..ref = ref
                ..mapProp = {
                  'test': 'foo',
                  'fun': () {
                    mapPropFunctionCalled = true;
                  }
                }
                ..functionProp = (() {
                  functionPropCalled = true;
                  return 'test';
                })
              )('JS'),
            ),
          ));
          expect(renderErrors, isEmpty);
          // Wait for the "lazy" component to display
          await screen.findByText('JS');
          expect(ref.current, isA<Element>());
          expect(mapPropFunctionCalled, isTrue);
          expect(functionPropCalled, isTrue);
          expect(screen.getByTestId('test'), isInTheDocument);
        });
        sharedNestedPropConversionTests(LazyTestJs, isJsComponent: true);
      });

      group('Dart Class component', () {
        test('has correct map prop conversion', () async {
          // The map should be a Dart Map, not a JS object
          final ref = createRef();
          final renderErrors = [];
          bool mapPropFunctionCalled = false;
          bool functionPropCalled = false;

          render((components.ErrorBoundary()
            ..onComponentDidCatch = ((error, _) => renderErrors.add(error))
            ..shouldLogErrors = false
            ..fallbackUIRenderer = ((_, __) => Dom.span()('An error occurred during render'))
          )(
            (Suspense()
              ..fallback = (Dom.div()..id = 'suspense')(
                'I am a fallback UI that will show while we load the lazy component! The load time is artificially inflated to last an additional 5 seconds just to prove it\'s working!',
              )
            )(
              (LazyClassComponentTypeTester()
                ..ref = ref
                ..mapProp = {
                  'test': 'foo',
                  'fun': () {
                    mapPropFunctionCalled = true;
                  }
                }
                ..functionProp = (() {
                  functionPropCalled = true;
                  return 'test';
                })
              )('Class'),
            ),
          ));
          // Wait for the "lazy" component to display
          await screen.findByText('Class');
          expect(ref.current, isA<ClassComponentTypeTesterComponent>());
          expect(mapPropFunctionCalled, isTrue);
          expect(functionPropCalled, isTrue);
          expect(screen.getByTestId('test'), isInTheDocument);
        });
      });
      group('Dart function component', () {
        test('has correct map prop conversion', () async {
          // The map should be a Dart Map, not a JS object
          final ref = createRef<Element>();
          final renderErrors = [];
          bool mapPropFunctionCalled = false;
          bool functionPropCalled = false;

          render((components.ErrorBoundary()
            ..onComponentDidCatch = ((error, _) => renderErrors.add(error))
            ..shouldLogErrors = false
            ..fallbackUIRenderer = ((_, __) => Dom.span()('An error occurred during render'))
          )(
            (Suspense()
              ..fallback = (Dom.div()..id = 'suspense')(
                'I am a fallback UI that will show while we load the lazy component! The load time is artificially inflated to last an additional 5 seconds just to prove it\'s working!',
              )
            )(
              (LazyUiForwardRefTypeTester()
                ..ref = ref
                ..mapProp = {
                  'test': 'foo',
                  'fun': () {
                    mapPropFunctionCalled = true;
                  }
                }
                ..functionProp = (() {
                  functionPropCalled = true;
                  return 'test';
                })
              )('UiForwardRef'),
            ),
          ));
          // Wait for the "lazy" component to display
          await screen.findByText('UiForwardRef');
          expect(ref.current, isA<Element>());
          expect(mapPropFunctionCalled, isTrue);
          expect(functionPropCalled, isTrue);
          expect(screen.getByTestId('test'), isInTheDocument);
        });
        sharedNestedPropConversionTests(LazyTestDart);
      });
    });
  });
}

/// These shared tests are adapted from prop_conversion_test.dart and are used to test the prop conversion behavior
sharedNestedPropConversionTests(UiFactory<TestJsProps> builder, {bool isJsComponent = false}) {
  group('nested prop conversions works as expected in advanced cases:', () {
    test('a custom Dart Map prop on a Dart component', () async {
      final renderErrors = [];

      // Use an ErrorBoundary to detect errors on render, since otherwise
      // React will just unmount the tree without throwing.
      await expectLater(() async {
        render(
          (Suspense()..fallback = Dom.div()('Loading'))(
            (components.ErrorBoundary()
              ..onComponentDidCatch = ((error, _) => renderErrors.add(error))
              ..shouldLogErrors = false
              ..fallbackUIRenderer = ((_, __) => Dom.span()('An error occurred during render'))
            )(
              (builder()
                ..component = (isJsComponent ? ExpectsDartMapProp.elementType : ExpectsDartMapProp)
                ..addProps(ExpectsDartMapProp()..dartMapProp = {'foo': 'bar'})
                ..addTestId('componentRoot')
              )(),
            ),
          ),
        );

        await waitForElementToBeRemoved(() => screen.getByText('Loading'));

        // Use prints as an easy way to swallow `print` calls and
        // prevent RTL from forwarding console errors to the test output,
        // since React error boundary logging is pretty noisy.
        // TODO instead, disable logging in this rtl.render call once that option is available: FED-1641
      }, prints(anything));

      expect(renderErrors, [
        if (isJsComponent)
          isA<Object>().havingToStringValue(anyOf(
            // DDC error message
            matches(
                RegExp(r"Expected a value of type 'Map[^']*', but got one of type '(Native|Legacy)JavaScriptObject'")),
            // dart2js error message
            matches(RegExp(r"type '(Unknown|Plain)JavaScriptObject' is not a subtype of type 'Map[^']*'")),
          )),
      ]);
      if (!isJsComponent) {
        // These are the expectations we'd use if this case didn't error:
        final node = screen.getByTestId('componentRoot');
        expect(node, hasAttribute('data-dart-map-prop', jsonEncode({'foo': 'bar'})));
      }
    }, tags: ['js-interop-tradeoff']);
    group('a ref is set on the lazy wrapper', () {
      group('which eventually ends up on a non-Dart component', () {
        final testCaseCollection = RefTestCaseCollection<Element>();

        group('and is passed in via a forwarded "ref" prop as a', () {
          for (final testCaseName in testCaseCollection.allTestCaseNames) {
            test(testCaseName, () async {
              final testCase = testCaseCollection.createCaseByName(testCaseName);

              render((Suspense()..fallback = 'Loading')(
                (builder()
                  ..addTestId('test-component')
                  ..component = (isJsComponent ? BasicForwardRef.elementType : BasicForwardRef)
                  ..ref = testCase.ref
                )(),
              ));
              await screen.findByTestId('test-component');
              expect(testCase.getCurrent(), isA<Element>());
              expect(testCase.getCurrent(), hasAttribute(basicForwardRefAttribute),
                  reason: 'test setup: ref should have been forwarded to the element we expect');
            });
          }
        });

        group('and is passed in via a custom "ref" prop (with conversion) as a', () {
          for (final testCaseName in testCaseCollection.allTestCaseNames) {
            test(testCaseName, () async {
              final testCase = testCaseCollection.createCaseByName(testCaseName);

              render((Suspense()..fallback = 'Loading')(
                (builder()
                  ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                  ..addTestId('test-component')
                  ..inputComponent = (isJsComponent ? BasicForwardRef.elementType : BasicForwardRef)
                  ..inputRef = testCase.ref
                )(),
              ));
              await screen.findByTestId('test-component');
              expect(testCase.getCurrent(), isA<Element>());
              expect(testCase.getCurrent(), hasAttribute(basicForwardRefAttribute),
                  reason: 'test setup: ref should have been forwarded to the element we expect');
            });
          }
        });

        group('and is passed in via a "ref" prop in a nested props Map (with conversion) as a', () {
          for (final testCaseName in testCaseCollection.allTestCaseNames) {
            test(testCaseName, () async {
              final testCase = testCaseCollection.createCaseByName(testCaseName);

              render((Suspense()..fallback = 'Loading')(
                (builder()
                  ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                  ..addTestId('test-component')
                  ..buttonComponent = (isJsComponent ? BasicForwardRef.elementType : BasicForwardRef)
                  ..buttonProps = (domProps()..ref = testCase.ref)
                )(),
              ));
              await screen.findByTestId('test-component');
              expect(testCase.getCurrent(), isA<Element>());
              expect(testCase.getCurrent(), hasAttribute(basicForwardRefAttribute),
                  reason: 'test setup: ref should have been forwarded to the element we expect');
            });
          }
        });
      });

      group('which eventually ends up on a Dart class component', () {
        final testCaseCollection = RefTestCaseCollection<ClassComponentComponent>();

        setUpAll(() {
          // Make sure the special cases we're concerned about are included in this set of test cases:
          void assertSingleMetaWhere(bool Function(RefTestCaseMeta) test) {
            expect(testCaseCollection.allTestCaseMetas.where(test).toList(), hasLength(1));
          }

          assertSingleMetaWhere((m) => !m.isJs && m.kind.isCallback && m.isStronglyTyped);
          assertSingleMetaWhere((m) => !m.isJs && m.kind.isCallback && !m.isStronglyTyped);
          assertSingleMetaWhere((m) => !m.isJs && m.kind.isObject && m.isStronglyTyped);
          assertSingleMetaWhere((m) => !m.isJs && m.kind.isObject && !m.isStronglyTyped);
        });

        void forEachTestCase(
            void Function(String testCaseName, bool isDartCallbackCase, bool isDartRefObjectCase, bool isTyped)
                callback) {
          for (final testCaseName in testCaseCollection.allTestCaseNames) {
            final meta = testCaseCollection.testCaseMetaByName(testCaseName);
            final isDartCallbackCase = !meta.isJs && meta.kind.isCallback;
            final isDartRefObjectCase = !meta.isJs && meta.kind.isObject;
            final isTyped = meta.isStronglyTyped;

            callback(testCaseName, isDartCallbackCase, isDartRefObjectCase, isTyped);
          }
        }

        group('and is passed in via a forwarded "ref" prop as a', () {
          forEachTestCase((testCaseName, isDartCallbackCase, isDartRefObjectCase, isTyped) {
            if (isDartCallbackCase && isTyped) {
              // Bail since we know typed Dart callback refs will fail with a runtime type error since the JS  ReactComponent
              // will be passed in instead of the Dart instance; this behavior will be tested in the untyped Dart callback ref test case.
              return;
            }

            test(testCaseName, () async {
              final testCase = testCaseCollection.createCaseByName(testCaseName);
              final isJsCallbackCase = testCaseName == RefTestCaseCollection.jsCallbackRefCaseName;

              render((Suspense()..fallback = 'Loading')(
                (builder()
                  ..addTestId('test-component')
                  ..component = (isJsComponent ? ClassComponent.elementType : ClassComponent)
                  ..ref = testCase.ref
                )(),
              ));
              await screen.findByTestId('test-component');
              // JS callbacks look the same to generateJsProps as Dart callback refs do,
              // so they get the Dart component as well. // TODO investigate, decide how concerned we should be about this
              if (isDartRefObjectCase || isDartCallbackCase || isJsCallbackCase) {
                expect(testCase.getCurrent(), isA<ClassComponentComponent>());
              } else {
                // When a JS ref object is used.
                expect(
                    testCase.getCurrent(), isA<ReactComponent>().havingDartComponent(isA<ClassComponentComponent>()));
              }
            });
          });
        });

        group('and is passed in via a custom "ref" prop (with conversion) as a', () {
          forEachTestCase((testCaseName, isDartCallbackCase, isDartRefObjectCase, isTyped) {
            if (isDartCallbackCase && isTyped) {
              // Bail since we know typed Dart callback refs will fail with a runtime type error since the JS  ReactComponent
              // will be passed in instead of the Dart instance; this behavior will be tested in the untyped Dart callback ref test case.
              return;
            }

            test(testCaseName, () async {
              final testCase = testCaseCollection.createCaseByName(testCaseName);
              final isJsCallbackCase = testCaseName == RefTestCaseCollection.jsCallbackRefCaseName;

              render((Suspense()..fallback = 'Loading')(
                (builder()
                  ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                  ..addTestId('test-component')
                  ..inputComponent = (isJsComponent ? ClassComponent.elementType : ClassComponent)
                  ..inputRef = testCase.ref
                )(),
              ));
              await screen.findByTestId('test-component');
              if ((isDartRefObjectCase || (isDartCallbackCase || isJsCallbackCase) && !isJsComponent)) {
                expect(testCase.getCurrent(), isA<ClassComponentComponent>());
              } else {
                // JS wrapped component or JS ref type
                expect(
                    testCase.getCurrent(), isA<ReactComponent>().havingDartComponent(isA<ClassComponentComponent>()));
              }
            });
          });
        });

        // This is the one case where Dart (and unfortunately, JS) callback refs actually get the class component
        group('and is passed in via a "ref" prop in a nested props Map (with conversion) as a', () {
          forEachTestCase((testCaseName, isDartCallbackCase, isDartRefObjectCase, isTyped) {
            final isJsCallbackCase = testCaseName == RefTestCaseCollection.jsCallbackRefCaseName;

            test(testCaseName, () async {
              final testCase = testCaseCollection.createCaseByName(testCaseName);

              render((Suspense()..fallback = 'Loading')(
                (builder()
                  ..component = (isJsComponent ? Dom.div.elementType : Dom.div)
                  ..addTestId('test-component')
                  ..buttonComponent = (isJsComponent ? ClassComponent.elementType : ClassComponent)
                  ..buttonProps = (domProps()..ref = testCase.ref)
                )(),
              ));
              await screen.findByTestId('test-component');
              // JS callbacks look the same to generateJsProps as Dart callback refs do,
              // so they get the Dart component as well. // TODO investigate, decide how concerned we should be about this
              if (isDartRefObjectCase || isDartCallbackCase || isJsCallbackCase) {
                expect(testCase.getCurrent(), isA<ClassComponentComponent>());
              } else {
                expect(
                    testCase.getCurrent(), isA<ReactComponent>().havingDartComponent(isA<ClassComponentComponent>()));
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

//
// Lazy Test Component Declarations
//

UiFactory<UiProps> SimpleLazy = lazy(
    () async => uiFunction(
        (props) => (Dom.div()
          ..addTestId('simple-lazy')
          ..addProps(props)
        )('id: ${props.id}'),
        UiFactoryConfig()),
    UiFactoryConfig());

UiFactory<TestDartClassProps> LazyTestDartClass =
    lazy(() async => TestDartClass, UiFactoryConfig(propsFactory: PropsFactory.fromUiFactory(TestDartClass)));

UiFactory<ClassComponentTypeTesterProps> LazyClassComponentTypeTester = lazy(() async => ClassComponentTypeTester,
    UiFactoryConfig(propsFactory: PropsFactory.fromUiFactory(ClassComponentTypeTester)));

UiFactory<ExpectsDartMapPropProps> LazyExpectsDartMapProp =
    lazy(() async => ExpectsDartMapProp, UiFactoryConfig(propsFactory: PropsFactory.fromUiFactory(ExpectsDartMapProp)));

UiFactory<TestJsProps> LazyTestJs = lazy(
  () async => TestJs,
  UiFactoryConfig(propsFactory: PropsFactory.fromUiFactory(TestJs)),
);

UiFactory<TestJsProps> LazyTestDart = lazy(
  () async => TestDart,
  _$TestDartConfig, // ignore: undefined_identifier
);

mixin DartTestJsWrapperPropsMixin on UiProps {
  void Function(DartTestJsWrapperProps props)? onRender;
}

class DartTestJsWrapperProps = UiProps with TestJsProps, DartTestJsWrapperPropsMixin;

UiFactory<DartTestJsWrapperProps> DartTestJsWrapper = uiForwardRef(
  (props, ref) {
    props.onRender?.call(props);

    return (TestJs()
      ..addProps(props.getPropsToForward(exclude: {DartTestJsWrapperPropsMixin}))
      ..ref = ref
    )(props.children);
  },
  _$DartTestJsWrapperConfig, // ignore: undefined_identifier
);

UiFactory<JsTypeTesterProps> JsTypeTester = uiJsComponent(
  ReactJsComponentFactoryProxy(_JsTypeTester),
  _$JsTypeTesterConfig, // ignore: undefined_identifier
);

@JS('JsTypeTester')
external ReactClass get _JsTypeTester;

final defaultMessageContext = createContextInit('default context value');

@Props(keyNamespace: '')
mixin TestDartPropsMixin on UiProps {
  String? stringProp;
  dynamic forwardRef;
}

@Props(keyNamespace: '')
class TestDartProps = UiProps with TestJsProps, TestDartPropsMixin;

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
      (inputComponent()
        ..addProps(domProps()..type = 'text')
        ..ref = inputRef)(),
      (component()
        ..addProps(props.getPropsToForward(exclude: {TestJsProps}))
        ..ref = ref)(children),
      (Dom.div()..role = 'alert')(message),
    );
  },
  _$TestDartConfig, // ignore: undefined_identifier
);

@Props(keyNamespace: '')
mixin TypeTesterProps on UiProps {
  late Map mapProp;
  late Function functionProp;
}

@Props(keyNamespace: '')
mixin JsTypeTesterProps on UiProps {
  @Accessor(key: 'mapProp')
  JsMap? _$raw$mapProp;

  Map? get mapProp => unjsifyMapProp(_$raw$mapProp);
  set mapProp(Map? value) => _$raw$mapProp = jsifyMapProp(value);

  late String Function() functionProp;
}

final LazyJsTypeTester = lazy(() async => JsTypeTester, _$JsTypeTesterConfig);
final LazyUiForwardRefTypeTester = lazy(() async => UiForwardRefTypeTester, _$UiForwardRefTypeTesterConfig);

UiFactory<TypeTesterProps> UiForwardRefTypeTester = uiForwardRef(
  (props, ref) {
    verifyType(props.mapProp);
    verifyType(props.functionProp);
    if (props.mapProp['fun'] is! Function) {
      throw ArgumentError('mapProp[\'fun\'] should be a function');
    } else {
      props.mapProp['fun']();
    }
    return (Dom.div()
      ..addTestId((props.functionProp() as String))
      ..ref = ref
      ..addProps(props.getPropsToForward(exclude: {TypeTesterProps}))
    )(props.children);
  },
  _$UiForwardRefTypeTesterConfig, // ignore: undefined_identifier
);

UiFactory<ClassComponentTypeTesterProps> ClassComponentTypeTester =
    castUiFactory(_$ClassComponentTypeTester); // ignore: undefined_identifier

@Props(keyNamespace: '')
mixin ClassComponentTypeTesterProps on UiProps {
  late Map mapProp;
  late Function functionProp;
}

class ClassComponentTypeTesterComponent extends UiComponent2<ClassComponentTypeTesterProps> {
  @override
  render() {
    verifyType(props.mapProp);
    verifyType(props.functionProp);
    if (props.mapProp['fun'] is! Function) {
      throw ArgumentError('mapProp[\'fun\'] should be a function');
    } else {
      props.mapProp['fun']();
    }
    return (Dom.div()
      ..addTestId((props.functionProp() as String))
      ..addProps(props.getPropsToForward(exclude: {ClassComponentTypeTesterProps}))
    )(props.children);
  }
}

UiFactory<TestDartClassProps> TestDartClass = castUiFactory(_$TestDartClass); // ignore: undefined_identifier

@Props(keyNamespace: '')
class TestDartClassProps = UiProps with TestJsProps, TestDartPropsMixin;

class TestDartClassComponent extends UiComponent2<TestDartClassProps> {
  @override
  get contextType => defaultMessageContext.reactDartContext;

  @override
  render() {
    final buttonProps = props.buttonProps ?? const {};
    final listOfProps = props.listOfProps ?? const [{}];
    final inputRef = props.inputRef;
    final buttonComponent = props.buttonComponent ?? Dom.button;
    final inputComponent = props.inputComponent ?? Dom.input;
    final component = props.component ?? Dom.span;
    final children = props.children;

    return Dom.div()(
      (buttonComponent()..addProps(buttonProps))(),
      (Dom.li()..addProps(listOfProps[0] ?? {}))(),
      (inputComponent()
        ..addProps(domProps()..type = 'text')
        ..ref = inputRef)(),
      (component()
        ..addProps(props.getPropsToForward(exclude: {TestJsProps}))
        ..ref = props.forwardRef)(children),
      (Dom.div()..role = 'alert')(context),
    );
  }
}
