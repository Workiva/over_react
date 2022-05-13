/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';
import 'dart:mirrors';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/source/line_info.dart';

import 'constant_evaluator.dart';
import 'util.dart';

/// Returns a String value when a literal or constant var/identifier is found within [expr].
String? getConstOrLiteralStringValueFrom(Expression expr) {
  final staticType = expr.staticType;
  if (staticType == null || !staticType.isDartCoreString) return null;

  final constantValue = expr.accept(ConstantEvaluator());
  return constantValue is String ? constantValue : null;
}

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

extension AstNodeAncestors on AstNode {
  /// A lazy iterable of all ancestors of this node.
  Iterable<AstNode> get ancestors sync* {
    final parent = this.parent;
    if (parent != null) {
      yield parent;
      yield* parent.ancestors;
    }
  }
}

/// Returns all the ancestors of [node] up until [ancestor], not including [ancestor].
///
/// Throws an error if [ancestor] is not an ancestor of [node], to help avoid
/// mistakenly passing in unrelated nodes.
List<AstNode> ancestorsBetween(AstNode node, AstNode ancestor) {
  final ancestorsBetween = <AstNode>[];
  var foundAncestor = false;
  for (final a in node.ancestors) {
    if (a == ancestor) {
      foundAncestor = true;
      break;
    }
    ancestorsBetween.add(a);
  }
  if (!foundAncestor) {
    throw ArgumentError("'node' is not a descendant of 'ancestor'");
  }
  return ancestorsBetween;
}

extension TypeOrBound on DartType {
  DartType get typeOrBound {
    final self = this;
    return self is TypeParameterType ? self.bound.typeOrBound : self;
  }
}

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

SimpleIdentifier? propertyNameFromNonCascadedAccessOrInvocation(Expression node) {
  if (node is PrefixedIdentifier) {
    return node.identifier;
  }
  if (node is PropertyAccess && !node.isCascaded) {
    return node.propertyName;
  }
  if (node is MethodInvocation && !node.isCascaded) {
    return node.methodName;
  }

  return null;
}

Tuple2<SimpleIdentifier, SimpleIdentifier>? getSimpleTargetAndPropertyName(Expression node) {
  if (node is PrefixedIdentifier) {
    return Tuple2(node.prefix, node.identifier);
  }

  if (node is PropertyAccess) {
    final target = node.target;
    if (target is SimpleIdentifier) {
      return Tuple2(target, node.propertyName);
    }
  }
  if (node is MethodInvocation) {
    final target = node.target;
    if (target is SimpleIdentifier) {
      return Tuple2(target, node.methodName);
    }
  }

  return null;
}


bool isAConstantValue(Expression expr) {
  if (expr is SetOrMapLiteral) return expr.isConst;
  if (expr is ListLiteral) return expr.isConst;
  if (expr is InstanceCreationExpression) return expr.isConst;

  return expr.accept(ConstantEvaluator()) != ConstantEvaluator.NOT_A_CONSTANT;
}

extension on FunctionExpression {
  FunctionDeclaration? get parentDeclaration => parent?.tryCast();
}

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
        final expression = statement.expression;
        if (expression != null) yield expression;
      }
    }
  }

  FunctionExpression? get parentExpression => parent?.tryCast();

  FunctionDeclaration? get parentDeclaration => parentExpression?.parentDeclaration;

  MethodDeclaration? get parentMethod => parent?.tryCast();

  String get functionNameOrDescription {
    final name = parentExpression?.parentDeclaration?.name.name;
    if (name != null) return name;

    // TODO come up with a better description in some cases
    return '<anonymous closure>';
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

extension AstNodeRangeHelper on AstNode {
  bool containsRangeOf(AstNode other) => other.offset >= offset && other.end <= end;
}
