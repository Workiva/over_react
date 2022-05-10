/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';
import 'dart:mirrors';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:over_react_analyzer_plugin/src/util/analyzer_util.dart';

/// Returns a String value when a literal or constant var/identifier is found within [expr].
String? getConstOrLiteralStringValueFrom(Expression expr) {
  if (!expr.staticType!.isDartCoreString) return null;

  if (expr is StringInterpolation) {
    final constantValue = expr.accept(ConstantEvaluator());
    return constantValue is String ? constantValue : null;
  } else if (expr is StringLiteral) {
    return expr.stringValue;
  } else if (expr is SimpleIdentifier) {
    final element = expr.staticElement;
    if (element is PropertyAccessorElement) {
      return element.variable.computeConstantValue()?.toStringValue();
    } else if (element is VariableElement) {
      return element.computeConstantValue()?.toStringValue();
    }
  }

  return null;
}

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
  FieldDeclaration? getFieldDeclaration(String name) => getField(name)?.thisOrAncestorOfType<FieldDeclaration>();
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
          yield statement.expression!;
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

/// Uses reflection to determine which value within [values] that [object] represents,
/// and returns the matching value.
///
/// Currently only works when the fields within [T] only contain core types and not other constant classes.
T getMatchingConst<T>(DartObject object, Iterable<T> values) {
  final classMirror = reflectClass(T);
  final objectTypeName = object.type!.element!.name;
  final valueTypeName = classMirror.simpleName.name;

  if (objectTypeName != valueTypeName) {
    throw ArgumentError('Object type $objectTypeName must exactly match value type $valueTypeName');
  }

  final fields =
      classMirror.instanceMembers.values.where((m) => m.isGetter && m.isSynthetic).map((m) => m.simpleName).toList();

  // Find the value where all fields are equal:
  return values.singleWhere((value) {
    return fields.every((field) {
      // Need to use the field symbol and not it converted back from a string or it won't work
      // for private members.
      final dynamic valueFieldValue = reflect(value).getField(field).reflectee;
      final objectFieldValue = object.getField(field.name)!.toWhateverValue();
      return valueFieldValue == objectFieldValue;
    });
  });
}

extension on DartObject {
  Object? toWhateverValue() =>
      toBoolValue() ??
      toDoubleValue() ??
      toFunctionValue() ??
      toIntValue() ??
      toListValue() ??
      toMapValue() ??
      toSetValue() ??
      toStringValue() ??
      toSymbolValue() ??
      toTypeValue();
}

extension on Symbol {
  String get name => MirrorSystem.getName(this);
}
