import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';

String getNodeSource(
  InvocationExpression node,
  String fileContent,
  LineInfo lineInfo, {
  int indent,
  int firstLineIndent,
}) {
  final src = fileContent.substring(node.offset, node.end);
  final nodeIndent = getIndent(fileContent, lineInfo, node.offset).length;

  if (indent == null || indent == nodeIndent) return (' ' * (firstLineIndent ?? 0)) + src;

  if (indent > nodeIndent) {
    // Increase indent

    if (firstLineIndent != indent) {
      final firstLine = (' ' * (firstLineIndent ?? 0)) + src.split('\n').first;
      final restOfTheLines = src.split('\n').skip(1).map((line) => (' ' * (indent - nodeIndent)) + line);
      final allLines = [firstLine, ...restOfTheLines];
      return allLines.join('\n');
    } else {
      return src.split('\n').map((line) => (' ' * (indent - nodeIndent)) + line).join('\n');
    }
  } else {
    // Decrease indent

    if (firstLineIndent != indent) {
      final firstLine = (' ' * (firstLineIndent ?? 0)) + src.split('\n').first;
      final restOfTheLines = src.split('\n').skip(1).map((line) => (' ' * (nodeIndent - indent)) + line);
      final allLines = [firstLine, ...restOfTheLines];
      return allLines.join('\n');
    } else {
      return src.split('\n').map((line) => line.replaceFirst(' ' * (nodeIndent - indent), '')).join('\n');
    }
  }
}
