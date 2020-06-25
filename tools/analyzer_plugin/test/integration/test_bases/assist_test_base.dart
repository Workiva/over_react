import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';

import 'server_plugin_contributor_test_base.dart';

/// Test base for integration tests that exercise a single assist contributor.
///
/// Tests should extend this class and override [getContributorUnderTest] to
/// return the contributor that is being tested.
///
/// Most tests should use the following utilities:
/// - [newSource] to create a test source file
/// - [createSelection] to select a range within that source
/// - [getAssists] to get the list of assist changes at that selection from the
///   contributor under test
abstract class AssistTestBase extends ServerPluginContributorTestBase {
  AsyncAssistContributor getContributorUnderTest();

  @override
  List<AsyncAssistContributor> getAssistContributors() => [getContributorUnderTest()];

  Future<List<PrioritizedSourceChange>> getAssists(SourceSelection selection) async {
    final parameters = EditGetAssistsParams(
        resourceProvider.convertPath(selection.source.uri.path), selection.offset, selection.length);
    final result = await testPlugin.handleEditGetAssists(parameters);
    return result.assists;
  }
}
