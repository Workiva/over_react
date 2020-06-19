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

    for (final argument in arguments) {
      if (argument is ListLiteral) {
        // 1st case: Any element in a list literal w/o key
        final list = argument;
        for (final e in list.elements) {
          var elementHasKeyProp = false;

          final curElement = identifyUsage(e);
          forEachCascadedProp(curElement, (lhs, rhs) {
            if (lhs.propertyName.name == 'key') {
              elementHasKeyProp = true;
            }
          });

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
        //  2nd case: element mapping
        // Build a list of all the nested method invocations
        MethodInvocation mapStatement;
        final invokedMeths = _buildTargetList(argument);
        for (final meth in invokedMeths) {
          if (meth.methodName.name == 'map') {
            mapStatement = meth;
          }
        }

        if (mapStatement == null) return; // if there was no map statement, nothing to lint

        final FunctionExpression mapStatementFuncArg = mapStatement.argumentList.arguments[0];
        final ExpressionFunctionBody mapFuncBody = mapStatementFuncArg.body;
        final elementMapped = getComponentUsage(mapFuncBody.expression);
        print('element mapped: $elementMapped');

        var elementsToMapTo = [elementMapped];

        for (final a in elementsToMapTo) {
          // If arg is InvocationExpression (e.g. ReactElement invocation), get the component for it and check its props
          var elemHasKeyProp = false;
          forEachCascadedProp(a, (lhs, rhs) {
            if (lhs.propertyName.name != 'key') {
              elemHasKeyProp = true;
            }
          });

          if (!elemHasKeyProp) {
            collector.addError(
              code,
              result.locationFor(mapStatement),
            );
          }
          else {
            // Anything that's not an InvocationExpression (e.g. a string) doesn't need a key prop
            break;
          }
        }
      }
    }
  }

// TODO: extract this out to util
  List<MethodInvocation> _buildTargetList(MethodInvocation method) {
    // a list of all the methods that could possibly be chained to the input method
    final methodsInvoked = <MethodInvocation>[method];
    dynamic target = method.target;
    while (target != null) {
      if (target is MethodInvocation) {
        methodsInvoked.add(method.target);
        target = target?.target;
      }
      else {
        return methodsInvoked;
      }
    }
    return methodsInvoked;
  }
}
