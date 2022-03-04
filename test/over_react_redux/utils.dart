// Copyright 2022 Workiva Inc.
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

import 'package:redux/redux.dart';
import 'package:test/test.dart';

/// Dispatches an action on a redux store, waits for the store to emit an onChange event,
/// and then waits for a [pumpEventQueue].
///
/// This can be used to dispatch an action and ensure it has been received by any subscribers,
/// which is helpful for verifying that something _doesn't_ happen in response to a store update.
Future<void> dispatchAndWait(Store store, dynamic action) async {
  final storeChangeFuture = store.onChange.first;
  store.dispatch(action);
  // Set an arbitrary timeout here so that tests don't hang for the default timeout (30s)
  // if this fails to dispatch.
  await storeChangeFuture.timeout(Duration(milliseconds: 100));
  await pumpEventQueue();
}
