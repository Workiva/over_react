// ignore: deprecated_member_use
import 'package:analyzer/analyzer.dart'
    show
        StaticTypeWarningCode,
        StaticWarningCode,
        NodeLocator;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';

class MissingCascadeParensDiagnostic extends DiagnosticContributor {
  static final code = new ErrorCode(
      'over_react_missing_cascade_parens',
      'Are you missing parentheses around the builder cascade?',
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final fixKind = new FixKind(
      code.name, 200, 'Add parentheses around cascade',
      appliedTogetherMessage: 'Add parentheses around cascades');

  @override
  computeErrors(result, collector) async {
    for (var error in result.errors) {
      final isBadFunction = [
        StaticTypeWarningCode.INVOCATION_OF_NON_FUNCTION,
        StaticTypeWarningCode.INVOCATION_OF_NON_FUNCTION_EXPRESSION,
      ].contains(error.errorCode);
      final isBadArity = [
        StaticWarningCode.NOT_ENOUGH_REQUIRED_ARGUMENTS,
        StaticWarningCode.EXTRA_POSITIONAL_ARGUMENTS_COULD_BE_NAMED,
        StaticWarningCode.EXTRA_POSITIONAL_ARGUMENTS,
      ].contains(error.errorCode);
      final isVoidUsage =
          [StaticWarningCode.USE_OF_VOID_RESULT].contains(error.errorCode);

      if (isBadFunction || isBadArity || isVoidUsage) {
        final node = new NodeLocator(error.offset, error.offset + error.length)
            .searchWithin(result.unit);

        InvocationExpression invocationExpression;
        if (isBadArity &&
            node is ArgumentList &&
            node.parent is InvocationExpression) {
          invocationExpression = node.parent;
        } else if (isBadFunction && node.parent is InvocationExpression) {
          invocationExpression = node.parent;
        } else if (isVoidUsage && node.parent is InvocationExpression) {
          invocationExpression = node.parent;
        }

        if (invocationExpression != null) {
          final assignment = invocationExpression.parent;
          if (assignment is AssignmentExpression) {
            final cascade = assignment.parent;
            if (cascade is CascadeExpression) {
              if (cascade.target.staticType?.name?.endsWith('Props') ?? false) {
                await collector.addErrorWithFix(
                  code,
                  location(result, range: range.node(cascade)),
                  fixKind: fixKind,
                  computeFix: () => buildFileEdit(result, (builder) {
                    builder.addSimpleInsertion(cascade.offset, '(');
                    builder.addSimpleInsertion(invocationExpression.argumentList.offset, ')');
                  }),
                );
              }
            }
          }
        }
      }
    }
  }
}
