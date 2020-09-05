// Adapted from https://github.com/facebook/react/blob/master@%7B2020-08-05%2000:00%7D/packages/eslint-plugin-react-hooks/src/RulesOfHooks.js

// Copyright (c) Facebook, Inc. and its affiliates.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
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
            "outside of a function. React Hooks must be called in a "
            "React function component or a custom React Hook function.");
        continue;
      }
      // todo look for tearOff usages as well! e.g., .map

      if (body.isFunctionComponent || body.isCustomHook) {
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
            });
        if (isWithinCondition) {
          addErrorForHook("React Hook '${hook.hookName}' is called "
              "conditionally. React Hooks must be called in the exact "
              "same order in every component render.");
          continue;
        }

        final isPotentiallyShortCircuited = body !=
            hook.node.thisOrAncestorMatching((ancestor) {
              if (ancestor == body) return true;

              // Short-circuiting binary expression
              if (ancestor is BinaryExpression && const {
                TokenType.QUESTION_QUESTION,
                TokenType.BAR_BAR,
                TokenType.AMPERSAND_AMPERSAND,
              }.contains(ancestor.operator.type) && (ancestor.rightOperand?.containsRangeOf(hook.node) ?? false)) {
                return true;
              }


              if (ancestor is AssignmentExpression) {
                // Short-circuiting assignment expression
                if (const {
                  TokenType.QUESTION_QUESTION_EQ,
                  TokenType.BAR_BAR_EQ,
                  TokenType.AMPERSAND_AMPERSAND_EQ,
                }.contains(ancestor.operator.type) && (ancestor.rightHandSide?.containsRangeOf(hook.node) ?? false)) {
                  return true;
                }
                // Null-aware assignment expression
                if (ancestor.leftHandSide.tryCast<PropertyAccess>()?.isNullAware ?? false) {
                  return true;
                }
              }

              // Null-awares (besides `??` and assignnments, handled above)
              // TODO handle null-shorting in nnbd
              if ((ancestor is CascadeExpression && ancestor.isNullAware) ||
                  (ancestor is IndexExpression && ancestor.isNullAware) ||
                  (ancestor is MethodInvocation && ancestor.isNullAware) ||
                  (ancestor is PropertyAccess && ancestor.isNullAware) ||
                  (ancestor is SpreadElement && ancestor.isNullAware)) {
                return true;
              }

              // In these cases we have to traverse back down the AST:
              //
              // - `foo?.bar()` (should be a MethodInvocation?)
              // - `foo.bar?.baz()`
              // TODO check all of the LHS for null-shorting instead of just parts of it?
              if (ancestor is FunctionExpressionInvocation) {
                if (ancestor.function.tryCast<PropertyAccess>()?.isNullAware ?? false) {
                  return true;
                }
              }

              return false;
            });
        if (isPotentiallyShortCircuited) {
          addErrorForHook("React Hook '${hook.hookName}' is called "
              "conditionally due to short-circuiting. React Hooks must be called in the exact "
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

extension on AstNode {
  bool containsRangeOf(AstNode other) => other.offset >= offset && other.end <= end;
}

class HookUsage {
  final MethodInvocation node;

  HookUsage(this.node);

  String get hookName => node.methodName.name;

  FunctionBody get nearestFunctionBody =>
      node.thisOrAncestorOfType<FunctionBody>();
}

extension on FunctionBody {
  FunctionExpression get parentExpression => parent?.tryCast();
  FunctionDeclaration get parentDeclaration => parentExpression?.parentDeclaration;
  MethodDeclaration get parentMethod => parent?.tryCast();

  bool get isFunctionComponent {
    // Function expression or top-level function
    // Perform a crude/lenient check for function components since they can take on so many forms
    // fixme make this way better
    if (parentExpression
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

  bool get isCustomHook {
    final declaration = parentDeclaration;
    return declaration != null && isHookName(declaration.name.name);
  }
}

extension on FunctionExpression {
  FunctionDeclaration get parentDeclaration => parent?.tryCast();
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
