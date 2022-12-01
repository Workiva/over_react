// Copyright 2020 Workiva Inc.
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

// Tests adapted from <https://github.com/Workiva/w_flux/blob/1.0.1/test/component_test.dart>.

library over_react.component_declaration.component2.flux_component_test;

import 'dart:async';
import 'dart:html';

import 'package:logging/logging.dart';
import 'package:pedantic/pedantic.dart';
import 'package:test/test.dart';
import 'package:w_flux/w_flux.dart';
import 'package:over_react/over_react.dart';

import '../../../../test_util/test_util.dart';

part 'basic.dart';
part 'handler_lifecycle.dart';
part 'handler_precedence.dart';
part 'prop_validation.dart';
part 'redraw_on.dart';
part 'store_handlers.dart';
part 'stateful/basic.dart';
part 'stateful/handler_lifecycle.dart';
part 'stateful/handler_precedence.dart';
part 'stateful/prop_validation.dart';
part 'stateful/redraw_on.dart';
part 'stateful/store_handlers.dart';

part 'flux_component_test.over_react.g.dart';

void main() {
  group('(Component2)', () {
    Future nextTick() async {
      await window.animationFrame;
      await window.animationFrame;
    }

    group('FluxUiPropsMixin', () {
      // TODO: Add tests / fixtures once the new boilerplate is ready
    });

    group('FluxUiProps', () {
      test('exposes an actions getter', () {
        var props = TestBasic();
        var testActions = TestActions();

        props.actions = testActions;

        expect(props.actions, equals(testActions));
        expect(props, containsPair('TestBasicProps.actions', testActions),
            reason: 'should have an `actions` getter with the a properly-namespaced prop key');
      });

      test('exposes a store getter', () {
        var props = TestBasic();
        var testStore = TestStore();

        props.store = testStore;

        expect(props.store, equals(testStore));
        expect(props, containsPair('TestBasicProps.store', testStore),
            reason: 'should have a `store` getter with the a properly-namespaced prop key');
      });
    });

    void sharedComponentTests(BaseTestComponents testComponents) {
      test('subscribes to a single store by default', () async {
        var store = TestStore();
        var renderedInstance = render(testComponents.basic()..store = store);
        dynamic component = getDartComponent(renderedInstance);

        store.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 1);

        unmount(renderedInstance);

        store.trigger();
        await nextTick();

        expect(component.numberOfRedraws, 1,
            reason: 'component should no longer be listening after unmount');
      });

      test('subscribes to any stores returned in redrawOn', () async {
        var stores = TestStores();
        var renderedInstance = render(testComponents.redrawOn()..store = stores);
        dynamic component = getDartComponent(renderedInstance);

        stores.store1.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 1);

        stores.store2.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 2);

        stores.store3.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 2,
            reason: 'should not redraw since `store3` is absent from the component\'s `redrawOn`');
      });

      test('prefers a handler specified in getStoreHandlers over redrawOn', () async {
        var stores = TestStores();
        var renderedInstance = render(testComponents.handlerPrecedence()..store = stores);
        dynamic component = getDartComponent(renderedInstance);

        stores.store1.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 0);
        expect(component.numberOfHandlerCalls, 1);

        stores.store2.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 1);
        expect(component.numberOfHandlerCalls, 1);
      });

      test('should not attempt subscription if store is a composite of stores', () async {
        var stores = TestStores();
        var renderedInstance = render(testComponents.basic()..store = stores);
        dynamic component = getDartComponent(renderedInstance);

        stores.store1.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 0);

        stores.store2.trigger();
        await nextTick();
        expect(component.numberOfRedraws, 0);
      });

      test('calls handlers specified in getStoreHandlers when each store triggers', () async {
        var store = TestStore();
        var renderedInstance = render(testComponents.storeHandlers()..store = store);
        dynamic component = getDartComponent(renderedInstance);

        store.trigger();
        await nextTick();
        expect(component.numberOfHandlerCalls, 1);

        unmount(renderedInstance);

        store.trigger();
        await nextTick();

        expect(component.numberOfHandlerCalls, 1,
            reason: 'component should no longer be listening');
      });

      test('should call lifecycle methods related to store handlers', () async {
        final store = TestStore();
        var renderedInstance = render(testComponents.handlerLifecycle()..store = store);
        dynamic component = getDartComponent(renderedInstance);

        expect(component.lifecycleCalls, [
          ['listenToStoreForRedraw', store],
        ]);
        component.lifecycleCalls.clear();

        // Cause store to trigger, wait for it to propagate
        store.trigger();
        await nextTick();
        await nextTick();

        expect(component.lifecycleCalls, [
          ['handleRedrawOn', store],
        ]);
      });

      test('cancels any subscriptions added with addSubscription', () async {
        // Setup a new subscription on a component
        int numberOfCalls = 0;
        StreamController controller = StreamController();
        var renderedInstance = render(testComponents.basic());
        dynamic component = getDartComponent(renderedInstance);
        component.addSubscription(controller.stream.listen((_) {
          numberOfCalls += 1;
        }));

        controller.add('something');
        await nextTick();
        expect(numberOfCalls, 1,
          reason: 'handler should get called when an event is added');

        unmount(renderedInstance);
        controller.add('something else');
        await nextTick();
        expect(numberOfCalls, 1,
            reason: 'the subscription to have been cancelled, and should not receive additional events');

        unawaited(controller.close());
      });

      test('should not redraw after being unmounted', () async {
        var renderedInstance = render(testComponents.basic());
        dynamic component = getDartComponent(renderedInstance);
        component.componentWillUnmount();
        component.redraw();
        await nextTick();
        expect(component.numberOfRedraws, equals(0));
      });

      group('calls super in the appropriate lifecycle methods', () {
        test('componentWillUnmount', () {
          var jacket = mount(testComponents.basic()());
          dynamic component = jacket.getDartInstance();
          // Bind this since expectAsync doesn't seem to play well when
          // called from react-dart's Zone
          component.getManagedDisposer(Zone.current.bindCallback(
              expectAsync0(() async {}, reason: 'should have called super, triggering disposal logic')
          ));
          jacket.unmount();
        });
      });

      group('when attempting to listen to a disposed store', () {
        const commonMessageString = 'Cannot listen to a disposed/disposing Store.';

        FluxUiComponent2 component;

        setUp(() {
          var jacket = mount((testComponents.basic())());
          component = jacket.getDartInstance() as FluxUiComponent2;
        });

        test('raises an assertion in DDC', () async {
          final store = TestStore();
          await store.dispose();

          // ignore: invalid_use_of_protected_member
          expect(() => component.listenToStoreForRedraw(store), throwsA(allOf(
            isA<AssertionError>(),
            hasToStringValue(contains(commonMessageString)),
          )));
        }, tags: 'ddc');

        test('logs a warning in dart2js', () async {
          final logs = <LogRecord>[];
          final sub = Logger.root.onRecord
              .where((log) =>
                  log.loggerName.contains('over_react._FluxComponentMixin'))
              .listen(logs.add);
          addTearDown(sub.cancel);

          {
            final store = TestStoreWithCustomName();
            await store.dispose();

            // Ignore StateErrors thrown by the Store itself
            try {
              // ignore: invalid_use_of_protected_member
              component.listenToStoreForRedraw(store);
            } on StateError catch (_) {}

            expect(logs, hasLength(1), reason: 'should have logged a single warning');
            final log = logs[0];
            expect(
                log.loggerName,
                anyOf(
                  'over_react._FluxComponentMixin.TestBasic',
                  'over_react._FluxComponentMixin.TestStatefulBasic'
                ),
                reason: 'should include component name');
            expect(log.stackTrace, isNotNull);
            expect(log.level, Level.WARNING);
            expect(log.message, contains(commonMessageString));
            expect(log.message, contains('a_custom_name'),
                reason: 'should contain the store disposableTypeName');
          }

          logs.clear();

          {
            final store = TestStore();
            await store.dispose();

            // Ignore StateErrors thrown by the Store itself
            try {
              // ignore: invalid_use_of_protected_member
              component.listenToStoreForRedraw(store);
            } on StateError catch (_) {}

            expect(logs, hasLength(1), reason: 'should have logged a single warning');
            final log = logs[0];
            expect(log.message, contains(store.runtimeType.toString()),
                reason: 'should contain the store runtimeType when disposableTypeName is not overridden');
          }
        }, tags: 'no-ddc');
      });
    }

    group('FluxUiComponent', () {
      sharedComponentTests(TestComponents());
    });

    group('FluxUiStatefulComponent', () {
      sharedComponentTests(TestStatefulComponents());
    });
  });
}

