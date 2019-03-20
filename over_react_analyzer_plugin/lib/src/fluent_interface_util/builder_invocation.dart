import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';


const String missingBuilderMessageSuffix = '\nAre you missing the builder invocation?';
const String missingBuilderFixMessage = 'Add builder invocation.';

bool couldBeMissingBuilderInvocation(Expression expression) {
  // TODO actually check against UiProps, or at the very least against Map
  return expression.staticType.name?.endsWith('Props') ?? false;
}

List<SourceEdit> getMissingInvocationBuilderEdits(Expression expression) {
  if (expression.unParenthesized != expression) {
    // Expression is already parenthesized
    return [
      new SourceEdit(expression.end, 0, '()'),
    ];
  } else if (expression.parent is ParenthesizedExpression) {
    // Expression is the child of a parenthesized expression
    return [
      new SourceEdit(expression.parent.end, 0, '()'),
    ];
  } else {
    if (expression is CascadeExpression) {
      // Expression is unparenthesized cascade
      return [
        new SourceEdit(expression.offset, 0, '('),
        new SourceEdit(expression.end + '('.length, 0, ')()'),
      ];
    } else {
      // Expression is unparenthesized without cascade
      return [
        new SourceEdit(expression.end, 0, '()'),
      ];
    }
  }
}
