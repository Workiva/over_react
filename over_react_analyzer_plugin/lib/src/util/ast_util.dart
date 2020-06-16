library over_react_analyzer_plugin.src.ast_util;

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:meta/meta.dart';

part 'ast_utils/identifiers.dart';

extension ClassOrMixinDeclarationUtils on ClassOrMixinDeclaration {
  /// Similar to [getField], but returns the entire declaration instead.
  FieldDeclaration getFieldDeclaration(String name) =>
      childEntities.whereType<FieldDeclaration>().singleWhere((decl) => decl.fields.variables.single.name.name == name);
}

int prevLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLine(lineInfo.getLocation(offset).lineNumber - 1);
}

int nextLine(int offset, LineInfo lineInfo) {
  return lineInfo.getOffsetOfLineAfter(offset);
}
