import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';

import 'server_plugin_contributor_test_base.dart';

/// Test base for integration tests that exercise a single diagnostic
/// contributor.
///
/// Tests should extend this class and override [getContributorUnderTest] to
/// return the contributor that is being tested.
///
/// Most tests should use the following utilities:
/// - [newSource] to create a test source file
/// - [createSelection] to select a range within that source
/// - [getErrorsWithFixes] to get the list of analysis errors with their fixes
///   (if any) from the contributor under test
abstract class DiagnosticTestBase extends ServerPluginContributorTestBase {
  DiagnosticContributor getContributorUnderTest();

  @override
  List<DiagnosticContributor> getDiagnosticContributors() => [getContributorUnderTest()];

  Future<List<AnalysisErrorFixes>> getErrorsWithFixes(SourceSelection selection) async {
    final parameters = EditGetFixesParams(sourcePath(selection.source), selection.offset);
    final result = await testPlugin.handleEditGetFixes(parameters);
    return result.fixes;
  }
}
