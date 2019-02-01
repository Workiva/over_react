import 'package:analyzer/dart/ast/ast.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/util.dart';

class ArrowFunctionPropCascadeChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-cascaded-arrow-functions';

  @override
  String get description =>
      '';

  @override
  void visitComponentUsage(CompilationUnit unit, FluentComponentUsage usage) {
    forEachCascadedProp(usage, (lhs, rhs) {
      if (rhs is FunctionExpression && rhs.body is ExpressionFunctionBody) {
        int wrapOffset = rhs.offset;
        int wrapEnd = rhs.end;

        final ExpressionFunctionBody body = rhs.body;
        final expression = body.expression;
        if (expression is CascadeExpression) {
          // todo do this intelligently based on indent
          wrapEnd = expression.target.end;
        }

        emitWarning(
          message: 'Unparenthesized arrow function values prevent subsequent cascades',
          offset: wrapOffset,
          end: wrapEnd,
          fixMessage: 'Wrap arrow function in parentheses',
          fix: '(' + unit.declaredElement.source.contents.data.substring(wrapOffset, wrapEnd) + ')'
        );
      }
    });
  }
}
