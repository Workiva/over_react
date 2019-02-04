import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/util.dart';

class StringRefChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-string ref';

  @override
  String get description =>
      '';

  @override
  void visitComponentUsage(_, FluentComponentUsage usage) {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (lhs.propertyName.name == 'ref' && rhs.staticType.name == 'String') {
        emitWarning(
          message: 'String refs are deprecated. Use a callback ref instead.',
          offset: rhs.offset,
          end: rhs.end,
        );
      }
    });
  }
}
