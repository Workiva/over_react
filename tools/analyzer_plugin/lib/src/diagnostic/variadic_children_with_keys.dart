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
    'variadic_children_with_keys',
    "Keying this child is not necessary because it's passed as an argument as opposed to inside an Iterable.",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.HINT,
    url: 'https://reactjs.org/docs/lists-and-keys.html',
  );

  static final fixKind = FixKind(code.name, 200, 'Remove unnecessary key');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    var isVariadic = false;
    final parentMethodName = usage.node.thisOrAncestorOfType<MethodDeclaration>()?.name?.name;

    final parent = usage.node.parent;

    if (parent is ArgumentList) {
      final enclosingUsage = identifyUsage(parent?.parent);

      if (enclosingUsage?.node?.argumentList == parent ?? false) {
        isVariadic = true;
      }
    } else if (parent is ReturnStatement && (parentMethodName == 'render' ?? false)) {
      isVariadic = true;
    }

    if (isVariadic) {
      for (final prop in usage.cascadedProps) {
        if (prop.name.name == 'key' && isAConstantValue(prop.rightHandSide)) {
          await collector.addErrorWithFix(
            code,
            result.locationFor(prop.assignment),
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
