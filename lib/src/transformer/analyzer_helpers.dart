library analyzer_helpers;

import 'dart:mirrors';

import 'package:analyzer/analyzer.dart';

/// Returns the value for the specified [expression] AST node.
///
/// Currently only supports:
///   * [StringLiteral]
///   * [BooleanLiteral]
///   * [IntegerLiteral]
///   * [NullLiteral]
dynamic getValue(Expression expression) {
  if (expression is StringLiteral) {
    return expression.stringValue;
  } else if (expression is BooleanLiteral) {
    return expression.value;
  } else if (expression is IntegerLiteral) {
    return expression.value;
  } else if (expression is NullLiteral) {
    return null;
  }

  throw 'Unsupported expression: $expression. Must be a string, boolean, integer, or null literal.';
}

/// Uses reflection to instantiate and returns the first annotation on [member] of type
/// [annotationType], or null if no matching annotations are found.
///
/// Annotation constructors are currently limited to the values supported by [getValue].
///
/// Naively assumes that the name the [annotationType] class is canonical.
dynamic instantiateAnnotation(AnnotatedNode member, Type annotationType) {
  // Be sure to use `originalDeclaration so that generic parameters work`
  ClassMirror classMirror = reflectClass(annotationType).originalDeclaration;
  String className = MirrorSystem.getName(classMirror.simpleName);

  // Find the annotation that matches [type]'s name.
  Annotation matchingAnnotation = member.metadata.firstWhere((annotation) {
    return annotation.name.name == className;
  }, orElse: () => null);

  // If no annotation is found, return null.
  if (matchingAnnotation == null) {
    return null;
  }

  if (matchingAnnotation.arguments == null) {
    throw 'Annotation not invocation of constructor: `$matchingAnnotation`. '
          'This is likely due to invalid usage of the annotation class, '
          'but could also be a name conflict with the specified type `$annotationType` ';
  }

  // Get the parameters from the annotation's AST.
  Map namedParameters = {};
  List positionalParameters = [];

  matchingAnnotation.arguments.arguments.forEach((expression) {
    if (expression is NamedExpression) {
      var name = (expression as NamedExpression).name.label.name;
      var value = getValue((expression as NamedExpression).expression);

      namedParameters[new Symbol(name)] = value;
    } else {
      var value = getValue(expression);

      positionalParameters.add(value);
    }
  });

  // Instantiate and return an instance of the annotation using reflection.
  String constructorName = matchingAnnotation.constructorName?.name ?? '';

  try {
    var instanceMirror = classMirror.newInstance(new Symbol(constructorName), positionalParameters, namedParameters);
    return instanceMirror.reflectee;
  } catch(e) {
    throw 'Unable to instantiate annotation: $matchingAnnotation. '
          'This is likely due to improper usage, or a naming conflict with annotationType $annotationType. '
          'Original error: $e.';
  }
}

/// Utility class that allows for easy access to an annotated node's instantiated annotation.
class NodeWithMeta<TNode extends AnnotatedNode, TMeta> {
  final TNode node;
  final TMeta meta;

  NodeWithMeta(unit)
      : this.node = unit,
        this.meta = instantiateAnnotation(unit, TMeta);
}
