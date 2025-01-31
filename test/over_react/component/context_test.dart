// Copyright 2019 Workiva Inc.
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

library context_test;

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client/js_backed_map.dart';
import 'package:test/test.dart';

import '../util/shared_type_tester.dart';
import 'fixtures/context_provider_component.dart';
import 'fixtures/test_context.dart';

part 'context_test.over_react.g.dart';

void main() {
  group('Context', () {
    test('createContext() returns a correctly typed object', () {
      final context = createContext<int>();
      expect(context, isA<Context>());
      expect(context, isA<Context<int?>>(), reason: 'should have a nullable generic type');
      expect(context.Consumer(), isA<ConsumerProps>());
      expect(context.Consumer(), isA<ConsumerProps<int?>>(), reason: 'should have the correct generic type');
      expect(context.Provider(), isA<ProviderProps>());
      expect(context.Provider(), isA<ProviderProps<int?>>(), reason: 'should have the correct generic type');
      expect(context.jsThis, isA<JsMap>());
      expect(context.reactDartContext, isA<react.Context>());
    });

    test('createContextInit() returns a correctly typed object', () {
      final context = createContextInit<int>(0);
      expect(context, isA<Context>());
      expect(context, isA<Context<int>>(), reason: 'should have a non-nullable generic type');
      expect(context.Consumer(), isA<ConsumerProps>());
      expect(context.Consumer(), isA<ConsumerProps<int>>(), reason: 'should have the correct generic type');
      expect(context.Provider(), isA<ProviderProps>());
      expect(context.Provider(), isA<ProviderProps<int>>(), reason: 'should have the correct generic type');
      expect(context.jsThis, isA<JsMap>());
      expect(context.reactDartContext, isA<react.Context>());
    });

    // This makes sure we're properly passing the argument along to createContextInit.
    test("createContext's deprecated defaultValue argument works as expected", () {
      final context = createContext<String>('default value');
      final consumerValues = [];
      render(context.Consumer()(
        (value) => consumerValues.add(value),
      ));
      expect(consumerValues, ['default value']);
    });

    group('Componentry', () {
      group('sets and retrieves values correctly', () {
        group('for various types:', () {
          void testTypeValue(dynamic typeToTest) {
            final context = testContextDynamic;

            final contextTypeRef = createRef<ContextTypeDynamicComponent>();
            final consumerValues = [];
            final functionComponentValues = [];

            final TestFunction = uiFunction((props) {
              final contextValue = useContext(context);
              functionComponentValues.add(contextValue);
            }, UiFactoryConfig());

            render(
              (context.Provider()..value = typeToTest)(
                context.Consumer()((value) {
                  consumerValues.add(value);
                }),
                (ContextTypeDynamic()..ref = contextTypeRef)(),
                TestFunction()(),
              ),
            );

            expect(consumerValues, [same(typeToTest)]);
            expect(functionComponentValues, [same(typeToTest)]);
            expect(contextTypeRef.current!.context, same(typeToTest));
          }

          sharedTypeTests(testTypeValue);
        });

        group('for contexts without a default value', () {
          late final context = testContextWithoutDefault;

          late UiFactory TestFunction;
          late Ref<ContextTypeWithoutDefaultComponent?> contextTypeRef;
          late List<dynamic> consumerValues;
          late List<dynamic> functionComponentValues;

          setUp(() {
            contextTypeRef = createRef();
            consumerValues = [];
            functionComponentValues = [];

            TestFunction = uiFunction((props) {
              final contextValue = useContext(context);
              functionComponentValues.add(contextValue);
            }, UiFactoryConfig());
          });

          test('when there is a provider', () {
            const testValue = 'test value';

            render(
              (context.Provider()..value = testValue)(
                context.Consumer()(
                  (value) => consumerValues.add(value),
                ),
                (ContextTypeWithoutDefault()..ref = contextTypeRef)(),
                TestFunction()(),
              ),
            );

            expect(consumerValues, [same(testValue)]);
            expect(functionComponentValues, [same(testValue)]);
            expect(contextTypeRef.current!.context, same(testValue));
          });

          test('when there is not a provider', () {
            render(
              Fragment()(
                context.Consumer()(
                  (value) => consumerValues.add(value),
                ),
                (ContextTypeWithoutDefault()..ref = contextTypeRef)(),
                TestFunction()(),
              ),
            );

            expect(consumerValues, [isNull]);
            expect(functionComponentValues, [isNull]);
            expect(contextTypeRef.current!.context, isNull);
          });
        });

        group('for contexts with a default value', () {
          late final context = testContextWithDefault;

          late UiFactory TestFunction;
          late Ref<ContextTypeWithDefaultComponent?> contextTypeRef;
          late List<dynamic> consumerValues;
          late List<dynamic> functionComponentValues;

          setUp(() {
            contextTypeRef = createRef();
            consumerValues = [];
            functionComponentValues = [];

            TestFunction = uiFunction((props) {
              final contextValue = useContext(context);
              functionComponentValues.add(contextValue);
            }, UiFactoryConfig());
          });

          test('when there is a provider', () {
            const testValue = 'test value';

            render(
              (context.Provider()..value = testValue)(
                context.Consumer()(
                  (value) => consumerValues.add(value),
                ),
                (ContextTypeWithDefault()..ref = contextTypeRef)(),
                TestFunction()(),
              ),
            );

            expect(consumerValues, [testValue]);
            expect(functionComponentValues, [testValue]);
            expect(contextTypeRef.current!.context, testValue);
          });

          test('when there is not a provider', () {
            const defaultValue = 'default value';

            render(
              Fragment()(
                context.Consumer()(
                  (value) => consumerValues.add(value),
                ),
                (ContextTypeWithDefault()..ref = contextTypeRef)(),
                TestFunction()(),
              ),
            );

            expect(consumerValues, [same(defaultValue)]);
            expect(functionComponentValues, [same(defaultValue)]);
            expect(contextTypeRef.current!.context, same(defaultValue));
          });
        });
      });

      group('experimental calculateChangeBits argument does not throw when used (has no effect in React 18)', () {
        late Ref<ContextProviderWrapperComponent?> providerRef;
        int? consumerEvenValue;
        int? consumerOddValue;

        setUp(() {
          providerRef = createRef();
          render(
            (ContextProviderWrapper()
              ..ref = providerRef
            )(
              (counterContext.Consumer()
                ..key = 'EvenContextConsumer'
                ..unstable_observedBits = EVEN_UPDATES
              )(
                (value) {
                  consumerEvenValue = value;
                }
              ),
              (counterContext.Consumer()
                ..key = 'OddContextConsumer'
                ..unstable_observedBits = ODD_UPDATES
              )(
                (value) {
                  consumerOddValue = value;
                }
              )
            )
          );
        });

        test('on first render', () {
          expect(consumerEvenValue, 1);
          expect(consumerOddValue, 1);
        });

        test('on value updates', () {
          // Test common behavior between React 17 (calculateChangedBits working)
          // and React 18 (it having no effect).
          providerRef.current!.increment();
          expect(consumerEvenValue, 2);
          providerRef.current!.increment();
          expect(consumerOddValue, 3);
          providerRef.current!.increment();
          expect(consumerEvenValue, 4);
        });
      });
    });

    group('ProviderProps', () {
      test('functions as a map view when constructed from its factory', () {
        final wrappedProps = {'foo': 'bar'};
        final props = createContext().Provider(wrappedProps);
        expect(props, containsPair('foo', 'bar'));
        props['newEntry'] = 'value';
        expect(wrappedProps, containsPair('newEntry', 'value'));
      });

      group('has functional overrides to members that are typically generated', () {
        late ProviderProps props;

        setUp(() {
          props = createContext().Provider();
        });

        test('staticMeta', () {
          expect(props.staticMeta.keys, contains('value'));
        });

        test('propKeyNamespace', () {
          expect(props.propKeyNamespace, '');
        });

        test('\$getPropKey (used by getPropKey)', () {
          expect(props.getPropKey((p) => p.value), 'value');

          late final ProviderProps getPropKeyArg;
          props.getPropKey((p) {
            getPropKeyArg = p;
            p.id; // Access a prop so that this doesn't throw
          });
          expect(getPropKeyArg, isA<ProviderProps>());
        });
      });
    });

    group('ConsumerProps', () {
      test('functions as a map view when constructed from its factory', () {
        final wrappedProps = {'foo': 'bar'};
        final props = createContext().Consumer(wrappedProps);
        expect(props, containsPair('foo', 'bar'));
        props['newEntry'] = 'value';
        expect(wrappedProps, containsPair('newEntry', 'value'));
      });

      group('has functional overrides to members that are typically generated', () {
        late ConsumerProps props;

        setUp(() {
          props = createContext().Consumer();
        });

        test('staticMeta', () {
          expect(props.staticMeta.keys, contains('unstable_observedBits'));
        });

        test('propKeyNamespace', () {
          expect(props.propKeyNamespace, '');
        });

        test('\$getPropKey (used by getPropKey)', () {
          expect(props.getPropKey((p) => p.unstable_observedBits), 'unstable_observedBits');

          late final ConsumerProps getPropKeyArg;
          props.getPropKey((p) {
            getPropKeyArg = p;
            p.id; // Access a prop so that this doesn't throw
          });
          expect(getPropKeyArg, isA<ConsumerProps>());
        });
      });
    });
  });
}

