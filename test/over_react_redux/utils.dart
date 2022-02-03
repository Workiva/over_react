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
