/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/source/line_info.dart';

import 'analyzer_util.dart';
import 'constant_evaluator.dart';
import 'util.dart';

/// Returns the AST node of the variable declaration associated with the [element] within [root],
/// or null if the [element] doesn't correspond to a variable declaration, or if it can't be found in [root].
VariableDeclaration? lookUpVariable(Element element, AstNode root) {
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  if (node is VariableDeclaration && node.declaredElement == element) {
    return node;
  }

  return null;
}

/// Returns the AST node of the function expression corresponding to [element] within [root],
/// which can be either a function declaration or a variable declaration that's
/// initialized to a function expression.
///
/// Returns null if the [element] doesn't correspond to one of these cases, or if it can't be found in [root].
FunctionExpression? lookUpFunction(Element element, AstNode root) {
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  if (node is FunctionDeclaration && node.declaredElement == element) {
    return node.functionExpression;
  }
  if (node is VariableDeclaration && node.declaredElement == element) {
    return node.initializer?.tryCast<FunctionExpression>();
  }

  return null;
}

/// Returns the AST node that declares [element] within [root],
/// assuming the node that declares it is a `Declaration` instance.
///
/// Returns null if the [element] doesn't correspond to a `Declaration`, or if it can't be found in [root].
Declaration? lookUpDeclaration(Element element, AstNode root) {
  // if (element is ExecutableElement) return null;
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  final declaration = node?.thisOrAncestorOfType<Declaration>();
  if (declaration?.declaredElement == element) {
    return declaration;
  }

  return null;
}

/// Returns the AST node that declares the formal parameter [element] within [root].
///
/// Returns null if the [element] doesn't correspond to a formal parameter, or if it can't be found in [root].
FormalParameter? lookUpParameter(Element element, AstNode root) {
  final node = NodeLocator2(element.nameOffset).searchWithin(root);
  final declaration = node?.thisOrAncestorOfType<FormalParameter>();
  if (declaration?.declaredElement == element) {
    return declaration;
  }

  return null;
}

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

Tuple2<SimpleIdentifier, SimpleIdentifier>? getSimpleTargetAndPropertyName(
  Expression node, {
  required bool allowMethodInvocation,
}) {
  if (node is PrefixedIdentifier) {
    return Tuple2(node.prefix, node.identifier);
  }

  if (node is PropertyAccess) {
    final target = node.target;
    if (target is SimpleIdentifier) {
      return Tuple2(target, node.propertyName);
    }
  }
  if (allowMethodInvocation && node is MethodInvocation) {
    final target = node.target;
    if (target is SimpleIdentifier) {
      return Tuple2(target, node.methodName);
    }
  }

  return null;
}

Identifier? getNonCascadedPropertyBeingAccessed(AstNode? node) {
  if (node is! Expression) return null;
  return getSimpleTargetAndPropertyName(node, allowMethodInvocation: true)?.item2;
}

/// An abstraction representing an invocation that looks like calling a property on an object,
/// which does not have a single AST representation.
///
/// For example, it could be a [MethodInvocation], or a [FunctionExpressionInvocation] where the expression is a
/// [PropertyAccess] or [PrefixedIdentifier].
class PropertyInvocation {
  final InvocationExpression invocation;
  final Identifier functionName;
  final Expression? target;
  final Expression? realTarget;
  final bool isNullAware;

  PropertyInvocation({
    required this.invocation,
    required this.functionName,
    required this.target,
    required this.realTarget,
    required this.isNullAware,
  });

  /// Constructs a property invocation represented by [node], throwing if it doesn't represent one.
  ///
  /// If you're unsure whether a node is a property invocation, use [detect] instead.
  factory PropertyInvocation.from(InvocationExpression node) {
    final detected = detect(node);
    if (detected == null) {
      throw ArgumentError.value(node, 'node',
          'Node does not represent a property invocation. Consider using PropertyInvocation.detect instead, which returns a nullable result.');
    }
    return detected;
  }

  /// Returns a property invocation for [node], or `null` if it does not represent one.
  static PropertyInvocation? detect(AstNode node) {
    if (node is! InvocationExpression) return null;

    // TODO(greg) - do we want to restrict target to be certain types? (e.g., rule out `foo.bar.baz()` or `foo().bar()`)
    //  or should that go in isInvocationADiscreteDependency?

    // TODO(greg) detect .call?
    if (node is MethodInvocation) {
      return PropertyInvocation(
        invocation: node,
        functionName: node.methodName,
        target: node.target,
        realTarget: node.realTarget,
        isNullAware: node.isNullAware,
      );
    }

    // FunctionExpressionInvocation cases
    final function = node.function;
    if (function is PropertyAccess) {
      return PropertyInvocation(
        invocation: node,
        functionName: function.propertyName,
        target: function.target,
        realTarget: function.realTarget,
        // TODO(greg) this might not ever this ever be true except for the .call case
        isNullAware: function.isNullAware,
      );
    } else if (function is PrefixedIdentifier) {
      return PropertyInvocation(
        invocation: node,
        functionName: function.identifier,
        target: function.prefix,
        realTarget: function.prefix,
        isNullAware: false,
      );
    }
    return null;
  }

  /// Returns the closest property invocation, starting with [node] and working up its ancestors, that can be
  /// [detect]ed, or null if there is none.
  static PropertyInvocation? detectClosest(AstNode node) =>
      detect(node) ?? node.ancestors.map(detect).whereNotNull().firstOrNull;
}

/// Returns all the identifiers in [root] that represent a resolved reference to [element].
List<SimpleIdentifier> allResolvedReferencesTo(Element element, AstNode root) {
  final visitor = _ReferenceVisitor(element);
  root.accept(visitor);
  return visitor.references;
}

class _ReferenceVisitor extends RecursiveAstVisitor<void> {
  final Element _targetElement;

  final List<SimpleIdentifier> references = [];

  _ReferenceVisitor(this._targetElement);

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    super.visitSimpleIdentifier(node);

    if (node.staticElement == _targetElement) {
      references.add(node);
    }
  }
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

  // TODO(greg) ancestorDeclaration might be better?
  FunctionDeclaration? get parentDeclaration => parentExpression?.parentDeclaration;

  MethodDeclaration? get parentMethod => parent?.tryCast();

  String get functionNameOrDescription {
    final name = parentExpression?.parentDeclaration?.name.lexeme;
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

extension AstNodeRangeHelper on AstNode {
  bool containsRangeOf(AstNode other) => other.offset >= offset && other.end <= end;
}

extension EmptyIdentifier on Expression {
  /// Whether this is an identifier with no name, usually stubbed in by the
  /// parser in response to invalid syntax.
  ///
  /// Example:
  ///
  /// ```dart
  /// // '..foo = '
  /// print(assignmentExpressionWithNoRhs.toSource());
  ///
  /// // 'true'
  /// print(assignmentExpressionWithNoRhs.rightHandSide.isEmdtyIdentifier);
  /// ```
  bool get isEmptyIdentifier {
    final self = this;
    return self is SimpleIdentifier && self.name == '';
  }
}
