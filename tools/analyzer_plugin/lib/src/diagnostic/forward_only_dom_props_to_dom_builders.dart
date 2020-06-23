import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

/// A warning that appears when `addUnconsumedProps` is used on an over_react `Dom.*` builder.
///
/// {@category Diagnostics}
/// {@subCategory Warnings}
class ForwardOnlyDomPropsToDomBuildersDiagnostic extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode(
    'over_react_forward_only_dom_props_to_dom_builders',
    "Custom props should not be forwarded to a Dom builder.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
    correction: 'Use addUnconsumedDomProps instead of addUnconsumedProps.',
  );

  static final fixKind = FixKind(code.name, 200, 'Use addUnconsumedDomProps');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    if (!usage.isDom) return;

    await forEachCascadedMethodAsync(usage, (methodIdentifier, args) async {
      if (methodIdentifier.name != 'modifyProps') return;
      final propModifier = args.arguments.whereType<SimpleIdentifier>().firstOrNull;
      if (propModifier == null) return;

      if (propModifier.name == 'addUnconsumedProps') {
        await collector.addErrorWithFix(
          code,
          result.location(offset: propModifier.offset, end: propModifier.end),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleReplacement(
              SourceRange(propModifier.offset, propModifier.length),
              'addUnconsumedDomProps',
            );
          }),
        );
      }
    });
  }
}
