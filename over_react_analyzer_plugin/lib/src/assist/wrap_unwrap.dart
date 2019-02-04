import 'package:analyzer/source/line_info.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react_analyzer_plugin/src/assist/contributor_base.dart';
import 'package:over_react_analyzer_plugin/src/component_usage.dart';

class WrapUnwrapAssistContributor extends AssistContributorBase {
  static AssistKind wrapInElement = new AssistKind('wrapInElement', 30, 'Wrap in another ReactElement');

  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    super.computeAssists(request, collector);
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

    final changeBuilder = new DartChangeBuilder(session);
    await changeBuilder.addFileEdit(request.result.path, (builder) {
      builder.addReplacement(range.node(usage.node), (DartEditBuilder builder) {
        // TODO how to compute easily compute suggestions for factories?
        builder.addSimpleLinkedEdit('COMPONENT', 'component');
        builder.write('()');
        builder.selectHere();
        builder.write('(\n$widgetIndent');
        builder.write(widgetSrcIndentedOneLevel);
        builder.write('\n$widgetIndent)');
      });
    });
    final sourceChange = changeBuilder.sourceChange
      ..message = wrapInElement.message
      ..id = wrapInElement.id;
    collector.addAssist(new PrioritizedSourceChange(wrapInElement.priority, sourceChange));
  }
}

/// Indents the content at [offset] with [indent].
///
/// Example:
///
///     setIndent('  foo', 2, ' ');    // ' foo'
SourceEdit setIndent(String source, LineInfo info, int offset, String indent) {
  var column = info.getLocation(offset).columnNumber - 1;
  return new SourceEdit(offset - column, column, indent);
}

/// Returns the whitespace characters, or "indent" from the start of
/// the line in [sourceFile] containing [offset], up until [offset].
///
/// Example:
///
///     getIndent('  foo', 5); // '  '
///     getIndent('  foo', 2); // '  '
///     getIndent('  foo', 1); // ' '
String getIndent(String source, LineInfo info, int offset) {
  final beginningOfColumn = offset - (info.getLocation(offset).columnNumber - 1);
  final lineContentUpToOffset = source.substring(beginningOfColumn, offset);
  return new RegExp(r'^ *')
      .firstMatch(lineContentUpToOffset)[0];
}

/// Returns whether [offsetA] and [offsetB] within [sourceFile] are on the same line.
bool isSameLine(String text, LineInfo info, int offsetA, int offsetB) {
  return info.getLocation(offsetA).lineNumber ==
         info.getLocation(offsetB).lineNumber;
}
