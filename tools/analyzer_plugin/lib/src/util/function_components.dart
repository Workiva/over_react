import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'ast_util.dart';
import 'util.dart';

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

class FunctionComponentVisitor extends GeneralizingAstVisitor<void> {
  final void Function(FunctionBody) onFunctionComponent;

  FunctionComponentVisitor(this.onFunctionComponent);

  // final _functionComponentBodyStack = <FunctionBody>[];

  @override
  void visitFunctionBody(FunctionBody node) {
    // final isFunctionComponentBody = isFunctionComponent(node);
    // if (isFunctionComponentBody) {
    //   _functionComponentBodyStack.add(node);
    // }
    // super.visitFunctionBody(node);
    // if (isFunctionComponentBody) {
    //   final popped = _functionComponentBodyStack.removeLast();
    //   assert(popped == node);
    // }

    if (isFunctionComponent(node)) {
      onFunctionComponent(node);
    }

    super.visitFunctionBody(node);
  }
}
