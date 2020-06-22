/// Misc utilities around dealing with ASTs, including some extensions.
library over_react_analyzer_plugin.src.ast_util;

import 'dart:collection';
import 'dart:mirrors';

// ignore: deprecated_member_use
// This is necessary for `ConstantEvaluator`. If that API is removed, it can just
// be copied and pasted into this analyzer package (if still needed).
import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/source/line_info.dart';

export 'package:over_react/src/builder/parsing/ast_util.dart';

/// Returns a lazy iterable of all descendants of [node], in breadth-first order.
Iterable<AstNode> allDescendants(AstNode node) sync* {
  final nodesQueue = Queue<AstNode>()..add(node);
  while (nodesQueue.isNotEmpty) {
    final current = nodesQueue.removeFirst();
    for (final child in current.childEntities) {
      if (child is AstNode) {
        yield child;
        nodesQueue.add(child);
      }
    }
  }
}

/// Returns a lazy iterable of all descendants of [node] of type [T], in breadth-first order.
Iterable<T> allDescendantsOfType<T extends AstNode>(AstNode node) => allDescendants(node).whereType<T>();

extension ClassOrMixinDeclarationUtils on ClassOrMixinDeclaration {
  /// Similar to [getField], but returns the entire declaration instead.
  FieldDeclaration getFieldDeclaration(String name) => getField(name).thisOrAncestorOfType<FieldDeclaration>();
}

int prevLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLine(lineInfo.getLocation(offset).lineNumber - 1);
}

int nextLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLineAfter(offset);
}

bool isAConstantValue(Expression expr) => expr.accept(ConstantEvaluator()) != ConstantEvaluator.NOT_A_CONSTANT;

/// Uses reflection to determine which value within [values] that [object] represents,
/// and returns the matching value.
///
/// Currently only works when the fields within [T] only contain core types and not other constant classes.
T getMatchingConst<T>(DartObject object, Iterable<T> values) {
  final classMirror = reflectClass(T);
  final objectTypeName = object.type.element.name;
  final valueTypeName = classMirror.simpleName.name;

  if (objectTypeName != valueTypeName) {
    throw ArgumentError('Object type $objectTypeName must exactly match value type $valueTypeName');
  }

  final fields =
      classMirror.instanceMembers.values.where((m) => m.isGetter && m.isSynthetic).map((m) => m.simpleName).toList();

  // Find the value where all fields are equal:
  return values.singleWhere((value) {
    return fields.every((field) {
      // Need to use the field symbol and not it converted back from a string or it won't work
      // for private members.
      final valueFieldValue = reflect(value).getField(field).reflectee;
      final objectFieldValue = object.getField(field.name).toWhateverValue();
      return valueFieldValue == objectFieldValue;
    });
  });
}

extension on DartObject {
  Object toWhateverValue() =>
      toBoolValue() ??
      toDoubleValue() ??
      toFunctionValue() ??
      toIntValue() ??
      toListValue() ??
      toMapValue() ??
      toSetValue() ??
      toStringValue() ??
      toSymbolValue() ??
      toTypeValue();
}

extension on Symbol {
  String get name => MirrorSystem.getName(this);
}
