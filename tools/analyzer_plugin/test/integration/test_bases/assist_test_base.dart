import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:test/test.dart';

import '../matchers.dart';
import 'server_plugin_contributor_test_base.dart';

/// Test base for integration tests that exercise a single assist contributor.
///
/// Tests should extend this class and override [assistKindUnderTest] with the
/// assist contributor kind that is being tested.
///
/// Most tests should use [newSource] to create a test source file,
/// [createSelection] to select a range within that source, and one of the
/// `expect` utility methods.
abstract class AssistTestBase extends ServerPluginContributorTestBase {
  /// Tests should override this getter to return the [AssistKind] for the
  /// assist contributor that is being tested.
  ///
  /// This will be used to filter the source changes produced by the test plugin
  /// to only those originating from this assist contributor.
  AssistKind get assistKindUnderTest;

  /// Fails the test if any selection of [sourceContents] from
  /// [selectionTargets] does not produce a single assist matching
  /// [assistKindUnderTest].
  Future<void> expectAllSelectionsProduceSingleAssist(String sourceContents, List<String> selectionTargets) async {
    final source = newSource('test.dart', sourceContents);
    for (final target in selectionTargets) {
      final selection = createSelection(source, target);
      final assists = await _getAllAssists(selection);
      expect(assists, hasLength(1), reason: 'Expected selection to produce an assist, but it did not: $target');
      expect(assists.single, isAssist(assistKindUnderTest));
    }
  }

  /// Returns the source change for the single assist produced at [selection]
  /// and fails the test if anything other than a single assist matching
  /// [assistKindUnderTest] is produced.
  Future<SourceChange> expectAndGetSingleAssist(SourceSelection selection) async {
    final assists = await _getAllAssists(selection);
    expect(assists, hasLength(1),
        reason: 'Expected only a single assist at selection (selection: ${selection.target})');
    final assist = assists.single;
    expect(assist, isAssist(assistKindUnderTest));
    return assist.change;
  }

  /// Fails the test if [selection] produces any assists matching
  /// [assistKindUnderTest].
  Future<void> expectNoAssist(SourceSelection selection) async {
    expect(await _getAllAssists(selection), isEmpty, reason: 'Unexpected assist at selection: ${selection.target}');
  }

  /// Returns all assists produced at [selection].
  Future<List<PrioritizedSourceChange>> _getAllAssists(SourceSelection selection) async {
    final parameters = EditGetAssistsParams(
        resourceProvider.convertPath(selection.source.uri.path), selection.offset, selection.length);
    return (await testPlugin.handleEditGetAssists(parameters))
        .assists
        .where((psc) => psc.change.id == assistKindUnderTest.id)
        .toList();
  }
}
