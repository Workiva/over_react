part of bot.collection;

NumberEnumerable n$(Iterable<num> source) {
  return new NumberEnumerable.from(source);
}

abstract class NumberEnumerable<T extends num> extends IterableBase<T> {
  const NumberEnumerable() : super();

  factory NumberEnumerable.from(Iterable<T> source) {
    requireArgumentNotNull(source, 'source');
    return new _SimpleNumEnumerable<T>(source);
  }

  factory NumberEnumerable.fromRange(int start, int count) {
    return new NumberEnumerable<T>.from(
        new Iterable.generate(count, (i) => i + start));
  }

  num max() => this.reduce((num a, num b) => math.max(a, b));

  num min() => this.reduce((num a, num b) => math.min(a, b));

  num sum() {
    num theSum = 0;
    for (final n in this) {
      if (n == null) {
        throw const InvalidOperationError('Input contained a null item');
      }
      theSum += n;
    }
    return theSum;
  }

  num average() {
    int theCount = 0;
    num theSum = 0;
    for (final n in this) {
      if (n == null) {
        throw const InvalidOperationError('Input contained a null item');
      }
      theSum += n;
      theCount++;
    }
    return theSum / theCount;
  }
}

class _SimpleNumEnumerable<T extends num> extends NumberEnumerable<T> {
  final Iterable<T> _source;

  const _SimpleNumEnumerable(this._source) : super();

  Iterator<T> get iterator => _source.iterator;
}

class _FuncNumEnumerable<TSource> extends NumberEnumerable {
  final Iterable<TSource> _source;
  final Func1<Iterator<TSource>, Iterator<num>> _func;

  const _FuncNumEnumerable(this._source, this._func) : super();

  Iterator<num> get iterator => _func(_source.iterator);
}
