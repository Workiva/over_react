import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/visitors/proptypes_visitors.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

/// A warning that appears when `throw`ing a `PropError` instead of returning it within `UiComponent2.propTypes`.
///
/// {@category Diagnostics}
/// {@subCategory Warnings}
class PropTypesReturnValueDiagnostic extends DiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_proptypes_do_not_throw',
      "propTypes errors are expected to be returned, not thrown. While any thrown errors/exceptions are caught by React and surfaced as prop warnings, throwing is not recommended.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final fixKind = FixKind(code.name, 200, 'Return the error');

  @override
  computeErrors(result, collector) async {
    final visitor = PropTypesVisitor();
    result.unit.accept(visitor);
    final throwExpressionsForPropKey = [
      ...?visitor.mapVisitor?.values?.map((value) => allDescendantsOfType<ThrowExpression>(value))?.toList(),
    ];

    for (final throwExpressions in throwExpressionsForPropKey) {
      for (final throwExpression in throwExpressions) {
        final throwKw = throwExpression.throwKeyword;
        await collector.addErrorWithFix(
          code,
          result.locationFor(throwKw),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleReplacement(SourceRange(throwKw.offset, throwKw.length), 'return');
          }),
        );
      }
    }
  }
}
