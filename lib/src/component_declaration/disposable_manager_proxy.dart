part of 'component_base.dart';

/// An implementation of [DisposableManagerV7] for use by
/// [UiComponent] and [UiComponent2].
mixin _DisposableManagerProxy implements DisposableManagerV7 {
  Disposable _disposableProxy;

  @override
  Future<T> awaitBeforeDispose<T>(Future<T> future) =>
      _getDisposableProxy().awaitBeforeDispose<T>(future);

  @override
  Future<T> getManagedDelayedFuture<T>(Duration duration, T callback()) =>
      _getDisposableProxy().getManagedDelayedFuture<T>(duration, callback);

  @override
  ManagedDisposer getManagedDisposer(Disposer disposer) =>
      _getDisposableProxy().getManagedDisposer(disposer);

  @override
  Timer getManagedPeriodicTimer(
          Duration duration, void callback(Timer timer)) =>
      _getDisposableProxy().getManagedPeriodicTimer(duration, callback);

  @override
  Timer getManagedTimer(Duration duration, void callback()) =>
      _getDisposableProxy().getManagedTimer(duration, callback);

  @override
  StreamSubscription<T> listenToStream<T>(
          Stream<T> stream, void onData(T event),
          {Function onError, void onDone(), bool cancelOnError,}) =>
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

  /// Instantiates a new [Disposable] instance on the first call to the
  /// [DisposableManagerV7] method.
  Disposable _getDisposableProxy() => _disposableProxy ??= new Disposable();

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
      _disposableProxy.manageAndReturnTypedDisposable(disposable);
}
