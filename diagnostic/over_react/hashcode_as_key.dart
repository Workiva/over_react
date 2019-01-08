import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/component_usage.dart';

class HashCodeAsKeyChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-hashcode-as-key';

  @override
  String get description =>
      'Verifies that `.hashCode` is not used as a React key since it is not unique';

  @override
  void visitComponentUsage(
      CompilationUnitElement element, FluentComponentUsage usage) {
    final cascade = usage.cascadeExpression;
    if (cascade == null) {
      return;
    }

    for (var section in cascade.cascadeSections) {
      if (section is AssignmentExpression) {
        final lhs = section.leftHandSide;
        if (lhs is PropertyAccess && lhs.propertyName.name == 'key') {
          final rhs = section.rightHandSide;
          if (rhs.toSource().contains('.hashCode')) {
            emitWarning(
              message: '`hashCode` should not be used as a React key since it is not unique',
              offset: section.offset,
              end: section.end,
            );
          }
        }
      }
    }
  }
}
