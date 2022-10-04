import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:over_react_analyzer_plugin/src/util/analyzer_util.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
export 'package:over_react_analyzer_plugin/src/doc_utils/docs_meta_annotation.dart';

/// The information about a requested set of assists when computing assists in a
/// `.dart` file.
///
/// Clients may not extend, implement or mix-in this class.
abstract class PotentiallyResolvedDartAssistRequest implements AssistRequest {
  /// The analysis result for the file in which the assists are being requested.
  PotentiallyResolvedResult get result;
}


abstract class AssistContributorBase extends Object implements AsyncAssistContributor {
  PotentiallyResolvedDartAssistRequest? _request;
  AssistCollector? _collector;
  AstNode? _node;

  PotentiallyResolvedDartAssistRequest get request => _throwIfNull(_request, 'request');
  AssistCollector get collector => _throwIfNull(_collector, 'collector');
  AstNode get node => _throwIfNull(_node, 'node',
      "To use 'node', you must call 'setupCompute' and only access 'node' if its return value is 'true'.");
  set request(PotentiallyResolvedDartAssistRequest? value) => _request = value;
  set collector(AssistCollector? value) => _collector = value;
  set node(AstNode? value) => _node = value;

  static T _throwIfNull<T>(T? value, String name, [String message = '']) {
    if (value != null) return value;
    throw StateError("'$name' is unset. $message");
  }

  AnalysisSession get session => request.result.session;

  bool setupCompute() {
    var locator = NodeLocator(request.offset, request.offset + request.length);
    final node = locator.searchWithin(request.result.unit);
    if (node != null) {
      this.node = node;
      return true;
    }
    return false;
  }

  @mustCallSuper
  @override
  Future<void> computeAssists(PotentiallyResolvedDartAssistRequest request, AssistCollector collector) async {
    this.request = request;
    this.collector = collector;
    _node = null;
  }
}
