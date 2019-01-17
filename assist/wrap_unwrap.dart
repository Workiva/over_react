import 'dart:math';

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/assist/assist_contributor_mixin.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:over_react/src/plugin/component_usage.dart';

class WrapUnwrapAssistContributor extends Object
    implements AssistContributor {
  static AssistKind wrapInElement = new AssistKind('wrapInElement', 100, 'Wrap in another ReactElement');

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
    if (usage == null) {
      return;
    }
    String widgetSrc = request.result.content.substring(usage.node.offset, usage.node.end);
    String widgetSrcIndentedOneLevel = widgetSrc.split('\n').map((line) => '  ' + line).join('\n');

    // Can't use changeBUilder since it's async?
//    final changeBuilder = new DartChangeBuilder(session);
//    changeBuilder.addFileEdit(request.result.path, (builder) {
//      builder.addReplacement(range.node(usage.node), (DartEditBuilder builder) {
//        builder.addSimpleLinkedEdit('COMPONENT', 'component', kind: LinkedEditSuggestionKind.VARIABLE, suggestions: [
//          'Dom.div',
//        ]);
//        builder.write('()');
//        builder.selectHere();
//        builder.write('(');
////        if (widgetSrc.contains(eol)) {
////          String indentOld = utils.getLinePrefix(widgetExpr.offset);
////          String indentNew = '$indentOld${getIndent(1)}';
//
////          builder.write(eol);
////          builder.write(indentNew);
////          widgetSrc = widgetSrc.replaceAll(
////              new RegExp("^$indentOld", multiLine: true), indentNew);
////          widgetSrc += ",$eol$indentOld";
////        }
//        builder.write(widgetSrc);
//        builder.write(')');
//      });
//    });
//    addAssist(wrapInElement, changeBuilder);

    var widgetIndent = getIndent(request.result.content, request.result.unit.declaredElement.lineInfo, usage.node.offset);

    const placeholder = 'component';
    final sourceChange = new SourceChange(wrapInElement.message, id: wrapInElement.id, edits: [

      new SourceFileEdit(request.result.path, request.result.unit.declaredElement.source.modificationStamp, edits: [
//        new SourceEdit(usage.node.offset, 0, '()('),
//        new SourceEdit(usage.node.end + 3, 0, ')'),

        new SourceEdit(usage.node.offset, usage.node.length, '$placeholder()(\n$widgetIndent$widgetSrcIndentedOneLevel,\n$widgetIndent)'),
      ]),
    ],
      linkedEditGroups: [
        new LinkedEditGroup([new Position(request.result.path, usage.node.offset)], placeholder.length,
          [
//            new LinkedEditSuggestion('Dom.div', LinkedEditSuggestionKind.VARIABLE),
          ]
        ),
      ]
    );

//    session.getTopLevelDeclarations(name);

//    request.result.libraryElement.importedLibraries

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
