// Adapted from analyzer-0.39.17/lib/src/dart/ast/constant_evaluator.dart
// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

import 'util.dart';

/// Instances of the class [ConstantEvaluator] evaluate constant expressions to
/// produce their compile-time value.
///
/// According to the Dart Language Specification:
///
/// > A constant expression is one of the following:
/// >
/// > * A literal number.
/// > * A literal boolean.
/// > * A literal string where any interpolated expression is a compile-time
/// >   constant that evaluates to a numeric, string or boolean value or to
/// >   **null**.
/// > * A literal symbol.
/// > * **null**.
/// > * A qualified reference to a static constant variable.
/// > * An identifier expression that denotes a constant variable, class or type
/// >   alias.
/// > * A constant constructor invocation.
/// > * A constant list literal.
/// > * A constant map literal.
/// > * A simple or qualified identifier denoting a top-level function or a
/// >   static method.
/// > * A parenthesized expression _(e)_ where _e_ is a constant expression.
/// > * <span>
/// >   An expression of the form <i>identical(e<sub>1</sub>, e<sub>2</sub>)</i>
/// >   where <i>e<sub>1</sub></i> and <i>e<sub>2</sub></i> are constant
/// >   expressions and <i>identical()</i> is statically bound to the predefined
/// >   dart function <i>identical()</i> discussed above.
/// >   </span>
/// > * <span>
/// >   An expression of one of the forms <i>e<sub>1</sub> == e<sub>2</sub></i>
/// >   or <i>e<sub>1</sub> != e<sub>2</sub></i> where <i>e<sub>1</sub></i> and
/// >   <i>e<sub>2</sub></i> are constant expressions that evaluate to a
/// >   numeric, string or boolean value.
/// >   </span>
/// > * <span>
/// >   An expression of one of the forms <i>!e</i>, <i>e<sub>1</sub> &amp;&amp;
/// >   e<sub>2</sub></i> or <i>e<sub>1</sub> || e<sub>2</sub></i>, where
/// >   <i>e</i>, <i>e<sub>1</sub></i> and <i>e<sub>2</sub></i> are constant
/// >   expressions that evaluate to a boolean value.
/// >   </span>
/// > * <span>
/// >   An expression of one of the forms <i>~e</i>, <i>e<sub>1</sub> ^
/// >   e<sub>2</sub></i>, <i>e<sub>1</sub> &amp; e<sub>2</sub></i>,
/// >   <i>e<sub>1</sub> | e<sub>2</sub></i>, <i>e<sub>1</sub> &gt;&gt;
/// >   e<sub>2</sub></i> or <i>e<sub>1</sub> &lt;&lt; e<sub>2</sub></i>, where
/// >   <i>e</i>, <i>e<sub>1</sub></i> and <i>e<sub>2</sub></i> are constant
/// >   expressions that evaluate to an integer value or to <b>null</b>.
/// >   </span>
/// > * <span>
/// >   An expression of one of the forms <i>-e</i>, <i>e<sub>1</sub>
/// >   -e<sub>2</sub></i>, <i>e<sub>1</sub> * e<sub>2</sub></i>,
/// >   <i>e<sub>1</sub> / e<sub>2</sub></i>, <i>e<sub>1</sub> ~/
/// >   e<sub>2</sub></i>, <i>e<sub>1</sub> &gt; e<sub>2</sub></i>,
/// >   <i>e<sub>1</sub> &lt; e<sub>2</sub></i>, <i>e<sub>1</sub> &gt;=
/// >   e<sub>2</sub></i>, <i>e<sub>1</sub> &lt;= e<sub>2</sub></i> or
/// >   <i>e<sub>1</sub> % e<sub>2</sub></i>, where <i>e</i>,
/// >   <i>e<sub>1</sub></i> and <i>e<sub>2</sub></i> are constant expressions
/// >   that evaluate to a numeric value or to <b>null</b>.
/// >   </span>
/// > * <span>
/// >   An expression of one the form <i>e<sub>1</sub> + e<sub>2</sub></i>,
/// >   <i>e<sub>1</sub> -e<sub>2</sub></i> where <i>e<sub>1</sub> and
/// >   e<sub>2</sub></i> are constant expressions that evaluate to a numeric or
/// >   string value or to <b>null</b>.
/// >   </span>
/// > * <span>
/// >   An expression of the form <i>e<sub>1</sub> ? e<sub>2</sub> :
/// >   e<sub>3</sub></i> where <i>e<sub>1</sub></i>, <i>e<sub>2</sub></i> and
/// >   <i>e<sub>3</sub></i> are constant expressions, and <i>e<sub>1</sub></i>
/// >   evaluates to a boolean value.
/// >   </span>
///
/// However, this comment is now at least a little bit out of sync with the
/// spec.
///
/// The values returned by instances of this class are therefore `null` and
/// instances of the classes `Boolean`, `BigInteger`, `Double`, `String`, and
/// `DartObject`.
///
/// In addition, this class defines several values that can be returned to
/// indicate various conditions encountered during evaluation. These are
/// documented with the static fields that define those values.
class ConstantEvaluator extends GeneralizingAstVisitor<Object?> {
  /// The value returned for expressions (or non-expression nodes) that are not
  /// compile-time constant expressions.
  static Object NOT_A_CONSTANT = Object();

