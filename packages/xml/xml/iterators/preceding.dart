part of xml;

/// Iterable to walk over the precedents of a node.
class _XmlPrecedingIterable extends IterableBase<XmlNode> {

  final XmlNode start;

  _XmlPrecedingIterable(this.start);

  @override
  Iterator<XmlNode> get iterator => new _XmlPrecedingIterator(start);

}

/// Iterator to walk over the precedents of a node.
class _XmlPrecedingIterator extends Iterator<XmlNode> {

  final XmlNode start;
  final List<XmlNode> todo = new List();

  _XmlPrecedingIterator(this.start) {
    todo.add(start.root);
  }

  @override
  XmlNode current;

  @override
  bool moveNext() {
    if (todo.isEmpty) {
      current = null;
      return false;
    } else {
      current = todo.removeLast();
      if (identical(current, start)) {
        current = null;
        todo.clear();
        return false;
      }
      todo.addAll(current.children.reversed);
      todo.addAll(current.attributes.reversed);
      return true;
    }
  }

}
