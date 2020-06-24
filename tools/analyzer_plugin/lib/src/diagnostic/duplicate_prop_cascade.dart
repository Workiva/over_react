import 'package:collection/collection.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class DuplicatePropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode(
      'over_react_duplicate_prop_cascade',
      "Prop '{0}' is set more than once ({1} of {2}). This is most likely a typo.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final fixKind = FixKind(code.name, 200, 'Remove duplicate prop key / value',
      appliedTogetherMessage: 'Remove duplicate prop keys / values');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final propUsagesByName = groupBy<PropAssignment, String>(usage.cascadedProps, (prop) => prop.name.name);
    final propUsagesWithDuplicates = propUsagesByName.values.where((usages) => usages.length > 1);
    for (final propUsages in propUsagesWithDuplicates) {
      for (var i = 0; i < propUsages.length - 1; i++) {
        final prop = propUsages[i];
        await collector.addErrorWithFix(
          code,
          result.locationFor(prop.leftHandSide),
          errorMessageArgs: [prop.name.name, i + 1, propUsages.length],
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addDeletion(prop.rangeForRemoval);
          }),
        );
      }
    }
  }
}
