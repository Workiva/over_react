import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

const _desc = r'Avoid using keys when not necessary.';
// <editor-fold desc="Documentation Details">
const _details = r'''

**PREFER** omitting `props.key` when an element is the only element in an iterable, or when it is not 
placed within an iterable.

**GOOD:**
```
@override
render() {
  return Dom.ul()(
    Dom.li()(
      'item 1',
    ),
    Dom.li()(
      'item 2',
    ),
  );
}
```

**BAD:**
```
@override
render() {
  return Dom.ul()(
    (Dom.li()..key = 1)(
      'item 1',
    ),
    (Dom.li()..key = 2)(
      'item 2',
    ),
  );
}
```

**BAD:**
```
@override
render() {
  return Dom.ul()([
    (Dom.li()..key = 1)(
      'the only item',
    ),
  ]);
}
```

''';
// </editor-fold>

class VariadicChildrenWithKeys extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
    'over_react_unnecessary_key',
    "Keying this child is not necessary because {0}.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
    url: 'https://reactjs.org/docs/lists-and-keys.html',
  );

  @override
  List<DiagnosticCode> get codes => [code];

  static final fixKind = FixKind(code.name, 200, 'Remove unnecessary key');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    String? reasonWhyUnnecessary;
    final parentMethodName = usage.node.thisOrAncestorOfType<MethodDeclaration>()?.name.lexeme;

    final parent = usage.node.parent;

    if (parent is ArgumentList) {
      final enclosingUsage = identifyUsage(parent.parent);

      if (enclosingUsage?.node.argumentList == parent) {
        reasonWhyUnnecessary = "it's passed as an argument as opposed to inside an Iterable";
      }
    } else if (parent is ReturnStatement && parentMethodName == 'render') {
      reasonWhyUnnecessary = "it's returned directly from 'render'";
    }

    if (reasonWhyUnnecessary != null) {
      for (final prop in usage.cascadedProps) {
        if (prop.name.name == 'key' && isAConstantValue(prop.rightHandSide)) {
          await collector.addErrorWithFix(
            code,
            result.locationFor(prop.node),
            errorMessageArgs: [reasonWhyUnnecessary],
            fixKind: fixKind,
            computeFix: () => buildFileEdit(result, (builder) {
              removeProp(usage, builder, prop);
            }),
          );
        }
      }
    }
  }
}
