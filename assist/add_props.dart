import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:over_react/src/plugin/component_usage.dart';

class AddPropsAssistContributor extends Object
    implements AssistContributor {
  static AssistKind wrapInElement = new AssistKind('addProps', 100, 'Add props');

  DartAssistRequest request;

  AssistCollector collector;

  AstNode node;

  AnalysisSession get session => request.result.session;

  bool _setupCompute() {
    var locator = new NodeLocator(request.offset, request.offset + request.length);
    node = locator.searchWithin(request.result.unit);
    return node != null;
  }

  @override
  void computeAssists(DartAssistRequest request, AssistCollector collector) {
    this.request = request;
    this.collector = collector;
    if (!_setupCompute()) return;

    _wrapInElement();
  }

  void _wrapInElement() {
    // todo tweak where this happens: should happen on child of element
    final usage = identifyUsage(node);
    if (usage == null || usage.node.function is ParenthesizedExpression) {
      return;
    }

    final functionToWrap = usage.node.function;

    if (request.offset < functionToWrap.offset || request.offset + request.length > usage.node.end) {
      return;
    }

    final sourceChange = new SourceChange(wrapInElement.message, id: wrapInElement.id, edits: [
      new SourceFileEdit(request.result.path, request.result.unit.declaredElement.source.modificationStamp, edits: [
        new SourceEdit(functionToWrap.offset, 0, '('),
        new SourceEdit(functionToWrap.end + 1, 0, '..)'),
      ]),
    ], selection: new Position(request.result.path, functionToWrap.end + 1 + 2),
      linkedEditGroups: [new LinkedEditGroup([
        new Position(request.result.path, functionToWrap.end + 1 + 2)
      ], 0, [])]
    );

    collector.addAssist(new PrioritizedSourceChange(wrapInElement.priority, sourceChange));
  }
}

