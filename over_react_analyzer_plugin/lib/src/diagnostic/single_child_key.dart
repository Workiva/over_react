import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class SingleChildWithKey extends ComponentUsageDiagnosticContributor {
  static final code = new ErrorCode(
      'single_child_key',
      'Only use a key when a child has siblings.',
      AnalysisErrorSeverity.INFO,
      AnalysisErrorType.HINT);

  static final fixKind = new FixKind(
      code.name, 200, 'Remove key prop',
      appliedTogetherMessage: 'Remove key prop');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    bool isSingleChild = false;

    // Navigate up the node tree to check if the current node has siblings
    if (usage.node.parent is ArgumentList) {
      final one = usage.node.parent.parent;
      if (one is InvocationExpression) {
        var usageCheck = getComponentUsage(one);
        if (usageCheck != null) {
          usageCheck.childArgumentCount > 1
              ? isSingleChild = false
              : isSingleChild = true;
        }
      }
    // If the initial else is triggered, the assumption is that the node is
    // at the root level and would not have siblings.
    } else {
      isSingleChild = true;
    }

    if (isSingleChild) {
     await forEachCascadedPropAsync(usage, (lhs, rhs) async {
        if (lhs.propertyName.name == 'key') {
          await collector.addErrorWithFix(code,
              location(result, range: range.node(lhs)),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addDeletion(new SourceRange(lhs.offset, rhs.end - lhs.offset));
             })
          );
        }
      });
    }
  }
}
