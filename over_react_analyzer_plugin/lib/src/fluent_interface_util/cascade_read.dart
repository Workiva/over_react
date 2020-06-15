import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';

void forEachCascadedProp(FluentComponentUsage usage, void Function(PropertyAccess lhs, Expression rhs) f) {
  if (usage.cascadeExpression == null) return;

  for (final section in usage.cascadeExpression.cascadeSections) {
    if (section is AssignmentExpression) {
      final lhs = section.leftHandSide;
      if (lhs is PropertyAccess) {
        f(lhs, section.rightHandSide);
      }
    }
  }
}

Future<void> forEachCascadedPropAsync(
    FluentComponentUsage usage, FutureOr<void> Function(PropertyAccess lhs, Expression rhs) f) async {
  if (usage.cascadeExpression == null) return;

  for (final section in usage.cascadeExpression.cascadeSections) {
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

  for (final section in usage.cascadeExpression.cascadeSections) {
    if (section is AssignmentExpression) {
      final lhs = section.leftHandSide;
      if (lhs is PropertyAccess) {
        yield lhs.propertyName;
      }
    }
  }
}
