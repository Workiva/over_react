import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/component_usage.dart';

class AnalyzerDebugHelper {
  AnalyzerDebugHelper([this.result, this.collector]);

  ResolvedUnitResult result;
  DiagnosticCollector collector;
  static const code = const ErrorCode(
      'over_react_debug_analyzer_plugin_helper',
      "{0}",
      AnalysisErrorSeverity.INFO,
      AnalysisErrorType.STATIC_WARNING,
    );


  log(String message, [ResolvedUnitResult new_result, DiagnosticCollector new_collector]) {
    this.result = new_result ?? result;
    this.collector = new_collector ?? collector;
    collector.addError(code, new Location(result.path, 0, 0, 1, 0),
                errorMessageArgs: [message]);
  }
}
