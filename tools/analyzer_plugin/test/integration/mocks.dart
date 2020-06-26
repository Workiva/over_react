import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:mockito/mockito.dart';
import 'package:over_react_analyzer_plugin/src/plugin.dart';

import 'test_bases/assist_test_base.dart';

class MockChannel extends Mock implements PluginCommunicationChannel {
  final List<Notification> sentNotifications = <Notification>[];

  @override
  void sendNotification(Notification notification) {
    sentNotifications.add(notification);
  }
}

/// A concrete [ServerPlugin] implementation designed for use in testing a
/// single assist or diagnostic contributor against a real-ish [AnalysisDriver].
///
/// Tests should not use, extend, or implement this class directly. Instead,
/// extend the contributor-specific test base class, like [AssistTestBase].
class PluginForTest extends OverReactAnalyzerPluginBase {
  final AnalysisDriver testDriver;

  PluginForTest(this.testDriver, ResourceProvider resourceProvider) : super(resourceProvider);

  @override
  String get name => 'over_react (for test)';

  @override
  AnalysisDriverGeneric createAnalysisDriver(ContextRoot contextRoot) => testDriver;
}
