import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:over_react_analyzer_plugin/src/config/config.dart';
import 'package:over_react_analyzer_plugin/src/config/parse.dart';

class ConfigReader {
  final cachedConfigs = <String, Config?>{};

  Config? getConfigForResult(ResolvedUnitResult result) {
    final file = result.session.analysisContext.contextRoot.optionsFile;
    if (file != null) {
      return _getConfigForFilePath(file);
    }

    return null;
  }

  Config? _getConfigForFilePath(File file) {
    if (cachedConfigs.containsKey(file.path)) {
      return cachedConfigs[file.path];
    }

    final config = _readConfigForFilePath(file);
    cachedConfigs[file.path] = config;
    return config;
  }

  Config? _readConfigForFilePath(File file) {
    final fileContents = file.readAsStringSync();
    return processAnalysisOptionsFile(fileContents);
  }
}
