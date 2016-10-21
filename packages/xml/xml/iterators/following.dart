part of xml;

/// Iterable to walk over the followers of a node.
class _XmlFollowingIterable extends IterableBase<XmlNode> {

  final XmlNode start;

  _XmlFollowingIterable(this.start);

  @override
  Iterator<XmlNode> get iterator => new _XmlFollowingIterator(start);

}

/// Iterator to walk over the followers of a node.
class _XmlFollowingIterator extends Iterator<XmlNode> {

  final List<XmlNode> todo = new List();

  _XmlFollowingIterator(XmlNode start) {
    var following = new List<XmlNode>();
    for (var parent = start.parent, child = start; parent != null; parent = parent.parent, child = child.parent) {
      var attributes_index = parent.attributes.indexOf(child);
      if (attributes_index != -1) {
        following.addAll(parent.attributes.sublist(attributes_index + 1));
        following.addAll(parent.children);
      } else {
        var children_index = parent.children.indexOf(child);
        following.addAll(parent.children.sublist(children_index + 1));
      }
    }
    todo.addAll(following.reversed);
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
      todo.addAll(current.children.reversed);
      todo.addAll(current.attributes.reversed);
      return true;
    }
  }

}
