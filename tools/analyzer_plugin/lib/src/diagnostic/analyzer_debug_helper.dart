import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

/// Usage:
///     final debug = AnalyzerDebugHelper(result, collector);
class AnalyzerDebugHelper {
  /// Whether debug messages are enabled.
  bool enabled;

  AnalyzerDebugHelper(this.result, this.collector, {this.enabled = false});

  final ResolvedUnitResult result;
  final DiagnosticCollector collector;
  static const code = DiagnosticCode(
    'over_react_debug_analyzer_plugin_helper',
    "{0}",
    AnalysisErrorSeverity.INFO,
    AnalysisErrorType.STATIC_WARNING,
  );

  /// Logs a debug message at a given location.
  ///
  /// [computeMessage] and [computeLocation] are only called when [enabled],
  /// allowing potentially expensive computations to be easily skipped when they're not needed.
  ///
  /// Usage:
  ///     final debug = AnalyzerDebugHelper(result, collector);
  ///     debug.log2(() => 'message', () => result.locationFor(node));
  void log(String Function() computeMessage, [Location Function()? computeLocation]) {
    if (!enabled) return;

    final message = computeMessage();
    final location = computeLocation != null ? computeLocation() : Location(result.path, 0, 0, 1, 1);
    collector.addError(code, location, errorMessageArgs: [message]);
  }
}

/// Returns a pattern that matches a file with a `// debug:` comment with the given [debugCode].
///
/// Useful for conditionally enabling [AnalyzerDebugHelper] infos based on the presence of a comment
/// in a file.
///
/// For example, `getDebugCommentPattern('foo')` will match files containing the following comments:
///
/// - `// debug: foo`
/// - `//debug:foo,bar`
RegExp getDebugCommentPattern(String debugCode) => RegExp(r'//\s*debug:.*\b' + RegExp.escape(debugCode) + r'\b');
