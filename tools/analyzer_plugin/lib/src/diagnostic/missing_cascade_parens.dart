// ignore: deprecated_member_use
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/analyzer.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/analyzer_debug_helper.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

const _desc = r'Syntax errors around cascades';
// <editor-fold desc="Documentation Details">
const _details = r'''

This diagnostic detects syntax errors related to the parentheses around over_react builder cascades.

**Well-formed:**
```
@override
render() {
  return (Dom.div()
    ..id = 'foo'
    ..className = 'foo--variant'
  )(
    'Hi there',
  );
}
```

**Syntax errors due to missing parentheses:**
```
@override
render() {
  return Dom.div()
    ..id = 'foo'
    ..className = 'foo--variant'
  (
    'Hi there',
  );
}
```

''';
// </editor-fold>

class MissingCascadeParensDiagnostic extends DiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_missing_cascade_parens',
    "This component usage looks like it's missing parentheses.",
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.SYNTACTIC_ERROR,
    correction: "Try adding parentheses around the cascaded props",
  );

  // Make smaller (higher priority) than
  // REMOVE_PARENTHESIS_IN_GETTER_INVOCATION

  static final fixKind = FixKind(code.name, 400, 'Add parentheses around props cascade',
      appliedTogetherMessage: 'Add parentheses around props cascades');

  @override
  computeErrors(result, collector) async {
    for (final error in result.errors) {
      final isBadFunction = const {
        'INVOCATION_OF_NON_FUNCTION',
        'INVOCATION_OF_NON_FUNCTION_EXPRESSION',
      }.contains(error.errorCode.name);
      final isBadArity = const {
        'NOT_ENOUGH_POSITIONAL_ARGUMENTS',
        'EXTRA_POSITIONAL_ARGUMENTS_COULD_BE_NAMED',
        'EXTRA_POSITIONAL_ARGUMENTS',
      }.contains(error.errorCode.name);
      final isVoidUsage = const {
        'USE_OF_VOID_RESULT',
      }.contains(error.errorCode.name);

      if (isBadFunction || isBadArity || isVoidUsage) {
        final node = NodeLocator(error.offset, error.offset + error.length).searchWithin(result.unit);

        final debug = AnalyzerDebugHelper(result, collector);
        debug.log('node.type: ${node.runtimeType}');

        InvocationExpression invocation;
        final parent = node.parent;
        if (isBadArity && node is ArgumentList && parent is InvocationExpression) {
          invocation = parent;
        } else if (isBadFunction && parent is InvocationExpression) {
          // FIXME we explain why we use the parent instead of node
          invocation = parent;
        } else if (isVoidUsage && parent is InvocationExpression) {
          invocation = parent;
        }
        debug.log('invocation : ${invocation?.toSource()}');

        if (invocation == null) return;

        final cascade = invocation.parent?.tryCast<AssignmentExpression>()?.parent?.tryCast<CascadeExpression>();
        if (cascade != null) {
          if (cascade?.target?.staticType?.isPropsClass ?? false) {
            await collector.addErrorWithFix(
              code,
              result.locationFor(cascade),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addSimpleInsertion(cascade.offset, '(');
                builder.addSimpleInsertion(invocation.argumentList.offset, ')');
              }),
            );
          }
          continue;
        }

        debug.log('${invocation.function.staticType?.getDisplayString(withNullability: false)}');

        if (isBadFunction && (invocation.function.staticType?.isReactElement ?? false)) {
          final expr = invocation.function?.tryCast<InvocationExpression>() ??
              invocation.function?.tryCast<ParenthesizedExpression>()?.unParenthesized?.tryCast();

          debug.log('expr: ${expr?.runtimeType} ${expr?.toSource()}');
          debug.log('expr.parent: ${expr?.parent?.runtimeType} ${expr?.parent?.toSource()}');

          if (expr.argumentList.arguments.firstOrNull?.staticType?.isPropsClass ?? false) {
            await collector.addErrorWithFix(
              code,
              result.locationFor(node),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addSimpleInsertion(expr.function.end, ')(');
              }),
            );
            continue;
          }
        }
      }
    }
  }
}
