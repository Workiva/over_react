// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class HashCodeAsKeyChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-hashcode-as-key';

  @override
  String get description =>
      'Verifies that `.hashCode` is not used as a React key since it is not unique';

  @override
  void visitComponentUsage(_, FluentComponentUsage usage) {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'key') {
        if (rhs.toSource().contains('.hashCode')) {
          emitWarning(
            message: '`hashCode` should not be used as a React key since it is not unique',
            offset: rhs.offset,
            end: rhs.end,
          );
        }
      }
    });
  }
}
