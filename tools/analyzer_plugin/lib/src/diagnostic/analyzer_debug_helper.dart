import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

/// Usage:
///     AnalyzerDebugHelper debug = new AnalyzerDebugHelper(result, collector);
class AnalyzerDebugHelper {
  AnalyzerDebugHelper(this.result, this.collector);

  final ResolvedUnitResult result;
  final DiagnosticCollector collector;
  static const code = DiagnosticCode(
    'over_react_debug_analyzer_plugin_helper',
    "{0}",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.STATIC_WARNING,
  );

  /// Usage:
  ///     AnalyzerDebugHelper debug = new AnalyzerDebugHelper(result, collector);
  ///     debug.log('message');
  void log(String message) {
    collector.addError(code, Location(result.path!, 0, 0, 1, 1, 1, 1), errorMessageArgs: [message]);
  }
}
