import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/parse.dart';

/// An analysis_options.yaml reader that parses the appropriate analysis_options.yaml file for the given
/// [ResolvedUnitResult] and returns the configuration options for the over react analyzer plugin.
///
/// The reader uses caching to reduce the number of file reads. If a result is given that uses the same
/// analysis_options.yaml as a previous result, the reader will return a cache version.
class AnalysisOptionsReader {
  final _cachedAnalysisOptions = <String, PluginAnalysisOptions?>{};

  PluginAnalysisOptions? getAnalysisOptionsForResult(ResolvedUnitResult result) {
    final file = result.session.analysisContext.contextRoot.optionsFile;
    if (file != null) {
      return _getAnalysisOptionForFilePath(file);
    }

    // There is no analysis_options.yaml, so return null.
    return null;
  }

  PluginAnalysisOptions? _getAnalysisOptionForFilePath(File file) {
    return _cachedAnalysisOptions.putIfAbsent(file.path, () => _readAnalysisOptionForFilePath(file));
  }

  PluginAnalysisOptions? _readAnalysisOptionForFilePath(File file) {
    final fileContents = file.readAsStringSync();
    return processAnalysisOptionsFile(fileContents);
  }
}
