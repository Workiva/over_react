import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../stubs.dart';
import 'analysis_driver_test_base.dart';
import 'assist_test_base.dart';

export 'package:analyzer/src/generated/source.dart' show Source;

/// Representation of a selected range on a [Source] file.
///
/// Useful when testing assist and diagnostic contributors that use the
/// selection as an input and can also alter the resulting selection after their
/// [SourceChange] is applied.
///
/// Use [ServerPluginContributorTestBase.createSelection] to easily create
/// instances of this model from an existing [Source].
class SourceSelection {
  final Source source;
  final int offset;
  final int length;
  final String? target;

  SourceSelection(this.source, this.offset, this.length, {this.target});
}

extension AsRange$SourceRange on SourceSelection {
  /// Returns SourceRange using [offset] and [length].
  ///
  /// Useful when you're dealing with ranges represented by incompatible types,
  /// and need to compare them (using [SourceRange.intersects], etc.).
  SourceRange toRange() => SourceRange(offset, length);
}

extension AsRange$Location on Location {
  /// Returns SourceRange using [offset] and [length].
  ///
  /// Useful when you're dealing with ranges represented by incompatible types,
  /// and need to compare them (using [SourceRange.intersects], etc.).
  SourceRange toRange() => SourceRange(offset, length);
}

extension AsRange$Position on Position {
  /// Returns SourceRange using [offset]].
  ///
  /// Useful when you're dealing with ranges represented by incompatible types,
  /// and need to compare them (using [SourceRange.intersects], etc.).
  SourceRange toRange() => SourceRange(offset, 0);
}

/// Test base that handles constructing an analysis server plugin designed for
/// use in tests.
///
/// Also provides some utilities related to source files.
///
/// Tests should not use, extend, or implement this class directly. Instead,
/// extend a test base for the specific type of contributor, like
/// [AssistTestBase].
abstract class ServerPluginContributorTestBase extends AnalysisDriverTestBase {
  PluginForTest get testPlugin => _plugin!;

  /// Applies the given [change] to [source], writes it via [resourceProvider]
  /// and returns the updated [Source].
  Source applySourceChange(SourceChange change, Source source) {
    final path = p.normalize(source.uri.toFilePath());
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

  /// Returns a selection (offset & length) within the contents of [source] by
  /// searching for [target] and selecting the portion between the two `#`
  /// symbols.
  ///
  /// For example, if you have the following source:
  ///
  /// ```
  /// import 'package:over_react/over_react.dart';
  /// var foo = Dom.div()('hello');
  /// ```
  ///
  /// Consider the following example [target] values and the selection they
  /// would create:
  ///
  /// - `#var foo#` => `var foo`
  /// - `var #fo#o` => `fo`
  ///
  /// It's also possible and valid to create a selection with no length by
  /// placing the two `#` symbols next to each other. A target of `var ##foo`
  /// will create a selection that starts right before `foo` but has no length.
  ///
  /// In summary, [target] should:
  /// - be a unique substring of the full source so the correct area is targeted
  /// - be at least as long as the selection you want to create
  /// - be as short as possible, given the previous two are satisifed
  /// - contain two `#` symbols that define the selection range in the target
  SourceSelection createSelection(Source source, String target, {int? offset}) {
    final parts = target.split('#');
    if (parts.length != 3) {
      throw ArgumentError.value(target, 'target', 'must have two "#" symbols denoting the selection range.');
    }
    final before = parts[0];
    final selection = parts[1];
    final after = parts[2];
    final searchString = '$before$selection$after';
    final loc = source.contents.data.indexOf(searchString);
    if (loc == -1) {
      throw ArgumentError('Target was not found in source: $target');
    }
    final nextLoc = source.contents.data.indexOf(searchString, loc + 1);
    if (nextLoc != -1) {
      throw ArgumentError('More than one match for target found in source: $target');
    }
    final offset = loc + before.length;
    final length = selection.length;
    return SourceSelection(source, offset, length, target: target);
  }

  /// Will fail the test if any unexpected plugin errors were sent on the plugin
  /// communication channel.
  void expectNoPluginErrors() {
    final pluginErrors = _channel!.sentNotifications.where((n) => n.event == 'plugin.error');
    expect(pluginErrors, isEmpty,
        reason: 'Unexpected plugin error(s):\n${pluginErrors.map((e) => e.toJson()).join('\n')}');
  }

  StubChannel? _channel;
  PluginForTest? _plugin;

  @override
  @mustCallSuper
  Future<void> setUp() async {
    await super.setUp();

    _channel = StubChannel();
    _plugin = PluginForTest(analysisDriver, resourceProvider)..start(_channel!);

    // ignore: missing_required_param
    final contextRoot = ContextRoot(testPath, []);
    await testPlugin.handleAnalysisSetContextRoots(AnalysisSetContextRootsParams([contextRoot]));
  }

  @override
  @mustCallSuper
  Future<void> tearDown() async {
    expectNoPluginErrors();
    await _plugin?.handlePluginShutdown(PluginShutdownParams());
    _channel = null;
    _plugin = null;
    super.tearDown();
  }
}
