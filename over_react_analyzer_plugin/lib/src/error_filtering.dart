// Adapted from package:analyzer/src/task/dart.dart
// The analyzer normally filters out errors with "ignore" comments,
// but it doesn't do it for plugin errors, so we need to do that in this plugin.

// ignore: implementation_imports
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/src/ignore_comments/ignore_info.dart' show IgnoreInfo; // ignore: implementation_imports
import 'package:analyzer_plugin/protocol/protocol_common.dart';

export 'package:analyzer/src/ignore_comments/ignore_info.dart' show IgnoreInfo; // ignore: implementation_imports

List<AnalysisError> filterIgnores(List<AnalysisError> errors, LineInfo lineInfo, IgnoreInfo Function() lazyIgnoreInfo) {
  if (errors.isEmpty) {
    return errors;
  }

  return _filterIgnored(errors, lazyIgnoreInfo(), lineInfo);
}

List<AnalysisError> _filterIgnored(List<AnalysisError> errors, IgnoreInfo ignoreInfo, LineInfo lineInfo) {
  if (errors.isEmpty || !ignoreInfo.hasIgnores) {
    return errors;
  }

  bool isIgnored(AnalysisError error) {
    final errorLine = lineInfo.getLocation(error.location.offset).lineNumber;
    final errorCode = error.code.toLowerCase();
    return ignoreInfo.ignoredAt(errorCode, errorLine);
  }

  return errors.where((e) => !isIgnored(e)).toList();
}
