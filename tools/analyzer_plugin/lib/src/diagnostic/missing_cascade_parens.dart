// ignore: deprecated_member_use
import 'package:analyzer/analyzer.dart'
    show CompileTimeErrorCode, NodeLocator, StaticTypeWarningCode, StaticWarningCode;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

class MissingCascadeParensDiagnostic extends DiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_missing_cascade_parens',
      'Are you missing parentheses around the builder cascade?',
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  // Make smaller (higher priority) than
  // REMOVE_PARENTHESIS_IN_GETTER_INVOCATION

  static final fixKind = FixKind(code.name, 400, 'Add parentheses around cascade',
      appliedTogetherMessage: 'Add parentheses around cascades');

  @override
  computeErrors(result, collector) async {
    for (final error in result.errors) {
      final isBadFunction = const {
        StaticTypeWarningCode.INVOCATION_OF_NON_FUNCTION,
        StaticTypeWarningCode.INVOCATION_OF_NON_FUNCTION_EXPRESSION,
      }.contains(error.errorCode);
      final isBadArity = const {
        CompileTimeErrorCode.NOT_ENOUGH_POSITIONAL_ARGUMENTS,
        CompileTimeErrorCode.EXTRA_POSITIONAL_ARGUMENTS_COULD_BE_NAMED,
        CompileTimeErrorCode.EXTRA_POSITIONAL_ARGUMENTS,
      }.contains(error.errorCode);
      final isVoidUsage = const {
        StaticWarningCode.USE_OF_VOID_RESULT,
      }.contains(error.errorCode);

      if (isBadFunction || isBadArity || isVoidUsage) {
        final node = NodeLocator(error.offset, error.offset + error.length).searchWithin(result.unit);

        final debug = AnalyzerDebugHelper(result, collector);
        debug.log('node.type: ${node.runtimeType}');

        InvocationExpression invocation;
        if (isBadArity && node is ArgumentList && node.parent is InvocationExpression) {
          invocation = node.parent;
        } else if (isBadFunction && node.parent is InvocationExpression) {
          // FIXME we explain why we use the parent instead of node
          invocation = node.parent;
        } else if (isVoidUsage && node.parent is InvocationExpression) {
          invocation = node.parent;
        }
        debug.log('invocation : ${invocation?.toSource()}');

        if (invocation == null) return;

        final cascade = invocation.parent?.tryCast<AssignmentExpression>()?.parent?.tryCast<CascadeExpression>();
        if (cascade != null) {
          if (cascade?.target?.staticType?.isPropsClass ?? false) {
            await collector.addErrorWithFix(
              code,
              result.locationFor(cascade),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addSimpleInsertion(cascade.offset, '(');
                builder.addSimpleInsertion(invocation.argumentList.offset, ')');
              }),
            );
          }
          continue;
        }

        debug.log('${invocation.function.staticType?.getDisplayString()}');

        if (isBadFunction && (invocation.function.staticType?.isReactElement ?? false)) {
          final expr = invocation.function?.tryCast<InvocationExpression>() ??
              invocation.function?.tryCast<ParenthesizedExpression>()?.unParenthesized?.tryCast();

          debug.log('expr: ${expr?.runtimeType} ${expr?.toSource()}');
          debug.log('expr.parent: ${expr?.parent?.runtimeType} ${expr?.parent?.toSource()}');

          if (expr.argumentList.arguments.firstOrNull?.staticType?.isPropsClass ?? false) {
            await collector.addErrorWithFix(
              code,
              result.locationFor(node),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addSimpleInsertion(expr.function.end, ')(');
              }),
            );
            continue;
          }
        }
      }
    }
  }
}