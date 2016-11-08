part of bot.collection;

class CollectionUtil {
  static bool allUnique(Iterable items) {
    requireArgumentNotNull(items, 'items');

    for (int i = 0; i < items.length; i++) {
      for (int j = i + 1; j < items.length; j++) {
        if (items.elementAt(i) == items.elementAt(j)) {
          return false;
        }
      }
    }
    return true;
  }

  static int count(Iterable source, bool test(dynamic)) {
    return source.fold(0, (int previous, dynamic element) {
      if (test(element)) {
        return previous + 1;
      } else {
        return previous;
      }
    });
  }

  static Iterable exclude(Iterable source, Iterable itemsToExclude) {
    requireArgumentNotNull(itemsToExclude, 'itemsToExclude');
    Func1<dynamic, bool> f = (e) => !itemsToExclude.contains(e);
    return $(source.where(f));
  }

  static Iterable distinct(
      Iterable source, [bool comparer(dynamic a, dynamic b) = null]) {
    if (comparer == null) {
      comparer = (a, b) => a == b;
    }
    return new FuncEnumerable(source, (Iterable s) =>
        new _DistinctIterator(s.iterator, comparer));
  }

  static void forEachWithIndex(Iterable source, Action2<dynamic, int> f) {
    int i = 0;
    for (final e in source) {
      f(e, i++);
    }
  }

  static Map toMap(
      Iterable source, Func1 valueFunc, [dynamic keyFunc(dynamic)]) {
    if (keyFunc == null) {
      keyFunc = (a) => a;
    }

    final map = new Map();
    for (final e in source) {
      final k = keyFunc(e);
      if (map.containsKey(k)) {
        throw new UnsupportedError("The key '$k' is duplicated");
      }
      map[k] = valueFunc(e);
    }
    return map;
  }
}

class _DistinctIterator<T> implements Iterator<T> {
  final Iterator<T> _source;
  final Func2<T, T, bool> _comparer;

  final List<T> _found;
  T _current;

  _DistinctIterator(this._source, this._comparer) : _found = new List<T>();

  T get current => _current;

  bool moveNext() {
    while (_source.moveNext()) {
      final candidate = _source.current;
      if (!_found.any((e) => _comparer(e, candidate))) {
        _current = candidate;
        _found.add(_current);
        return true;
      }
    }
    return false;
  }
}
