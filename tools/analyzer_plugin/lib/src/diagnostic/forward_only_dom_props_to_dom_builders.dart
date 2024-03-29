import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/function_components.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Avoid forwarding custom props to a Dom builder.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** to use `addUnconsumedDomProps` instead of `addUnconsumedProps` on Dom builders.

**GOOD:**
```
@override
render() {
  return (Dom.div()
    ..modifyProps(addUnconsumedDomProps)
    ..id = 'foo'
  )(props.children);
}
```

**BAD:**
```
@override
render() {
  return (Dom.div()
    ..modifyProps(addUnconsumedProps)
    ..id = 'foo'
  )(props.children);
}
```

''';
// </editor-fold>

/// A warning that appears when `addUnconsumedProps` is used on an over_react `Dom.*` builder.
///
/// {@category Diagnostics}
/// {@subCategory Warnings}
class ForwardOnlyDomPropsToDomBuildersDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_forward_only_dom_props_to_dom_builders',
    'Forwarding all props to a DOM component can result in unsupported prop warnings at runtime.',
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
    correction: 'Use addUnconsumedDomProps instead of addUnconsumedProps.',
  );

  @override
  List<DiagnosticCode> get codes => [code];

  static final fixKind = FixKind(code.name, 200, 'Use addUnconsumedDomProps');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    if (!usage.isDom) return;

    for (final invocation in usage.cascadedMethodInvocations) {
      final isFnComponent = getClosestFunctionComponent(usage.node) != null;
      final invocationName = invocation.methodName.name;
      if (!isFnComponent && invocationName != 'modifyProps') continue;

      // In function components, the prop modifier is the same as the cascaded method invocation
      // since you directly call `..addUnconsumedProps` instead of `..modifyProps(addUnconsumedProps)`.
      final propModifier = isFnComponent
          // ..#addUnconsumedProps#(props, consumedProps)
          ? invocation.node.methodName
          // ..modifyProps(#addUnconsumedProps#)
          : invocation.node.argumentList.arguments.whereType<SimpleIdentifier>().firstOrNull;
      if (propModifier == null) continue;

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
    }
  }
}
