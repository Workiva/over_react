// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';

class VariadicChildrenDiagnostic extends ComponentUsageDiagnosticContributor {
  static const code = const ErrorCode(
    'over_react_variadic_children',
    'Variadic children should be used instead of lists where possible',
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  static final fixKind = new FixKind(code.name, 200,
      'Unwrap children from list literal',
      appliedTogetherMessage: 'Unwrap children from list literals');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final arguments = usage.node.argumentList.arguments;
    if (arguments.length == 1 && arguments.single is ListLiteral) {
      ListLiteral list = arguments.single;

      await collector.addErrorWithFix(code,
        location(result, offset: list.offset, end: list.end),
        fixKind: fixKind,
        computeFix: () => buildFileEdit(result, (builder) {
          builder.addDeletion(range.token(list.leftBracket));
          builder.addDeletion(range.token(list.rightBracket));
          // todo remove any keys from children as well
        }),
      );
    }
  }
}
