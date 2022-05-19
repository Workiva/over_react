import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:over_react_analyzer_plugin/src/config/config.dart';
import 'package:over_react_analyzer_plugin/src/config/parse.dart';

class ConfigReader {
  final cachedConfigs = <String, Future<Config?>>{};

  Future<Config?> getConfigForResult(ResolvedUnitResult result) async {
    final file = result.session.analysisContext.contextRoot.optionsFile;
    if (file != null) {
      return _getConfigForFilePath(file.path);
    }

    return null;
  }

  Future<Config?> _getConfigForFilePath(String filePath) async {
    if (cachedConfigs.containsKey(filePath)) {
      return cachedConfigs[filePath];
    }

    final config = _readConfigForFilePath(filePath);
    cachedConfigs[filePath] = config;
    return config;
  }

  Future<Config?> _readConfigForFilePath(String filePath) async {
    final fileContents = await File(filePath).readAsString();
    return processAnalysisOptionsFile(fileContents);
  }
}
