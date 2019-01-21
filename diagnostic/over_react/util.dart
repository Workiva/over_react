import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react/src/plugin/component_usage.dart';

void forEachCascadedProp(FluentComponentUsage usage, void f(PropertyAccess lhs, Expression rhs)) {
  if (usage.cascadeExpression == null) return;

  for (var section in usage.cascadeExpression.cascadeSections) {
    if (section is AssignmentExpression) {
      final lhs = section.leftHandSide;
      if (lhs is PropertyAccess) {
        f(lhs, section.rightHandSide);
      }
    }
  }
}
