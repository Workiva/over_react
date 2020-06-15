import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';

/// Usage:
///     AnalyzerDebugHelper debug = new AnalyzerDebugHelper(result, collector);
class AnalyzerDebugHelper {
  AnalyzerDebugHelper([this.result, this.collector]);

  ResolvedUnitResult result;
  DiagnosticCollector collector;
  static const code = ErrorCode(
    'over_react_debug_analyzer_plugin_helper',
    "{0}",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.STATIC_WARNING,
  );

  /// Usage:
  ///     AnalyzerDebugHelper debug = new AnalyzerDebugHelper(result, collector);
  ///     debug.log('message');
  void log(String message, [ResolvedUnitResult new_result, DiagnosticCollector new_collector]) {
    result = new_result ?? result;
    collector = new_collector ?? collector;
    collector.addError(code, Location(result.path, 0, 0, 1, 0), errorMessageArgs: [message]);
  }
}
