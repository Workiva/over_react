/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';
// ignore: deprecated_member_use
// This is necessary for `ConstantEvaluator`. If that API is removed, it can just
// be copied and pasted into this analyzer package (if still needed).
import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

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

extension ClassOrMixinDeclarationUtils on ClassOrMixinDeclaration {
  /// Similar to [getField], but returns the entire declaration instead.
  FieldDeclaration getFieldDeclaration(String name) => getField(name).thisOrAncestorOfType<FieldDeclaration>();
}

int prevLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLine(lineInfo.getLocation(offset).lineNumber - 1);
}

int nextLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLineAfter(offset);
}

bool isAConstantValue(Expression expr) => expr.accept(ConstantEvaluator()) != ConstantEvaluator.NOT_A_CONSTANT;
