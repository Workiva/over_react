//@dart=2.11

// Copyright 2024 Workiva Inc.
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

library over_react.component_declaration.unsound_flux_component_test;

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../test_util/test_util.dart';
import 'flux_component_test.dart';

// These tests are only possible in unsound null safety, otherwise we'll get null errors
// when the mocks return null when they shouldn't.
void main() {
  void sharedComponentTests(BaseTestComponents testComponents) {
    group(
        'mounts, rerenders, and unmounts properly when using a mock store that returns null'
        ' for members like .listen and isOrWillBeDisposed', () {
      test('basic usage', () async {
        final mockStore = MockTestStore();
        final jacket = mount((testComponents.basic()..store = mockStore)());
        await pumpEventQueue();
        verify(mockStore.listen(any));
        jacket.rerender((testComponents.basic()..store = mockStore)());
        await pumpEventQueue();
        jacket.unmount();
      });

      test('with redrawOn override', () async {
        final mockStores = MockedTestStores();
        final jacket = mount((testComponents.redrawOn()..store = mockStores)());
        await pumpEventQueue();
        verify(mockStores.store1.listen(any));
        verify(mockStores.store2.listen(any));
        jacket.rerender((testComponents.redrawOn()..store = mockStores)());
        await pumpEventQueue();
        jacket.unmount();
      });

      test('with storeHandlers override', () async {
        final mockStore = MockTestStore();
        final jacket = mount((testComponents.storeHandlers()..store = mockStore)());
        await pumpEventQueue();
        verify(mockStore.listen(any));
        jacket.rerender((testComponents.storeHandlers()..store = mockStore)());
        await pumpEventQueue();
        jacket.unmount();
      });
    });
  }

  group('FluxUiComponent', () {
    sharedComponentTests(TestComponents());
  });

  group('FluxUiStatefulComponent', () {
    sharedComponentTests(TestStatefulComponents());
  });
}

class MockTestStore extends Mock implements TestStore {}

class MockedTestStores implements TestStores {
  @override
  final TestStore store1 = MockTestStore();
  @override
  final TestStore store2 = MockTestStore();
  @override
  final TestStore store3 = MockTestStore();
}
