// From analyzer 1.7.2 src/dart/ast/utilities.dart
// Permalink: https://github.com/dart-lang/sdk/blob/d97bd979570c4aacde322d8b04256ce477aa9729/pkg/analyzer/lib/src/dart/ast/utilities.dart
//
// Copyright 2013, the Dart project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

/// An object used to locate the [AstNode] associated with a source range, given
/// the AST structure built from the source. More specifically, they will return
/// the [AstNode] with the shortest length whose source range completely
/// encompasses the specified range.
class NodeLocator extends UnifyingAstVisitor<void> {
  /// The start offset of the range used to identify the node.
  final int _startOffset;

  /// The end offset of the range used to identify the node.
  final int _endOffset;

  /// The element that was found that corresponds to the given source range, or
  /// `null` if there is no such element.
  AstNode? _foundNode;

  /// Initialize a newly created locator to locate an [AstNode] by locating the
  /// node within an AST structure that corresponds to the given range of
  /// characters (between the [startOffset] and [endOffset] in the source.
  NodeLocator(int startOffset, [int? endOffset])
      : _startOffset = startOffset,
        _endOffset = endOffset ?? startOffset;

  /// Return the node that was found that corresponds to the given source range
  /// or `null` if there is no such node.
  AstNode? get foundNode => _foundNode;

  /// Search within the given AST [node] for an identifier representing an
  /// element in the specified source range. Return the element that was found,
  /// or `null` if no element was found.
  AstNode? searchWithin(AstNode? node) {
    if (node == null) {
      return null;
    }
    try {
      node.accept(this);
    } catch (_) {
      return null;
    }
    return _foundNode;
  }

  @override
  void visitNode(AstNode node) {
    // Don't visit a new tree if the result has been already found.
    if (_foundNode != null) {
      return;
    }
    // Check whether the current node covers the selection.
    var beginToken = node.beginToken;
    var endToken = node.endToken;
    // Don't include synthetic tokens.
    while (endToken != beginToken) {
      // Fasta scanner reports unterminated string literal errors
      // and generates a synthetic string token with non-zero length.
      // Because of this, check for length > 0 rather than !isSynthetic.
      if (endToken.type == TokenType.EOF || endToken.length > 0) {
        break;
      }
      endToken = endToken.previous!;
    }
    var end = endToken.end;
    var start = node.offset;
    if (end < _startOffset || start > _endOffset) {
      return;
    }
    // Check children.
    try {
      node.visitChildren(this);
    } catch (_) {
      // Ignore the exception and proceed in order to visit the rest of the
      // structure.
    }
    // Found a child.
    if (_foundNode != null) {
      return;
    }
    // Check this node.
    if (start <= _startOffset && _endOffset <= end) {
      _foundNode = node;
    }
  }
}

/// An object used to locate the [AstNode] associated with a source range.
/// More specifically, they will return the deepest [AstNode] which completely
/// encompasses the specified range.
class NodeLocator2 extends UnifyingAstVisitor<void> {
  /// The inclusive start offset of the range used to identify the node.
  final int _startOffset;

  /// The inclusive end offset of the range used to identify the node.
  final int _endOffset;

  /// The found node or `null` if there is no such node.
  AstNode? _foundNode;

  /// Initialize a newly created locator to locate the deepest [AstNode] for
  /// which `node.offset <= [startOffset]` and `[endOffset] < node.end`.
  ///
  /// If [endOffset] is not provided, then it is considered the same as the
  /// given [startOffset].
  NodeLocator2(int startOffset, [int? endOffset])
      : _startOffset = startOffset,
        _endOffset = endOffset ?? startOffset;

  /// Search within the given AST [node] and return the node that was found,
  /// or `null` if no node was found.
  AstNode? searchWithin(AstNode? node) {
    if (node == null) {
      return null;
    }
    try {
      node.accept(this);
    } catch (_) {
      return null;
    }
    return _foundNode;
  }

