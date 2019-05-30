import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class ArrowFunctionPropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = ErrorCode('over_react_cascaded_arrow_functions',
      'Unparenthesized arrow function values prevent subsequent cascades',
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  static final fixKind = FixKind(code.name, 200,
      'Wrap arrow function in parentheses',
      appliedTogetherMessage: 'Wrap arrow functions in parentheses');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    await forEachCascadedPropAsync(usage, (lhs, rhs) async {
      if (rhs is FunctionExpression && rhs.body is ExpressionFunctionBody) {
        int wrapOffset = rhs.offset;
        int wrapEnd = rhs.end;

        final ExpressionFunctionBody body = rhs.body;
        final expression = body.expression;
        if (expression is CascadeExpression) {
          // todo do this intelligently based on indent
          wrapEnd = expression.target.end;
        }

        await collector.addErrorWithFix(
          code,
          location(result, offset: wrapOffset, end: wrapEnd),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleInsertion(wrapOffset, '(');
            builder.addSimpleInsertion(wrapEnd, ')');
          }),
        );
      }
    });
  }
}
