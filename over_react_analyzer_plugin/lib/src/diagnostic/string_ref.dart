import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class StringRefDiagnostic extends ComponentUsageDiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_string_ref',
    'String refs are deprecated. Use a callback ref instead.',
    // todo make error in Component2
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
  );

  @override
  computeErrorsForUsage(result, collector, usage) async {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'ref' && rhs.staticType.isDartCoreString) {
        // todo add fix to convert this and usages to callback ref
        collector.addError(code, result.locationFor(rhs));
      }
    });
  }
}
