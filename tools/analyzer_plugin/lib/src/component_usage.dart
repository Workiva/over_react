// Adapted from https://github.com/Workiva/over_react_codemod/blob/2.1.1/lib/src/util/component_usage.dart

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'util/util.dart';
import 'util/ast_util.dart';
import 'util/react_types.dart';

/// A usage of an OverReact component via its fluent interface.
class FluentComponentUsage {
  FluentComponentUsage._(this.node, this.cascadeExpression, this.builder);

  /// The top-level node of this usage.
  final InvocationExpression node;

  /// The cascade of this usage (unwrapped from parens), or `null` if it doesn't have one.
  final CascadeExpression? cascadeExpression;

  /// The expression upon which the cascade is performed,
  /// and that is invoked with children to build the component.
  ///
  /// E.g., `Dom.div()`, `Button()`, `builder`
  ///
  /// Usually a [MethodInvocation] or [Identifier].
  final Expression builder;

  /// The factory of this usage, or `null` if it does not have one.
  ///
  /// E.g., `Dom.div` for `Dom.div()()`, `Button` for `Button()()`,
  /// `null` for `builder()`
  Expression? get factory => builder.tryCast<InvocationExpression>()?.function;

  /// Whether this usage's builder and all descendant expressions (including the
  /// factory, if it exists) have fully resolved static information available.
  bool get isBuilderResolved => !hasUnresolvedOrDynamicReferences(builder);

  /// The top-level variable element for this usage's factory, or `null` if either:
  ///
  /// - the AST for this usage is not resolved
  /// - there is no factory
  /// - the factory's static element is either a reference to a non-top-level variable or another expression
  TopLevelVariableElement? get factoryTopLevelVariableElement {
    final factory = this.factory;
    if (factory is Identifier) {
      final staticElement = factory.staticElement;
      VariableElement? variable;
      if (staticElement is VariableElement) {
        variable = staticElement;
      } else if (staticElement is PropertyAccessorElement) {
        variable = staticElement.variable;
      }
      if (variable is TopLevelVariableElement) {
        return variable;
      }
    }

    return null;
  }

  /// The static type of this usage's builder, or `null` if this usage is not fully resolved.
  DartType? get builderType {
    if (!hasUnresolvedOrDynamicReferences(builder)) {
      return builder.staticType;
    }
    return null;
  }

  /// The class element for the builder's props class (or, for parameterized types
  /// the bound of that type), or `null` if this usage is not fully resolved.
  ClassElement? get propsClassElement =>
      builderType?.typeOrBound.tryCast<InterfaceType>()?.element;

  /// The name of the builder's props class (or, for parameterized types
  /// the bound of that type), or `null` if this usage is not fully resolved.
  String? get propsName => propsClassElement?.name;

  /// The name of the component, derived from either:
  ///
  /// - the static top-level factory variable (if applicable)
  /// - the name of the builder's props class (if resolved)
  /// - the unresolved source of the factory
  ///
  /// or `null` if this usage does not have a factory.
  String? get componentName {
    final factoryTopLevelVariableElement = this.factoryTopLevelVariableElement;
    if (factoryTopLevelVariableElement != null) {
      return factoryTopLevelVariableElement.name;
    }

    final builder = this.builder;
    if (builder is MethodInvocation) {
      final methodElement =
          builder.methodName.staticElement?.tryCast<MethodElement>();
      if (methodElement != null && methodElement.isStatic) {
        final className = methodElement.enclosingElement.name;
        if (className != null) {
          return className + '.' + builder.methodName.name;
        }
      }
    }

    final propsName = this.propsName;
    if (propsName != null &&
        !const {'dynamic', 'UiProps'}.contains(propsName)) {
      // Some props classes have an extra "Component" part in their name.
      return propsName.replaceFirst(RegExp(r'(Component)?Props$'), '');
    }

    return _getUnresolvedComponentName(builder);
  }

  /// Whether this usage is a DOM/SVG component.
  bool get isDom => const {'DomProps', 'SvgProps'}.contains(propsName);

  /// Whether this usage is an SVG component.
  bool get isSvg => const {'SvgProps'}.contains(propsName);

