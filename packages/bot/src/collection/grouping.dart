part of bot.collection;

class Grouping<K, V> {
  final HashMap<K, List<V>> _values = new HashMap<K, List<V>>();

  Grouping(Iterable<V> source, [K keyFunc(V) = null]) {
    if (keyFunc == null) {
      keyFunc = (v) => v;
    }

    for (final V value in source) {
      final K key = keyFunc(value);
      final values = _values.putIfAbsent(key, () => new List<V>());
      values.add(value);
    }
  }

  /**
   * Returns whether this map contains the given [key].
   */
  bool containsKey(K key) => _values.containsKey(key);

  List<V> operator [](K key) => _values[key];

  /**
   * Applies [f] to each {key, value} pair of the map.
   */
  void forEach(void f(K key, List<V> value)) => _values.forEach(f);

  /**
   * Returns a collection containing all the keys in the map.
   */
  Iterable<K> getKeys() => _values.keys;

  Iterable<V> getValues() => _values.values.expand((a) => a);

  /**
   * The number of {key, value} pairs in the map.
   */
  int get length => _values.length;

  /**
   * Returns true if there is no {key, value} pair in the map.
   */
  bool get isEmpty => _values.isEmpty;

  String toString() => _values.toString();
}
