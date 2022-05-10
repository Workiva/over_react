import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';
import 'package:over_react_analyzer_plugin/src/indent_util.dart';
import 'package:over_react_analyzer_plugin/src/util/fix.dart';

const _desc = r'Wrap selection with another ReactElement';
// <editor-fold desc="Documentation Details">
const _details = r'''

When a VDom element is selected by the user, the assist wraps the selection with another ReactElement:

**EXAMPLE:**
```
final foo = Dom.div()(
  'Hi there foo',
);
```

**BECOMES:**
```
final foo = component()(
  Dom.div()(
    'Hi there foo',
  ),
);  
```

''';
// </editor-fold>

class WrapUnwrapAssistContributor extends AssistContributorBase {
  @DocsMeta(_desc, details: _details)
  static const wrapInElement = AssistKind('wrapInElement', 30, _desc);

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

    final content = request.result.content;
    final widgetSrc = content.substring(usage.node.offset, usage.node.end);
    final widgetSrcIndentedOneLevel = widgetSrc.split('\n').map((line) => '  ' + line).join('\n');
    final widgetIndent = getIndent(content, request.result.lineInfo, usage.node.offset);

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
