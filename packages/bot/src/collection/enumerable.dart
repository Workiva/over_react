part of bot.collection;

Enumerable $(Iterable source) {
  if (source is Enumerable) {
    return source;
  } else {
    return new Enumerable.fromIterable(source);
  }
}

abstract class Enumerable<T> extends IterableBase<T> {
  const Enumerable();

  factory Enumerable.fromIterable(Iterable<T> source) {
    requireArgumentNotNull(source, 'source');
    return new _SimpleEnumerable<T>(source);
  }

  int count(Func1<T, bool> f) => CollectionUtil.count(this, f);

  @override
  Enumerable map(Func1<T, dynamic> f) => $(super.map(f));

  @override
  Enumerable<T> where(Func1<T, bool> f) => $(super.where(f));

  Enumerable<T> exclude(Iterable<T> items) =>
      CollectionUtil.exclude(this, items);

  @override
  Enumerable expand(Func1<T, Iterable> f) => $(super.expand(f));

  Enumerable<T> distinct([Func2<T, T, bool> comparer = null]) =>
      CollectionUtil.distinct(this, comparer);

  Grouping<dynamic, T> group([Func1<T, Object> keyFunc = null]) {
    return new Grouping(this, keyFunc);
  }

  Enumerable<T> concat(Iterable<T> source) =>
      $([this, source]).expand((e) => e);

  void forEachWithIndex(Action2<T, int> f) {
    int i = 0;
    for (final e in this) {
      f(e, i++);
    }
  }

  Map toMap(Func1<T, Object> valueFunc, [Func1<T, dynamic> keyFunc]) =>
      CollectionUtil.toMap(this, valueFunc, keyFunc);

  NumberEnumerable selectNumbers(Func1<T, num> f) =>
      new NumberEnumerable.from(this.map(f));

  @override
  String toString() => "[${join(', ')}]";
}

class _SimpleEnumerable<T> extends Enumerable<T> {
  final Iterable<T> _source;

  _SimpleEnumerable(this._source) : super();

  @override
  Iterator<T> get iterator => _source.iterator;
}
