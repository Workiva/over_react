import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class DuplicatePropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = ErrorCode(
      'over_react_duplicate_prop_cascade',
      "Prop '{0}' is set more than once ({1} of {2}). This is most likely a typo.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final fixKind = FixKind(code.name, 200, 'Remove duplicate prop key / value',
      appliedTogetherMessage: 'Remove duplicate prop keys / values');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final propUsagesByName = <String, List<Pair<PropertyAccess, Expression>>>{};
    forEachCascadedProp(usage, (lhs, rhs) {
      propUsagesByName.putIfAbsent(lhs.propertyName.name, () => []).add(Pair(lhs, rhs));
    });

    for (final usages in propUsagesByName.values) {
      if (usages.length > 1) {
        for (var i = 0; i < usages.length; i++) {
          final lhs = usages[i].first;
          final rhs = usages[i].last;
          await collector.addErrorWithFix(
            code,
            result.locationFor(lhs),
            errorMessageArgs: [lhs.propertyName.name, i + 1, usages.length],
            fixKind: fixKind,
            computeFix: () => buildFileEdit(result, (builder) {
              builder.addDeletion(range.endEnd(lhs.beginToken.previous, rhs));
            }),
          );
        }
      }
    }
  }
}
