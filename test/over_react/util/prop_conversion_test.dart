@TestOn('browser')
@JS()
library rmui.test.unit.util.prop_conversion_test;

import 'dart:convert';
import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:react/react.dart' as react;
import 'package:over_react/over_react.dart';
import 'package:over_react/components.dart' as components;
import 'package:over_react/src/util/js_component.dart';
import 'package:over_react/src/util/prop_conversion.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart'
    show React, ReactClass, ReactComponent, ReactContext;
import 'package:react_testing_library/matchers.dart';
import 'package:react_testing_library/react_testing_library.dart';
import 'package:react_testing_library/user_event.dart';
import 'package:test/test.dart';

import 'ref_test_cases.dart';
part 'prop_conversion_test.over_react.g.dart';

main() {
  enableTestMode();

  group('prop conversion', () {
    group('utilities:', () {
      Matcher hasJsBackedMapValue(dynamic matcher) => isA<JsMap>()
          .having((jsMap) => JsBackedMap.backedBy(jsMap), 'JsBackedMap.backedBy', matcher);

      group('jsifyMapProp', () {
        test('passes through null values', () {
          expect(jsifyMapProp(null), null);
        });

        test('converts maps to JS objects', () {
          expect(jsifyMapProp({'foo': 'bar'}),
              hasJsBackedMapValue({'foo': 'bar'}));
        });

        test('converts nested maps deep conversion of JS objects and functions',
            () {
          dartFunction() {}

          expect(
              jsifyMapProp({
                'foo': {
                  'bar': dartFunction,
                }
              }),
              hasJsBackedMapValue({
                'foo': hasJsBackedMapValue({
                  'bar': allowInterop(dartFunction),
                })
              }));
        });

        // This function is tested more thoroughly and functionally in the "Map props using (un)jsifyMapProp" group below.
      });

      group('unjsifyMapProp', () {
        test('passes through null values', () {
          expect(unjsifyMapProp(null), null);
        });

        group('converts JS objects to maps', () {
          test('with the correct contents', () {
            expect(unjsifyMapProp(jsify({'foo': 'bar'}) as JsMap),
                equals({'foo': 'bar'}));
          });

          test('casting the returned map to the correct type', () {
            expect(unjsifyMapProp<String, String>(jsify({'foo': 'bar'}) as JsMap),
                isA<Map<String, String>>());
            expect(
                unjsifyMapProp<String, int>(jsify({'foo': 1}) as JsMap), isA<Map<String, int>>());
          });
        });
        // This function is tested more thoroughly and functionally in the "Map props using (un)jsifyMapProp" group below.
      });

      group('jsifyMapListProp', () {
        test('passes through null values', () {
          expect(jsifyMapListProp(null), null);
        });

        test('passes through empty list', () {
          expect(jsifyMapListProp([]), []);
        });

        test('passes through null list values', () {
          expect(jsifyMapListProp([null]), [null]);
        });

        test('converts maps to JS objects', () {
          expect(
            jsifyMapListProp([
              {'foo': 'bar'},
              {'bar': 1},
              {'foo2': true},
            ]),
            orderedEquals([
              hasJsBackedMapValue({'foo': 'bar'}),
              hasJsBackedMapValue({'bar': 1}),
              hasJsBackedMapValue({'foo2': true}),
            ]),
          );
        });

        test('converts nested maps deep conversion of JS objects and functions', () {
          dartFunction() {}

          expect(
            jsifyMapListProp([
              {
                'foo': {'bar': dartFunction}
              }
            ]),
            orderedEquals([
              hasJsBackedMapValue({
                'foo': hasJsBackedMapValue({'bar': allowInterop(dartFunction)})
              })
            ]),
          );
        });
      });

      group('unjsifyMapListProp', () {
        test('passes through null values', () {
          expect(unjsifyMapListProp(null), null);
        });

        test('passes through empty list', () {
          expect(unjsifyMapListProp([]), []);
        });

        test('passes through null list values', () {
          expect(unjsifyMapListProp([null]), [null]);
        });

        group('converts JS objects to maps', () {
          test('with the correct contents', () {
            expect(
              unjsifyMapListProp([
                jsify({'foo': 'bar'}) as JsMap,
                jsify({'bar': 1}) as JsMap,
                jsify({'foo2': true}) as JsMap,
              ]),
              equals([
                {'foo': 'bar'},
                {'bar': 1},
                {'foo2': true},
              ]),
            );
          });

          test('casting the returned list to the correct type', () {
            expect(
              unjsifyMapListProp<String, String>([
                jsify({'foo': 'bar'}) as JsMap
              ]),
              allOf(isA<List<Map<String, String>?>>(), everyElement(isA<Map<String, String>>())),
            );
            expect(
              unjsifyMapListProp<String, int>([
                jsify({'foo': 1}) as JsMap
              ]),
              allOf(isA<List<Map<String, int>?>>(), everyElement(isA<Map<String, int>>())),
            );
            expect(
              unjsifyMapListProp<String, dynamic>([
                jsify({'foo': 1}) as JsMap,
                jsify({'bar': true}) as JsMap
              ]),
              allOf(isA<List<Map<String, dynamic>?>>(), everyElement(isA<Map<String, dynamic>>())),
            );
          });
        });
      });

      group('jsifyRefProp', () {
        test('passes through null', () {
          expect(jsifyRefProp(null), null);
        });

        test('passes through Dart callback refs', () {
          void dartCallbackRef(dynamic ref) {}
          expect(jsifyRefProp(dartCallbackRef),
              sameOrSameAllowInterop(dartCallbackRef));
        });

        test('converts Dart ref objects', () {
          final dartRef = createRef();
          expect(jsifyRefProp(dartRef), same(dartRef.jsRef));
        });

        test('passes through JS refs', () {
          final jsRef = createRef().jsRef;
          expect(jsifyRefProp(jsRef), same(jsRef));
        });

        test('passes through JS callback refs', () {
          final jsCallbackRef = allowInterop((dynamic ref) {});
          expect(jsifyRefProp(jsCallbackRef), same(jsCallbackRef));
        });

        test('passes through arbitrary Dart objects', () {
          final object = Object();
          expect(jsifyRefProp(object), same(object));
        });

        test('passes through arbitrary JS objects', () {
          final object = newObject();
          expect(jsifyRefProp(object), same(object));
        });
      });

      group('unjsifyRefProp', () {
        test('passes through null', () {
          expect(unjsifyRefProp(null), null);
        });

        test('passes through Dart callback refs', () {
          void dartCallbackRef(dynamic ref) {}
          expect(unjsifyRefProp(dartCallbackRef), same(dartCallbackRef));
        });

        test('passes through Dart ref objects', () {
          final dartRef = createRef();
          expect(unjsifyRefProp(dartRef), same(dartRef));
        });

        test(
            'passes through JS ref objects'
            ' (that had not previously been converted with jsifyRefProp)', () {
          final jsRef = createRef().jsRef;
          expect(unjsifyRefProp(jsRef), same(jsRef));
        });

        test('passes through JS callback refs', () {
          final jsCallbackRef = allowInterop((dynamic ref) {});
          expect(unjsifyRefProp(jsCallbackRef), same(jsCallbackRef));
        });

        test('passes through arbitrary Dart objects', () {
          final object = Object();
          expect(unjsifyRefProp(object), same(object));
          expect(() => unjsifyRefProp(object, throwOnUnhandled: true),
              throwsArgumentError,
              reason:
                  'this object type should be considered an "unhandled" case'
                  ' and not get treated like another ref type');
        });

        test('passes through arbitrary JS objects', () {
          final object = newObject();
          expect(unjsifyRefProp(object), same(object));
          expect(() => unjsifyRefProp(object, throwOnUnhandled: true),
              throwsArgumentError,
              reason:
                  'this object type should be considered an "unhandled" case'
                  ' and not get treated like another ref type');
        });
      });

      group(
          'unjsifyRefProp(jsifyRefProp(object)) returns a value equivalent to `object` when passed',
          () {
        dynamic jsifyAndUnjsify(dynamic value) =>
            unjsifyRefProp(jsifyRefProp(value));

        test('null', () {
          expect(jsifyAndUnjsify(null), null);
        });

        test('Dart callback refs', () {
          void dartCallbackRef(dynamic ref) {}
          // Unwrapping from allowInterop isn't trivial to do, and in this case that's unnecessary,
          // since the allowInterop'd function can be called the same as the original.
          expect(jsifyAndUnjsify(dartCallbackRef),
              same(allowInterop(dartCallbackRef)));
        });

        // E.g., this unsound but seemingly safe case
        //
        // final builder = Foo();
        // builder.barRef = createRef();
        // (If we don't reconvert it) Runtime type error expected `Ref`, got `NativeJavaScriptObject`.
        // builder.barRef as Ref;
        test('Dart ref objects (with same reified generic type)', () {
          final dartRef = createRef<Element>();
          expect(jsifyAndUnjsify(dartRef), same(dartRef));

          // These expectations are redundant due to the `same` expectation above,
          // but this is really the behavior we want to test.
          expect(jsifyAndUnjsify(dartRef),
              isA<Ref>().havingJsRef(same(dartRef.jsRef)),
              reason: 'should be backed by the same JS object');
          expect(jsifyAndUnjsify(dartRef), isA<Ref<Element?>>(),
              reason: 'should have the same reified type');
        });

        test('JS ref objects', () {
          final jsRef = createRef().jsRef;
          expect(jsifyAndUnjsify(jsRef), same(jsRef));
        });

        test('JS callback refs', () {
          final jsCallbackRef = allowInterop((dynamic ref) {});
          expect(jsifyAndUnjsify(jsCallbackRef), same(jsCallbackRef));
        });

        test('arbitrary Dart objects', () {
          final object = Object();
          expect(jsifyAndUnjsify(object), same(object));
        });

        test('arbitrary JS objects', () {
          final object = newObject();
          expect(jsifyAndUnjsify(object), same(object));
        });
      });

      group('jsifyContextProp', () {
        test('passes through null', () {
          expect(jsifyContextProp(null), null);
        });

        test('converts Dart context objects', () {
          final dartContext = createContext();
          expect(jsifyContextProp(dartContext), same(dartContext.jsThis));
        });
      });

      group('unjsifyContextProp', () {
        test('passes through null', () {
          expect(unjsifyContextProp(null), null);
        });

        test('converts JS context objects to Dart context objects (dynamic generic type)', () {
          final jsContext = react.createContext().jsThis;
          expect(unjsifyContextProp<dynamic>(jsContext), isA<Context>());
          expect(unjsifyContextProp<dynamic>(jsContext)!.jsThis, same(jsContext));
        });

        test('converts JS context objects to Dart context objects (with generic type)', () {
          final jsContext = react.createContext().jsThis;
          expect(unjsifyContextProp<String>(jsContext), isA<Context<String>>());
          expect(unjsifyContextProp<String>(jsContext)!.jsThis, same(jsContext));
        });
      });

      group(
          'unjsifyContextProp(jsifyContextProp(object)) returns a value equivalent to `object` when passed',
          () {
        Context<T>? jsifyAndUnjsify<T>(Context<T>? value) =>
            unjsifyContextProp(jsifyContextProp(value));

        test('null', () {
          expect(jsifyAndUnjsify(null), null);
        });

        test('Dart context object', () {
          final context = createContext();
          expect(jsifyAndUnjsify(context)!.jsThis, same(context.jsThis));
        });

        group('Dart context objects (with same reified generic type)', () {
          test('when the type parameter is dynamic', () {
            final dartContext = createContextInit<Element>(DivElement());
            expect(dartContext, isA<Context<Element>>(), reason: 'test setup check');

            // Specify dynamic here so the static type parameter to this method
            // doesn't influence the reified type.
            expect(jsifyAndUnjsify<dynamic>(dartContext), same(dartContext));

            // These expectations are redundant due to the `same` expectation above,
            // but this is really the behavior we want to test.
            expect(jsifyAndUnjsify<dynamic>(dartContext),
                isA<Context>().havingJsThis(same(dartContext.jsThis)),
                reason: 'should be backed by the same JS object');
            expect(jsifyAndUnjsify<dynamic>(dartContext), isA<Context<Element>>(),
                reason: 'should have the same reified type');
          });

          test('when the type parameter is specified/inferred', () {
            final dartContext = createContextInit<Element>(DivElement());
            expect(dartContext, isA<Context<Element>>(), reason: 'test setup check');

            // Specify dynamic here so the static type parameter to this method
            // doesn't influence the reified type.
            expect(jsifyAndUnjsify(dartContext), same(dartContext));

            // These expectations are redundant due to the `same` expectation above,
            // but this is really the behavior we want to test.
            expect(jsifyAndUnjsify(dartContext),
                isA<Context>().havingJsThis(same(dartContext.jsThis)),
                reason: 'should be backed by the same JS object');
            expect(jsifyAndUnjsify(dartContext), isA<Context<Element>>(),
                reason: 'should have the same reified type');
          });
        });
      });
    });

    group(
        'works as expected when using converting prop getters/setters with JS components:',
        () {
      group('Map props using (un)jsifyMapProp', () {
        group('get converted to JS objects', () {
          group('in the setter, and gets unconverted in getter', () {
            // This case is a little redundant with the (un)jsifyMapProp tests above, but include it for completeness.
            test('when set to a Map', () {
              final builder = TestJs()..buttonProps = {'data-foo': 'bar'};

              final propKey = TestJs.getPropKey((p) => p.buttonProps);
              expect(builder, {propKey: isA<JsMap>()},
                  reason:
                      'test setup: should have converted to a JS object for storage in props map'
                      ' (we want to ensure this happens before it gets to the ReactComponentFactoryProxy)');
              expect(builder.buttonProps, isA<Map>(),
                  reason:
                      'should have unconverted JsMap to a Map in the typed getter');
            });

            // This case is a little redundant with the (un)jsifyMapProp tests above, but include it for completeness.
            test('when null', () {
              final builder = TestJs();

              expect(builder, {}, reason: 'test setup check');
              expect(builder.buttonProps, isNull);

              builder.buttonProps = null;
              final propKey = TestJs.getPropKey((p) => p.buttonProps);
              expect(builder, {propKey: null});
              expect(builder.buttonProps, isNull);
            });

            group('and allows pattern of setting a map prop in a builder', () {
              test('and then mutating the value read from the builder', () {
                final builder = TestJs();

                builder.buttonProps = {};
                expect(builder.buttonProps, {});

                final propKey = TestJs.getPropKey((p) => p.buttonProps);
                expect(builder, {propKey: isA<JsMap>()},
                    reason:
                        'test setup: should have converted to a JS object for storage in props map');

                // For this test, it's important to mutate the the value returned from the `builder.buttonProps` getter,
                // and not the original Map passed into `builder.buttonProps`.
                builder.buttonProps!['data-foo'] = 'bar';
                expect(builder.buttonProps, {'data-foo': 'bar'});
              });

              group('and then reading a nested value that gets unconverted:',
                  () {
                group('A nested map prop', () {
                  test('using the typed props map', () {
                    final builder = TestJs()
                      ..buttonProps = (TestJs()..buttonProps = {'foo': 'bar'});
                    expect(TestJs(builder.buttonProps).buttonProps,
                        allOf(isA<Map>(), {'foo': 'bar'}));
                  });

                  test('not using the typed props map', () {
                    final builder = TestJs()
                      ..buttonProps = (TestJs()..buttonProps = {'foo': 'bar'});
                    final propKey = TestJs.getPropKey((p) => p.buttonProps);
                    expect(builder.buttonProps,
                        containsPair(propKey, isA<JsMap>()),
                        reason: 'not a Dart map due to tradeoffs');
                  }, tags: 'js-interop-tradeoff');
                });

                // This is a special case since style gets unconverted conditionally in UiProps
                group('special-case: style map', () {
                  test('using the typed props map', () {
                    final builder = TestJs()
                      ..buttonProps = {
                        'style': {
                          'color': 'blue',
                        },
                      };
                    expect(domProps(builder.buttonProps).style, isA<Map>());
                  });

                  test('not using the typed props map', () {
                    final builder = TestJs()
                      ..buttonProps = {
                        'style': {
                          'color': 'blue',
                        },
                      };
                    expect(builder.buttonProps,
                        containsPair('style', isA<JsMap>()),
                        reason: 'not a Dart map due to tradeoffs');
                  }, tags: 'js-interop-tradeoff');
                });
              });

              test('but not then mutating the original value', () {
                final buttonProps = {};

                final builder = TestJs();

                builder.buttonProps = buttonProps;
                expect(builder.buttonProps, {});

                final propKey = TestJs.getPropKey((p) => p.buttonProps);
                expect(builder, {propKey: isA<JsMap>()},
                    reason:
                        'test setup: should have converted to a JS object for storage in props map');

                // For this test, it's important to mutate the original `buttonProps` Map passed into `builder.buttonProps`,
                // and not the value returned from the `builder.buttonProps` getter.
                buttonProps['data-foo'] = 'bar';
                expect(builder.buttonProps, isEmpty);
                // This is what we'd expect if this case worked.
                // expect(builder.buttonProps, {'data-foo': 'bar'});
              }, tags: 'js-interop-tradeoff');
            });
          });

          test('and can be read properly by the JS component', () {
            final view =
                render((TestJs()..buttonProps = {'data-foo': 'bar'})());
            final button = view.getByRole('button');
            expect(button, hasAttribute('data-foo', 'bar'),
                reason: 'buttonProps should have been readable by JS component'
                    ' and properly passed to the rendered button');
          });
        });

        // We're testing this since ReactJsComponentFactoryProxy doesn't convert values nested within JS objects;
        // it only converts values nested within Dart Maps/Lists.

        group(
            'work with props that would normally get converted in ReactJsComponentFactoryProxy:',
            () {
          test('Dart Maps and Functions', () {
            final onClickCalls = [];
            final view = render((TestJs()
              ..buttonProps = (domProps()
                ..style = {'color': 'blue'}
                ..onClick = (event) {
                  onClickCalls.add(event);
                }))());

            final button = view.getByRole('button');
            expect(button, hasStyles({'color': 'blue'}));

            UserEvent.click(button);
            expect(onClickCalls, [
              isA<SyntheticMouseEvent>(),
            ]);
          });

          group('refs under the "ref" key', () {
            test('JS callback ref', () {
              dynamic buttonRef;
              final view = render((TestJs()
                ..buttonProps = (domProps()
                  ..ref = allowInterop((ref) {
                    buttonRef = ref;
                  })))());
              expect(buttonRef, view.getByRole('button'));
            });

            group('Dart callback ref', () {
              test('(untyped)', () {
                dynamic buttonRef;
                final view = render((TestJs()
                  ..buttonProps = (domProps()
                    ..ref = (ref) {
                      buttonRef = ref;
                    }))());
                expect(buttonRef, view.getByRole('button'));
              });

              test('(typed)', () {
                late ButtonElement? buttonRef;
                final view = render((TestJs()
                  ..buttonProps = (domProps()
                    ..ref = (ButtonElement? ref) {
                      buttonRef = ref;
                    }))());
                expect(buttonRef, view.getByRole('button'));
              });
            });

            // This test only fails in Dart2js when conversion is missing, since the JS class that DDC compiles the
            // Dart `Ref` class to has a `current` getter/setter that are compatible with the JS API, and happens to work.
            test('Dart ref object', () {
              final buttonRef = createRef();
              final view = render(
                  (TestJs()..buttonProps = (domProps()..ref = buttonRef))());
              expect(buttonRef.current, view.getByRole('button'));
            }, tags: 'ddc-false-positive');

            test('JS ref object', () {
              final buttonRef = createRef().jsRef;
              final view = render(
                  (TestJs()..buttonProps = (domProps()..ref = buttonRef))());
              expect(buttonRef.current, view.getByRole('button'));
            });
          });
        });
      });

      group('List<Map> props using (un)jsifyMapListProp', () {
        group('get converted to JS objects', () {
          group('in the setter, and gets unconverted in getter', () {
            // This case is a little redundant with the (un)jsifyMapListProp tests above, but include it for completeness.
            test('when set to a Map', () {
              final builder = TestJs()
                ..listOfProps = [
                  {'foo': 'bar'},
                  {'bar': 1},
                  {'foo2': true},
                ];

              final propKey = TestJs.getPropKey((p) => p.listOfProps);
              expect(builder, {propKey: isA<List<JsMap?>>()},
                  reason:
                      'test setup: should have converted to a List of JS objects for storage in props map'
                      ' (we want to ensure this happens before it gets to the ReactComponentFactoryProxy)');
              expect(builder.listOfProps, isA<List<Map?>>(),
                  reason: 'should have unconverted List<JsMap?> to a List<?Map> in the typed getter');
            });

            // This case is a little redundant with the (un)jsifyMapListProp tests above, but include it for completeness.
            test('when null', () {
              final builder = TestJs();

              expect(builder, {}, reason: 'test setup check');
              expect(builder.listOfProps, isNull);

              builder.listOfProps = null;
              final propKey = TestJs.getPropKey((p) => p.listOfProps);
              expect(builder, {propKey: null});
              expect(builder.listOfProps, isNull);
            });

            test('when an empty list', () {
              final builder = TestJs()..listOfProps = [];

              expect(builder.listOfProps, []);

              builder.listOfProps = [];
              final propKey = TestJs.getPropKey((p) => p.listOfProps);
              expect(builder, {propKey: []});
              expect(builder.listOfProps, []);
            });

            test('when a null list value', () {
              final builder = TestJs()..listOfProps = [null];

              expect(builder.listOfProps, [null]);

              builder.listOfProps = [null];
              final propKey = TestJs.getPropKey((p) => p.listOfProps);
              expect(builder, {propKey: [null]});
              expect(builder.listOfProps, [null]);
            });

            group('and allows pattern of setting a map prop in a builder', () {
              test('and then mutating the value read from the builder', () {
                final builder = TestJs();

                builder.listOfProps = [{}];
                expect(builder.listOfProps, [{}]);

                final propKey = TestJs.getPropKey((p) => p.listOfProps);
                expect(builder, {propKey: isA<List<JsMap?>>()},
                    reason:
                        'test setup: should have converted to a JS object for storage in props map');

                // For this test, it's important to mutate the the value returned from the `builder.listOfProps` getter,
                // and not the original Map passed into `builder.listOfProps`.
                builder.listOfProps![0]!['data-foo'] = 'bar';
                expect(builder.listOfProps, [
                  {'data-foo': 'bar'}
                ]);
              });

              group('and then reading a nested value that gets unconverted:', () {
                group('A nested map list prop', () {
                  test('using the typed props map', () {
                    final builder = TestJs()
                      ..listOfProps = [
                        (TestJs()
                          ..listOfProps = [
                            {'foo': 'bar'}
                          ])
                      ];
                    expect(
                        TestJs(builder.listOfProps![0]).listOfProps,
                        allOf(isA<List<Map?>>(), [
                          {'foo': 'bar'}
                        ]));
                  });

                  test('not using the typed props map', () {
                    final builder = TestJs()
                      ..listOfProps = [
                        (TestJs()
                          ..listOfProps = [
                            {'foo': 'bar'}
                          ])
                      ];
                    final propKey = TestJs.getPropKey((p) => p.listOfProps);
                    expect(
                        builder.listOfProps,
                        [
                          containsPair(propKey, [isA<JsMap>()])
                        ],
                        reason: 'not a Dart map due to tradeoffs');
                  }, tags: 'js-interop-tradeoff');
                });
              });

              test('but not then mutating the original value', () {
                final listOfProps = [{}];

                final builder = TestJs();

                builder.listOfProps = listOfProps;
                expect(builder.listOfProps, [{}]);

                final propKey = TestJs.getPropKey((p) => p.listOfProps);
                expect(builder, {propKey: isA<List<JsMap?>>()},
                    reason:
                        'test setup: should have converted to a JS object for storage in props map');

                // For this test, it's important to mutate the original `listOfProps` List passed into `builder.listOfProps`,
                // and not the value returned from the `builder.listOfProps` getter.
                listOfProps[0]['data-foo'] = 'bar';
                expect(builder.listOfProps, [isEmpty]);
                // This is what we'd expect if this case worked.
                // expect(builder.listOfProps, [{'data-foo': 'bar'}]);
              }, tags: 'js-interop-tradeoff');
            });
          });

          test('and can be read properly by the JS component', () {
            final view = render((TestJs()
              ..listOfProps = [
                {'data-foo': 'bar'}
              ])());
            final listitem = view.getByRole('listitem');
            expect(listitem, hasAttribute('data-foo', 'bar'),
                reason: 'listOfProps should have been readable by JS component'
                    ' and properly passed to the rendered list item');
          });
        });

        // We're testing this since ReactJsComponentFactoryProxy doesn't convert values nested within JS objects;
        // it only converts values nested within Dart Maps/Lists.

        group('work with props that would normally get converted in ReactJsComponentFactoryProxy:',
            () {
          test('Dart Maps and Functions', () {
            final onClickCalls = [];
            final view = render((TestJs()
              ..listOfProps = [
                (domProps()
                  ..style = {'color': 'blue'}
                  ..onClick = onClickCalls.add)
              ])());

            final listitem = view.getByRole('listitem');
            expect(listitem, hasStyles({'color': 'blue'}));

            UserEvent.click(listitem);
            expect(onClickCalls, [
              isA<SyntheticMouseEvent>(),
            ]);
          });

          group('refs under the "ref" key', () {
            test('JS callback ref', () {
              dynamic listitemRef;
              final view = render((TestJs()
                ..listOfProps = [
                  (domProps()
                    ..ref = allowInterop((ref) {
                      listitemRef = ref;
                    }))
                ])());
              expect(listitemRef, view.getByRole('listitem'));
            });

            group('Dart callback ref', () {
              test('(untyped)', () {
                dynamic listitemRef;
                final view = render((TestJs()
                  ..listOfProps = [
                    (domProps()
                      ..ref = (ref) {
                        listitemRef = ref;
                      })
                  ])());
                expect(listitemRef, view.getByRole('listitem'));
              });

              test('(typed)', () {
                late LIElement? listitemRef;
                final view = render((TestJs()
                  ..listOfProps = [
                    (domProps()
                      ..ref = (LIElement? ref) {
                        listitemRef = ref;
                      })
                  ])());
                expect(listitemRef, view.getByRole('listitem'));
              });
            });

            // This test only fails in Dart2js when conversion is missing, since the JS class that DDC compiles the
            // Dart `Ref` class to has a `current` getter/setter that are compatible with the JS API, and happens to work.
            test('Dart ref object', () {
              final listitemRef = createRef();
              final view = render((TestJs()..listOfProps = [(domProps()..ref = listitemRef)])());
              expect(listitemRef.current, view.getByRole('listitem'));
            }, tags: 'ddc-false-positive');

            test('JS ref object', () {
              final listitemRef = createRef().jsRef;
              final view = render((TestJs()..listOfProps = [(domProps()..ref = listitemRef)])());
              expect(listitemRef.current, view.getByRole('listitem'));
            });
          });
        });
      });

      group('custom ref props using (un)jsifyRefProp', () {
        group(
            'convert the ref properly for consumption by the JS component when the ref is a',
            () {
          test('JS callback ref', () {
            dynamic inputRef;
            final view = render((TestJs()
              ..inputRef = allowInterop((ref) {
                inputRef = ref;
              }))());
            expect(inputRef, view.getByRole('textbox'));
          });

          group('Dart callback ref', () {
            test('(untyped)', () {
              dynamic inputRef;
              final view = render((TestJs()
                ..inputRef = (ref) {
                  inputRef = ref;
                })());
              expect(inputRef, view.getByRole('textbox'));
            });

            test('(typed)', () {
              late InputElement? inputRef;
              final view = render((TestJs()
                ..inputRef = (InputElement? ref) {
                  inputRef = ref;
                })());
              expect(inputRef, view.getByRole('textbox'));
            });
          });

          test('Dart ref object', () {
            final inputRef = createRef();
            final view = render((TestJs()..inputRef = inputRef)());
            expect(inputRef.current, view.getByRole('textbox'));
          });

          test('JS ref object', () {
            final inputRef = createRef().jsRef;
            final view = render((TestJs()..inputRef = inputRef)());
            expect(inputRef.current, view.getByRole('textbox'));
          });
        });

        group('get converted to JS objects', () {
          group('in the setter, and gets unconverted in getter', () {
            // This case is a little redundant with the (un)jsifyRefProp tests above, but include it for completeness.
            test('when set to a ref that gets converted', () {
              final dartRef = createRef();
              final builder = TestJs()..inputRef = dartRef;

              final propKey = TestJs.getPropKey((p) => p.inputRef);
              expect(builder, {propKey: same(dartRef.jsRef)},
                  reason:
                      'test setup: should have converted to a JS ref for storage in props map'
                      ' (we want to ensure this happens before it gets to the ReactComponentFactoryProxy)');
              expect(builder.inputRef, isA<Ref>(),
                  reason:
                      'should have unconverted JsRef to a Ref in the typed getter');
            });

            // This case is a little redundant with the (un)jsifyRefProp tests above, but include it for completeness.
            test('when null', () {
              final builder = TestJs();

              expect(builder, {}, reason: 'test setup check');
              expect(builder.inputRef, isNull);

              builder.inputRef = null;
              final propKey = TestJs.getPropKey((p) => p.inputRef);
              expect(builder, {propKey: null});
              expect(builder.inputRef, isNull);
            });
          });
        });
      });

      group('context props using (un)jsifyContextProp', () {
        group('get converted to JS context', () {
          group('in the setter, and gets unconverted in getter', () {
            // This case is a little redundant with the (un)jsifyContextProp tests above, but include it for completeness.
            test('when set to a Context', () {
              final context = createContext<String>();

              final builder = TestJs()..messageContext = context;

              final propKey = TestJs.getPropKey((p) => p.messageContext);
              expect(builder, {propKey: isA<ReactContext>()},
                  reason:
                      'test setup: should have converted to a JS context for storage in props map');
              expect(builder.messageContext, isA<Context>(),
                  reason:
                      'should have unconverted JS context to a Dart context in the typed getter');
            });

            // This case is a little redundant with the (un)jsifyContextProp tests above, but include it for completeness.
            test('when null', () {
              final builder = TestJs();

              expect(builder, {}, reason: 'test setup check');
              expect(builder.messageContext, isNull);

              builder.messageContext = null;
              final propKey = TestJs.getPropKey((p) => p.messageContext);
              expect(builder, {propKey: null});
              expect(builder.messageContext, isNull);
            });
          });

          test('and can be read properly by the JS component', () {
            final context = createContext<String>();
            final view =
                render((context.Provider()..value = 'test context value')(
              (TestJs()..messageContext = context)(),
            ));
            final alert = view.getByRole('alert');
            expect(alert, hasTextContent('test context value'),
                reason: 'messageContext should have been readable by JS component'
                    ' and used to render the alert');
          });
        });
      });
    });

    group('works as expected in advanced cases:', () {
      group('Dart component wrapper around JS component', () {
        // This is a regression test for the original case described in the original Dart wrapper props conversion issues
        // ticket (CPLAT-11941), and it works as expected due to unconverting props in the getter.
        test(
            'when a JS component clones the element with JS props that normally get converted before passing them in,'
            ' and the Dart component receives those JS props and attempts to read them',
            () {
          final propKey = TestJs.getPropKey((p) => p.buttonProps);

          late DartTestJsWrapperProps capturedProps;
          final view = render(React.cloneElement(
            (DartTestJsWrapper()
              ..onRender = expectAsync1((props) {
                capturedProps = props;
              }))(),
            jsify({
              propKey: {
                'style': {'color': 'blue'}
              }
            }) as JsMap,
          ));

          expect(() => capturedProps.buttonProps, returnsNormally);
          expect(capturedProps.buttonProps, isA<Map>());

          final node = view.getByRole('button');
          expect(node, hasStyles({'color': 'blue'}));
        });

        test(
            'when a JS component clones the element with a list of JS props that normally get converted before passing them in,'
            ' and the Dart component receives those JS props and attempts to read them', () {
          final propKey = TestJs.getPropKey((p) => p.listOfProps);

          late DartTestJsWrapperProps capturedProps;
          final view = render(React.cloneElement(
            (DartTestJsWrapper()
              ..onRender = expectAsync1((props) {
                capturedProps = props;
              }))(),
            jsify({
              propKey: [
                {
                  'style': {'color': 'blue'}
                }
              ]
            }) as JsMap,
          ));

          expect(() => capturedProps.listOfProps, returnsNormally);
          expect(capturedProps.listOfProps, isA<List<Map?>>());

          final node = view.getByRole('listitem');
          expect(node, hasStyles({'color': 'blue'}));
        });

        group('that renders a Dart component expecting a Dart style map', () {
          test('when passed styles from a Dart component', () {
            final view = render((DartTestJsWrapper()
              ..component = ExpectsDartStyleProp.elementType
              ..style = {'color': 'blue'}
              ..addTestId('componentRoot'))());
            final node = view.getByTestId('componentRoot');
            expect(node, hasStyles({'color': 'blue'}));
          });

          test('when a JS component clones the element with JS styles', () {
            final view = render(React.cloneElement(
              (DartTestJsWrapper()
                ..component = ExpectsDartStyleProp.elementType
                ..addTestId('componentRoot'))(),
              jsify({
                'style': {'color': 'blue'}
              }) as JsMap,
            ));
            final node = view.getByTestId('componentRoot');
            expect(node, hasStyles({'color': 'blue'}));
          });
        });
      });

      group('Dart component used as `component` prop', () {
        test('expecting a Dart style map', () {
          final view = render((TestJs()
            ..component = ExpectsDartStyleProp.elementType
            ..style = {'color': 'blue'}
            ..addTestId('componentRoot'))());
          final node = view.getByTestId('componentRoot');
          expect(node, hasStyles({'color': 'blue'}));
        });

        test('expecting a custom Dart Map prop', () {
          final renderErrors = [];

          // Use an ErrorBoundary to detect errors on render, since otherwise
          // React will just unmount the tree without throwing.
          expect(() {
            render((components.ErrorBoundary()
              ..onComponentDidCatch = ((error, _) => renderErrors.add(error))
              ..shouldLogErrors = false
              ..fallbackUIRenderer =
                  ((_, __) => Dom.span()('An error occurred during render')))(
              (TestJs()
                ..component = ExpectsDartMapProp.elementType
                ..addProps(ExpectsDartMapProp()..dartMapProp = {'foo': 'bar'})
                ..addTestId('componentRoot'))(),
            ));
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

        // This case can't use MUI button because it always passes children as lists instead of passing them through.
        group('expecting a custom Dart children prop', () {
          ReactElement expectNonListChildren(ReactElement el) {
            expect(
                JsBackedMap.backedBy(el.props)['children'], isNot(isA<List>()),
                reason:
                    'test setup check; children should not be a List in order to test how'
                    ' the Dart `component` behaves when the `children` prop is not a List');
            return el;
          }

          // Using UiProps/ReactComponentFactoryProxy might not be the most stable way to pass in children that aren't
          // lists (though they do conditionally pass in non-Lists for JS components), but it gets the job done, and also
          // emulates real-world cases of passing children from Dart consumption
          // (though not when the JS component is providing the children; but that may not be the case for real world uses of MUI).
          //
          // So, we'll use expectNonListChildren to ensure these are testing non-list children properly.
          test('(no children)', () {
            render(expectNonListChildren((TestJs()
              ..component = ExpectsListChildrenProp.elementType
              ..addTestId('componentRoot'))()));
          });

          test('(one child)', () {
            final view = render(expectNonListChildren((TestJs()
              ..component = ExpectsListChildrenProp.elementType
              ..addTestId('componentRoot'))('single-child')));
            final node = view.getByTestId('componentRoot');
            expect(node, hasTextContent('single-child'));
          });

          test('(multiple children)', () {
            final view = render((TestJs()
              ..component = ExpectsListChildrenProp.elementType
              ..addTestId('componentRoot'))('child-1', 'child-2'));
            final node = view.getByTestId('componentRoot');
            expect(node, hasTextContent('child-1' 'child-2'));
          });
        });

        group('and a ref is set on that component', () {
          group('which eventually ends up on a non-Dart component', () {
            final testCaseCollection = RefTestCaseCollection<Element>();

            group('and is passed in via a forwarded "ref" prop as a', () {
              for (final testCaseName in testCaseCollection.allTestCaseNames) {
                test(testCaseName, () {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((TestJs()
                    ..component = BasicForwardRef.elementType
                    ..ref = testCase.ref)());

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
                test(testCaseName, () {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((TestJs()
                    ..inputComponent = BasicForwardRef.elementType
                    ..inputRef = testCase.ref)());

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
                test(testCaseName, () {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((TestJs()
                    ..buttonComponent = BasicForwardRef.elementType
                    ..buttonProps = (domProps()..ref = testCase.ref))());

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

                test(testCaseName, () {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((TestJs()
                    ..component = ClassComponent.elementType
                    ..ref = testCase.ref)());

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

                test(testCaseName, () {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((TestJs()
                    ..inputComponent = ClassComponent.elementType
                    ..inputRef = testCase.ref)());

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

                test(testCaseName, () {
                  final testCase =
                      testCaseCollection.createCaseByName(testCaseName);

                  render((TestJs()
                    ..buttonComponent = ClassComponent.elementType
                    ..buttonProps = (domProps()..ref = testCase.ref))());

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
  });
}

//
// Misc convenience functions
//

const _getPropKey = getPropKey;

extension<T extends UiProps> on UiFactory<T> {
  String getPropKey(void Function(T) accessProp) {
    return _getPropKey<T>(accessProp, this);
  }
}

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

    final consumedProps =
        props.staticMeta.forMixins({DartTestJsWrapperPropsMixin});
    return (TestJs()
      ..addUnconsumedProps(props, consumedProps)
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