  /// The children of this usage.
  Iterable<ComponentChild> get children sync* {
    final arguments = node.argumentList.arguments;

    if (arguments.length == 1) {
      final singleArgument = arguments[0];
      if (singleArgument is ListLiteral) {
        for (final element in singleArgument.elements) {
          if (element is Expression) {
            yield ExpressionComponentChild(element, isVariadic: false);
          } else {
            // IfElement|ForElement|SpreadElement
            yield CollectionElementComponentChild(element);
          }
        }
        return;
      }
    }

    for (final child in arguments) {
      yield ExpressionComponentChild(child, isVariadic: true);
    }
  }

  List<Expression> get cascadeSections =>
      cascadeExpression?.cascadeSections ?? const [];

  /// The prop assignments cascaded on this usage's builder.
  ///
  /// See also: other `cascaded`* methods in this class.
  Iterable<PropAssignment> get cascadedProps => cascadeSections
      .whereType<AssignmentExpression>()
      .where((assignment) => assignment.leftHandSide is PropertyAccess)
      .map((assignment) => PropAssignment(assignment));

  /// The prop reads cascaded on this usage's builder.
  ///
  /// See also: other `cascaded`* methods in this class.
  Iterable<PropRead> get cascadedGetters =>
      cascadeSections.whereType<PropertyAccess>().map((p) => PropRead(p));

  /// The index prop assignments cascaded on this usage's builder.
  ///
  /// See also: other `cascaded`* methods in this class.
  Iterable<IndexPropAssignment> get cascadedIndexAssignments => cascadeSections
      .whereType<AssignmentExpression>()
      .where((assignment) => assignment.leftHandSide is IndexExpression)
      .map((assignment) => IndexPropAssignment(assignment));

  /// The method calls cascaded on this usage's builder.
  ///
  /// See also: other `cascaded`* methods in this class.
  Iterable<BuilderMethodInvocation> get cascadedMethodInvocations =>
      cascadeSections
          .whereType<MethodInvocation>()
          .map((methodInvocation) => BuilderMethodInvocation(methodInvocation));

  /// All the cascades on this usage's builder, each wrapped in one of the
  /// [BuilderMemberAccess] subtypes.
  ///
  /// See also: other `cascaded`* methods in this class.
  List<BuilderMemberAccess> get cascadedMembers {
    final allHandledMembers = [
      ...cascadedProps,
      ...cascadedGetters,
      ...cascadedIndexAssignments,
      ...cascadedMethodInvocations,
    ];

    final allUnhandledMembers = cascadeSections
        .where((section) => !allHandledMembers.any((m) => m.node == section))
        .map((section) => OtherBuilderMemberAccess(section))
        .toList();

    return [
      ...allHandledMembers,
      ...allUnhandledMembers,
    ]
      // Order them in the order they appear by sorting based on the offset.
      ..sort((a, b) => a.node.offset.compareTo(b.node.offset));
  }
}

/// A child of a component usage.
///
/// Will be either an instance of:
/// - [ExpressionComponentChild]
/// - [CollectionElementComponentChild] (more of an edge case)
abstract class ComponentChild {
  /// The root node of the child.
  AstNode get node;
}

/// A child declared as a [CollectionElement] within a single list literal argument
/// to a component usage.
///
/// Example:
/// ```dart
/// Dom.div()([
///   // ExpressionComponentChild
///   'foo',
///   // CollectionElementComponentChild
///   if (condition) 'bar',
/// ])
/// ```
class CollectionElementComponentChild implements ComponentChild {
  @override
  final CollectionElement node;

  CollectionElementComponentChild(this.node);
}

/// A child declared as an expression either as a variadic argument to an invocation,
/// or an item within a single list literal argument to a component usage.
///
/// Example:
/// ```dart
/// Dom.div()([
///   // ExpressionComponentChild isVariadic=false
///   'foo',
///   // CollectionElementComponentChild
///   if (condition) 'bar',
/// ]);
///
/// Dom.div()(
///   // ExpressionComponentChild isVariadic=true
///   'foo',
///   // ExpressionComponentChild isVariadic=true
///   'bar',
/// );
/// ```
class ExpressionComponentChild implements ComponentChild {
  @override
  final Expression node;

