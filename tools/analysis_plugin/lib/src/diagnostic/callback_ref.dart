import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref.dart' show addCreateRef;
import 'string_ref.dart';

/// A diagnostic that warns the user about callback ref usage.
///
/// > See: [addCreateRef], [StringRefDiagnostic]
class CallbackRefDiagnostic extends ComponentUsageDiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_prefer_create_ref',
    'Creating refs using createRef() is preferred over assigning fields in a callback ref.',
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
  );

  static final fixKind = FixKind(code.name, 200, 'Convert to createRef()');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'ref' &&
          result.typeSystem.isSubtypeOf(rhs.staticType, result.typeProvider.functionType)) {
        collector.addErrorWithFix(
          code,
          result.locationFor(rhs),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            addCreateRef(builder, usage, result);
          }),
        );
      }
    });
  }
}
