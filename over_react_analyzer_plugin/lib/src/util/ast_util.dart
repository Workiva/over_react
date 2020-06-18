/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';

export 'package:over_react/src/builder/parsing/ast_util.dart';

/// Returns a lazy iterable of all descendants of [node], in breadth-first order.
Iterable<AstNode> allDescendants(AstNode node) sync* {
  final nodesQueue = Queue<AstNode>()..add(node);
  while (nodesQueue.isNotEmpty) {
    final current = nodesQueue.removeFirst();
    for (final child in current.childEntities) {
      if (child is AstNode) {
        yield child;
        nodesQueue.add(child);
      }
    }
  }
}

/// Returns a lazy iterable of all descendants of [node] of type [T], in breadth-first order.
Iterable<T> allDescendantsOfType<T extends AstNode>(AstNode node) => allDescendants(node).whereType<T>();
