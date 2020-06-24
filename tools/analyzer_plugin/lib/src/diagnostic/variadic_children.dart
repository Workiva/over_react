import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

const _desc = r'Avoid using iterable children when variadic children can be used.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** using variadic children when possible.

**GOOD:**
```
@override
render() {
  return Dom.ul()(
    Dom.li()('Item 1'),
    Dom.li()('Item 2'),
  );
}
```

**BAD:**
```
@override
render() {
  return Dom.ul()([
    (Dom.li()..key = 1)('Item 1'),
    (Dom.li()..key = 2)('Item 2'),
  ]);
}
```

''';
// </editor-fold>

class VariadicChildrenDiagnostic extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_variadic_children',
    _desc,
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  static final fixKind = FixKind(code.name, 200, 'Unwrap children from list literal',
      appliedTogetherMessage: 'Unwrap children from list literals');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    final arguments = usage.node.argumentList.arguments;
    if (arguments.length == 1 && arguments.single is ListLiteral) {
      final list = arguments.single as ListLiteral;

      await collector.addErrorWithFix(
        code,
        result.locationFor(list),
        fixKind: fixKind,
        computeFix: () => buildFileEdit(result, (builder) {
          builder.addDeletion(range.token(list.leftBracket));
          builder.addDeletion(range.token(list.rightBracket));
          // todo remove any keys from children as well
        }),
      );
    }
  }
}
