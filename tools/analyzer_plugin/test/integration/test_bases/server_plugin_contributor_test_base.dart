import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:meta/meta.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/diagnostic_contributor.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../mocks.dart';
import 'analysis_driver_test_base.dart';

abstract class ServerPluginContributorTestBase extends AnalysisDriverTestBase {
  PluginForTest get testPlugin => _plugin;

  Source applySourceChange(SourceChange change, Source expectedSource) {
    final path = p.normalize(expectedSource.uri.toFilePath());
    final applicableFileEdits = change.edits.where((edit) => edit.file == path);
    expect(applicableFileEdits.map((edit) => edit.file), contains(path),
        reason: 'Expected SourceChange to include edits for "$path".');
    final updated = SourceEdit.applySequence(
      resourceProvider.getFile(path).readAsStringSync(),
      [for (final fileEdit in applicableFileEdits) ...fileEdit.edits],
    );
    final file = resourceProvider.updateFile(path, updated);
    return file.createSource();
  }

  SourceSelection createSelection(Source source, String target, {int offset}) {
    final parts = target.split('#');
    expect(parts, hasLength(3),
        reason:
            'Target must have two "#" symbols denoting the selection range.');
    final before = parts[0];
    final selection = parts[1];
    final after = parts[2];
    final loc = source.contents.data.indexOf('$before$selection$after');
    expect(loc, greaterThanOrEqualTo(0),
        reason: 'Target was not found in source.');
    final offset = loc + before.length;
    final length = selection.length;
    return SourceSelection(source, offset, length);
  }

  List<AsyncAssistContributor> getAssistContributors() => [];
  List<DiagnosticContributor> getDiagnosticContributors() => [];

  MockChannel _channel;
  PluginForTest _plugin;

  @override
  @mustCallSuper
  Future<void> setUp() async {
    await super.setUp();

    _channel = MockChannel();
    _plugin = PluginForTest(
      analysisDriver,
      resourceProvider,
      assistContributors: getAssistContributors(),
      diagnosticContributors: getDiagnosticContributors(),
    )..start(_channel);

    // ignore: missing_required_param
    final contextRoot = ContextRoot(testPath, []);
    await testPlugin.handleAnalysisSetContextRoots(
        AnalysisSetContextRootsParams([contextRoot]));
  }

  @override
  @mustCallSuper
  Future<void> tearDown() async {
    await _plugin?.handlePluginShutdown(PluginShutdownParams());
    _channel = null;
    _plugin = null;
    super.tearDown();
  }
}
