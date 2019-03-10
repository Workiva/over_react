// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' hide AnalysisError;
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';

export 'package:over_react_analyzer_plugin/src/component_usage.dart';

abstract class SubChecker {
  String get name;
  String get description;
  
  int modificationStamp;

  List<CheckerError> _errors = [];

  void emitHint({String message, int offset, int end, List<SourceEdit> fixEdits, String fixMessage}) {
    _errors.add(new CheckerError(name, message, offset, end, AnalysisErrorSeverity.INFO, AnalysisErrorType.LINT, fixEdits, fixMessage, modificationStamp));
  }
  void emitWarning({String message, int offset, int end, List<SourceEdit> fixEdits, String fixMessage}) {
    _errors.add(new CheckerError(name, message, offset, end,  AnalysisErrorSeverity.WARNING, AnalysisErrorType.LINT, fixEdits, fixMessage, modificationStamp));
  }
  void emitError({String message, int offset, int end, List<SourceEdit> fixEdits, String fixMessage}) {
    _errors.add(new CheckerError(name, message, offset, end,  AnalysisErrorSeverity.ERROR, AnalysisErrorType.LINT, fixEdits, fixMessage, modificationStamp));
  }

  List<CheckerError> getErrors() => _errors.toList();

  void clearErrors() {
    _errors.clear();
  }

  @mustCallSuper
  void check(ResolvedUnitResult result) {
    modificationStamp = result.unit?.declaredElement?.source?.modificationStamp;
  }
}


abstract class ComponentUsageChecker extends SubChecker {
  void visitComponentUsage(
  CompilationUnit unit, FluentComponentUsage usage);

  @override
  void check(ResolvedUnitResult result) {
    super.check(result);

    var astVisitor = new ComponentUsageVisitor(
    (usage) => visitComponentUsage(result.unit, usage));
    result.unit.accept(astVisitor);
  }
}

typedef void _OnComponent(FluentComponentUsage usage);

class ComponentUsageVisitor extends RecursiveAstVisitor<void> {
  ComponentUsageVisitor(this.onComponent);

  final _OnComponent onComponent;

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    return visitInvocationExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    return visitInvocationExpression(node);
  }

  void visitInvocationExpression(InvocationExpression node) {
    var usage = getComponentUsage(node);
    if (usage != null) {
      onComponent(usage);
    }

    node.visitChildren(this);
    return null;
  }
}

//
//class ComponentUsageElementVisitor extends RecursiveElementVisitor<void> {
//  final _OnComponent onComponent;
//
//  ComponentUsageElementVisitor(this.onComponent);
//
//  @override
//  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
//    return visitInvocationExpression(node);
//  }
//
//  @override
//  void visitMethodInvocation(MethodInvocation node) {
//    return visitInvocationExpression(node);
//  }
//
//  void visitInvocationExpression(InvocationExpression node) {
//    var usage = getComponentUsage(node);
//    if (usage != null) {
//      onComponent(usage);
//    }
//
//    node.visitChildren(this);
//    return null;
//  }
//}

class CheckerError {
  CheckerError(this.code, this.message, this.offset, this.end, this.severity, this.type, this.fixEdits, this.fixMessage, this.modificationStamp) {
    if (((offset == null) != (end == null)) ||
        ((offset == null) && fixEdits != null)) {
      throw new ArgumentError(
          'Offset, end and fixEdits must either all be null or all non-null. '
              'Got: offset $offset, end $end, fixEdits $fixEdits');
    }
  }

  /// The code of the error
  final String code;
  
  /// Error message for the user.
  final String message;

  /// Optionally, the offset of the incorrect code.
  final int offset;

  /// Optionally, the length of the incorrect code.
  final int end;

  final int modificationStamp;

  String fixMessage;

  List<SourceEdit> fixEdits;

  int get length => end - offset;

  AnalysisErrorSeverity severity;

  AnalysisErrorType type;

  bool get hasFix => fixEdits != null;
}
