@JS()
library over_react.promise_interop;
import 'dart:js';

import 'package:js/js.dart';

/// Creates JS `Promise` which is resolved when [future] completes.
///
/// See also:
/// - [promiseToFuture]
Promise futureToPromise<T>(Future<T> future) {
  return Promise(allowInterop((Function resolve, Function reject) {
    future.then((result) => resolve(result), onError: reject);
  }));
}

@JS()
abstract class Promise {
  external factory Promise(
      Function(dynamic Function(dynamic value) resolve, dynamic Function(dynamic error) reject) executor);

  external Promise then(dynamic Function(dynamic value) onFulfilled, [dynamic Function(dynamic error) onRejected]);
}
