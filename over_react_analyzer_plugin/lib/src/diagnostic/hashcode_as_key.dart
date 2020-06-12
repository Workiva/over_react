import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class HashCodeAsKeyDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = ErrorCode(
      'over_react_missing_casecade_parens',
      "React keys should not be derived from 'hashCode' since it is not unique",
      AnalysisErrorSeverity.WARNING,
      AnalysisErrorType.STATIC_WARNING);

  @override
  computeErrorsForUsage(result, collector, usage) async {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'key') {
        if (rhs.toSource().contains('.hashCode')) {
          collector.addError(code, result.locationFor(rhs));
        }
      }
    });
  }
}
