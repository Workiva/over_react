import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class SingleChildWithKey extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode(
      'single_child_key',
      'React keys are only needed for children rendered in lists with siblings.',
      AnalysisErrorSeverity.INFO,
      AnalysisErrorType.HINT);

  static final fixKind = FixKind(code.name, 200, 'Remove unnecessary key', appliedTogetherMessage: 'Remove key prop');

  @override
  computeErrorsForUsage(result, collector, usage) async {
    var isInAList = false;
    var isVariadic = false;
    var isSingleChild = false;

    final parentMethodName = usage.node.thisOrAncestorOfType<MethodDeclaration>()?.name?.name;

    if (usage.node.parent is ListLiteral && (usage.node.parent?.parent is! ReturnStatement)) {
      ListLiteral parent = usage.node.parent;
      isInAList = true;

      if (parent.elements.length == 1) {
        isSingleChild = true;
      }
    } else if (usage.node.parent is ArgumentList) {
      ArgumentList parent = usage.node.parent;
      final enclosingUsage = identifyUsage(parent?.parent);

      if (enclosingUsage?.node?.argumentList == parent ?? false) {
        isVariadic = true;
      }
    } else if (usage.node.parent is ReturnStatement && (parentMethodName == 'render' ?? false)) {
      isVariadic = true;
    }

    if ((isInAList && isSingleChild) || isVariadic) {
      for (final prop in usage.cascadedProps) {
        if (prop.name.name == 'key' && prop.rightHandSide is SimpleStringLiteral) {
          await collector.addErrorWithFix(
            code,
            result.locationFor(prop.assignment),
            fixKind: fixKind,
            computeFix: () => buildFileEdit(result, (builder) {
              builder.addDeletion(prop.rangeForRemoval);
            }),
          );
        }
      }
    }
  }
}
