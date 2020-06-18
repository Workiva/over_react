import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class SingleChildWithKey extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode(
      'single_child_key',
      'React keys are only needed for children rendered in lists with siblings.',
      AnalysisErrorSeverity.INFO,
      AnalysisErrorType.HINT);

  static final fixKind = FixKind(
      code.name, 200, 'Remove unnecessary key',
      appliedTogetherMessage: 'Remove key prop');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    var isInAList = false;
    var isVariadic = false;
    var isSingleChild = false;

    if (usage.node.parent is ListLiteral) {
      ListLiteral parent = usage.node.parent;
      isInAList = true;

      if (parent.elements.length == 1) {
        isSingleChild = true;
      }
    } else if (usage.node.parent is ArgumentList) {
      var grandparent = usage.node.parent?.parent;
      if (grandparent is FunctionExpressionInvocation) {
        isVariadic = true;
      }
    } else if (usage.node.parent is ExpressionFunctionBody || usage.node.parent is ReturnStatement) {
      isVariadic = true;
    }

    if ((isInAList && isSingleChild) || isVariadic) {
     await forEachCascadedPropAsync(usage, (lhs, rhs) async {
        if (lhs.propertyName.name == 'key') {
          await collector.addErrorWithFix(code,
              result.location(range: range.node(lhs)),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                builder.addDeletion(range.endEnd(lhs.beginToken.previous, rhs));
             })
          );
        }
      });
    }
  }
}
