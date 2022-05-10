import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

const _desc = r'Avoid setting a link target without rel="noopener noreferrer".';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** creating links that open in a new window that do not expose security vulnarabilities.

**GOOD:**
```
(Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
  ..rel = 'noopener noreferrer'
)();
```

**BAD:**
```
(Dom.a()
  ..href = 'https://www.workiva.com'
  ..target = '_blank'
)();
```

<blockquote>
  <a href="https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/" target="_blank" rel="noreferrer noopener">
    Read more about the <code>target="_blank"</code> security vulnerability
  </a>
</blockquote>

''';
// </editor-fold>

/// A warning that appears when the `target` prop is set, but `rel = 'noreferrer noopener'` is not.
///
/// > See: ["The most underestimated vulnerability ever"](https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/)
///
/// {@category Diagnostics}
/// {@subCategory Warnings}
class LinkTargetUsageWithoutRelDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_avoid_link_target_vulnerability',
    "A target is set for links opening '{0}', which is a potential security vulnerability.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
    correction: 'Always add rel="noopener noreferrer" when using a target for a link.',
  );

  static final fixKind = FixKind(code.name, 200, 'Add rel="noopener noreferrer"');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    String hrefValue;
    Pair<Expression, Expression> targetPropSection;
    Pair<Expression, Expression> relPropSection;
    for (final prop in usage.cascadedProps) {
      final propName = prop.name.name;
      if (propName == 'href') {
        hrefValue = prop.rightHandSide.staticType.isDartCoreNull ? null : prop.rightHandSide.toString();
      } else if (propName == 'target') {
        targetPropSection = Pair(prop.leftHandSide, prop.rightHandSide);
      } else if (propName == 'rel') {
        relPropSection = Pair(prop.leftHandSide, prop.rightHandSide);
      }
    }

    if (hrefValue == null || targetPropSection == null || targetPropSection.last.staticType.isDartCoreNull) return;

    const requiredRelValues = {
      'noopener',
      'noreferrer',
    };
    var actualRelValues = <String>{};
    var offerQuickFix = relPropSection == null || relPropSection.last.staticType.isDartCoreNull;
    if (relPropSection != null && relPropSection.last.staticType.isDartCoreString) {
      offerQuickFix = relPropSection.last is StringLiteral;

      final declaredValues = getConstOrLiteralStringValueFrom(relPropSection.last)?.split(' ')?.toSet();
      if (declaredValues != null) {
        actualRelValues = declaredValues;
      }
    }
    final missingRequiredRelValues = requiredRelValues.difference(actualRelValues);

    if (missingRequiredRelValues.isNotEmpty) {
      if (offerQuickFix) {
        await collector.addErrorWithFix(
          code,
          result.location(offset: targetPropSection.first.offset, end: targetPropSection.last.end),
          errorMessageArgs: [hrefValue],
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            if (relPropSection == null) {
              addProp(usage, builder, result.content, result.lineInfo,
                  name: 'rel', value: "'${requiredRelValues.join(' ')}'");
            } else {
              builder.addSimpleReplacement(
                SourceRange(relPropSection.last.offset, relPropSection.last.length),
                "'${[...actualRelValues, ...missingRequiredRelValues].join(' ')}'",
              );
            }
          }),
        );
      } else {
        collector.addError(
          code,
          result.location(offset: targetPropSection.first.offset, end: targetPropSection.last.end),
          errorMessageArgs: [hrefValue],
        );
      }
    }
  }
}
