import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

/// Warn when missing `key` props in iterators/collection literals
class IteratorKey extends ComponentUsageDiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_key',
    'Missing "key" prop for element in iterator',
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @override
  computeErrorsForUsage(ResolvedUnitResult result, DiagnosticCollector collector, FluentComponentUsage usage) async {
    final arguments = usage.node.argumentList.arguments;

    for (final argument in arguments) {
      if (argument is ListLiteral) {
        // 1st case: list literal w/o key
        var hasKeyProp = false;

        final list = argument;
        for (final e in list.elements) {
          final componentInList = identifyUsage(e);
          forEachCascadedProp(componentInList, (lhs, rhs) {
            if (lhs.propertyName.name == 'key') {
              hasKeyProp = true;
            }
          });
        }

        if (!hasKeyProp) {
          collector.addError(
            code,
            result.locationFor(list),
          );
        }
      } else if (argument is MethodInvocation) {
        //  2nd case: element mapping
        final mapStatement = argument;
        final mapStatementArgs = mapStatement.argumentList;
        final mapStatementElemArgs = mapStatementArgs.childEntities.whereType<InvocationExpression>();
        var hasKeyProp = false;

        for (final e in mapStatementElemArgs) {
          final componentUsage = getComponentUsage(e);
          forEachCascadedProp(componentUsage, (lhs, rhs) {
            if (lhs.propertyName.name == 'key') {
              hasKeyProp = true;
            }
          });
        }

        if (!hasKeyProp) {
          collector.addError(
            code,
            result.locationFor(mapStatement),
          );
        }
      }
    }
  }
}
