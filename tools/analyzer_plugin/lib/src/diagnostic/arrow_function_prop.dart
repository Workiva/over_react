import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class ArrowFunctionPropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_cascaded_arrow_functions',
      'Unparenthesized arrow function values prevent subsequent cascades',
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final fixKind = FixKind(code.name, 200, 'Wrap arrow function in parentheses',
      appliedTogetherMessage: 'Wrap arrow functions in parentheses');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    for (final prop in usage.cascadedProps) {
      final rhs = prop.rightHandSide;
      if (rhs is FunctionExpression && rhs.body is ExpressionFunctionBody) {
        var wrapOffset = rhs.offset;
        var wrapEnd = rhs.end;

        final ExpressionFunctionBody body = rhs.body;
        final expression = body.expression;
        if (expression is CascadeExpression) {
          // todo do this intelligently based on indent
          wrapEnd = expression.target.end;
        }

        await collector.addErrorWithFix(
          code,
          result.location(offset: wrapOffset, end: wrapEnd),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleInsertion(wrapOffset, '(');
            builder.addSimpleInsertion(wrapEnd, ')');
          }),
        );
      }
    }
  }
}
