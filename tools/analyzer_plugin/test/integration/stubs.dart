import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/plugin/navigation_mixin.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/plugin.dart';

import 'test_bases/assist_test_base.dart';

class StubChannel implements PluginCommunicationChannel {
  final List<Notification> sentNotifications = <Notification>[];

  @override
  void sendNotification(Notification notification) {
    sentNotifications.add(notification);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}

/// A stubbed ServerPlugin base class to use for testing, so that we can ensure its AnalysisContextCollection isn't
/// being used instead of the one we've set up in tests.
class StubServerPlugin implements ServerPlugin {
  @override
  get channel => throw UnimplementedError();

  @override
  get priorityPaths => throw UnimplementedError();

  @override
  set priorityPaths(value) => throw UnimplementedError();

  @override
  afterNewContextCollection({required contextCollection}) => throw UnimplementedError();

  @override
  analyzeFile({required analysisContext, required path}) => throw UnimplementedError();

  @override
  analyzeFiles({required analysisContext, required paths}) => throw UnimplementedError();

  @override
  beforeContextCollectionDispose({required contextCollection}) => throw UnimplementedError();

  @override
  get contactInfo => throw UnimplementedError();

  @override
  contentChanged(paths) => throw UnimplementedError();

  @override
  createByteStore() => throw UnimplementedError();

  @override
  get fileGlobsToAnalyze => throw UnimplementedError();

  @override
  flushAnalysisState({elementModels = true}) => throw UnimplementedError();

  @override
  getResolvedUnitResult(path) => throw UnimplementedError();

  @override
  handleAffectedFiles({required analysisContext, required paths}) => throw UnimplementedError();

  @override
  handleAnalysisGetNavigation(parameters) => throw UnimplementedError();

  @override
  handleAnalysisHandleWatchEvents(parameters) => throw UnimplementedError();

  @override
  handleAnalysisSetContextRoots(parameters) => throw UnimplementedError();

  @override
  handleAnalysisSetPriorityFiles(parameters) => throw UnimplementedError();

  @override
  handleAnalysisSetSubscriptions(parameters) => throw UnimplementedError();

  @override
  handleAnalysisUpdateContent(parameters) => throw UnimplementedError();

  @override
  handleCompletionGetSuggestions(parameters) => throw UnimplementedError();

  @override
  handleEditGetAssists(parameters) => throw UnimplementedError();

  @override
  handleEditGetAvailableRefactorings(parameters) => throw UnimplementedError();

  @override
  handleEditGetFixes(parameters) => throw UnimplementedError();

  @override
  handleEditGetRefactoring(parameters) => throw UnimplementedError();

  @override
  handleKytheGetKytheEntries(parameters) => throw UnimplementedError();

  @override
  handlePluginShutdown(parameters) => throw UnimplementedError();

  @override
  handlePluginVersionCheck(parameters) => throw UnimplementedError();

  @override
  isCompatibleWith(serverVersion) => throw UnimplementedError();

  @override
  get name => throw UnimplementedError();

  @override
  void onDone() {}

  @override
  void onError(exception, stackTrace) {}

  @override
  get resourceProvider => throw UnimplementedError();

  @override
  sendFoldingNotification(path) => throw UnimplementedError();

  @override
  sendHighlightsNotification(path) => throw UnimplementedError();

  @override
  sendNavigationNotification(path) => throw UnimplementedError();

  @override
  void sendNotificationsForFile(path) {}

  @override
  void sendNotificationsForSubscriptions(subscriptions) {}

  @override
  sendOccurrencesNotification(path) => throw UnimplementedError();

  @override
  sendOutlineNotification(path) => throw UnimplementedError();

  @override
  void start(channel) => throw UnimplementedError();

  @override
  get subscriptionManager => throw UnimplementedError();

  @override
  get version => throw UnimplementedError();
}

/// A concrete [ServerPlugin] implementation designed for use in testing a
/// single assist or diagnostic contributor against real-ish AnalysisContexts.
///
/// Tests should not use, extend, or implement this class directly. Instead,
/// extend the contributor-specific test base class, like [AssistTestBase].
class PluginForTest extends StubServerPlugin
    with
        DiagnosticMixin,
        NavigationMixin,
        DartNavigationMixin,
        AsyncAssistsMixin,
        AsyncDartAssistsMixin,
        OverReactAnalyzerPluginBase {
  @override
  late PluginCommunicationChannel channel;

  @override
  late OverlayResourceProvider resourceProvider;

  late Future<ResolvedUnitResult> Function(String path)? handleGetResolvedUnitResult;

  @override
  Future<ResolvedUnitResult> getResolvedUnitResult(String path) =>
      handleGetResolvedUnitResult?.call(path) ?? (throw UnimplementedError());

  @override
  Future<void> analyzeFile({required AnalysisContext analysisContext, required String path}) =>
      throw UnimplementedError();

  @override
  Future<void> analyzeFiles({required AnalysisContext analysisContext, required List<String> paths}) =>
      throw UnimplementedError();

  @override
  Future<void> contentChanged(List<String> paths) => throw UnimplementedError();

  @override
  String get name => 'over_react (for test)';
}
