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

@TestOn('browser')
library context_test;

import 'package:over_react/over_react.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client/js_backed_map.dart';
import 'package:test/test.dart';

import '../util/shared_type_tester.dart';
import 'fixtures/context_provider_component.dart';
import 'fixtures/context_type_component.dart';
import 'fixtures/test_context.dart';

void main() {
  group('Context', () {
    test('createContext() returns a correctly typed object', () {
      expect(someContext, isA<Context>());
      expect(someContext.Consumer(), isA<ConsumerProps>());
      expect(someContext.Provider(), isA<ProviderProps>());
      expect(someContext.jsThis, isA<JsMap>());
      expect(someContext.reactDartContext, isA<react.Context>());
    });

    group('Componentry', () {
      group('sets and retrieves values correctly:', () {
        void testTypeValue(dynamic typeToTest) {
          ContextTypeComponent contextTypeRef;
          render(
            (someContext.Provider()..value = typeToTest)(
              someContext.Consumer()(
                (value){
                  expect(value, same(typeToTest), reason: 'Consumer did not recieve the correct type.');
                }
              ),
              (ContextType()..ref = (ref) { contextTypeRef = ref; })(),
            ),
          );

          expect(
            contextTypeRef.context,
            same(typeToTest),
            reason: 'ContextType based component did not recieve the correct type.',
          );
        }
        sharedTypeTests(testTypeValue);
      });

      group('experimental calculateChangeBits argument functions correctly', () {
        ContextProviderWrapperComponent providerRef;
        int consumerEvenValue;
        int consumerOddValue;

        setUp(() {
          render(
            (ContextProviderWrapper()
              ..ref = (ref) {
                providerRef = ref;
              }
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
          providerRef.increment();
          expect(consumerEvenValue, 2);
          expect(consumerOddValue, 1);
          providerRef.increment();
          expect(consumerEvenValue, 2);
          expect(consumerOddValue, 3);
          providerRef.increment();
          expect(consumerEvenValue, 4);
          expect(consumerOddValue, 3);
        });
      });
    });
  });
}
