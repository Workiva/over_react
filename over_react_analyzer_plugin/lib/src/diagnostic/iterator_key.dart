import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';
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
        final list = argument;
        for (final e in list.elements) {
          if (e is! InvocationExpression) continue; // Don't need to lint non-elements

          final componentUsage = getComponentUsage(e);
          if (componentUsage == null) continue;
          var elementHasKeyProp = _doesElementHaveKeyProp(componentUsage);

          if (!elementHasKeyProp) {
            // If current element in the list is missing a key prop, add warning & don't bother w/ remaining elements
            collector.addError(
              code,
              result.locationFor(list),
            );
            break;
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
        final FunctionExpression mapStatementFuncArg = mapStatement.argumentList.arguments[0];

        final body = mapStatementFuncArg.body;

        final returnExpression =
            body?.tryCast<ExpressionFunctionBody>()?.expression ??
                body?.tryCast<BlockFunctionBody>()?.block?.statements?.whereType<ReturnStatement>()?.firstOrNull?.expression;
        if (returnExpression is! InvocationExpression) continue; // Don't need to lint non-elements

        final componentUsage = getComponentUsage(returnExpression);
        if (componentUsage == null) continue;

        var elementHasKeyProp = _doesElementHaveKeyProp(componentUsage);

        if (!elementHasKeyProp) {
          collector.addError(
            code,
            result.locationFor(mapStatement),
          );
        }
      }
    }
  }

  bool _doesElementHaveKeyProp(FluentComponentUsage element) {
    var elementHasKeyProp = false;
    forEachCascadedProp(element, (lhs, rhs) {
      if (lhs.propertyName.name == 'key') {
        elementHasKeyProp = true;
      }
    });

    return elementHasKeyProp;
  }

  List<MethodInvocation> _buildInvocationList(MethodInvocation method) {
    // A list of all the methods that could possibly be chained to the input method
    final methodsInvoked = <MethodInvocation>[method];
    dynamic target = method.target;
    while (target != null) {
      if (target is MethodInvocation) {
        methodsInvoked.add(target);
        target = target.target;
      } else {
        return methodsInvoked;
      }
    }
    return methodsInvoked;
  }
}
