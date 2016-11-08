
/// Provides [StreamTransformer]s to limit the rate at which a Stream emits events.
library rate_limit;

import 'dart:async';

/// Enforces a wait period between events.
class Throttler<T> implements StreamTransformer {

  Debouncer<T> _debounce;

  /// Requires a [wait] period to elapse after any previous event before 
  /// emitting the next event.
  /// 
  /// If [leading] is true, then events which do not occur in a wait period 
  /// are emitted immediately, otherwise they will be emitted at the end of the 
  /// wait period.
  /// 
  /// If [trailing] is true, then the last event to occur in a wait period will 
  /// be output at the end of the wait period.
  /// 
  /// If both [leading] and [trailing] are false, throws an [ArgumentError].
  Throttler(
      Duration wait, 
      {bool leading: true, 
       bool trailing: true}) {
    if(!leading && !trailing) {
      throw new ArgumentError('Either `leading` or `trailing` must be true.');
    }
    _debounce = new Debouncer<T>(wait, maxWait: wait, leading: leading, trailing: trailing);
  }

  Stream<T> bind(Stream<T> stream) => _debounce.bind(stream);
}

/// Enforces a *quiet* wait period between events.
class Debouncer<T> implements StreamTransformer {

  final Duration _wait;
  final Duration _maxWait;
  final bool _leading;
  final bool _trailing;
  bool get _waitEqualsMaxWait {
    if(__waitEqualsMaxWait == null) {
      __waitEqualsMaxWait = _wait == _maxWait;
    }
    return __waitEqualsMaxWait;
  }
  bool __waitEqualsMaxWait;
  
  /// Requires a [wait] period to elapse *with no input events* after any 
  /// previous event before emitting the next event.
  /// 
  /// If [maxWait] is provided, then it specifies the maximum wait period 
  /// before events can be emitted again.
  /// 
  /// If [maxWait] is less than [wait], throws an [ArgumentError].
  /// 
  /// If [leading] is true, then events which do not occur in a wait period 
  /// are emitted immediately, otherwise they will be emitted at the end of the 
  /// wait period.
  /// 
  /// If [trailing] is true, then the last event to occur in a wait period will 
  /// be output at the end of the wait period.
  /// 
  /// If both [leading] and [trailing] are false, throws an [ArgumentError].
  Debouncer(
      Duration wait, 
      {Duration maxWait, 
       bool leading: false, 
       bool trailing: true}) : 
       _wait = wait,
       _maxWait = maxWait,
       _leading = leading,
       _trailing = trailing {
    if(!leading && !trailing) {
      throw new ArgumentError('Either `leading` or `trailing` must be true.');
    }
    if(maxWait != null && maxWait < wait) {
      throw new ArgumentError('`maxWait` cannot be less than `wait`.');
    }
  }
    
  StreamTransformer<T, T> get _transformer =>
      new StreamTransformer<T, T>(
          (Stream<T> input, bool cancelOnError) {
            StreamController<T> controller;
            StreamSubscription<T> subscription;
            Timer waitTimer;
            Timer maxWaitTimer;
            T trailingData;
            cancelTimers() {
              if(waitTimer != null) {
                waitTimer.cancel();
                waitTimer = null;
              }
              if(maxWaitTimer != null) {
                maxWaitTimer.cancel();
                maxWaitTimer = null;
              }
            }
            var done = false;
            T lastData;
            finish() {
              if(done) {
                cancelTimers();
                controller.close();
              }
            }
            bool addData;
            controller = new StreamController<T>(
              onListen: () {
                subscription = input.listen((data) {
              
                  addData = _trailing;
                  lastData = data;
                  bool setTimer = false;
                  bool setMaxTimer = false;
                  if(waitTimer == null) {
                    setTimer = true;
                    if(_leading) {
                      controller.add(lastData);
                      addData = false;
                    }
                    if(_maxWait != null && !_waitEqualsMaxWait) {
                      setMaxTimer = true;
                    }
                  } else {
                    if(!_waitEqualsMaxWait) {
                      waitTimer.cancel();
                      setTimer = true;
                    }
                  }
                  afterWait() {
                    if(addData) {
                      controller.add(lastData);
                    }
                    cancelTimers();
                    if(done) controller.close();
                  }

                  if(setTimer) {
                    waitTimer = new Timer(_wait, afterWait);
                  }
                  if(setMaxTimer) {
                    maxWaitTimer = new Timer(_maxWait, afterWait);
                  }
                },
                onError: (error, stackTrace) {
                  // TODO: Is this necessary?
                  if(cancelOnError) cancelTimers();
                  controller.addError(error, stackTrace);
                },
                onDone: () {
                  done = true;
                  if(waitTimer == null || !_trailing) finish();
                },
                cancelOnError: cancelOnError);
              },
              onPause: () {
                if(subscription != null) subscription.pause();
              },
              onResume: () {
                if(subscription != null) subscription.resume();
              },
              onCancel: () {
                if(subscription != null) subscription.cancel();
              },
              sync: true);
            return controller.stream.listen(null);
          });

  Stream<T> bind(Stream<T> stream) => _transformer.bind(stream);
}
