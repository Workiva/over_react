import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

import 'package:over_react_analyzer_plugin/src/assist/refs/add_create_ref.dart' show addCreateRef;
import 'callback_ref.dart';

/// A diagnostic that warns the user about String ref usage.
///
/// > See: [addCreateRef], [CallbackRefDiagnostic]
class StringRefDiagnostic extends ComponentUsageDiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_string_ref',
    'String refs are deprecated.',
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
    correction: 'Use createRef() instead.',
  );

  static final fixKind = FixKind(code.name, 200, 'Convert to createRef()');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    for (final prop in usage.cascadedProps) {
      if (prop.name.name == 'ref' && prop.rightHandSide.staticType.isDartCoreString) {
        await collector.addErrorWithFix(
          code,
          result.locationFor(prop.rightHandSide),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            addCreateRef(builder, usage, result);
          }),
        );
      }
    }
  }
}
