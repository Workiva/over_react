library bot.graph;

import 'dart:math' as math;
import 'dart:collection';

import 'require.dart';

part 'graph/topo_sort.dart';
part 'graph/tarjan.dart';

class _Graph<T> {
  final LinkedHashMap<T, _GraphNode<T>> _map;

  factory _Graph(Map<T, Iterable<T>> items) {
    var map = new LinkedHashMap<T, _GraphNode<T>>();

    _GraphNode<T> getNode(T value) =>
        map.putIfAbsent(value, () => new _GraphNode<T>(value));

    items.forEach((T item, Iterable<T> outLinks) {
      if (outLinks == null) outLinks = <T>[];

      var node = getNode(item);
      for (T outLink in outLinks) {
        var newItem = node.outNodes.add(getNode(outLink));
        requireArgument(newItem, 'items', 'Outlinks must not contain dupes');
      }
    });

    return new _Graph.core(map);
  }

  _Graph.core(this._map);

  Iterable<_GraphNode<T>> get nodes => _map.values;

  String toString() {
    var sb = new StringBuffer();
    sb.writeln('{');
    _map.values.forEach((_GraphNode<T> value) {
      var outNodeStr = value.outNodes.map((gn) => gn.value).join(', ');

      sb.writeln('  ${value.value} => {$outNodeStr}');
    });

    sb.writeln('}');
    return sb.toString();
  }
}

class _GraphNode<T> {
  final T value;
  final LinkedHashSet<_GraphNode<T>> outNodes =
      new LinkedHashSet<_GraphNode<T>>();

  _GraphNode(this.value);

  bool operator ==(other) =>
      other is _GraphNode && other.value == value;

  int get hashCode => value.hashCode;
}
