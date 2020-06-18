/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

export 'package:over_react/src/builder/parsing/ast_util.dart';

/// Returns a lazy iterable of all descendants of [node], in breadth-first order.
///
/// > Related: [getMatchingDescendants], [allDescendantsOfType]
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

/// Returns nodes within [node] that match the predicate [test].
///
/// > Related: [getMatchingDescendantsOfType], [getFirstMatchingDescendant]
Iterable<AstNode> getMatchingDescendants(AstNode node, bool Function(AstNode node) test) =>
    allDescendants(node).where(test);

/// Returns the first node within [node] that match the predicate [test].
///
/// > Related: [getFirstMatchingDescendantOfType]
AstNode getFirstMatchingDescendant<T extends AstNode>(AstNode node, bool Function(T) test) =>
    allDescendants(node).firstWhere(test, orElse: () => null);

/// Returns a lazy iterable of all descendants of [node] of type [T], in breadth-first order.
///
/// > Related: [forEachDescendantOfType], [getMatchingDescendantsOfType]
Iterable<T> allDescendantsOfType<T extends AstNode>(AstNode node) => allDescendants(node).whereType<T>();

/// Returns [T]s within [node] that match the predicate [test].
///
/// > Related: [getFirstMatchingDescendantOfType]
Iterable<T> getMatchingDescendantsOfType<T extends AstNode>(AstNode node, bool Function(T) test) =>
    allDescendantsOfType<T>(node).where(test);

/// Returns the first [T] within [node] that match the predicate [test].
T getFirstMatchingDescendantOfType<T extends AstNode>(AstNode node, bool Function(T) test) =>
    allDescendantsOfType<T>(node).firstWhere(test, orElse: () => null);

/// Recursively visits [T]s that match the predicate [test], and calls [handleMatch] when visiting.
///
/// > Related: [getMatchingDescendantsOfType]
void forEachDescendantOfType<T extends AstNode>(AstNode node, bool Function(T) test, dynamic Function(T) handleMatch) {
  getMatchingDescendantsOfType(node, test).forEach(handleMatch);
}

extension ClassOrMixinDeclarationUtils on ClassOrMixinDeclaration {
  /// Similar to [getField], but returns the entire declaration instead.
  FieldDeclaration getFieldDeclaration(String name) => childEntities
      .whereType<FieldDeclaration>()
      .firstWhere((decl) => decl.fields.variables.single.name.name == name, orElse: () => null);
}

int prevLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLine(lineInfo.getLocation(offset).lineNumber - 1);
}

int nextLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLineAfter(offset);
}
