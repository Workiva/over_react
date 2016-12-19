// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:meta/meta.dart';

// ignore: one_member_abstracts
abstract class _Disposable {
  Future<Null> dispose();
}

class _InternalDisposable implements _Disposable {
  Disposer _disposer;

  _InternalDisposable(this._disposer);

  @override
  Future<Null> dispose() {
    var disposeFuture = _disposer();
    _disposer = null;
    if (disposeFuture == null) {
      return new Future(() => null);
    }
    return disposeFuture.then((_) => null);
  }
}

/// A function that, when called, disposes of one or more objects.
typedef Future<dynamic> Disposer();

/// Allows the creation of managed objects, including helpers for common patterns.
///
/// There are three ways to consume this class: as a mixin, a base class,
/// and an interface. All should work fine but the first is the simplest
/// and most powerful. Using the class as an interface will require
/// significant effort.
///
/// In the case below, the class is used as a mixin. This provides both
/// default implementations and flexibility since it does not occupy
/// a spot in the class hierarchy.
///
/// Helper methods, such as [manageStreamSubscription] allow certain
/// cleanup to be automated. Managed subscriptions will be automatically
/// canceled when [dispose] is called on the object.
///
///      class MyDisposable extends Object with Disposable {
///        StreamController _controller = new StreamController();
///
///        MyDisposable(Stream someStream) {
///          manageStreamSubscription(someStream.listen((_) => print('some stream')));
///          manageStreamController(_controller);
///        }
///
///        Future<Null> onDispose() {
///          // Other cleanup
///        }
///      }
///
/// The [manageDisposer] helper allows you to clean up arbitrary objects
/// on dispose so that you can avoid keeping track of them yourself. To
/// use it, simply provide a callback that returns a [Future] of any
/// kind. For example:
///
///      class MyDisposable extends Object with Disposable {
///        StreamController _controller = new StreamController();
///
///        MyDisposable() {
///          var thing = new ThingThatRequiresCleanup();
///          manageDisposer(() {
///            thing.cleanUp();
///            return new Future(() {});
///          });
///        }
///      }
///
/// Cleanup will then be automatically performed when the containing
/// object is disposed. If returning a future is inconvenient or
/// otherwise undesireable, you may also return `null` explicitly.
///
/// Implementing the [onDispose] method is entirely optional and is only
/// necessary if there is cleanup required that is not covered by one of
/// the helpers.
///
/// It is possible to schedule a callback to be called after the object
/// is disposed for purposes of further, external, cleanup or bookkeeping
/// (for example, you might want to remove any objects that are disposed
/// from a cache). To do this, use the [didDispose] future:
///
///      var myDisposable = new MyDisposable();
///      myDisposable.didDispose.then((_) {
///        // External cleanup
///      });
abstract class Disposable implements _Disposable {
  Completer<Null> _didDispose = new Completer<Null>();
  bool _isDisposing = false;
  List<_Disposable> _internalDisposables = [];

  /// A [Future] that will complete when this object has been disposed.
  Future<Null> get didDispose => _didDispose.future;

  /// Whether this object has been disposed.
  bool get isDisposed => _didDispose.isCompleted;

  /// Whether this object has been disposed or is disposing.
  ///
  /// This will become `true` as soon as the [dispose] method is called
  /// and will remain `true` forever. This is intended as a convenience
  /// and `object.isDisposedOrDisposing` will always be the same as
  /// `object.isDisposed || object.isDisposing`.
  bool get isDisposedOrDisposing => isDisposed || isDisposing;

  /// Whether this object is in the process of being disposed.
  ///
  /// This will become `true` as soon as the [dispose] method is called
  /// and will become `false` once the [didDispose] future completes.
  bool get isDisposing => _isDisposing;

  /// Dispose of the object, cleaning up to prevent memory leaks.
  @override
  Future<Null> dispose() async {
    if (isDisposed) {
      return null;
    }
    if (_isDisposing) {
      return didDispose;
    }
    _isDisposing = true;

    List<Future> futures = []
      ..addAll(_internalDisposables.map((disposable) => disposable.dispose()))
      ..add(onDispose());

    _internalDisposables = [];

    // We need to filter out nulls because a subscription cancel
    // method is allowed to return a plain old null value.
    return Future
        .wait(futures.where((future) => future != null))
        .then(_completeDisposeFuture);
  }

  /// Automatically dispose another object when this object is disposed.
  ///
  /// The parameter may not be `null`.
  @mustCallSuper
  @protected
  void manageDisposable(Disposable disposable) {
    _throwIfNull(disposable, 'disposable');
    _internalDisposables.add(disposable);
  }

  /// Automatically handle arbitrary disposals using a callback.
  ///
  /// The parameter may not be `null`.
  @mustCallSuper
  @protected
  void manageDisposer(Disposer disposer) {
    _throwIfNull(disposer, 'disposer');
    _internalDisposables.add(new _InternalDisposable(disposer));
  }

  /// Automatically cancel a stream controller when this object is disposed.
  ///
  /// The parameter may not be `null`.
  @mustCallSuper
  @protected
  void manageStreamController(StreamController controller) {
    _throwIfNull(controller, 'controller');
    _internalDisposables.add(new _InternalDisposable(() {
      if (!controller.hasListener) {
        controller.stream.listen((_) {});
      }
      return controller.close();
    }));
  }

  /// Automatically cancel a stream subscription when this object is disposed.
  ///
  /// The parameter may not be `null`.
  @mustCallSuper
  @protected
  void manageStreamSubscription(StreamSubscription subscription) {
    _throwIfNull(subscription, 'subscription');
    _internalDisposables
        .add(new _InternalDisposable(() => subscription.cancel()));
  }

  /// Callback to allow arbitrary cleanup on dispose.
  @protected
  Future<Null> onDispose() async {
    return null;
  }

  Null _completeDisposeFuture(List<dynamic> _) {
    _didDispose.complete();
    _isDisposing = false;
    return null;
  }

  void _throwIfNull(dynamic subscription, String name) {
    if (subscription == null) {
      throw new ArgumentError.notNull(name);
    }
  }
}
