import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:source_span/source_span.dart';

/// Indents the content at [offset] with [indent].
///
/// Example:
///
///     setIndent('  foo', 2, ' ');    // ' foo'
SourceEdit setIndent(String source, LineInfo info, int offset, String indent) {
  var column = info.getLocation(offset).columnNumber - 1;
  return SourceEdit(offset - column, column, indent);
}

/// Returns the whitespace characters, or "indent" from the start of
/// the line in [source] containing [offset], up until [offset].
///
/// Example:
///
///     getIndent('  foo', 5); // '  '
///     getIndent('  foo', 2); // '  '
///     getIndent('  foo', 1); // ' '
String getIndent(String source, LineInfo info, int offset) {
  final beginningOfColumn = offset - (info.getLocation(offset).columnNumber - 1);
  final lineContentUpToOffset = source.substring(beginningOfColumn, offset);
  return RegExp(r'^ *').firstMatch(lineContentUpToOffset)[0];
}

/// Returns whether [offsetA] and [offsetB] within are on the same line, according to [info[.
bool isSameLine(LineInfo info, int offsetA, int offsetB) {
  return info.getLocation(offsetA).lineNumber == info.getLocation(offsetB).lineNumber;
}

extension SourceFileTools on SourceFile {
  /// Returns the starting offset for the line after the provided offset.
  int getOffsetForLineAfter(int offset) {
    return getOffset(getLine(offset) + 1);
  }

  /// Returns the starting offset for the line before the provided offset.
  int getOffsetForLineBefore(int offset) {
    return getOffset(getLine(offset) - 1);
  }

  /// Grabs a range that is comprised of an entire AstNode plus the entire line
  /// before and the start of the line after.
  SourceRange getEncompassingRangeFor(AstNode node) {
    final startingOffset = getOffsetForLineBefore(node.offset);
    final endingOffset = getOffsetForLineAfter(node.end);

    return SourceRange(startingOffset, endingOffset - startingOffset);
  }
}
