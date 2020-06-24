import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';

import '../mocks.dart';
import 'server_plugin_contributor_test_base.dart';

abstract class AssistTestBase extends ServerPluginContributorTestBase {
  AsyncAssistContributor getContributorUnderTest();

  @override
  List<AsyncAssistContributor> getAssistContributors() =>
      [getContributorUnderTest()];

  Future<List<PrioritizedSourceChange>> getAssists(
      SourceSelection selection) async {
    final parameters = EditGetAssistsParams(
        resourceProvider.convertPath(selection.source.uri.path),
        selection.offset,
        selection.length);
    final result = await testPlugin.handleEditGetAssists(parameters);
    return result.assists;
  }
}
