// Copyright 2015 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Copied from https://github.com/Workiva/dart_transformer_utils/tree/0.2.23/lib/

library;

import 'package:analyzer/dart/ast/ast.dart';

/// Returns a copy of a class [member] declaration with [body] as a new
/// implementation.
///
/// Currently only supports:
///   * [FieldDeclaration] (single variable only)
///   * [MethodDeclaration] (getter, setter, and methods)
String copyClassMember(ClassMember? member, String body) {
  if (member is FieldDeclaration) return _copyFieldDeclaration(member, body);
  if (member is MethodDeclaration) {
    if (member.isGetter) return _copyGetterDeclaration(member, body);
    if (member.isSetter) return _copySetterDeclaration(member, body);
    return _copyMethodDeclaration(member, body);
  }
  throw UnsupportedError('Unsupported class member type: ${member.runtimeType}. '
      'Only FieldDeclaration and MethodDeclaration are supported.');
}

/// Returns the value of the specified [expression] AST node if it represents a literal.
///
/// For non-literal nodes, the return value will be the result of calling [onUnsupportedExpression] with [expression].
///
/// If [onUnsupportedExpression] isn't specified, an [UnsupportedError] will be thrown.
///
/// Currently only supports:
///   * [StringLiteral]
///   * [BooleanLiteral]
///   * [IntegerLiteral]
///   * [NullLiteral]
dynamic getValue(Expression expression,
    {dynamic Function(Expression expression)? onUnsupportedExpression}) {
  if (expression is StringLiteral) {
    var value = expression.stringValue;
    if (value != null) {
      return value;
    }
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

  throw UnsupportedError('Unsupported expression: $expression. '
      'Must be a uninterpolated string, boolean, integer, or null literal.');
}

class AnnotationArgs {
  final Map<String, dynamic> named;
  final List<dynamic> positional;

  AnnotationArgs({required this.named, required this.positional});
}

AnnotationArgs getAnnotationArgs(Annotation annotation,
    {dynamic Function(Expression argument)? onUnsupportedArgument}) {
  Map<String, dynamic> namedParameters = {};
  List positionalParameters = [];

  annotation.arguments?.arguments.forEach((argument) {
    var onUnsupportedExpression =
        onUnsupportedArgument == null ? null : (_) => onUnsupportedArgument(argument);

    if (argument is NamedExpression) {
      var name = argument.name.label.name;
      var value = getValue(argument.expression, onUnsupportedExpression: onUnsupportedExpression);

      namedParameters[name] = value;
    } else {
      var value = getValue(argument, onUnsupportedExpression: onUnsupportedExpression);

      positionalParameters.add(value);
    }
  });

  return AnnotationArgs(
    named: namedParameters,
    positional: positionalParameters,
  );
}

String _copyFieldDeclaration(FieldDeclaration decl, String initializer) {
  var result = '';
  if (decl.fields.type != null) {
    result = '${decl.fields.type}';
  } else if (decl.staticKeyword == null) {
    result = 'var';
  }
  if (decl.staticKeyword != null) {
    result = '${decl.staticKeyword} $result';
  }
  result = '$result ${decl.fields.variables.first.name.lexeme}';
  if (initializer.isNotEmpty) {
    result = '$result = $initializer;';
  } else {
    result = '$result;';
  }
  return result;
}

String _copyGetterDeclaration(MethodDeclaration decl, String body) {
  var result = '';
  if (decl.returnType != null) {
    result = '${decl.returnType} get';
  } else {
    result = 'get';
  }
  if (decl.isStatic) {
    result = 'static $result';
  }

  result = '$result ${decl.name.lexeme}';
  if (decl.body.keyword != null) {
    result = '$result ${decl.body.keyword}${decl.body.star ?? ''}';
  }
  result = '$result {\n$body\n}';
  return result;
}

String _copySetterDeclaration(MethodDeclaration decl, String body) {
  var result = 'void set';
  if (decl.isStatic) {
    result = 'static $result';
  }
  result = '$result ${decl.name.lexeme}${decl.parameters} {\n$body\n  }';
  return result;
}

String _copyMethodDeclaration(MethodDeclaration decl, String body) {
  var result = '${decl.name.lexeme}';
  if (decl.returnType != null) {
    result = '${decl.returnType} $result';
  }
  if (decl.isStatic) {
    result = 'static $result';
  }
  result = '$result${decl.parameters}';
  if (decl.body.keyword != null) {
    result = '$result ${decl.body.keyword}${decl.body.star ?? ''}';
  }
  result = '$result {\n$body\n  }';
  return result;
}
