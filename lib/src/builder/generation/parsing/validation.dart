import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:logging/logging.dart';
import 'package:source_span/source_span.dart';

import 'ast_util.dart';

abstract class ValidationErrorCollector {
  static ValidationErrorCallback stringCallback(void Function(String) callback) {
    return (message, [span]) => callback(span?.message(message) ?? message);
  }

  ValidationErrorCollector();

  factory ValidationErrorCollector.callback(
    SourceFile sourceFile, {
    ValidationErrorCallback onError,
    ValidationErrorCallback onWarning,
  }) = _CallbackValidationErrorCollector;

  factory ValidationErrorCollector.print(SourceFile sourceFile) {
    return _CallbackValidationErrorCollector(
      sourceFile,
      onError: stringCallback(print),
      onWarning: stringCallback(print),
    );
  }

  factory ValidationErrorCollector.log(SourceFile sourceFile, Logger logger) {
    return _CallbackValidationErrorCollector(
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

typedef ValidationErrorCallback = void Function(String message, [SourceSpan span]);

class _CallbackValidationErrorCollector extends ValidationErrorCollector {
  @override
  final SourceFile _sourceFile;
  final ValidationErrorCallback onError;
  final ValidationErrorCallback onWarning;

  _CallbackValidationErrorCollector(
    this._sourceFile, {
    this.onError,
    this.onWarning,
  });

  @override
  void addError(String message, [SourceSpan span]) => onError(message, span);
  @override
  void addWarning(String message, [SourceSpan span]) => onWarning(message, span);
}
