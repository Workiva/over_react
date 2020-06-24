import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

import '../mocks.dart';
import 'server_plugin_contributor_test_base.dart';

abstract class DiagnosticTestBase extends ServerPluginContributorTestBase {
  DiagnosticContributor getContributorUnderTest();

  @override
  List<DiagnosticContributor> getDiagnosticContributors() =>
      [getContributorUnderTest()];

  Future<List<AnalysisErrorFixes>> getErrorsWithFixes(
      SourceSelection selection) async {
    final parameters =
        EditGetFixesParams(sourcePath(selection.source), selection.offset);
    final result = await testPlugin.handleEditGetFixes(parameters);
    return result.fixes;
  }
}
