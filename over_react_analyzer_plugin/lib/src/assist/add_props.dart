import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/fluent_interface_util.dart';

class AddPropsAssistContributor extends AssistContributorBase {
  static AssistKind addPropsKind = AssistKind('addProps', 31, 'Add props');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _addProps();
  }

  Future<void> _addProps() async {
    // todo tweak where this happens: should happen on child of element
    final usage = identifyUsage(node);
    if (usage == null || usage.cascadeExpression != null) {
      return;
    }

    final functionToWrap = usage.node.function;

    if (request.offset < functionToWrap.offset || request.offset + request.length > usage.node.end) {
      return;
    }

    final sourceChange = await buildFileEdit(request.result, (builder) {
      addProp(usage, builder, request.result.content, request.result.lineInfo, buildNameEdit: (builder) {
        // TODO how to start completion of props?
        // TODO figure out why the offset of this of off
        builder.selectHere();
      });
    });

    sourceChange
      ..message = addPropsKind.message
      ..id = addPropsKind.id;
    collector.addAssist(PrioritizedSourceChange(addPropsKind.priority, sourceChange));
  }
}
