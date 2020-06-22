import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

const _desc = 'Surround arrow functions in cascading setters with parentheses to allow subsequent cascades.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** to surround arrow functions in cascading setters with parentheses.

Otherwise, subsequent cascades do not work properly.

**GOOD:**
```
EventTarget target;

(Dom.button()
  ..onClick = ((event) => eventTarget = event.target)
  ..id = 'foo'
)()
```

**BAD:**
```
EventTarget target;

(Dom.button()
  ..onClick = (event) => eventTarget = event.target
  // This id will not get set on the button
  ..id = 'foo'
)()
```

''';
// </editor-fold>

class ArrowFunctionPropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
      'over_react_cascaded_arrow_functions', _desc, AnalysisErrorSeverity.WARNING, AnalysisErrorType.STATIC_WARNING);

  static final fixKind = FixKind(code.name, 200, 'Wrap arrow function in parentheses',
      appliedTogetherMessage: 'Wrap arrow functions in parentheses');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    await forEachCascadedPropAsync(usage, (lhs, rhs) async {
      if (rhs is FunctionExpression && rhs.body is ExpressionFunctionBody) {
        var wrapOffset = rhs.offset;
        var wrapEnd = rhs.end;

        final ExpressionFunctionBody body = rhs.body;
        final expression = body.expression;
        if (expression is CascadeExpression) {
          // todo do this intelligently based on indent
          wrapEnd = expression.target.end;
        }

        await collector.addErrorWithFix(
          code,
          result.location(offset: wrapOffset, end: wrapEnd),
          fixKind: fixKind,
          computeFix: () => buildFileEdit(result, (builder) {
            builder.addSimpleInsertion(wrapOffset, '(');
            builder.addSimpleInsertion(wrapEnd, ')');
          }),
        );
      }
    });
  }
}
