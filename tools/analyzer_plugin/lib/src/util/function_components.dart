import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/util/hooks.dart';

import 'ast_util.dart';
import 'util.dart';

/// A utility class that provides information about a function component.
class FunctionComponent {
  /// The function body.
  final FunctionBody body;

  FunctionComponent(this.body);

  @override
  bool operator ==(other) => other is FunctionComponent && other.body == body;

  @override
  int get hashCode => body.hashCode;

  /// The function component function expression.
  FunctionExpression get functionExpression => body.parentExpression!;

  /// The variable initialized to this function component's factory.
  ///
  /// May be null if the function component is not assigned to a variable,
  /// or is assigned to the variable outside of an initializer.
  VariableDeclaration? get factoryVariable {
    final functionExpression = this.functionExpression;

    final closestVariable = functionExpression.thisOrAncestorOfType<VariableDeclaration>();
    if (closestVariable == null) return null;

    final closestVariableInitializer = closestVariable.initializer;
    if (closestVariableInitializer == null) return null;

    // TODO perform a better check than this, which has false positives in certain cases.
    // As a contrived example: `var something = render(uiFunction((props) {…}, …)());`
    if (closestVariableInitializer.containsRangeOf(functionExpression)) {
      return closestVariable;
    }

    return null;
  }

  /// The name of this function component's factory, if it exists and could be found.
  ///
  /// See [factoryVariable] for more info on when this may be null.
  SimpleIdentifier? get factoryName => factoryVariable?.name;
}

FunctionComponent? getClosestFunctionComponent(AstNode node) {
  final body = getClosestFunctionComponentBody(node);
  return body == null ? null : FunctionComponent(body);
}

FunctionBody? getClosestFunctionComponentBody(AstNode node) =>
    node.ancestors.whereType<FunctionBody>().firstWhereOrNull(isFunctionComponent);

FunctionBody? getClosestFunctionComponentOrHookBody(AstNode node) =>
    node.ancestors.whereType<FunctionBody>().firstWhereOrNull((body) => isFunctionComponent(body) || isCustomHookFunction(body));

/// Returns whether [body] is a React function component body.
///
/// This is determined by checking if it's the body of a function passed into one of the various
/// APIs for creating a function component: `uiFunctionComponent`, `uiForwardRef`, `registerFunctionComponent`, etc.
bool isFunctionComponent(FunctionBody body) {
  final invocationOfFunctionThisIsAnArgTo =
      body.parentExpression?.parent?.tryCast<ArgumentList>()?.parent?.tryCast<InvocationExpression>();

  // ignore: omit_local_variable_types
  final String? nameOfFunctionThisIsAnArgTo =
      // Top-level function invocations (optionally namespaced)
      invocationOfFunctionThisIsAnArgTo?.tryCast<MethodInvocation>()?.methodName.name ??
          // Invocations top-level function variables with namespaced imports (e.g., registerFunctionComponent)
          invocationOfFunctionThisIsAnArgTo
              ?.tryCast<FunctionExpressionInvocation>()
              ?.function
              .tryCast<PrefixedIdentifier>()
              ?.identifier
              .name;

  if (nameOfFunctionThisIsAnArgTo != null) {
    return const {
      // over_react
      'uiFunction',
      'uiForwardRef',
      // react-dart
      'registerFunctionComponent',
      'forwardRef',
      'forwardRef2',
    }.contains(nameOfFunctionThisIsAnArgTo);
  }

  // Method/constructor declaration, getter, etc
  return false;
}

/// Returns all function components in [node] and its descendants.
List<FunctionComponent> getAllFunctionComponents(AstNode node) {
  final components = <FunctionComponent>[];
  node.accept(FunctionComponentVisitor(components.add));
  return components;
}

/// A recursive visitor that calls [onFunctionComponent] for each function component it encounters.
class FunctionComponentVisitor extends GeneralizingAstVisitor<void> {
  final void Function(FunctionComponent) onFunctionComponent;

  FunctionComponentVisitor(this.onFunctionComponent);

  @override
  void visitFunctionBody(FunctionBody node) {
    if (isFunctionComponent(node)) {
      onFunctionComponent(FunctionComponent(node));
    }

    super.visitFunctionBody(node);
  }
}
