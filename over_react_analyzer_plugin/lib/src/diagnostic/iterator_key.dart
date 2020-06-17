import 'dart:developer';

import 'package:over_react/over_react.dart';
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

    // Handle 1st case: list literal w/o key
    if (arguments.length == 1 && arguments.single is ListLiteral) {
      var hasKeyProp = false;

      debugger();
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

    // Handle 2nd case: list literal w/o key
    print('usage node: ${usage.node}');

    final isIterable = arguments.single.staticType is Iterable;
    print('argument is iterable $isIterable');

    MethodInvocation mapStatement = arguments.single;
    print('map statement: $mapStatement');

    // ignore: omit_local_variable_types
    final ArgumentList mapStatementArgs = mapStatement.argumentList;
    print('mapargs: $mapStatementArgs');

    // todo: traverse the react elems in the map body and check for key prop;
    final mapStatementElemArgs = mapStatementArgs.childEntities.whereType<ReactElement>();
    print('mapStatementElemArgs: $mapStatementElemArgs');


    print('');
  }
}
