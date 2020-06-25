/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';
// This is necessary for `ConstantEvaluator`. If that API is removed, it can just
// be copied and pasted into this analyzer package (if still needed).
// ignore: deprecated_member_use
import 'package:analyzer/analyzer.dart' show ConstantEvaluator;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';

export 'package:over_react/src/builder/parsing/ast_util.dart';
export 'package:over_react/src/builder/parsing/util.dart';

/// Returns a lazy iterable of all descendants of [node], in breadth-first order.
Iterable<AstNode> allDescendants(AstNode node) sync* {
  final nodesQueue = Queue<AstNode>()..add(node);
  while (nodesQueue.isNotEmpty) {
    final current = nodesQueue.removeFirst();
    if (current == null) return;

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
  FieldDeclaration getFieldDeclaration(String name) => getField(name)?.thisOrAncestorOfType<FieldDeclaration>();
}

int prevLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLine(lineInfo.getLocation(offset).lineNumber - 1);
}

int nextLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLineAfter(offset);
}

bool isAConstantValue(Expression expr) => expr.accept(ConstantEvaluator()) != ConstantEvaluator.NOT_A_CONSTANT;

extension FunctionBodyUtils on FunctionBody {
  /// An of expressions representing:
  ///
  /// - for `ExpressionFunctionBody`: the single expression
  /// - for `BlockFunctionBody`: the expressions within all `return` statements for that function,
  ///   excluding return statements which have no value (`return;`) or belong to nested functions
  ///
  /// Useful when you want to get all of the potential return values, but don't care what
  /// kind of function body you're dealing with.
  Iterable<Expression> get returnExpressions sync* {
    final self = this; // Need this for type promotion in is-checks.
    if (self is ExpressionFunctionBody) {
      yield self.expression;
    } else if (self is BlockFunctionBody) {
      for (final statement in self.returnStatements) {
        // Expression is null for returns statements without values (`return;`). Skip those.
        if (statement.expression != null) {
          yield statement.expression;
        }
      }
    }
  }
}

extension BlockFunctionBodyUtils on BlockFunctionBody {
  /// Returns all return statements for this function body.
  ///
  /// Includes return statements nested in `if`/`for`/other blocks,
  /// and does not include return statements for nested functions.
  List<ReturnStatement> get returnStatements {
    final visitor = _ReturnStatementsForBodyVisitor();
    accept(visitor);
    return visitor.returnStatementsForBody;
  }
}

class _ReturnStatementsForBodyVisitor extends RecursiveAstVisitor<void> {
  final returnStatementsForBody = <ReturnStatement>[];

  @override
  void visitReturnStatement(ReturnStatement node) {
    returnStatementsForBody.add(node);
  }

  @override
  void visitFunctionExpression(FunctionExpression node) {
    // Don't call super so we don't traverse inside other functions.
  }
}
