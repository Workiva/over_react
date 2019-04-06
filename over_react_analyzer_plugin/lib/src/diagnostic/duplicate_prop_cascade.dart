import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class DuplicatePropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = ErrorCode(
      'over_react_invalid_child',
      "Prop '{0}' is set more than once ({1} of {2}). This is most likely a typo.",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_TYPE_WARNING);

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final propUsagesByName = <String, List<PropertyAccess>>{};
    forEachCascadedProp(usage, (lhs, rhs) {
      propUsagesByName.putIfAbsent(lhs.propertyName.name, () => []).add(lhs);
    });

    propUsagesByName.forEach((name, usages) {
      // TODO add quick fix to remove duplicates
      if (usages.length > 1) {
        for (var i = 0; i < usages.length; i++) {
          final lhs = usages[i];
          collector.addError(code,
            location(result, range: range.node(lhs)),
            errorMessageArgs: [lhs.propertyName.name, i + 1, usages.length]
          );
        }
      }
    });
  }
}
