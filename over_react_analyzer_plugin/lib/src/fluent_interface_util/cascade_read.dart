import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/optional.dart';

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

Future<void> forEachCascadedPropAsync(FluentComponentUsage usage, FutureOr<void> f(PropertyAccess lhs, Expression rhs)) async {
  if (usage.cascadeExpression == null) return;

  for (var section in usage.cascadeExpression.cascadeSections) {
    if (section is AssignmentExpression) {
      final lhs = section.leftHandSide;
      if (lhs is PropertyAccess) {
        await f(lhs, section.rightHandSide);
      }
    }
  }
}


Iterable<SimpleIdentifier> getSetPropNames(FluentComponentUsage usage) sync* {
  if (usage.cascadeExpression == null) return;

  for (var section in usage.cascadeExpression.cascadeSections) {
    if (section is AssignmentExpression) {
      final lhs = section.leftHandSide;
      if (lhs is PropertyAccess) {
        yield lhs.propertyName;
      }
    }
  }
}
