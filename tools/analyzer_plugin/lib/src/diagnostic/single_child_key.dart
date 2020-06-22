import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';

// TODO
const _desc = r'TODO';
// TODO
// <editor-fold desc="Documentation Details">
const _details = r'''

TODO

''';
// </editor-fold>

class SingleChildWithKey extends ComponentUsageDiagnosticContributor {
  @DocsMeta(_desc, details: _details)
  static const code = DiagnosticCode(
      'over_react_single_child_key',
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
      await forEachCascadedPropAsync(usage, (lhs, rhs) async {
        if (lhs.propertyName.name == 'key' && isAConstantValue(rhs)) {
          await collector.addErrorWithFix(code, result.location(range: SourceRange(lhs.offset, rhs.end - lhs.offset)),
              fixKind: fixKind,
              computeFix: () => buildFileEdit(result, (builder) {
                    builder.addDeletion(range.endEnd(lhs.beginToken.previous, rhs));
                  }));
        }
      });
    }
  }
}
