// Adapted from dart_medic `misc` branch containing over_react diagnostics

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';

class VariadicChildrenChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-variadic-children';

  @override
  String get description =>
      'Verifies that variadic children are used where possible instead of lists';

  @override
  void visitComponentUsage(unit, FluentComponentUsage usage) {
    final arguments = usage.node.argumentList.arguments;
    if (arguments.length == 1 && arguments.single is ListLiteral) {
      ListLiteral list = arguments.single;
      emitHint(
        // todo remove keys
        message: 'Variadic children should be used instead of lists where possible',
        offset: list.offset,
        end: list.end,
        fixEdits: [
          new SourceEdit(list.leftBracket.offset, list.leftBracket.length, ''),
          new SourceEdit(list.rightBracket.offset - list.leftBracket.length, list.rightBracket.length, ''),
        ],
        fixMessage: 'Unwrap children from list literal',
      );
    }
  }
}
