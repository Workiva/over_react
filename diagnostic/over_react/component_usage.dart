// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react/src/plugin/component_usage.dart';

export 'package:over_react/src/plugin/component_usage.dart';

abstract class _Checker {
  String get name;
  String get description;

  List<CheckerError> _errors = [];

  void emitHint({String message, int offset, int end, String fix, String fixMessage}) {
    _errors.add(new CheckerError(name, message, offset, end, AnalysisErrorSeverity.INFO, AnalysisErrorType.LINT, fix, fixMessage));
  }
  void emitWarning({String message, int offset, int end, String fix, String fixMessage}) {
    _errors.add(new CheckerError(name, message, offset, end,  AnalysisErrorSeverity.WARNING, AnalysisErrorType.LINT, fix, fixMessage));
  }

  List<CheckerError> getErrors() => _errors.toList();

  void clearErrors() {
    _errors.clear();
  }
}

abstract class ComponentUsageChecker extends SimpleElementVisitor<Null> with _Checker {
  void visitComponentUsage(
      CompilationUnitElement element, FluentComponentUsage usage);

  @override
  Null visitCompilationUnitElement(CompilationUnitElement element) {
    var astVisitor = new ComponentUsageVisitor(
        (usage) => visitComponentUsage(element, usage));
    element.computeNode().accept(astVisitor);

    return null;
  }
}

typedef void _OnComponent(FluentComponentUsage usage);

class ComponentUsageVisitor<R> extends RecursiveAstVisitor<R> {
  final _OnComponent onComponent;

  ComponentUsageVisitor(this.onComponent);

  @override
  R visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    return visitInvocationExpression(node);
  }

  @override
  R visitMethodInvocation(MethodInvocation node) {
    return visitInvocationExpression(node);
  }

  R visitInvocationExpression(InvocationExpression node) {
    var usage = getComponentUsage(node);
    if (usage != null) {
      onComponent(usage);
    }

    node.visitChildren(this);
    return null;
  }
}

class CheckerError {
  /// The code of the error
  final String code;
  
  /// Error message for the user.
  final String message;

  /// Optionally, the offset of the incorrect code.
  final int offset;

  /// Optionally, the length of the incorrect code.
  final int end;

  String fixMessage;

  int get length => end - offset;

  /// Optionally, the fix for the incorrect code.
  final String fix;

  AnalysisErrorSeverity severity;

  AnalysisErrorType type;

  CheckerError(this.code, this.message, this.offset, this.end, this.severity, this.type, this.fix, this.fixMessage) {
    if (((offset == null) != (end == null)) ||
        ((offset == null) && (fix != null))) {
      throw new ArgumentError(
          'Offset, end and fix must either all be null or all non-null. '
              'Got: offset $offset, end $end, fix $fix');
    }
  }
}
