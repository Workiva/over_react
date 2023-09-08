import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/plugin/navigation_mixin.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/subscriptions/subscription_manager.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/assist.dart';
import 'package:over_react_analyzer_plugin/src/async_plugin_apis/diagnostic.dart';
import 'package:over_react_analyzer_plugin/src/plugin.dart';
import 'package:pub_semver/src/version.dart';

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

class StubServerPlugin implements ServerPlugin {
  @override
  PluginCommunicationChannel get channel => throw UnimplementedError();

  @override
  Set<String> get priorityPaths => throw UnimplementedError();

  @override
  set priorityPaths(Set<String> value) => throw UnimplementedError();

  @override
  Future<void> afterNewContextCollection({required AnalysisContextCollection contextCollection}) =>
      throw UnimplementedError();

  @override
  Future<void> analyzeFile({required AnalysisContext analysisContext, required String path}) =>
      throw UnimplementedError();

  @override
  Future<void> analyzeFiles({required AnalysisContext analysisContext, required List<String> paths}) =>
      throw UnimplementedError();

  @override
  Future<void> beforeContextCollectionDispose({required AnalysisContextCollection contextCollection}) =>
      throw UnimplementedError();


  @override
  String? get contactInfo => throw UnimplementedError();

  @override
  Future<void> contentChanged(List<String> paths) => throw UnimplementedError();

  @override
  ByteStore createByteStore() => throw UnimplementedError();

  @override
  List<String> get fileGlobsToAnalyze => throw UnimplementedError();

  @override
  Future<void> flushAnalysisState({bool elementModels = true}) => throw UnimplementedError();

  @override
  Future<ResolvedUnitResult> getResolvedUnitResult(String path) => throw UnimplementedError();

  @override
  Future<void> handleAffectedFiles({required AnalysisContext analysisContext, required List<String> paths}) =>
      throw UnimplementedError();

  @override
  Future<AnalysisGetNavigationResult> handleAnalysisGetNavigation(AnalysisGetNavigationParams parameters) =>
      throw UnimplementedError();

  @override
  Future<AnalysisHandleWatchEventsResult> handleAnalysisHandleWatchEvents(AnalysisHandleWatchEventsParams parameters) =>
      throw UnimplementedError();

  @override
  Future<AnalysisSetContextRootsResult> handleAnalysisSetContextRoots(AnalysisSetContextRootsParams parameters) =>
      throw UnimplementedError();

  @override
  Future<AnalysisSetPriorityFilesResult> handleAnalysisSetPriorityFiles(AnalysisSetPriorityFilesParams parameters) =>
      throw UnimplementedError();

  @override
  Future<AnalysisSetSubscriptionsResult> handleAnalysisSetSubscriptions(AnalysisSetSubscriptionsParams parameters) =>
      throw UnimplementedError();

  @override
  Future<AnalysisUpdateContentResult> handleAnalysisUpdateContent(AnalysisUpdateContentParams parameters) =>
      throw UnimplementedError();

  @override
  Future<CompletionGetSuggestionsResult> handleCompletionGetSuggestions(CompletionGetSuggestionsParams parameters) =>
      throw UnimplementedError();

  @override
  Future<EditGetAssistsResult> handleEditGetAssists(EditGetAssistsParams parameters) => throw UnimplementedError();

  @override
  Future<EditGetAvailableRefactoringsResult> handleEditGetAvailableRefactorings(
          EditGetAvailableRefactoringsParams parameters) =>
      throw UnimplementedError();

  @override
  Future<EditGetFixesResult> handleEditGetFixes(EditGetFixesParams parameters) => throw UnimplementedError();

  @override
  Future<EditGetRefactoringResult?> handleEditGetRefactoring(EditGetRefactoringParams parameters) =>
      throw UnimplementedError();

  @override
  Future<KytheGetKytheEntriesResult?> handleKytheGetKytheEntries(KytheGetKytheEntriesParams parameters) =>
      throw UnimplementedError();

  @override
  Future<PluginShutdownResult> handlePluginShutdown(PluginShutdownParams parameters) => throw UnimplementedError();

  @override
  Future<PluginVersionCheckResult> handlePluginVersionCheck(PluginVersionCheckParams parameters) =>
      throw UnimplementedError();

  @override
  bool isCompatibleWith(Version serverVersion) => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  void onDone() {}

  @override
  void onError(Object exception, StackTrace stackTrace) {}

  @override
  OverlayResourceProvider get resourceProvider => throw UnimplementedError();

  @override
  Future<void> sendFoldingNotification(String path) => throw UnimplementedError();

  @override
  Future<void> sendHighlightsNotification(String path) => throw UnimplementedError();

  @override
  Future<void> sendNavigationNotification(String path) => throw UnimplementedError();

  @override
  void sendNotificationsForFile(String path) {}

  @override
  void sendNotificationsForSubscriptions(Map<String, List<AnalysisService>> subscriptions) {}

  @override
  Future<void> sendOccurrencesNotification(String path) => throw UnimplementedError();

  @override
  Future<void> sendOutlineNotification(String path) => throw UnimplementedError();

  @override
  void start(PluginCommunicationChannel channel) => throw UnimplementedError();

  @override
  SubscriptionManager get subscriptionManager => throw UnimplementedError();

  @override
  String get version => throw UnimplementedError();
}

/// A concrete [ServerPlugin] implementation designed for use in testing a
/// single assist or diagnostic contributor against a real-ish [AnalysisDriver].
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
  PluginCommunicationChannel? _channel;

  @override
  PluginCommunicationChannel get channel => _channel!;



  @override
  void start(PluginCommunicationChannel channel) {
    _channel = channel;
  }

  @override
  late OverlayResourceProvider resourceProvider;

  @override
  Future<void> analyzeFile({required AnalysisContext analysisContext, required String path}) =>
      throw UnimplementedError();

  @override
  Future<void> analyzeFiles({required AnalysisContext analysisContext, required List<String> paths}) =>
      throw UnimplementedError();

  @override
  Future<void> contentChanged(List<String> paths) => throw UnimplementedError();

  @override
  Future<ResolvedUnitResult> getResolvedUnitResult(String path) => handleGetResolvedUnitResult?.call(path) ?? (throw UnimplementedError());

  Future<ResolvedUnitResult> Function(String path)? handleGetResolvedUnitResult;

  @override
  String get name => 'over_react (for test)';
}
