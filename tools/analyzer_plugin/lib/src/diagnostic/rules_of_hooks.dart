// Adapted from https://github.com/facebook/react/blob/main@%7B2020-08-05%2000:00%7D/packages/eslint-plugin-react-hooks/src/RulesOfHooks.js
//
// MIT License
//
// Copyright (c) Facebook, Inc. and its affiliates.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/hooks.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Enforces the Rules of Hooks';
// <editor-fold desc="Documentation Details">
const _details = r'''

This diagnostic enforces the Rules of Hooks.

From the React [the React Rules of Hooks docs](https://reactjs.org/docs/hooks-rules.html):

> Hooks are a new addition in React 16.8. They let you use state and other React features without writing a class.
> 
> Hooks are JavaScript functions, but you need to follow two rules when using them.
> 
> ### Only Call Hooks at the Top Level
> Don’t call Hooks inside loops, conditions, or nested functions. Instead, always use Hooks at the top level of your React function, before any early returns. 
> By following this rule, you ensure that Hooks are called in the same order each time a component renders. 
> That’s what allows React to correctly preserve the state of Hooks between multiple `useState` and `useEffect` calls. (If you’re curious, we’ll explain this in depth below.)
> 
> ### Only Call Hooks from React Functions
> Don’t call Hooks from regular JavaScript functions. Instead, you can:
> 
> - ✅ Call Hooks from React function components.
> - ✅ Call Hooks from custom Hooks (we’ll learn about them on the next page).
>
> By following this rule, you ensure that all stateful logic in a component is clearly visible from its source code.

''';
// </editor-fold>
class RulesOfHooks extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_rules_of_hooks',
    "{0}",
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.STATIC_WARNING,
    url: 'https://reactjs.org/docs/hooks-rules.html',
  );

  @override
  List<DiagnosticCode> get codes => [code];

  @override
  Future<void> computeErrors(result, collector) async {
    for (final hook in getAllHookUsages(result.unit!)) {
      const sameOrderMessage = "React Hooks must be called in the exact same order in every component render.";
      const mustBeCalledInMessage =
          "React Hooks must be called in a React function component or a custom React Hook function.";

      void addErrorForHook(String message) =>
          collector.addError(code, result.locationFor(hook.node), errorMessageArgs: [message]);

      final body = hook.node.thisOrAncestorOfType<FunctionBody>();
      if (body == null) {
        addErrorForHook("React Hook '${hook.hookName}' cannot be called outside of a function. $mustBeCalledInMessage");
      } else if (isFunctionComponent(body) || isCustomHookFunction(body)) {
        // Validate that the order of this hook is the same every call.
        String? errorMessage;
        if (_isWithinLoop(body, hook)) {
          errorMessage = "may be executed more than once because it is called in a loop.";
        } else if (_isWithinCondition(body, hook)) {
          errorMessage = "is called conditionally.";
        } else if (_isPotentiallyShortCircuited(body, hook)) {
          errorMessage = "is called conditionally due to short-circuiting.";
        } else if (_isAfterConditionalReturn(body, hook)) {
          errorMessage = "is called conditionally because it comes after a conditional return statement.";
        }

        if (errorMessage != null) {
          addErrorForHook("React Hook '${hook.hookName}' $errorMessage $sameOrderMessage");
        }
      } else if (body.parentMethod != null) {
        // Custom message for hooks inside a class
        addErrorForHook("React Hook '${hook.hookName}' cannot be called in a class or class component."
            " $mustBeCalledInMessage");
      } else if (body.parentDeclaration != null) {
        // Custom message if we found an invalid function name.
        addErrorForHook("React Hook '${hook.hookName}' is called in function '${body.functionNameOrDescription}'"
            " that is neither a React function component nor a custom React Hook function."
            " React function components must be declared using 'uiFunction' or 'uiForwardRef' in over_react,"
            " or using 'registerFunctionComponent' or 'forwardRef2' in react-dart."
            " React hook names must start with 'use'.");
      } else {
        // Assume in all other cases the user called a hook in some
        // random function callback. This should usually be true for
        // anonymous function expressions. Hopefully this is clarifying
        // enough in the common case that the incorrect message in
        // uncommon cases doesn't matter.
        // fixme why was this check necessary in the original code?
//        if (isSomewhereInsideComponentOrHook) {
        addErrorForHook("React Hook '${hook.hookName}' cannot be called inside a callback. $mustBeCalledInMessage");
//        }
      }
      // todo look for tearOff usages as well! e.g., .map
    }
  }

  static bool _isWithinLoop(FunctionBody body, HookUsage hook) => // force dartfmt line wrap
      ancestorsBetween(hook.node, body).any((ancestor) =>
          ancestor is ForStatement || // force dartfmt line wrap
          ancestor is WhileStatement ||
          ancestor is DoStatement ||
          ancestor is ForElement);

  static bool _isWithinCondition(FunctionBody body, HookUsage hook) => // force dartfmt line wrap
      ancestorsBetween(hook.node, body).any((ancestor) =>
          ancestor is IfStatement || // force dartfmt line wrap
          ancestor is SwitchStatement ||
          ancestor is ConditionalExpression ||
          ancestor is IfElement);

  static bool _isPotentiallyShortCircuited(FunctionBody body, HookUsage hook) =>
      ancestorsBetween(hook.node, body).any((ancestor) {
        // Short-circuiting binary expression
        if (ancestor is BinaryExpression &&
            const {
              TokenType.QUESTION_QUESTION,
              TokenType.BAR_BAR,
              TokenType.AMPERSAND_AMPERSAND,
            }.contains(ancestor.operator.type) &&
            (ancestor.rightOperand.containsRangeOf(hook.node))) {
          return true;
        }

        if (ancestor is AssignmentExpression) {
          // Short-circuiting assignment expression
          if (const {
                TokenType.QUESTION_QUESTION_EQ,
                TokenType.BAR_BAR_EQ,
                TokenType.AMPERSAND_AMPERSAND_EQ,
              }.contains(ancestor.operator.type) &&
              (ancestor.rightHandSide.containsRangeOf(hook.node))) {
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

  static bool _isAfterConditionalReturn(FunctionBody body, HookUsage hook) =>
      body is BlockFunctionBody &&
      body.returnStatements.any((ret) {
        // Ignore any return statements that are not nested within function body and thus not conditional.
        // Hooks after those will show up as dead code via built-in analyzer warnings.
        // todo this isn't working for some reason
        if (ret.parent == body.block) return false;

        return hook.node.offset > ret.offset;
      });
}
