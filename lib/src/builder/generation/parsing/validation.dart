import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:logging/logging.dart';
import 'package:source_span/source_span.dart';

import 'ast_util.dart';

abstract class ErrorCollector {
  static ErrorCollectorCallback stringCallback(void Function(String) callback) {
    return (message, [span]) => callback(span?.message(message) ?? message);
  }

  ErrorCollector();

  factory ErrorCollector.callback(
    SourceFile sourceFile, {
    ErrorCollectorCallback onError,
    ErrorCollectorCallback onWarning,
  }) = _CallbackErrorCollector;

  factory ErrorCollector.print(SourceFile sourceFile) {
    return _CallbackErrorCollector(
      sourceFile,
      onError: stringCallback(print),
      onWarning: stringCallback(print),
    );
  }

  factory ErrorCollector.log(SourceFile sourceFile, Logger logger) {
    return _CallbackErrorCollector(
      sourceFile,
      onError: stringCallback(logger.severe),
      onWarning: stringCallback(logger.warning),
    );
  }

  SourceFile get _sourceFile;

  void addError(String message, [SourceSpan span]);
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

  @override
  void addError(String message, [SourceSpan span]) => onError(message, span);
  @override
  void addWarning(String message, [SourceSpan span]) => onWarning(message, span);
}
