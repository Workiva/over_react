import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

/// Warn when missing `key` props in iterators/collection literals
class IteratorKey extends ComponentUsageDiagnosticContributor {
  static const code = ErrorCode(
    'over_react_key',
    'Missing "key" prop for element in iterator',
    AnalysisErrorSeverity.WARNING,
    AnalysisErrorType.STATIC_WARNING,
  );

  @override
  computeErrorsForUsage(ResolvedUnitResult result, DiagnosticCollector collector, FluentComponentUsage usage) async {
    final arguments = usage.node.argumentList.arguments;

    // Handle 1st case: list literal w/o key
    // [Dom.div()(), Dom.div()(), Dom.div()()],
    if (arguments.length == 1 && arguments.single is ListLiteral) {
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

    // TODO: handle map case
//     if (arguments.)
//     coolStrings.map((s) => Dom.p()(s))
  }
}