  /// Whether this child is passed in as a direct argument to a component
  /// usage invocation, as opposed to within a single list argument.
  ///
  /// Example:
  /// ```dart
  /// Dom.div()([
  ///   // isVariadic=false
  ///   'foo',
  ///   // isVariadic=false
  ///   'bar',
  /// ]);
  ///
  /// Dom.div()(
  ///   // isVariadic=true
  ///   'foo',
  ///   // isVariadic=true
  ///   'bar',
  /// );
  /// ```
  final bool isVariadic;

  ExpressionComponentChild(this.node, {required this.isVariadic});
}

/// Returns the type category for an expression based on its static type.
///
/// See [ReactNodeTypeCategory] for more information.
ReactNodeTypeCategory typeCategoryForReactNode(Expression node) {
  final staticType = node.staticType;
  if (staticType == null) {
    return ReactNodeTypeCategory.unknown;
  }

  if (staticType.isReactElement) {
    return ReactNodeTypeCategory.reactElement;
  }

  if (staticType.isDartCoreString ||
      staticType.isDartCoreBool ||
      staticType.isDartCoreNum ||
      staticType.isDartCoreInt ||
      staticType.isDartCoreDouble ||
      staticType.isDartCoreNull) {
    return ReactNodeTypeCategory.primitive;
  }

  return ReactNodeTypeCategory.other;
}

/// A category of types that make up `ReactNode` (the union type of values
/// that can be returned from `render` in React components, passed as children,
/// or passed into top-level `react_dom.render` calls).
enum ReactNodeTypeCategory {
  /// The static type is not available.
  unknown,

  /// The type is a primitive Dart type: string, boolean, number, or null.
  primitive,

  /// The type is `ReactElement`.
  reactElement,

  /// The type is some other type.
  other,
}

/// An access of a member on a [FluentComponentUsage] builder,
/// typically cascaded.
///
/// Will be one of the following subtypes:
/// - [PropAssignment]
/// - [IndexPropAssignment]
/// - [PropRead]
/// - [BuilderMethodInvocation]
/// - [OtherBuilderMemberAccess]
abstract class BuilderMemberAccess {
  Expression get node;

  /// Whether this access is part of a cascade on the builder.
  bool get isInCascade => parentCascade != null;

  /// The parent cascade on the builder, if it exists.
  CascadeExpression? get parentCascade => node.parent.tryCast();
}

/// An access of a [FluentComponentUsage] builder member whose expression type
/// is not explicitly handled by another BuilderMemberAccess subtype.
class OtherBuilderMemberAccess extends BuilderMemberAccess {
  @override
  final Expression node;

  OtherBuilderMemberAccess(this.node);
}

/// A read of a property (usually a prop) on a [FluentComponentUsage] builder.
class PropRead extends BuilderMemberAccess {
  @override
  final PropertyAccess node;

  PropRead(this.node);

  /// The name of the property being read.
  Identifier get name => node.propertyName;
}

/// A method invocation on a [FluentComponentUsage] builder.
class BuilderMethodInvocation extends BuilderMemberAccess {
  @override
  final MethodInvocation node;

  BuilderMethodInvocation(this.node);

  /// The name of the method being invoked.
  Identifier get methodName => node.methodName;
}

/// An assignment of a property (usually a prop) on a [FluentComponentUsage] builder.
abstract class PropAssignment extends BuilderMemberAccess {
  factory PropAssignment(AssignmentExpression node) {
    if (node.leftHandSide is PropertyAccess) {
      return _PropertyAccessPropAssignment(node);
    }

    throw ArgumentError.value(
      node.leftHandSide,
      'node.leftHandSide',
      'Unhandled LHS node type',
    );
  }

  PropAssignment._();

  /// The name of the prop being assigned,
  /// or of the property on a prop being assigned.
  ///
  /// For example:
  /// - `prop` for `Foo()..prop = ...`
  /// - `id` for `Foo()..dom.id = ...`
  ///
  /// See also: [prefix], [target]
  SimpleIdentifier get name;

