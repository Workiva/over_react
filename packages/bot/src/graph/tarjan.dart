part of bot.graph;

/**
 * [Tarjan's strongly connected components algorithm](http://en.wikipedia.org/wiki/Tarjan's_strongly_connected_components_algorithm)
 */
List<List> stronglyConnectedComponents(Map<dynamic, Iterable> graph) {
  requireArgumentNotNull(graph, 'graph');

  var nodes = new _Graph(graph);
  var tarjan = new _TarjanCycleDetect(nodes);
  return tarjan.calculate();
}

class _TarjanCycleDetect<T> {
  final _indexExpando = new Expando<int>('index');
  final _linkExpando = new Expando<int>('link');

  final Queue<_GraphNode<T>> _stack = new Queue<_GraphNode<T>>();
  final List<List<T>> _scc = new List<List<T>>();
  final _Graph<T> _list;

  int _index = 0;

  _TarjanCycleDetect(this._list);

  List<List<T>> calculate() {
    for (var node in _list.nodes) {
      if (_getIndex(node) == -1) {
        _tarjan(node);
      }
    }
    return _scc;
  }

  void _tarjan(_GraphNode<T> v) {
    _setIndex(v, _index);
    _setLowLink(v, _index);
    _index++;
    _stack.addFirst(v);
    for (final n in v.outNodes) {
      if (_getIndex(n) == -1) {
        _tarjan(n);
        _setLowLink(v, math.min(_getLowLink(v), _getLowLink(n)));
      } else if (_stack.contains(n)) {
        _setLowLink(v, math.min(_getLowLink(v), _getIndex(n)));
      }
    }
    if (_getLowLink(v) == _getIndex(v)) {
      _GraphNode n;
      var component = new List<T>();
      do {
        n = _stack.removeFirst();
        component.add(n.value);
      } while (n != v);
      _scc.add(component);
    }
  }

  int _getIndex(_GraphNode<T> node) {
    var value = _indexExpando[node];
    return (value == null) ? -1 : value;
  }

  int _setIndex(_GraphNode<T> node, int value) => _indexExpando[node] = value;

  int _getLowLink(_GraphNode<T> node) => _linkExpando[node];

  int _setLowLink(_GraphNode<T> node, int value) => _linkExpando[node] = value;
}
