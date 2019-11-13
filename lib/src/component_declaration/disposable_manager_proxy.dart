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

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:react/react.dart' as react;
import 'package:w_common/disposable.dart';

/// An implementation of [DisposableManagerV7] for use by
/// `UiComponent` and `UiComponent2`.
mixin DisposableManagerProxy on react.Component implements DisposableManagerV7 { // ignore: deprecated_member_use
  Disposable _disposableProxy;

  @override
  @mustCallSuper
  void componentWillUnmount() {
    super.componentWillUnmount();

    _disposableProxy?.dispose();
  }

  /// Instantiates a new [Disposable] instance on the first call to the
  /// [DisposableManagerV7] method.
  Disposable _getDisposableProxy() => _disposableProxy ??= Disposable();

  @override
  Future<T> awaitBeforeDispose<T>(Future<T> future) =>
      _getDisposableProxy().awaitBeforeDispose<T>(future);

  @override
  Future<T> getManagedDelayedFuture<T>(Duration duration, T Function() callback) =>
      _getDisposableProxy().getManagedDelayedFuture<T>(duration, callback);

  @override
  ManagedDisposer getManagedDisposer(Disposer disposer) =>
      _getDisposableProxy().getManagedDisposer(disposer);

  @override
  Timer getManagedPeriodicTimer(
          Duration duration, void Function(Timer timer) callback) =>
      _getDisposableProxy().getManagedPeriodicTimer(duration, callback);

  @override
  Timer getManagedTimer(Duration duration, void Function() callback) =>
      _getDisposableProxy().getManagedTimer(duration, callback);

  @override
  StreamSubscription<T> listenToStream<T>(
          Stream<T> stream, void Function(T event) onData,
          {Function onError, void Function() onDone, bool cancelOnError,}) =>
      _getDisposableProxy().listenToStream(stream, onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  Disposable manageAndReturnDisposable(Disposable disposable) =>
      _getDisposableProxy().manageAndReturnDisposable(disposable);

  @override
  Completer<T> manageCompleter<T>(Completer<T> completer) =>
      _getDisposableProxy().manageCompleter<T>(completer);

  @override
  void manageDisposable(Disposable disposable) =>
      _getDisposableProxy().manageDisposable(disposable);

  /// DEPRECATED. Use [getManagedDisposer] instead.
  @Deprecated('w_common 2.0.0')
  @override
  void manageDisposer(Disposer disposer) =>
      _getDisposableProxy().manageDisposer(disposer);

  @override
  void manageStreamController(StreamController controller) =>
      _getDisposableProxy().manageStreamController(controller);

  /// DEPRECATED. Use [listenToStream] instead.
  @Deprecated('w_common 2.0.0')
  @override
  void manageStreamSubscription(StreamSubscription subscription) =>
      _getDisposableProxy().manageStreamSubscription(subscription);

  /// Automatically dispose another object when this object is disposed.
  ///
  /// This method is an extension to `manageAndReturnDisposable` and returns the
  /// passed in [Disposable] as its original type in addition to handling its
  /// disposal. The method should be used when a variable is set and should
  /// conditionally be managed for disposal. The most common case will be dealing
  /// with optional parameters:
  ///
  ///      class MyDisposable extends Disposable {
  ///        // This object also extends disposable
  ///        MyObject _internal;
  ///
  ///        MyDisposable({MyObject optional}) {
  ///          // If optional is injected, we should not manage it.
  ///          // If we create our own internal reference we should manage it.
  ///          _internal = optional ??
  ///              manageAndReturnTypedDisposable(new MyObject());
  ///        }
  ///
  ///        // ...
  ///      }
  ///
  /// The parameter may not be `null`.
  @override
  T manageAndReturnTypedDisposable<T extends Disposable>(T disposable) =>
      _getDisposableProxy().manageAndReturnTypedDisposable(disposable);
}
