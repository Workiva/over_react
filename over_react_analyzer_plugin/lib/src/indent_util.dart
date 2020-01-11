import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';

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
/// the line in [sourceFile] containing [offset], up until [offset].
///
/// Example:
///
///     getIndent('  foo', 5); // '  '
///     getIndent('  foo', 2); // '  '
///     getIndent('  foo', 1); // ' '
String getIndent(String source, LineInfo info, int offset) {
  final beginningOfColumn = offset - (info.getLocation(offset).columnNumber - 1);
  final lineContentUpToOffset = source.substring(beginningOfColumn, offset);
  return RegExp(r'^ *')
      .firstMatch(lineContentUpToOffset)[0];
}

/// Returns whether [offsetA] and [offsetB] within [sourceFile] are on the same line.
bool isSameLine(LineInfo info, int offsetA, int offsetB) {
  return info.getLocation(offsetA).lineNumber ==
         info.getLocation(offsetB).lineNumber;
}
