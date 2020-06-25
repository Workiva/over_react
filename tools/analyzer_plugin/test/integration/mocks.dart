import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

import 'test_bases/server_plugin_contributor_test_base.dart';

class MockChannel extends Mock implements PluginCommunicationChannel {}

/// A concrete [ServerPlugin] implementation designed for use in testing a
/// single assist or diagnostic contributor against a real-ish [AnalysisDriver].
///
/// Tests should not use, extend, or implement this class directly; the
/// [ServerPluginContributorTestBase] class does this and provides a simpler API
/// for testing an individual contributor.
class PluginForTest extends ServerPlugin with AsyncAssistsMixin, AsyncDartAssistsMixin, DiagnosticMixin {
  final AnalysisDriver testDriver;

  final List<AsyncAssistContributor> _assistContributors;
  final List<DiagnosticContributor> _diagnosticContributors;

  PluginForTest(
    this.testDriver,
    ResourceProvider resourceProvider, {
    List<AsyncAssistContributor> assistContributors,
    List<DiagnosticContributor> diagnosticContributors,
  })  : _assistContributors = assistContributors ?? [],
        _diagnosticContributors = diagnosticContributors ?? [],
        super(resourceProvider);

  @override
  List<String> get fileGlobsToAnalyze => <String>['*.dart'];

  @override
  String get name => 'Test Plugin';

  @override
  String get version => '0.1.0';

  @override
  AnalysisDriverGeneric createAnalysisDriver(ContextRoot contextRoot) => testDriver;

  @override
  List<AsyncAssistContributor> getAssistContributors(String path) => _assistContributors;

  @override
  List<DiagnosticContributor> getDiagnosticContributors(String path) => _diagnosticContributors;
}
