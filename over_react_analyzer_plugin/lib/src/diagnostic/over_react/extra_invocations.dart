import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic/over_react/component_usage.dart';

class ExtraInvocationsChecker extends ComponentUsageChecker {
  @override
  String get name => 'over-react-extra-invocations';

  @override
  String get description => 'Attempts to detect and fix a common syntax error: missing a comma after fluent interface builder invocation.';

  @override
  void visitComponentUsage(CompilationUnit unit, FluentComponentUsage usage) {
    final parent = usage.node.parent;
    // Example:
    //
    //    (Foo()..foo = true)(1)
    //    (Bar()..var = true)(2)
    //
    // The `Foo` invocation is detected as a usage, and is parsed as a function
    // expression being invoked with `Bar()..bar = true` , which
    // is being invoked with `2`
    if (parent is FunctionExpressionInvocation && parent.function == usage.node) {
      emitError(
          message: 'Extraneous invocations; are you missing a comma between ReactElements?',
          offset: usage.node.offset,
          end: usage.node.end,
          fixMessage: 'Add comma after builder invocation',
          fixEdits: [
            new SourceEdit(usage.node.end, 0, ',')
          ]
      );
    }
  }
}
