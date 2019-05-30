// This file is based on over_react_format's FluentComponentUsage

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// A usage of an OverReact component via its fluent interface.
class FluentComponentUsage {
  FluentComponentUsage._(this.node, this.cascadeExpression, this.builder);

  /// The top-level node of this usage.
  final InvocationExpression node;

  /// The cascade of this usage (unwrapped from parens), or `null` if it doesn't have one.
  final CascadeExpression cascadeExpression;

  /// The expression upon which the cascade is performed,
  /// and that is invoked with children to build the component.
  ///
  /// E.g., `Dom.div()`, `Button()`, `builder`
  ///
  /// Usually a [MethodInvocation] or [Identifier].
  final Expression builder;

  String get componentName {
    final typeName = builder.staticType?.name;
    if (typeName == null) return null;
    if (const ['dynamic', 'UiProps'].contains(typeName)) return null;
    if (isDom) {
      if (builder is MethodInvocation) {
        return (builder as MethodInvocation).methodName.name;
      }
      // unknown, not a direct method invocation on `Dom`
      return null;
    }
    if (typeName.endsWith('Props')) {
      return typeName.substring(0, typeName.length - 'Props'.length);
    }

    return null;
  }

  bool get isDom => const ['DomProps', 'SvgProps'].contains(builder.staticType?.name);
  bool get isSvg => const ['SvgProps'].contains(builder.staticType?.name);


  /// Whether the invocation contains one or more children passed as arguments instead of a list.
  bool get hasVariadicChildren =>
      node.argumentList.arguments.isNotEmpty &&
      node.argumentList.arguments.first is! ListLiteral;

  /// The number of child arguments passed into the invocation.
  int get childArgumentCount => node.argumentList.arguments.length;
}

/// Returns the OverReact fluent interface component for the invocation expression [node],
/// or `null` if it doesn't represent one.
///
/// Fluent interface usages that are detected:
///
/// * `Dom.*()`, optionally namespaced with a named import
///     * e.g., `Dom.h1()`, `over_react.Dom.h1()`
/// * Capitalized factory invocations, optionally namespaced with a named import
///     * e.g., `Foo()`, `bar_library.Foo()`
/// * `*Factory*()`
///     * e.g., `customButtonFactory()`
/// * `*Builder*()`
///     * e.g., `getButtonBuilder()`
/// * `*builder*`
///     * e.g., `var buttonBuilder = Button();`
FluentComponentUsage getComponentUsage(InvocationExpression node) {
  var functionExpression = node.function;

  Expression builder;
  CascadeExpression cascadeExpression;

  if (functionExpression is ParenthesizedExpression) {
    var expression = functionExpression.expression;
    if (expression is CascadeExpression) {
      cascadeExpression = expression;
      builder = expression.target;
    } else {
      builder = expression;
    }
  } else {
    builder = functionExpression;
  }

  bool isComponent;
  if (builder.staticType != null) {
    // Resolved AST
    isComponent = builder.staticType.name?.endsWith('Props') ?? false;
  } else {
    // Unresolved AST (or type wasn't available)
    isComponent = false;

    if (builder is MethodInvocation) {
      String builderName;
      if (builder.target != null) {
        builderName = builder.target.toSource() + '.' + builder.methodName.name;
      } else {
        builderName = builder.methodName.name;
      }

      if (builderName != null) {
        isComponent =
            new RegExp(r'(?:^|\.)Dom\.[a-z0-9]+$').hasMatch(builderName) ||
            new RegExp(r'factory|builder', caseSensitive: false)
                .hasMatch(builderName) ||
            new RegExp(r'(?:^|\.)[A-Z][^\.]*$').hasMatch(builderName);
      }
    } else if (builder is Identifier) {
      isComponent =
          new RegExp(r'builder', caseSensitive: false).hasMatch(builder.name);
    }
  }

  if (!isComponent) return null;

  return new FluentComponentUsage._(node, cascadeExpression, builder);
}

/// A visitor that detects whether a given node is a [FluentComponentUsage].
class ComponentDetector extends SimpleAstVisitor<void> {
  bool detected = false;

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    return visitInvocationExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    return visitInvocationExpression(node);
  }

  @override
  void visitParenthesizedExpression(ParenthesizedExpression node) {
    // Recursively traverse parentheses, in case there are extra parens on the component.
    node.visitChildren(this);

    return null;
  }

  void visitInvocationExpression(InvocationExpression node) {
    if (getComponentUsage(node) != null) {
      detected = true;
    }

    return null;
  }
}

/// Returns whether there is an OverReact component usage within [arguments].
///
/// Usages that aren't directly arguments (nested within other structures) are not detected.
bool hasChildComponent(ArgumentList arguments) {
  var detector = new ComponentDetector();
  arguments.visitChildren(detector);

  return detector.detected;
}




/// Attempt to find and return the closest expression that encloses the [node]
/// and is an independent Flutter `Widget`.  Return `null` if nothing found.
FluentComponentUsage identifyUsage(AstNode node) {
  for (; node != null; node = node.parent) {
    if (node is InvocationExpression) {
      final usage = getComponentUsage(node);
      if (usage != null) {
        return usage;
      }
    }
    if (node is ArgumentList || node is Statement || node is FunctionBody) {
      return null;
    }
  }
  return null;
}
