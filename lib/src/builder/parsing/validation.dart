// Copyright 2020 Workiva Inc.
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

import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:logging/logging.dart';
import 'package:source_span/source_span.dart';

import 'ast_util.dart';

/// A class for uniformly handling situations which require expressing warnings or
/// errors.
abstract class ErrorCollector {
  /// Creates a function compatible with the [ErrorCollectorCallback] signature
  /// that automatically handles the optional `span` that can be passed in.
  static ErrorCollectorCallback stringCallback(void Function(String) callback) {
    return (message, [span]) => callback(span?.message(message) ?? message);
  }

  ErrorCollector();

  /// Constructor to be used for a completely custom implementation of [onError]
  /// and [onWarning].
  ///
  /// The use of [stringCallback] may still be useful as it handles the [SourceSpan]
  /// but provides the opportunity to have implement custom logic.
  factory ErrorCollector.callback(
    SourceFile sourceFile, {
    ErrorCollectorCallback onError,
    ErrorCollectorCallback onWarning,
  }) = _CallbackErrorCollector;

  /// Constructor to simply log all messages and spans to the console.
  factory ErrorCollector.print(SourceFile sourceFile) {
    return _CallbackErrorCollector(
      sourceFile,
      onError: stringCallback(print),
      onWarning: stringCallback(print),
    );
  }

  /// Constructor that allows for the customization via the usage of a [Logger]
  /// instance.
  factory ErrorCollector.log(SourceFile sourceFile, Logger logger) {
    return _CallbackErrorCollector(
      sourceFile,
      onError: stringCallback(logger.severe),
      onWarning: stringCallback(logger.warning),
    );
  }

  SourceFile get _sourceFile;

  /// Triggers the callback that is implemented to respond to errors.
  void addError(String message, [SourceSpan span]);

  /// Triggers the callback that is implemented to respond to errors.
  void addWarning(String message, [SourceSpan span]);

  FileSpan spanFor(SyntacticEntity nodeOrToken) => _sourceFile.spanFor(nodeOrToken);
  FileSpan span(int start, [int end]) => _sourceFile.span(start, end);
}

typedef ErrorCollectorCallback = void Function(String message, [SourceSpan span]);

class _CallbackErrorCollector extends ErrorCollector {
  @override
  final SourceFile _sourceFile;
  final ErrorCollectorCallback onError;
  final ErrorCollectorCallback onWarning;

  _CallbackErrorCollector(
    this._sourceFile, {
    this.onError,
    this.onWarning,
  });

  /// Triggers the callback that is implemented to respond to errors.
  @override
  void addError(String message, [SourceSpan span]) => onError?.call(message, span);

  /// Triggers the callback that is implemented to respond to errors.
  @override
  void addWarning(String message, [SourceSpan span]) => onWarning?.call(message, span);
}
