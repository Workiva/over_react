import 'package:analyzer/source/source_range.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class SingleChildWithKey extends ComponentUsageDiagnosticContributor {
  static final code = new ErrorCode(
      'single_child_key',
      'Only use a key when a child has siblings.',
      AnalysisErrorSeverity.INFO,
      AnalysisErrorType.HINT);

  static final fixKind = new FixKind(
      code.name, 200, 'Remove key prop',
      appliedTogetherMessage: 'Remove key prop');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final bool isSingleChild = usage.childArgumentCount == 1;

    if (isSingleChild) {
     await forEachCascadedPropAsync(usage, (lhs, rhs) async {
        if (lhs.propertyName.name == 'key') {
          await collector.addErrorWithFix(code,
              location(result, range: range.node(lhs)),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addDeletion(new SourceRange(lhs.offset, rhs.end - lhs.offset));
             })
          );
        }
      });
    }
  }
}
