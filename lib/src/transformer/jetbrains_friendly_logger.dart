library web_skin_dart.transformer.jetbrains_friendly_logger;

import 'package:barback/barback.dart';
import 'package:source_span/source_span.dart';

/// A logger that proxies a regular [TransformLogger], but formats references to source files
/// in a way that JetBrains IDEs understand, so that links in Pub output take you to the right place
/// in the file when you click on them.
class JetBrainsFriendlyLogger implements TransformLogger {
  final TransformLogger _logger;

  JetBrainsFriendlyLogger(TransformLogger this._logger);

  /// Returns a String reference to the specified [span], formatted in a way that JetBrains IDEs understand
  /// so that links in Pub output take you to the right place in the file when you click on them.
  static String clickableReference(SourceSpan span) {
    String spanString = '';
    if (span != null) {
      // Format the span in a way that Jetbrains IDEs understand so that links
      // in the output take you to the right place in the file.
      var point = span.start;
      spanString = '[${point.sourceUrl} ${point.line + 1}:${point.column + 1}]: ';
    }

    return spanString;
  }

  /// Logs an informative message.
  ///
  /// If [asset] is provided, the log entry is associated with that asset.
  /// Otherwise it's associated with the primary input of [transformer]. If
  /// present, [span] indicates the location in the input asset that caused the
  /// error.
  @override
  void info(String message, {AssetId asset, SourceSpan span}) =>
      _logger.info(clickableReference(span) + message, asset: asset);

  /// Logs a message that won't be displayed unless the user is running in
  /// verbose mode.
  ///
  /// If [asset] is provided, the log entry is associated with that asset.
  /// Otherwise it's associated with the primary input of [transformer]. If
  /// present, [span] indicates the location in the input asset that caused the
  /// error.
  @override
  void fine(String message, {AssetId asset, SourceSpan span}) =>
      _logger.fine(clickableReference(span) + message, asset: asset);

  /// Logs a warning message.
  ///
  /// If [asset] is provided, the log entry is associated with that asset.
  /// Otherwise it's associated with the primary input of [transformer]. If
  /// present, [span] indicates the location in the input asset that caused the
  /// error.
  @override
  void warning(String message, {AssetId asset, SourceSpan span}) =>
      _logger.warning(clickableReference(span) + message, asset: asset);

  /// Logs an error message.
  ///
  /// If [asset] is provided, the log entry is associated with that asset.
  /// Otherwise it's associated with the primary input of [transformer]. If
  /// present, [span] indicates the location in the input asset that caused the
  /// error.
  ///
  /// Logging any errors will cause Barback to consider the transformation to
  /// have failed, much like throwing an exception. This means that neither the
  /// primary input nor any outputs emitted by the transformer will be passed on
  /// to the following phase, and the build will be reported as having failed.
  ///
  /// Unlike throwing an exception, this doesn't cause a transformer to stop
  /// running. This makes it useful in cases where a single input may have
  /// multiple errors that the user wants to know about.
  @override
  void error(String message, {AssetId asset, SourceSpan span}) =>
      _logger.error(clickableReference(span) + message, asset: asset);
}
