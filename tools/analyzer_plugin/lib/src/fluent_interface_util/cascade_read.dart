import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';

/// Finds things in the cascading setters within [usage] where the left side is a prop name,
/// and the right side is an [Expression] that the [PropertyAccess] is assigned to, calling [f] for each prop found.
///
/// If you are needing to match method invocations like `modifyProps()` within the cascade,
/// use [forEachCascadedMethod] instead.
///
/// > See also: [forEachCascadedPropAsync]
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

/// A version of [forEachCascadedProp] where the [f] callback called on each prop is awaited.
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

/// Finds [MethodInvocation]s in the cascading setters within [usage], calling [f] for each method found.
///
/// > See also: [forEachCascadedMethodAsync]
void forEachCascadedMethod(
    FluentComponentUsage usage, void Function(SimpleIdentifier methodIdentifier, ArgumentList args) f) {
  if (usage.cascadeExpression == null) return;

  for (final section in usage.cascadeExpression.cascadeSections) {
    if (section is MethodInvocation) {
      f(section.methodName, section.argumentList);
    }
  }
}

/// A version of [forEachCascadedProp] where the [f] callback called on each prop is awaited.
Future<void> forEachCascadedMethodAsync(
    FluentComponentUsage usage, FutureOr<void> Function(SimpleIdentifier methodIdentifier, ArgumentList args) f) async {
  if (usage.cascadeExpression == null) return;

  for (final section in usage.cascadeExpression.cascadeSections) {
    if (section is MethodInvocation) {
      await f(section.methodName, section.argumentList);
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
