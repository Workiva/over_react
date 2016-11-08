library bot.helpers;

import '../bot.dart' show StringLineReader;
import 'typedefs.dart';
import 'collection.dart';

class FuncEnumerable<TSource, TOutput> extends Enumerable<TOutput> {
  final TSource _source;
  final Func1<TSource, Iterator<TOutput>> _func;

  FuncEnumerable(this._source, this._func) : super();

  @override
  Iterator<TOutput> get iterator => _func(_source);
}

class StringLineIterator extends Iterator<String> {
  final StringLineReader _reader;

  String _current;

  StringLineIterator(String source) : _reader = new StringLineReader(source);

  String get current => _current;

  bool moveNext() {
    _current = _reader.readNextLine();
    return _current != null;
  }
}
