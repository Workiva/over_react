import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/parse.dart';

class AnalysisOptionsReader {
  final _cachedAnalysisOptions = <String, PluginAnalysisOptions?>{};

  PluginAnalysisOptions? getAnalysisOptionsForResult(ResolvedUnitResult result) {
    final file = result.session.analysisContext.contextRoot.optionsFile;
    if (file != null) {
      return _getAnalysisOptionForFilePath(file);
    }

    return null;
  }

  PluginAnalysisOptions? _getAnalysisOptionForFilePath(File file) {
    if (_cachedAnalysisOptions.containsKey(file.path)) {
      return _cachedAnalysisOptions[file.path];
    }

    final _analysisOptions = _readAnalysisOptionForFilePath(file);
    _cachedAnalysisOptions[file.path] = _analysisOptions;
    return _analysisOptions;
  }

  PluginAnalysisOptions? _readAnalysisOptionForFilePath(File file) {
    final fileContents = file.readAsStringSync();
    return processAnalysisOptionsFile(fileContents);
  }
}
