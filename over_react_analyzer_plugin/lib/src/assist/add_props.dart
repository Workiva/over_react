import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';

class AddPropsAssistContributor extends AssistContributorBase {
  static AssistKind addProps = new AssistKind('addProps', 31, 'Add props');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _addProps();
  }

  Future<void> _addProps() async {
    // todo tweak where this happens: should happen on child of element
    final usage = identifyUsage(node);
    if (usage == null || usage.node.function is ParenthesizedExpression) {
      return;
    }

    final functionToWrap = usage.node.function;

    if (request.offset < functionToWrap.offset || request.offset + request.length > usage.node.end) {
      return;
    }

    final changeBuilder = new DartChangeBuilder(session);
    await changeBuilder.addFileEdit(request.result.path, (builder) {
      builder.addSimpleInsertion(functionToWrap.offset, '(');
      builder.addInsertion(functionToWrap.end, (builder) {
        builder.write('..');
        // TODO how to start completion of props?
        builder.selectHere();
        builder.write(')');
      });
    });
    final sourceChange = changeBuilder.sourceChange
      ..message = addProps.message
      ..id = addProps.id;
    collector.addAssist(new PrioritizedSourceChange(addProps.priority, sourceChange));
  }
}

