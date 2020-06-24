import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer_plugin/channel/channel.dart' as ap;
import 'package:analyzer_plugin/plugin/plugin.dart' as ap;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as ap;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as ap;
import 'package:analyzer_plugin/protocol/protocol.dart' as ap;
import 'package:mockito/mockito.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

class MockChannel extends Mock implements ap.PluginCommunicationChannel {}

class SourceSelection {
  final Source source;
  final int offset;
  final int length;

  SourceSelection(this.source, this.offset, this.length);
}

class PluginForTest extends MockServerPlugin
    with AsyncAssistsMixin, AsyncDartAssistsMixin, DiagnosticMixin {
  final List<AsyncAssistContributor> _assistContributors;
  final List<DiagnosticContributor> _diagnosticContributors;

  PluginForTest(
    AnalysisDriver testDriver,
    ResourceProvider resourceProvider, {
    List<AsyncAssistContributor> assistContributors,
    List<DiagnosticContributor> diagnosticContributors,
  })  : _assistContributors = assistContributors ?? [],
        _diagnosticContributors = diagnosticContributors ?? [],
        super(testDriver, resourceProvider);

  @override
  List<AsyncAssistContributor> getAssistContributors(String path) =>
      _assistContributors;

  @override
  List<DiagnosticContributor> getDiagnosticContributors(String path) =>
      _diagnosticContributors;
}

/// A concrete implementation of a server plugin that is suitable for testing.
class MockServerPlugin extends ap.ServerPlugin {
  final AnalysisDriver testDriver;

  MockServerPlugin(this.testDriver, ResourceProvider resourceProvider)
      : super(resourceProvider);

  @override
  List<String> get fileGlobsToAnalyze => <String>['*.dart'];

  @override
  String get name => 'Test Plugin';

  @override
  String get version => '0.1.0';

  @override
  AnalysisDriverGeneric createAnalysisDriver(ap.ContextRoot contextRoot) =>
      testDriver;
}
