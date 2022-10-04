import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart' as analyzer_fs;
import 'package:over_react_analyzer_plugin/src/analysis_options/parse.dart';
import 'package:over_react_analyzer_plugin/src/analysis_options/plugin_analysis_options.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

/// An analysis_options.yaml reader that parses the appropriate analysis_options.yaml file
/// and returns the configuration options for the over react analyzer plugin.
///
/// The reader uses caching to reduce the number of file reads. If a result is given that uses the same
/// analysis_options.yaml as a previous result, the reader will return a cache version.
class PluginOptionsReader {
  final _cachedAnalysisOptions = <String, PluginAnalysisOptions?>{};

  PluginAnalysisOptions? getAnalysisOptionsForResult(PotentiallyResolvedResult result) =>
      getOptionsForContextRoot(result.session.analysisContext.contextRoot);

  PluginAnalysisOptions? getOptionsForContextRoot(ContextRoot root) {
    final file = root.optionsFile;
    if (file == null) return null;

    return getAnalysisOptionForFile(file);
  }

  PluginAnalysisOptions? getAnalysisOptionForFile(analyzer_fs.File file) {
    return _cachedAnalysisOptions.putIfAbsent(file.path, () {
      if (!file.exists) return null;
      return processAnalysisOptionsFile(file.readAsStringSync());
    });
  }
}
