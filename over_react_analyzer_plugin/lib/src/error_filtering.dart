// Adapted from package:analyzer/src/task/dart.dart
// The analyzer normally filters out errors with "ignore" comments,
// but it doesn't do it for plugin errors, so we need to do that in this plugin.

// ignore: implementation_imports
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/src/task/dart.dart' show IgnoreInfo;
import 'package:analyzer_plugin/protocol/protocol_common.dart';

List<AnalysisError> filterIgnores(List<AnalysisError> errors, LineInfo lineInfo,  IgnoreInfo lazyIgnoreInfo()) {
  if (errors.isEmpty) {
    return errors;
  }

  return _filterIgnored(errors, lazyIgnoreInfo(), lineInfo);
}

List<AnalysisError> _filterIgnored(
    List<AnalysisError> errors, IgnoreInfo ignoreInfo, LineInfo lineInfo) {
  if (errors.isEmpty || !ignoreInfo.hasIgnores) {
    return errors;
  }

  bool isIgnored(AnalysisError error) {
    int errorLine = lineInfo.getLocation(error.location.offset).lineNumber;
    String errorCode = error.code.toLowerCase();
    return ignoreInfo.ignoredAt(errorCode, errorLine);
  }

  return errors.where((AnalysisError e) => !isIgnored(e)).toList();
}