  @override
  void visitNode(AstNode node) {
    // Don't visit a new tree if the result has been already found.
    if (_foundNode != null) {
      return;
    }
    // Check whether the current node covers the selection.
    var beginToken = node.beginToken;
    var endToken = node.endToken;
    // Don't include synthetic tokens.
    while (endToken != beginToken) {
      // Fasta scanner reports unterminated string literal errors
      // and generates a synthetic string token with non-zero length.
      // Because of this, check for length > 0 rather than !isSynthetic.
      if (endToken.type == TokenType.EOF || endToken.length > 0) {
        break;
      }
      endToken = endToken.previous!;
    }
    var end = endToken.end;
    var start = node.offset;
    if (end <= _startOffset || start > _endOffset) {
      return;
    }
    // Check children.
    try {
      node.visitChildren(this);
    } catch (_) {
      // Ignore the exception and proceed in order to visit the rest of the
      // structure.
    }
    // Found a child.
    if (_foundNode != null) {
      return;
    }
    // Check this node.
    if (start <= _startOffset && _endOffset < end) {
      _foundNode = node;
    }
  }
}

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
class ConstantEvaluator extends GeneralizingAstVisitor<Object> {
  /// The value returned for expressions (or non-expression nodes) that are not
  /// compile-time constant expressions.
  static Object NOT_A_CONSTANT = Object();

  @override
  Object? visitAdjacentStrings(AdjacentStrings node) {
    final buffer = StringBuffer();
    for (final string in node.strings) {
      final value = string.accept(this);
      if (identical(value, NOT_A_CONSTANT)) {
        return value;
      }
      buffer.write(value);
    }
    return buffer.toString();
  }

  @override
  Object? visitBinaryExpression(BinaryExpression node) {
    final leftOperand = node.leftOperand.accept(this);
    if (identical(leftOperand, NOT_A_CONSTANT)) {
      return leftOperand;
    }
    final rightOperand = node.rightOperand.accept(this);
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
  Object visitBooleanLiteral(BooleanLiteral node) => node.value;

  @override
  Object visitDoubleLiteral(DoubleLiteral node) => node.value;

  @override
  Object? visitIntegerLiteral(IntegerLiteral node) => node.value;

  @override
  Object? visitInterpolationExpression(InterpolationExpression node) {
    final value = node.expression.accept(this);
    if (value == null || value is bool || value is String || value is num) {
      return value;
    }
    return NOT_A_CONSTANT;
  }

  @override
  Object visitInterpolationString(InterpolationString node) => node.value;

  @override
  Object? visitListLiteral(ListLiteral node) {
    final list = <Object?>[];
    for (final element in node.elements) {
      if (element is Expression) {
        final value = element.accept(this);
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
  Object visitMethodInvocation(MethodInvocation node) => visitNode(node);

  @override
  Object visitNode(AstNode node) => NOT_A_CONSTANT;

  @override
  Object? visitNullLiteral(NullLiteral node) => null;

  @override
  Object? visitParenthesizedExpression(ParenthesizedExpression node) => node.expression.accept(this);

  @override
  Object visitPrefixedIdentifier(PrefixedIdentifier node) => _getConstantValue(null);

  @override
  Object? visitPrefixExpression(PrefixExpression node) {
    final operand = node.operand.accept(this);
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
  Object visitPropertyAccess(PropertyAccess node) => _getConstantValue(null);

  @override
  Object visitSetOrMapLiteral(SetOrMapLiteral node) {
    // There are a lot of constants that this class does not support, so we
    // didn't add support for set literals. As a result, this assumes that we're
    // looking at a map literal until we prove otherwise.
    Map<String, Object?> map = HashMap<String, Object?>();
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
  Object visitSimpleIdentifier(SimpleIdentifier node) => _getConstantValue(null);

  @override
  Object visitSimpleStringLiteral(SimpleStringLiteral node) => node.value;

  @override
  Object? visitStringInterpolation(StringInterpolation node) {
    final buffer = StringBuffer();
    for (final element in node.elements) {
      final value = element.accept(this);
      if (identical(value, NOT_A_CONSTANT)) {
        return value;
      }
      buffer.write(value);
    }
    return buffer.toString();
  }

  @override
  Object visitSymbolLiteral(SymbolLiteral node) {
    // TODO(brianwilkerson) This isn't optimal because a Symbol is not a String.
    final buffer = StringBuffer();
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
  Object _getConstantValue(Element? element) {
    // TODO(brianwilkerson) Implement this
//    if (element is FieldElement) {
//      FieldElement field = element;
//      if (field.isStatic && field.isConst) {
//        //field.getConstantValue();
//      }
//      //    } else if (element instanceof VariableElement) {
//      //      VariableElement variable = (VariableElement) element;
//      //      if (variable.isStatic() && variable.isConst()) {
//      //        //variable.getConstantValue();
//      //      }
//    }
    return NOT_A_CONSTANT;
  }
}
