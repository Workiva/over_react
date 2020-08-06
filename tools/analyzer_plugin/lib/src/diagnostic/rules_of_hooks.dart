// Adapted from https://github.com/facebook/react/blob/master@%7B2020-08-05%2000:00%7D/packages/eslint-plugin-react-hooks/src/RulesOfHooks.js

// Copyright (c) Facebook, Inc. and its affiliates.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

final _hookNamePattern = RegExp(r'^use[A-Z0-9].*$');

/// Catch all identifiers that begin with "use" followed by an uppercase Latin
/// character to exclude identifiers like "user".
bool isHookName(String s) => _hookNamePattern.hasMatch(s);

class RulesOfHooks extends DiagnosticContributor {
  @DocsMeta('Enforces the Rules of Hooks', details: '')
  static const code = DiagnosticCode(
    'over_react_rules_of_hooks',
    "{0}",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_WARNING,
    url: 'https://reactjs.org/docs/hooks-rules.html',
  );

  @override
  Future<void> computeErrors(result, collector) async {
    final visitor = HooksUsagesVisitor();
    result.unit.accept(visitor);
    for (final hook in visitor.hookUsages) {
      void addErrorForHook(String message) =>
          collector.addError(code, result.locationFor(hook.node),
              errorMessageArgs: [message]);

      final body = hook.nearestFunctionBody;

      if (body == null) {
        addErrorForHook("React Hook '${hook.hookName}' cannot be called "
            "at the top level. React Hooks must be called in a "
            "React function component or a custom React Hook function.");
        continue;
      }
      // todo look for tearOff usages as well! e.g., .map

      if (hook.isDirectlyInsideFunctionComponent || hook.isDirectlyInsideHook) {
        // Report an error if a hook may be called more then once.
        final isWithinLoop = body !=
            hook.node.thisOrAncestorMatching((ancestor) {
              return ancestor is ForStatement ||
                  ancestor is WhileStatement ||
                  ancestor is DoStatement ||
                  ancestor is ForElement ||
                  ancestor == body;
            });
        if (isWithinLoop) {
          addErrorForHook(
            "React Hook '${hook.hookName}' may be executed "
            "more than once because it is called in a loop. "
            "React Hooks must be called in the exact same order in "
            "every component render.",
          );
          continue;
        }

        // Report an error if a hook is called conditionally.

        final isWithinCondition = body !=
            hook.node.thisOrAncestorMatching((ancestor) {
              return ancestor is IfStatement ||
                  ancestor is SwitchStatement ||
                  ancestor is ConditionalExpression ||
                  ancestor is IfElement ||
                  ancestor == body;
              // todo what about on RHS of short-circuiting operators like `??`
            });
        if (isWithinCondition) {
          addErrorForHook("React Hook '${hook.hookName}' is called "
              "conditionally. React Hooks must be called in the exact "
              "same order in every component render.");
          continue;
        }

        // Report an error if a hook is called conditionally as a result of early returns.

        final isAfterReturn = body is BlockFunctionBody &&
            body.returnStatements.any((ret) {
              // Ignore any return statements that are not nested within function body and thus not conditional.
              // Hooks after those will show up as dead code via built-in analyzer warnings.
              // todo this isn't working for some reason
              if (ret.parent == body.block) return false;

              return hook.node.offset > ret.offset;
            });
        if (isAfterReturn) {
          addErrorForHook("React Hook '${hook.hookName}' is called "
              "conditionally because it comes after a conditional return statement."
              " React Hooks must be called in the exact "
              "same order in every component render.");
          continue;
        }
      } else if (body.parentMethod != null) {
        // todo fix up message to talk about classes; maybe combine check with previous and say hooks should be top level functions?
        // Custom message for hooks inside a class
        addErrorForHook("React Hook '${hook.hookName}' cannot be called "
            "in a class component. React Hooks must be called in a "
            "React function component or a custom React Hook function.");
      } else if (body.parentExpression?.parentDeclaration != null) {
        // Custom message if we found an invalid function name.
        addErrorForHook("React Hook '${hook.hookName}' is called in "
            "function '${body.parentExpression.parentDeclaration.name.name}' "
            "that is neither a React function component nor a custom "
            "React Hook function."
//                " React component names must start with an uppercase letter."
            " React hook names must start with 'use'.");
      } else {
        // Assume in all other cases the user called a hook in some
        // random function callback. This should usually be true for
        // anonymous function expressions. Hopefully this is clarifying
        // enough in the common case that the incorrect message in
        // uncommon cases doesn't matter.
        // fixme why was this check necessary in the original code?
//        if (isSomewhereInsideComponentOrHook) {
        addErrorForHook("React Hook '${hook.hookName}' cannot be called "
            "inside a callback. React Hooks must be called in a "
            "React function component or a custom React Hook function.");
//        }
      }
    }
  }
}

class HookUsage {
  final MethodInvocation node;

  HookUsage(this.node);

  String get hookName => node.methodName.name;

  FunctionBody get nearestFunctionBody =>
      node.thisOrAncestorOfType<FunctionBody>();

  bool get isDirectlyInsideFunctionComponent {
    return nearestFunctionBody?.isFunctionComponent ?? false;
  }

  bool get isDirectlyInsideHook {
    final functionDeclaration =
        nearestFunctionBody.parentExpression.parentDeclaration;
    return functionDeclaration != null &&
        isHookName(functionDeclaration.name.name);
  }
}

extension on FunctionBody {
  FunctionExpression get parentExpression => parent.tryCast();

  MethodDeclaration get parentMethod => parent.tryCast();

  bool get isFunctionComponent {
    // Function expression or top-level function
    // Perform a crude/lenient check for function components since they can take on so many forms
    // fixme make this way better
    if (parent
            ?.tryCast<FunctionExpression>()
            ?.parameters
            ?.parameters
            ?.any((parameter) {
          return parameter.identifier.name == 'props';
        }) ??
        false) {
      return true;
    }

    // Method/constructor declaration, getter, etc
    return false;
  }
}

extension on FunctionExpression {
  FunctionDeclaration get parentDeclaration => parent.tryCast();
}

class HooksUsagesVisitor extends RecursiveAstVisitor<void> {
  final hookUsages = <HookUsage>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (isHookName(node.methodName.name)) {
      hookUsages.add(HookUsage(node));
    }

    super.visitMethodInvocation(node);
  }
}
