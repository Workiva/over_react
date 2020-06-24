import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
import 'package:over_react_analyzer_plugin/src/util/ast_util.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

/// Warn when missing `key` props in iterators/collection literals
class IteratorKey extends ComponentUsageDiagnosticContributor {
  static const code = DiagnosticCode(
    'over_react_missing_key',
    'Missing "key" prop for element in iterator',
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @override
  computeErrorsForUsage(ResolvedUnitResult result, DiagnosticCollector collector, FluentComponentUsage usage) async {
    final arguments = usage.node.argumentList.arguments;

    for (final argument in arguments) {
      if (argument is ListLiteral) {
        // 1st case: Any element in a list literal w/o key

        // Don't need to lint non-elements
        final componentUsagesInList = argument.elements
            .whereType<InvocationExpression>()
            .map(getComponentUsage)
            .whereNotNull();

        for (final usage in componentUsagesInList) {
          var elementHasKeyProp = _doesElementHaveKeyProp(usage);

          if (!elementHasKeyProp) {
            // If current element in the list is missing a key prop, add warning & don't bother w/ remaining elements
            collector.addError(
              code,
              result.locationFor(usage.node),
            );
          }
        }
      } else if (argument is MethodInvocation) {
        // 2nd case: Element mapping
        // Look through all method invocations (e.g. .map.toList()) until you find the mapping function
        MethodInvocation mapStatement;
        final invokedMethods = _buildInvocationList(argument);
        for (final method in invokedMethods) {
          if (method.methodName.name == 'map') {
            mapStatement = method;
          }
        }
        // If there's no `.map`, there's no elements returned, so nothing to lint for this arg
        if (mapStatement == null) continue;

        // Get the top level element that's being returned from the map
        final mapStatementFuncArg = mapStatement.argumentList.arguments.firstOrNull?.tryCast<FunctionExpression>();
        if (mapStatementFuncArg == null) continue;

        final returnedComponentUsages = mapStatementFuncArg.body.returnExpressions
            .whereType<InvocationExpression>()
            .map(getComponentUsage)
            .whereNotNull();
        for (final returnedUsage in returnedComponentUsages) {
          var elementHasKeyProp = _doesElementHaveKeyProp(returnedUsage);

          if (!elementHasKeyProp) {
            collector.addError(
              code,
              result.locationFor(returnedUsage.node),
            );
          }
        }
      }
    }
  }

  bool _doesElementHaveKeyProp(FluentComponentUsage element) =>
      element.cascadedProps.any((prop) => prop.name.name == 'key');

  List<MethodInvocation> _buildInvocationList(MethodInvocation method) {
    // A list of all the methods that could possibly be chained to the input method
    final methodsInvoked = <MethodInvocation>[];
    for (var current = method; current != null; current = current.target.tryCast<MethodInvocation>()) {
      methodsInvoked.add(current);
    }
    return methodsInvoked;
  }
}
