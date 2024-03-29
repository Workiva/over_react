// Adapted from https://github.com/dart-lang/sdk/blob/68bfd72e4490e2b5b9061fbdf4ce459bf1b22558/pkg/analyzer/lib/src/task/dart.dart
//
// Copyright 2013, the Dart project authors. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// The analyzer normally filters out errors with "ignore" comments,
// but it doesn't do it for plugin errors, so we need to do that in this plugin.

import 'package:analyzer/error/error.dart' as analyzer;
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as protocol;
import 'package:over_react_analyzer_plugin/src/util/ignore_info.dart';

List<protocol.AnalysisError> filterIgnoresForProtocolErrors(List<protocol.AnalysisError> errors, LineInfo lineInfo, IgnoreInfo Function() lazyIgnoreInfo) {
  if (errors.isEmpty) return errors;

  final ignoreInfo = lazyIgnoreInfo();
  if (!ignoreInfo.hasIgnores) return errors;

  bool isIgnored(protocol.AnalysisError error) {
    final errorLine = lineInfo.getLocation(error.location.offset).lineNumber;
    final errorCode = error.code.toLowerCase();
    return ignoreInfo.ignoredAt(errorCode, errorLine);
  }

  return errors.where((e) => !isIgnored(e)).toList();
}

List<analyzer.AnalysisError> filterIgnoresForErrors(List<analyzer.AnalysisError> errors, LineInfo lineInfo, IgnoreInfo Function() lazyIgnoreInfo) {
  if (errors.isEmpty) return errors;

  final ignoreInfo = lazyIgnoreInfo();
  if (!ignoreInfo.hasIgnores) return errors;

  bool isIgnored(analyzer.AnalysisError error) {
    final errorLine = lineInfo.getLocation(error.offset).lineNumber;
    return ignoreInfo.ignoredAt(error.errorCode.name, errorLine);
  }

  return errors.where((e) => !isIgnored(e)).toList();
}