  /// The prefix of this prop assignment.
  ///
  /// For example, the value of `targetName.name` in the expression below is "aria":
  ///
  /// ```dart
  /// ..aria.label = 'foo'
  /// ```
  ///
  /// See also: [name], [target]
  SimpleIdentifier? get prefix;

  /// Whether the prop assignment is prefixed.
  bool get isPrefixed => prefix != null;

  /// The object on which a property is being assigned.
  ///
  /// Could be:
  /// - a factory invocation expression (`Foo()` in `Foo()..prop = ...`)
  /// - a builder expression (`builder` in `builder..prop = ...`)
  /// - a prop being assigned to (`..dom` in `Foo()..dom.id = ...`)
  ///
  /// See also: [name], [prefix]
  Expression get target;

  /// The cascaded assignment expression that backs this assignment.
  @override
  AssignmentExpression get node;

  /// The property access representing the left hand side of this assignment.
  Expression get leftHandSide => node.leftHandSide;

  /// The expression for the right hand side of this assignment.
  Expression get rightHandSide => node.rightHandSide;
}

class _PropertyAccessPropAssignment extends PropAssignment {
  /// The cascaded assignment expression that backs this assignment.
  @override
  final AssignmentExpression node;

  _PropertyAccessPropAssignment(this.node)
      : assert(node.leftHandSide is PropertyAccess),
        super._();

  /// The property access representing the left hand side of this assignment.
  @override
  PropertyAccess get leftHandSide => node.leftHandSide as PropertyAccess;

  @override
  SimpleIdentifier get name => leftHandSide.propertyName;

  @override
  Expression get target => leftHandSide.realTarget;

  @override
  SimpleIdentifier? get prefix =>
      leftHandSide.target?.tryCast<PropertyAccess>()?.propertyName;
}

/// An assignment of a property using `operator[]=` on a [FluentComponentUsage] builder.
///
/// For example, `..['data-foo'] = 'bar'`
class IndexPropAssignment extends BuilderMemberAccess {
  /// The cascaded assignment expression that backs this assignment.
  @override
  final AssignmentExpression node;

  IndexPropAssignment(this.node) {
    if (node.leftHandSide is! IndexExpression) {
      throw ArgumentError.value(
        node.leftHandSide,
        'node.leftHandSide',
        'Must be an IndexExpreesion',
      );
    }
  }

  /// The property access representing the left hand side of this assignment.
  IndexExpression get leftHandSide => node.leftHandSide as IndexExpression;

  /// The index being assigned to.
  Expression get index => leftHandSide.index;

  /// The expression for the right hand side of this assignment.
  Expression get rightHandSide => node.rightHandSide;
}

/// Returns whether [expression] or any of its descendants contain references
/// that either:
///
/// 1. are not fully resolved
/// 2. represent members accessed on `dynamic` expressions (e.g., `dynamicVar.foo`)
///
/// Unfortunately, it's difficult to distinguish between the two and only detect
/// unresolved references.
///
/// If dynamic member accesses are rare, this can a more accurate alternative
/// than just checking for [Expression.staticType], since that often shows up
/// as `dynamic` in resolved contexts when something doesn't fully resolve.
bool hasUnresolvedOrDynamicReferences(Expression expression) {
  if (expression.staticType == null) return true;

  final visitor = _ResolvedExpressionVisitor();
  expression.accept(visitor);
  return visitor.hasUnresolvedOrDynamicReferences;
}

class _ResolvedExpressionVisitor extends GeneralizingAstVisitor<void> {
  var hasUnresolvedOrDynamicReferences = false;

  @override
  visitIdentifier(Identifier node) {
    super.visitIdentifier(node);

    if (node.staticElement == null) {
      hasUnresolvedOrDynamicReferences = true;
    }
  }

