library bot.expand_stream;

import 'dart:async';

import 'typedefs.dart';

Stream expandStream(Stream source, Stream convert(input), {Stream onDone()}) {
  var controller = new StreamController();

  streamForEachAsync(source, (item) => controller.addStream(convert(item)))
      .then((_) {
    if (onDone != null) {
      return controller.addStream(onDone());
    }
  }).then((_) {
    return controller.close();
  });

  return controller.stream;
}

Future streamForEachAsync(Stream source, action(item)) {
  var obj = new _StreamForEachAsync(source, action);
  return obj.future;
}

class _StreamForEachAsync<T> {
  final Func1<T, dynamic> _action;
  final StreamIterator<T> _iterator;

  final Completer _completer = new Completer();

  _StreamForEachAsync(Stream<T> source, this._action)
      : this._iterator = new StreamIterator(source) {
    _moveNext();
  }

  Future get future => _completer.future;

  void _moveNext() {
    _iterator.moveNext().then((bool hasNext) {
      if (!hasNext) {
        _completer.complete();
        return;
      }

      new Future(() => _action(_iterator.current))
          .then((_) => _moveNext())
          .catchError((error, stackTrace) {
        new Future(_iterator.cancel)
            .then((_) => _completer.completeError(error, stackTrace));
      });
    }, onError: (error, stack) {
      _completer.completeError(error, stack);
    });
  }
}
