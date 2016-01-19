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
dynamic getValue(Expression expression, {
    dynamic onUnsupportedExpression(Expression expression)
}) {
  if (expression is StringLiteral) {
    var value = expression.stringValue;
    if (value == null) {
      throw 'Unsupported expression: Must not be an interpolated string. Was: $expression.';
    }
    return value;
  } else if (expression is BooleanLiteral) {
    return expression.value;
  } else if (expression is IntegerLiteral) {
    return expression.value;
  } else if (expression is NullLiteral) {
    return null;
  }

  if (onUnsupportedExpression != null) {
    return onUnsupportedExpression(expression);
  }

  throw 'Unsupported expression: Must be a string, boolean, integer, or null literal. Was: $expression.';
}

/// Returns the name of the class being instantiated for [annotation],
/// or null if the annotation is not the invocation of a constructor.
///
/// Workaround for a Dart analyzer issue where the constructor name is included in [annotation.name].
String _getClassName(Annotation annotation) {
  var className = annotation.name?.name;
  if (className != null) {
    className = className.split('.').first;
  }

  return className;
}

/// Returns the name of the constructor being instantiated for [annotation],
/// or null if the annotation is not the invocation of a named constructor.
///
/// Workaround for a Dart analyzer issue where the constructor name is included in [annotation.name].
String _getConstructorName(Annotation annotation) {
  var constructorName = annotation.constructorName?.name;
  if (constructorName == null) {
    var periodIndex = annotation.name.name.indexOf('.');
    if (periodIndex != -1) {
      constructorName = annotation.name.name.substring(periodIndex + 1);
    }
  }

  return constructorName;
}

/// Returns the first annotation AST node on [member] of type [annotationType],
/// or null if no matching annotations are found.
Annotation getMatchingAnnotation(AnnotatedNode member, Type annotationType) {
  // Be sure to use `originalDeclaration` so that generic parameters work.
  ClassMirror classMirror = reflectClass(annotationType).originalDeclaration;
  String className = MirrorSystem.getName(classMirror.simpleName);

  // Find the annotation that matches [type]'s name.
  return member.metadata.firstWhere((annotation) {
    return _getClassName(annotation) == className;
  }, orElse: () => null);
}

/// Uses reflection to instantiate and returns the first annotation on [member] of type
/// [annotationType], or null if no matching annotations are found.
///
/// Annotation constructors are currently limited to the values supported by [getValue].
///
/// Naively assumes that the name of the [annotationType] class is canonical.
dynamic instantiateAnnotation(AnnotatedNode member, Type annotationType, {
    dynamic onUnsupportedArgument(Expression argument)
}) {
  var matchingAnnotation = getMatchingAnnotation(member, annotationType);

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

  matchingAnnotation.arguments.arguments.forEach((argument) {
    var onUnsupportedExpression =
        onUnsupportedArgument == null ? null : (_) => onUnsupportedArgument(argument);

    if (argument is NamedExpression) {
      var name = argument.name.label.name;
      var value = getValue(argument.expression,
          onUnsupportedExpression: onUnsupportedExpression);

      namedParameters[new Symbol(name)] = value;
    } else {
      var value = getValue(argument,
          onUnsupportedExpression: onUnsupportedExpression);

      positionalParameters.add(value);
    }
  });

  // Instantiate and return an instance of the annotation using reflection.
  String constructorName = _getConstructorName(matchingAnnotation) ?? '';

  // Be sure to use `originalDeclaration` so that generic parameters work.
  ClassMirror classMirror = reflectClass(annotationType).originalDeclaration;

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
  /// The optionally annotated node.
  final TNode node;

  /// The node of the [TMeta] annotation, if it exists.
  final Annotation metaNode;

  /// A reflectively-instantiated version of [metaNode], if it exists.
  TMeta _meta;

  /// The arguments passed to the metadata that are not supported by [getValue],
  /// (or by special handling in subclasses) and therefore not represented in the instantiation of [meta].
  List<Expression> unsupportedArguments;

  NodeWithMeta(TNode node)
      : this.node = node,
        this.metaNode = getMatchingAnnotation(node, TMeta)
  {
    this.unsupportedArguments = <Expression>[];
    this._meta = instantiateAnnotation(node, TMeta, onUnsupportedArgument: this.unsupportedArguments.add);
  }

  /// Whether this node's metadata has arguments that could not be initialized using [getValue]
  /// (or by special handling in subclasses), and therefore cannot represented in the instantiation of [meta].
  bool get isIncomplete => unsupportedArguments.isNotEmpty;

  /// A reflectively-instantiated version of [metaNode], if it exists.
  ///
  /// Throws a [StateError] if this node's metadata is incomplete.
  TMeta get meta {
    if (isIncomplete) {
      throw new StateError('Metadata is incomplete; unsupported arguments $unsupportedArguments. Use `incompleteMeta` instead.');
    }
    return _meta;
  }

  /// A reflectively-instantiated version of [metaNode], if it exists.
  TMeta get potentiallyIncompleteMeta => _meta;
}