  @override
  visitInvocationExpression(InvocationExpression node) {
    super.visitInvocationExpression(node);

    if (node.staticInvokeType == null) {
      hasUnresolvedOrDynamicReferences = true;
    }
  }
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
FluentComponentUsage? getComponentUsage(InvocationExpression node) {
  var functionExpression = node.function;

  Expression builder;
  CascadeExpression? cascadeExpression;

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

  // Method names that might look like builders to the name regexes, but we want to exclude.
  // Excluding these known usages is easier than trying to differentiate unresolved calls
  // from dynamic calls.
  const methodNameBlockList = {
    // built_value's `Built.toBuilder`
    'toBuilder',
  };

  final bool isComponent;

  // Can't just check for staticType since if we're in an attempted-to-be-resolved AST
  // but something goes wrong, we'll get dynamic.
  if (!hasUnresolvedOrDynamicReferences(builder)) {
    // Resolved AST
    isComponent = builder.staticType!.isPropsClass;
  } else {
    // Unresolved AST (or type wasn't available)

    if (builder is MethodInvocation) {
      if (methodNameBlockList.contains(builder.methodName.name)) {
        isComponent = false;
      } else {
        final builderName = _getUnresolvedComponentName(builder);
        if (builderName != null) {
          isComponent =
              RegExp(r'(?:^|\.)Dom\.[a-z0-9]+$').hasMatch(builderName) ||
                  RegExp(r'factory|builder', caseSensitive: false)
                      .hasMatch(builderName) ||
                  RegExp(r'(?:^|\.)[A-Z][^\.]*$').hasMatch(builderName);
        } else {
          isComponent = false;
        }
      }
    } else if (builder is Identifier) {
      final parent = builder.parent;
      if (parent is MethodInvocation &&
          parent.methodName == builder &&
          methodNameBlockList.contains(builder.name)) {
        isComponent = false;
      } else {
        isComponent =
            RegExp(r'builder', caseSensitive: false).hasMatch(builder.name);
      }
    } else {
      isComponent = false;
    }
  }

  if (!isComponent) return null;

  return FluentComponentUsage._(node, cascadeExpression, builder);
}

FluentComponentUsage? getComponentUsageFromExpression(Expression node) {
  return node is InvocationExpression ? getComponentUsage(node) : null;
}

String? _getUnresolvedComponentName(Expression builder) {
  if (builder is MethodInvocation) {
    String builderName;
    if (builder.target != null) {
      builderName = builder.target!.toSource() + '.' + builder.methodName.name;
    } else {
      builderName = builder.methodName.name;
    }
    return builderName;
  }
  return null;
}

/// A visitor that detects whether a given node is a [FluentComponentUsage].
class _ComponentDetector extends SimpleAstVisitor<void> {
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
  }

  void visitInvocationExpression(InvocationExpression node) {
    if (getComponentUsage(node) != null) {
      detected = true;
    }
  }
}

/// Returns whether there is an OverReact component usage within [arguments].
///
/// Usages that aren't directly arguments (nested within other structures) are not detected.
bool hasChildComponent(ArgumentList arguments) {
  var detector = _ComponentDetector();
  arguments.visitChildren(detector);

  return detector.detected;
}

/// Attempt to find and return the closest expression that encloses the [node]
/// and is an independent Flutter `Widget`.  Return `null` if nothing found.
FluentComponentUsage? identifyUsage(AstNode? node) {
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

class ComponentUsageVisitor extends RecursiveAstVisitor<void> {
  ComponentUsageVisitor(this.onComponent);

  final void Function(FluentComponentUsage) onComponent;

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    visitInvocationExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    visitInvocationExpression(node);
  }

  void visitInvocationExpression(InvocationExpression node) {
    var usage = getComponentUsage(node);
    if (usage != null) {
      onComponent(usage);
    }

    node.visitChildren(this);
  }
}


extension DomNodeName on FluentComponentUsage {
  String? get domNodeName {
    if (!isDom) return null;

    final componentName = this.componentName;
    if (componentName == null) return null;

    final nodeNameMatch = RegExp(r'\bDom.(\w+)$').firstMatch(componentName);
    if (nodeNameMatch == null) return null;

    return nodeNameMatch.group(1)!;
  }
}

/// Returns all component usages in [node] and its descendants.
List<FluentComponentUsage> getAllComponentUsages(AstNode node) {
  final usages = <FluentComponentUsage>[];
  node.accept(ComponentUsageVisitor(usages.add));
  return usages;
}
