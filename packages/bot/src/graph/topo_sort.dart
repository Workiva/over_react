part of bot.graph;

List topologicalSort(Map<dynamic, Iterable<dynamic>> dependencies) {
  requireArgumentNotNull(dependencies, 'dependencies');

  var graph = new _Graph(dependencies);

  var items = new LinkedHashSet();

  int targetCount = graph._map.length;

  while (items.length < targetCount) {

    var zeros = graph._map.values
        .where((_GraphNode node) {
          return !items.contains(node.value) &&
              node.outNodes
              .where((node) => !items.contains(node.value))
              .isEmpty;
        })
        .map((node) => node.value)
        .toList();

    if (zeros.isEmpty) throw new ArgumentError('There is a loop in the map');

    for (var item in zeros) {
      var added = items.add(item);
      assert(added);
    }
  }

  return items.toList();
}
