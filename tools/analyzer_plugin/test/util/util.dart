// From https://github.com/Workiva/over_react_codemod/blob/a14a4ef372a1b2c2a625755cec7a6f956a074650/lib/src/util.dart
import 'package:analyzer/error/error.dart';
import 'package:analyzer/source/line_info.dart';

String prettyPrintErrors(Iterable<AnalysisError> errors,
    {LineInfo? lineInfo, bool includeFilename = true}) {
  return errors.map((e) {
    final severity = e.errorCode.errorSeverity.name.toLowerCase();
    final errorCode = e.errorCode.name.toLowerCase();
    final location =
        lineInfo?.getLocation(e.offset).toString() ?? 'offset ${e.offset}';
    final filename = e.source.shortName;

    return " - [$severity] ${e.message} ($errorCode at${includeFilename ? ' $filename' : ''} $location)";
  }).join('\n');
}

String blockComment(String contents) => '/*$contents*/';

String lineComment(String contents) =>
    contents.split('\n').map((line) => '// $line\n').join('');
