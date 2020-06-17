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
  computeErrorsForUsage(ResolvedUnitResult result,
      DiagnosticCollector collector, FluentComponentUsage usage) async {
    final arguments = usage.node.argumentList.arguments;

    if (arguments.length == 1) {
      if (arguments.single is ListLiteral) {
        // Handle 1st case: list literal w/o key
        var hasKeyProp = false;

        ListLiteral list = arguments.single;
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
      }
      else if (arguments.single is MethodInvocation){
        print('arguments length: ${arguments.length}');
        //  Handle 2nd case: list literal w/o key
        MethodInvocation mapStatement = arguments.single;
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
