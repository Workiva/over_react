
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:source_span/source_span.dart';

import 'ast_util.dart';

abstract class ValidationErrorCollector {
  SourceFile get _sourceFile;

  void addError(String message, [SourceSpan span]);
  void addWarning(String message, [SourceSpan span]);

  FileSpan spanFor(SyntacticEntity nodeOrToken) => _sourceFile.spanFor(nodeOrToken);
  FileSpan span(int start, [int end]) => _sourceFile.span(start, end);
}

class CallbackValidationErrorCollector extends ValidationErrorCollector {
  @override
  final SourceFile _sourceFile;
  final void Function(String message, [SourceSpan span]) onError;
  final void Function(String message, [SourceSpan span]) onWarning;

  CallbackValidationErrorCollector(this._sourceFile, {
    this.onError,
    this.onWarning,
  });

  @override
  void addError(String message, [SourceSpan span]) => onError(message, span);
  @override
  void addWarning(String message, [SourceSpan span]) => onWarning(message, span);
}

class ConsoleValidationErrorCollector extends ValidationErrorCollector {
  @override
  final SourceFile _sourceFile;

  ConsoleValidationErrorCollector(this._sourceFile);

  @override
  void addError(String message, [SourceSpan span]) => print(span?.message(message) ?? message);
  @override
  void addWarning(String message, [SourceSpan span]) => print(span?.message(message) ?? message);
}
