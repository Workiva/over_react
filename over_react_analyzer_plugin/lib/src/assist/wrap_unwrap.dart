import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';

class WrapUnwrapAssistContributor extends AssistContributorBase {
  static AssistKind wrapInElement = AssistKind('wrapInElement', 30, 'Wrap in another ReactElement');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    await super.computeAssists(request, collector);
    if (!setupCompute()) return;

    await _wrapInElement();
  }

  Future<void> _wrapInElement() async {
    // todo tweak where this happens: should happen on child of element
    final usage = identifyUsage(node);
    if (usage == null) {
      return;
    }

    final widgetSrc = request.result.content.substring(usage.node.offset, usage.node.end);
    final widgetSrcIndentedOneLevel = widgetSrc.split('\n').map((line) => '  ' + line).join('\n');
    final widgetIndent = getIndent(request.result.content, request.result.unit.declaredElement.lineInfo, usage.node.offset);

    final sourceChange = await buildFileEdit(request.result, (builder) {
      builder.addReplacement(range.node(usage.node), (builder) {
        // TODO how to compute easily compute suggestions for factories?
        builder.addSimpleLinkedEdit('COMPONENT', 'component');
        builder.write('()');
        builder.selectHere();
        builder.write('(\n$widgetIndent');
        builder.write(widgetSrcIndentedOneLevel);
        builder.write(',');
        builder.selectHere();
        builder.write('\n$widgetIndent)');
      });
    });
    sourceChange
      ..message = wrapInElement.message
      ..id = wrapInElement.id;
    collector.addAssist(PrioritizedSourceChange(wrapInElement.priority, sourceChange));
  }
}