class TestActions {}

class TestStore extends Store {}

class TestStoreWithCustomName extends Store {
  @override
  String get disposableTypeName => 'a_custom_name';
}

class TestStores {
  TestStore store1 = TestStore();
  TestStore store2 = TestStore();
  TestStore store3 = TestStore();
}

abstract class BaseTestComponents {
  TestBasicProps basic();
  TestHandlerPrecedenceProps handlerPrecedence();
  TestPropValidationProps propValidation();
  TestRedrawOnProps redrawOn();
  TestStoreHandlersProps storeHandlers();
  TestHandlerLifecycleProps handlerLifecycle();
}

class TestComponents extends BaseTestComponents {
  @override TestBasicProps basic() => TestBasic();
  @override TestHandlerPrecedenceProps handlerPrecedence() => TestHandlerPrecedence();
  @override TestPropValidationProps propValidation() => TestPropValidation();
  @override TestRedrawOnProps redrawOn() => TestRedrawOn();
  @override TestStoreHandlersProps storeHandlers() => TestStoreHandlers();
  @override TestHandlerLifecycleProps handlerLifecycle() => TestHandlerLifecycle();
}

class TestStatefulComponents extends BaseTestComponents {
  @override TestStatefulBasicProps basic() => TestStatefulBasic();
  @override TestStatefulHandlerPrecedenceProps handlerPrecedence() => TestStatefulHandlerPrecedence();
  @override TestStatefulPropValidationProps propValidation() => TestStatefulPropValidation();
  @override TestStatefulRedrawOnProps redrawOn() => TestStatefulRedrawOn();
  @override TestStatefulStoreHandlersProps storeHandlers() => TestStatefulStoreHandlers();
  @override TestStatefulHandlerLifecycleProps handlerLifecycle() => TestStatefulHandlerLifecycle();
}
