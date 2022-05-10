import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

const _desc = "Props can't be cascaded after unparenthesized arrow functions.";
// <editor-fold desc="Documentation Details">
const _details = r'''

**ALWAYS** surround arrow functions in cascading setters with parentheses.

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
    'over_react_cascaded_arrow_functions',
    _desc,
    AnalysisErrorSeverity.ERROR,
    AnalysisErrorType.SYNTACTIC_ERROR,
    correction: 'Try wrapping the arrow functions in parentheses or using a block function.',
  );

  static final fixKind = FixKind(code.name, 200, 'Wrap arrow function in parentheses');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    for (final prop in usage.cascadedProps) {
      final rhs = prop.rightHandSide;
      if (rhs is FunctionExpression && rhs.body is ExpressionFunctionBody) {
        final body = rhs.body as ExpressionFunctionBody;

        // If a cascade expression is not found in the body, it is not an un-parenthesized
        // function expression in the middle of another cascade... do not lint.
        if (body.expression is! CascadeExpression) continue;

        var wrapOffset = rhs.offset;
        var wrapEnd = rhs.end;

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
    }
  }
}
