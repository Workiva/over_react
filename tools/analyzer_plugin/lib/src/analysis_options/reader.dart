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
    if (_cachedAnalysisOptions.containsKey(file.path)) {
      // Cache hit
      return _cachedAnalysisOptions[file.path];
    }

    // Cache miss; read the file and add to the cache
    final _analysisOptions = _readAnalysisOptionForFilePath(file);
    _cachedAnalysisOptions[file.path] = _analysisOptions;
    return _analysisOptions;
  }

  PluginAnalysisOptions? _readAnalysisOptionForFilePath(File file) {
    final fileContents = file.readAsStringSync();
    return processAnalysisOptionsFile(fileContents);
  }
}
