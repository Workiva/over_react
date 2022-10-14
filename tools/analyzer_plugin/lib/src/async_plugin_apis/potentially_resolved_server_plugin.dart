// Copyright 2022 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:analyzer/dart/analysis/results.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/driver.dart' show AnalysisDriver;
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:over_react_analyzer_plugin/src/util/potentially_resolved_result.dart';

enum RunMode {
  resolved,
  unresolved,
}

mixin PotentiallyResolvedServerPlugin on ServerPlugin {
  RunMode get runMode;

  Future<PotentiallyResolvedResult> getPotentiallyResolvedResult(String path) async => runMode == RunMode.resolved
      ? PotentiallyResolvedResult.resolved(await getResolvedUnitResult(path))
      : PotentiallyResolvedResult.unresolved(getUnResolvedUnitResult(path));

  /// Return the result of analyzing the file with the given [path].
  ///
  /// Throw a [RequestFailure] is the file cannot be analyzed or if the driver
  /// associated with the file is not an [AnalysisDriver].
  ParsedUnitResult getUnResolvedUnitResult(String path) {
    var driver = driverForPath(path);
    if (driver is! AnalysisDriver) {
      // Return an error from the request.
      throw RequestFailure(RequestErrorFactory.pluginError('Failed to parse $path', null));
    }
    var result = driver.parseFileSync2(path);
    if (result is! ParsedUnitResult) {
      // Return an error from the request.
      throw RequestFailure(RequestErrorFactory.pluginError('Failed to parse $path', null));
    }
    return result;
  }
}
