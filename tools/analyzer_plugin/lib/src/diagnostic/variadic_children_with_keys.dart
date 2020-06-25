import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

class VariadicChildrenWithKeys extends ComponentUsageDiagnosticContributor {
  static final code = DiagnosticCode('variadic_children_with_keys',
      'React keys are only needed for children rendered in lists.', AnalysisErrorSeverity.INFO, AnalysisErrorType.HINT);

  static final fixKind = FixKind(code.name, 200, 'Remove unnecessary key', appliedTogetherMessage: 'Remove key prop');

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
              builder.addDeletion(prop.rangeForRemoval);
            }),
          );
        }
      }
    }
  }
}
