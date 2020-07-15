import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/util/util.dart';

import 'cascade_edits.dart';

extension UsageCascades on FluentComponentUsage {
  Iterable<Expression> get _cascadeSections => cascadeExpression?.cascadeSections ?? const [];

  /// Returns an iterable of all cascaded prop assignments in this usage.
  ///
  /// See also: [cascadedMethodInvocations]
  Iterable<PropAssignment> get cascadedProps => _cascadeSections
      .whereType<AssignmentExpression>()
      .where((assignment) => assignment.leftHandSide is PropertyAccess)
      .map((assignment) => PropAssignment(assignment));

  /// Returns an iterable of all cascaded method calls in this usage.
  Iterable<MethodInvocation> get cascadedMethodInvocations => _cascadeSections.whereType<MethodInvocation>();
}

class PropAssignment {
  /// The cascaded assignment expression that backs this assignment.
  final AssignmentExpression assignment;

  PropAssignment(this.assignment) : assert(assignment.leftHandSide is PropertyAccess);

  /// The property access representing the left hand side of this assignment.
  PropertyAccess get leftHandSide => assignment.leftHandSide as PropertyAccess;

  /// The expression for the right hand side of this assignment.
  Expression get rightHandSide => assignment.rightHandSide;

  /// The name of the prop being assigned.
  Identifier get name => leftHandSide.propertyName;

  /// The "target" of the [name].
  ///
  /// For example, the value of `targetName.name` in the expression below is "aria":
  ///
  /// ```dart
  /// ..aria.label = 'foo'
  /// ```
  Identifier get targetName => leftHandSide.target?.tryCast<PropertyAccess>()?.propertyName;

  /// Returns the name of the mixin the prop lives within that serves as its "namespace".
  String get namespace => leftHandSide.propertyName.staticElement.enclosingElement.name;

  /// A range that can be used in a `builder.addDeletion` call to remove this prop.
  ///
  /// Includes the space between the previous token and the start of this assignment, so that
  /// the entire prop line is removed.
  ///
  /// __Note: prefer using [removeProp] instead of using this directly to perform removals__
  @protected
  SourceRange get rangeForRemoval => range.endEnd(assignment.beginToken.previous, assignment);
}

// TODO remove once all in-flight PRs that might be consuming this are merged
@Deprecated('Use FluentComponentUsage.cascadedProps instead')
void forEachCascadedProp(FluentComponentUsage usage, void Function(PropertyAccess lhs, Expression rhs) f) {
  for (final prop in usage.cascadedProps) {
    f(prop.leftHandSide, prop.rightHandSide);
  }
}

// TODO remove once all in-flight PRs that might be consuming this are merged
@Deprecated('Use FluentComponentUsage.cascadedProps instead')
Future<void> forEachCascadedPropAsync(
    FluentComponentUsage usage, FutureOr<void> Function(PropertyAccess lhs, Expression rhs) f) async {
  for (final prop in usage.cascadedProps) {
    await f(prop.leftHandSide, prop.rightHandSide);
  }
}

// TODO remove once all in-flight PRs that might be consuming this are merged
@Deprecated('Use FluentComponentUsage.cascadedMethods instead')
void forEachCascadedMethod(
    FluentComponentUsage usage, void Function(SimpleIdentifier methodIdentifier, ArgumentList args) f) {
  for (final invocation in usage.cascadedMethodInvocations) {
    f(invocation.methodName, invocation.argumentList);
  }
}

// TODO remove once all in-flight PRs that might be consuming this are merged
@Deprecated('Use FluentComponentUsage.cascadedMethods instead')
Future<void> forEachCascadedMethodAsync(
    FluentComponentUsage usage, FutureOr<void> Function(SimpleIdentifier methodIdentifier, ArgumentList args) f) async {
  for (final invocation in usage.cascadedMethodInvocations) {
    await f(invocation.methodName, invocation.argumentList);
  }
}