  @override
  Object? visitAdjacentStrings(AdjacentStrings node) {
    var buffer = StringBuffer();
    for (final string in node.strings) {
      var value = string.accept(this);
      if (identical(value, NOT_A_CONSTANT)) {
        return value;
      }
      buffer.write(value);
    }
    return buffer.toString();
  }

  @override
  Object? visitBinaryExpression(BinaryExpression node) {
    var leftOperand = node.leftOperand.accept(this);
    if (identical(leftOperand, NOT_A_CONSTANT)) {
      return leftOperand;
    }
    var rightOperand = node.rightOperand.accept(this);
    if (identical(rightOperand, NOT_A_CONSTANT)) {
      return rightOperand;
    }
    while (true) {
      if (node.operator.type == TokenType.AMPERSAND) {
        // integer or {@code null}
        if (leftOperand is int && rightOperand is int) {
          return leftOperand & rightOperand;
        }
      } else if (node.operator.type == TokenType.AMPERSAND_AMPERSAND) {
        // boolean or {@code null}
        if (leftOperand is bool && rightOperand is bool) {
          return leftOperand && rightOperand;
        }
      } else if (node.operator.type == TokenType.BANG_EQ) {
        // numeric, string, boolean, or {@code null}
        if (leftOperand is bool && rightOperand is bool) {
          return leftOperand != rightOperand;
        } else if (leftOperand is num && rightOperand is num) {
          return leftOperand != rightOperand;
        } else if (leftOperand is String && rightOperand is String) {
          return leftOperand != rightOperand;
        }
      } else if (node.operator.type == TokenType.BAR) {
        // integer or {@code null}
        if (leftOperand is int && rightOperand is int) {
          return leftOperand | rightOperand;
        }
      } else if (node.operator.type == TokenType.BAR_BAR) {
        // boolean or {@code null}
        if (leftOperand is bool && rightOperand is bool) {
          return leftOperand || rightOperand;
        }
      } else if (node.operator.type == TokenType.CARET) {
        // integer or {@code null}
        if (leftOperand is int && rightOperand is int) {
          return leftOperand ^ rightOperand;
        }
      } else if (node.operator.type == TokenType.EQ_EQ) {
        // numeric, string, boolean, or {@code null}
        if (leftOperand is bool && rightOperand is bool) {
          return leftOperand == rightOperand;
        } else if (leftOperand is num && rightOperand is num) {
          return leftOperand == rightOperand;
        } else if (leftOperand is String && rightOperand is String) {
          return leftOperand == rightOperand;
        }
      } else if (node.operator.type == TokenType.GT) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand.compareTo(rightOperand) > 0;
        }
      } else if (node.operator.type == TokenType.GT_EQ) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand.compareTo(rightOperand) >= 0;
        }
      } else if (node.operator.type == TokenType.GT_GT) {
        // integer or {@code null}
        if (leftOperand is int && rightOperand is int) {
          return leftOperand >> rightOperand;
        }
      } else if (node.operator.type == TokenType.LT) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand.compareTo(rightOperand) < 0;
        }
      } else if (node.operator.type == TokenType.LT_EQ) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand.compareTo(rightOperand) <= 0;
        }
      } else if (node.operator.type == TokenType.LT_LT) {
        // integer or {@code null}
        if (leftOperand is int && rightOperand is int) {
          return leftOperand << rightOperand;
        }
      } else if (node.operator.type == TokenType.MINUS) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand - rightOperand;
        }
      } else if (node.operator.type == TokenType.PERCENT) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand.remainder(rightOperand);
        }
      } else if (node.operator.type == TokenType.PLUS) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand + rightOperand;
        }
        if (leftOperand is String && rightOperand is String) {
          return leftOperand + rightOperand;
        }
      } else if (node.operator.type == TokenType.STAR) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand * rightOperand;
        }
      } else if (node.operator.type == TokenType.SLASH) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand / rightOperand;
        }
      } else if (node.operator.type == TokenType.TILDE_SLASH) {
        // numeric or {@code null}
        if (leftOperand is num && rightOperand is num) {
          return leftOperand ~/ rightOperand;
        }
      }
      break;
    }
    // TODO(brianwilkerson) This doesn't handle numeric conversions.
    return visitExpression(node);
  }

  @override
  Object? visitBooleanLiteral(BooleanLiteral node) => node.value;

  @override
  Object? visitDoubleLiteral(DoubleLiteral node) => node.value;

  @override
  Object? visitIntegerLiteral(IntegerLiteral node) => node.value;

  @override
  Object? visitInterpolationExpression(InterpolationExpression node) {
    var value = node.expression.accept(this);
    if (value == null || value is bool || value is String || value is num) {
      return value;
    }
    return NOT_A_CONSTANT;
  }

  @override
  Object? visitInterpolationString(InterpolationString node) => node.value;

  @override
  Object? visitListLiteral(ListLiteral node) {
    var list = <Object?>[];
    for (final element in node.elements) {
      if (element is Expression) {
        var value = element.accept(this);
        if (identical(value, NOT_A_CONSTANT)) {
          return value;
        }
        list.add(value);
      } else {
        // There are a lot of constants that this class does not support, so we
        // didn't add support for the extended collection support.
        return NOT_A_CONSTANT;
      }
    }
    return list;
  }

  @override
  Object? visitMethodInvocation(MethodInvocation node) => visitNode(node);

  @override
  Object? visitNode(AstNode node) => NOT_A_CONSTANT;

  @override
  Object? visitNullLiteral(NullLiteral node) => null;

  @override
  Object? visitParenthesizedExpression(ParenthesizedExpression node) => node.expression.accept<Object?>(this);

  @override
  Object? visitPrefixedIdentifier(PrefixedIdentifier node) => _getConstantValue(node.staticElement);

  @override
  Object? visitPrefixExpression(PrefixExpression node) {
    var operand = node.operand.accept(this);
    if (identical(operand, NOT_A_CONSTANT)) {
      return operand;
    }
    while (true) {
      if (node.operator.type == TokenType.BANG) {
        if (identical(operand, true)) {
          return false;
        } else if (identical(operand, false)) {
          return true;
        }
      } else if (node.operator.type == TokenType.TILDE) {
        if (operand is int) {
          return ~operand;
        }
      } else if (node.operator.type == TokenType.MINUS) {
        if (operand == null) {
          return null;
        } else if (operand is num) {
          return -operand;
        }
      } else {}
      break;
    }
    return NOT_A_CONSTANT;
  }

  @override
  Object? visitPropertyAccess(PropertyAccess node) {
    if (node.isCascaded) {
      return node.realTarget.accept<Object?>(this);
    }

    final constantValue = _getConstantValue(node.propertyName.staticElement);
    if (constantValue != NOT_A_CONSTANT) return constantValue;

    final targetparentPotentialConstant =
        node.target?.tryCast<PropertyAccess>()?.propertyName.staticElement ??
            node.target?.tryCast<Identifier>()?.staticElement;
    if (targetparentPotentialConstant != null) {
      final targetValue = _tryComputeConstantValue(targetparentPotentialConstant);
      if (targetValue != null) {
        final property = targetValue.getFieldOnThisOrSuper(node.propertyName.name);
        if (property != null) {
          return _tryConvertDartObject(property);
        }
      }
    }

    return NOT_A_CONSTANT;
  }

  @override
  Object? visitSetOrMapLiteral(SetOrMapLiteral node) {
    // There are a lot of constants that this class does not support, so we
    // didn't add support for set literals. As a result, this assumes that we're
    // looking at a map literal until we prove otherwise.
    final map = <String, Object?>{};
    for (final element in node.elements) {
      if (element is MapLiteralEntry) {
        final key = element.key.accept(this);
        final value = element.value.accept(this);
        if (key is String && !identical(value, NOT_A_CONSTANT)) {
          map[key] = value;
        } else {
          return NOT_A_CONSTANT;
        }
      } else {
        // There are a lot of constants that this class does not support, so
        // we didn't add support for the extended collection support.
        return NOT_A_CONSTANT;
      }
    }
    return map;
  }

  @override
  Object? visitSimpleIdentifier(SimpleIdentifier node) => _getConstantValue(node.staticElement);

  @override
  Object? visitSimpleStringLiteral(SimpleStringLiteral node) => node.value;

  @override
  Object? visitStringInterpolation(StringInterpolation node) {
    final buffer = StringBuffer();
    for (final element in node.elements) {
      var value = element.accept(this);
      if (identical(value, NOT_A_CONSTANT)) {
        return value;
      }
      buffer.write(value);
    }
    return buffer.toString();
  }

  @override
  Object? visitSymbolLiteral(SymbolLiteral node) {
    // TODO(brianwilkerson) This isn't optimal because a Symbol is not a String.
    var buffer = StringBuffer();
    for (final component in node.components) {
      if (buffer.length > 0) {
        buffer.writeCharCode(0x2E);
      }
      buffer.write(component.lexeme);
    }
    return buffer.toString();
  }

  /// Return the constant value of the static constant represented by the given
  /// [element].
  static Object? _getConstantValue(Element? element) {
    if (element == null) return NOT_A_CONSTANT;
    final constantValue = _tryComputeConstantValue(element);
    if (constantValue == null) return NOT_A_CONSTANT;
    return _tryConvertDartObject(constantValue);
  }

  static DartObject? _tryComputeConstantValue(Element? element) {
    if (element is VariableElement) {
      return element.computeConstantValue();
    }
    if (element is PropertyAccessorElement) {
      return element.variable.computeConstantValue();
    }

    return null;
  }

  static Object? _tryConvertDartObject(DartObject? object) {
    if (object == null) {
      return NOT_A_CONSTANT;
    }

    if (object.isNull) return null;

    {
      final primitiveValue = object.toBoolValue() ??
          object.toDoubleValue() ??
          object.toIntValue() ??
          object.toStringValue();
      if (primitiveValue != null) return primitiveValue;
    }
    // FIXME these shallow checks should be sufficient, and rule out any nested cases, right?
    {
      final listValue = object.toListValue();
      if (listValue != null) {
        final list = listValue.map(_tryConvertDartObject).toList();
        return list.contains(NOT_A_CONSTANT) ? NOT_A_CONSTANT : list;
      }
    }
    {
      final setValue = object.toSetValue();
      if (setValue != null) {
        final set = setValue.map(_tryConvertDartObject).toSet();
        return set.contains(NOT_A_CONSTANT) ? NOT_A_CONSTANT : set;
      }
    }
    {
      final mapValue = object.toMapValue();
      if (mapValue != null) {
        final map = mapValue.map(
            (key, value) => MapEntry(_tryConvertDartObject(key), _tryConvertDartObject(value)));
        return (map.containsKey(NOT_A_CONSTANT) || map.containsValue(NOT_A_CONSTANT))
            ? NOT_A_CONSTANT
            : map;
      }
    }

    return NOT_A_CONSTANT;
  }
}

extension on DartObject {
  DartObject? getFieldOnThisOrSuper(String fieldName) {
    return getField(fieldName) ?? getField('(super)')?.getFieldOnThisOrSuper(fieldName);
  }
}
