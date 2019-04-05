// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class DuplicatePropCascadeDiagnostic extends ComponentUsageDiagnosticContributor {
  @override
  String get name => 'over-react-duplicate-prop-cascade';

  @override
  String get description =>
      'Verifies that props aren\'t set more than once in the same cascade, which is usually a typo.';

  @override
  void visitComponentUsage(_, FluentComponentUsage usage) {
    final propUsagesByName = <String, List<PropertyAccess>>{};
    forEachCascadedProp(usage, (lhs, rhs) {
      propUsagesByName.putIfAbsent(lhs.propertyName.name, () => []).add(lhs);
    });

    propUsagesByName.forEach((name, usages) {
      if (usages.length > 1) {
        for (var i = 0; i < usages.length; i++) {
          final lhs = usages[i];
          addHint(
            message:
                'Prop `$name` is cascaded multiple times (${i + 1} of ${usages.length}). This is most likely a typo.',
            offset: lhs.offset,
            end: lhs.end,
          );
        }
      }
    });
  }
}
