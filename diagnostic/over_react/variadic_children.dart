import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:over_react/src/plugin/diagnostic/over_react/component_usage.dart';

class VariadicChildrenChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-variadic-children';

  @override
  String get description =>
      'Verifies that variadic children are used where possible instead of lists';

  @override
  void visitComponentUsage(
      CompilationUnitElement element, FluentComponentUsage usage) {
    final arguments = usage.node.argumentList.arguments;
    if (arguments.length == 1 && arguments.single is ListLiteral) {
      ListLiteral list = arguments.single;
      emitHint(
        // todo remove keys
        message: 'Variadic children should be used instead of lists where possible',
        offset: list.offset,
        end: list.end,
        // TODO preserve comments
        // todo is there a better way to get a replacement based on the source?
        fix: element.source.contents.data.substring(list.leftBracket.end, list.rightBracket.offset),
        fixMessage: 'Unwrap children from list literal',
      );
    }
  }
}