final testContextDynamic = createContext();

UiFactory<ContextTypeDynamicProps> ContextTypeDynamic = castUiFactory(_$ContextTypeDynamic);

mixin ContextTypeDynamicProps on UiProps {}

class ContextTypeDynamicComponent extends UiComponent2<ContextTypeDynamicProps> {
  @override
  final contextType = testContextDynamic.reactDartContext;

  @override
  render() {
    return Dom.span()('${this.context}');
  }
}

final testContextWithoutDefault = createContext<String>();

UiFactory<ContextTypeWithoutDefaultProps> ContextTypeWithoutDefault =
    castUiFactory(_$ContextTypeWithoutDefault);

mixin ContextTypeWithoutDefaultProps on UiProps {}

class ContextTypeWithoutDefaultComponent extends UiComponent2<ContextTypeWithoutDefaultProps> {
  @override
  final contextType = testContextWithoutDefault.reactDartContext;

  @override
  render() {
    return Dom.span()('${this.context}');
  }
}

final testContextWithDefault = createContextInit('default value');

UiFactory<ContextTypeWithDefaultProps> ContextTypeWithDefault =
    castUiFactory(_$ContextTypeWithDefault);

mixin ContextTypeWithDefaultProps on UiProps {}

class ContextTypeWithDefaultComponent extends UiComponent2<ContextTypeWithDefaultProps> {
  @override
  final contextType = testContextWithDefault.reactDartContext;

  @override
  render() {
    return Dom.span()('${this.context}');
  }
}
