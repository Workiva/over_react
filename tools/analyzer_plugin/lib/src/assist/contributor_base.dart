import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/analyzer.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
export 'package:over_react_analyzer_plugin/src/doc_utils/docs_meta_annotation.dart';

abstract class AssistContributorBase extends Object implements AsyncAssistContributor {
  DartAssistRequest request;

  AssistCollector collector;

  AstNode node;

  AnalysisSession get session => request.result.session;

  bool setupCompute() {
    var locator = NodeLocator(request.offset, request.offset + request.length);
    node = locator.searchWithin(request.result.unit);
    return node != null;
  }

  @mustCallSuper
  @override
  Future<void> computeAssists(DartAssistRequest request, AssistCollector collector) async {
    this.request = request;
    this.collector = collector;
  }
}
