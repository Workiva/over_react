// Copyright 2021 Workiva Inc.
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

import 'dart:async';

import 'package:over_react/src/over_react_redux/over_react_flux.dart';
import 'package:test/test.dart';
import 'package:w_flux/w_flux.dart' as flux;

main() {
  // See connect_flux_integration_test.dart for more test coverage of this class
  group('ConnectFluxAdapterStore', () {
    group('teardown', () {
      test('calls super, closing change subscriptions', () async {
        final adapterStore = SimpleStore().asConnectFluxStore(null);
        expect(() => adapterStore.onChange.listen((_) {}), returnsNormally,
            reason: 'test setup check: the stream should be open');

        await adapterStore.teardown();
      });

      test('stops listening to the flux store', () async {
        final store = SpyStore();
        final adapterStore = store.asConnectFluxStore(null);

        expect(store.spiedSubscriptions, hasLength(1));
        // ignore: cancel_subscriptions
        final sub = store.spiedSubscriptions.single;

        final subCalls = [];
        sub.onData(subCalls.add);

        store.trigger();
        await pumpEventQueue();
        expect(subCalls, hasLength(1),
            reason: 'test setup check; subscription should have gotten event');

        await adapterStore.teardown();
        store.trigger();
        await pumpEventQueue();
        expect(subCalls, hasLength(1), reason: 'subscription should have been cancelled');
      });

      group('can be called multiple times without throwing', () {
        ConnectFluxAdapterStore adapterStore;

        setUp(() {
          adapterStore = SimpleStore().asConnectFluxStore(null);
        });

        test('synchronously', () async {
          await Future.wait([
            adapterStore.teardown(),
            adapterStore.teardown(),
          ]);
        });

        test('synchronously', () async {
          await adapterStore.teardown();
          await adapterStore.teardown();
        });
      });
    });

    group('calls teardown when the flux store is disposed', () {
      flux.Store store;
      ConnectFluxAdapterStore adapterStore;

      setUp(() {
        store = SimpleStore();
        adapterStore = store.asConnectFluxStore(null);
      });

      test('', () async {
        expect(adapterStore.teardownCalled, isFalse);

        await store.dispose();
        await pumpEventQueue();
        expect(adapterStore.teardownCalled, isTrue);
      });

      group('and doesn\'t break if teardown', () {
        test('has already been called', () async {
          expect(adapterStore.teardownCalled, isFalse);

          await adapterStore.teardown();
          expect(adapterStore.teardownCalled, isTrue);

          await store.dispose();
          await pumpEventQueue();
        });

        test('is called after', () async {
          expect(adapterStore.teardownCalled, isFalse);

          await store.dispose();
          await pumpEventQueue();
          expect(adapterStore.teardownCalled, isTrue);

          await adapterStore.teardown();
        });
      });
    });
  });
}

class SimpleStore extends flux.Store {}

class SpyStore extends flux.Store {
  final spiedSubscriptions = <StreamSubscription>[];

  @override
  listen(onData, {onError, onDone, cancelOnError}) {
    final sub =
        super.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    spiedSubscriptions.add(sub);
    return sub;
  }
}
