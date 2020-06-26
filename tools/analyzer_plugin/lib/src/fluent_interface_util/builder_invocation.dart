import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:over_react_analyzer_plugin/src/util/react_types.dart';

const missingBuilderMessageSuffix = ' Are you missing the builder invocation?';
const missingBuilderFixMessage = 'Add builder invocation';

const addBuilderInvocationFix = FixKind('over_react_add_builder_invocation', 200, missingBuilderFixMessage);

bool couldBeMissingBuilderInvocation(Expression expression) => expression.staticType?.isPropsClass ?? false;

void buildMissingInvocationEdits(Expression expression, DartFileEditBuilder builder) {
  if (expression.unParenthesized != expression) {
    // Expression is already parenthesized
    builder.addSimpleInsertion(expression.end, '()');
  } else if (expression.parent is ParenthesizedExpression) {
    // Expression is the child of a parenthesized expression
    builder.addSimpleInsertion(expression.parent.end, '()');
  } else {
    if (expression is CascadeExpression) {
      // Expression is unparenthesized cascade
      builder.addSimpleInsertion(expression.offset, '(');
      builder.addSimpleInsertion(expression.end, ')()');
    } else {
      builder.addSimpleInsertion(expression.end, '()');
    }
  }
}
