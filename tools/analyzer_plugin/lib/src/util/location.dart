import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';

extension ResultLocation on ResolvedUnitResult {
  Location location({
    int? offset,
    int? end,
    int? length,
    SourceRange? range,
  }) {
    if (range != null) {
      offset = range.offset;
      length = range.length;
      end = range.end;
    } else {
      if (offset == null) {
        throw ArgumentError.notNull('offset or range');
      }
      if (end != null && length != null) {
        throw ArgumentError('Cannot specify both `end` and `length`.');
      } else if (length != null) {
        end = offset + length;
      } else if (end != null) {
        length = end - offset;
      } else {
        end = offset;
        length = 0;
      }
    }

    final startInfo = lineInfo.getLocation(offset);
    final endInfo = lineInfo.getLocation(end);
    return Location(path!, offset, length, startInfo.lineNumber,
        startInfo.columnNumber, endInfo.lineNumber, endInfo.columnNumber);
  }

  Location locationFor(SyntacticEntity entity) {
    return location(offset: entity.offset, length: entity.length);
  }
}
