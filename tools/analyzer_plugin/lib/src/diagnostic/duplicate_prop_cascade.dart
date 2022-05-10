import 'package:collection/collection.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

const _desc = r'Avoid setting the same prop more than once on a component builder.';
// <editor-fold desc="Documentation Details">
const _details = r'''

When the same prop appears on a builder more than once, the last one set "wins" - so no runtime error will occur
as a result of the duplicate setter. 

However - the presence of duplicate setters is most likely a typo.

''';
// </editor-fold>

class DuplicatePropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
      'over_react_duplicate_prop_cascade',
      "Prop '{0}' is set more than once ({1} of {2}). This is most likely a typo.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  static final fixKind = FixKind(code.name, 200, 'Remove duplicate prop keys / values');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final propUsagesByName = groupBy<PropAssignment, String>(usage.cascadedProps, (prop) {
      final prefix = prop.prefix;
      if (prefix != null && prefix.name != 'dom') {
        return '${prefix.name}.${prop.name.name}';
      }

      return prop.name.name;
    });
    final propUsagesWithDuplicates = propUsagesByName.values.where((usages) => usages.length > 1);
    for (final propUsages in propUsagesWithDuplicates) {
      for (var i = 0; i < propUsages.length; i++) {
        final propWithWarning = propUsages[i];
        await collector.addErrorWithFix(
          code,
          result.locationFor(propWithWarning.leftHandSide),
          errorMessageArgs: [propWithWarning.name.name, i + 1, propUsages.length],
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            for (var i = 0; i < propUsages.length - 1; i++) {
              // We iterate and remove all but the final instance of a duplicated prop, so that the last
              // instance (the one that is actually used at run time) is retained.
              removeProp(usage, builder, propUsages[i]);
            }
          }),
        );
      }
    }
  }
}
