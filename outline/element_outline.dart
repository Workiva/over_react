import 'package:analyzer_plugin/utilities/analyzer_converter.dart';
import 'package:analyzer_plugin/utilities/outline/outline.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:over_react/src/plugin/diagnostic/over_react/component_usage.dart';

// TODO can you only create outlines for existing elements??
class ReactElementOutlineContributor implements OutlineContributor {
  final AnalyzerConverter converter = new AnalyzerConverter();

  @override
  void computeOutline(OutlineRequest request, OutlineCollector collector) {
    if (request is! DartOutlineRequest) return;

    final result = (request as DartOutlineRequest).result;

    // need at least one outline for some reason
    final element = new plugin.Element(plugin.ElementKind.UNKNOWN, '', 0);
    // Outlines work intermittently, less so when this element does not constitute the whole file
    collector.startElement(element, result.unit.offset, result.unit.length);
    collector.endElement();

    result.unit.declaredElement.lineInfo;

    List<int> elementEndStack = [];

    final visitor = new ComponentUsageVisitor((usage) {
      {
        final start = usage.node.offset;
        final end = usage.node.end;

        while (elementEndStack.isNotEmpty && start >= elementEndStack.last) {
          collector.endElement();
          elementEndStack.removeLast();
        }

        // USE FUNCTION_INVOCATION instead?
        final usageElement = new plugin.Element(plugin.ElementKind.FUNCTION_INVOCATION, usage.builder.toSource(), 0);

        collector.startElement(usageElement, start, end - start);
        elementEndStack.add(end);
      }
    });
    result.unit.accept(visitor);

    while (elementEndStack.isNotEmpty) {
      elementEndStack.removeLast();
      collector.endElement();
    }
  }
}

