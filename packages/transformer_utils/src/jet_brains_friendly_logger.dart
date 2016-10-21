// Copyright 2015 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library transformer_utils.src.jet_brains_friendly_logger;

import 'package:barback/barback.dart';
import 'package:source_span/source_span.dart';

/// A logger that proxies a regular [TransformLogger], but formats references to
/// source files with [clickableReference].
class JetBrainsFriendlyLogger implements TransformLogger {
  final TransformLogger _logger;

  JetBrainsFriendlyLogger(TransformLogger this._logger);

  /// Returns a String reference to the specified [span], formatted in a way
  /// that JetBrains IDEs understand so that links in Pub output take you to the
  /// right place in the file when you click on them.
  static String clickableReference(SourceSpan span) {
    String spanString = '';
    if (span != null) {
      // Format the span in a way that Jetbrains IDEs understand so that links
      // in the output take you to the right place in the file.
      var point = span.start;
      spanString =
          '[${point.sourceUrl} ${point.line + 1}:${point.column + 1}]: ';
    }

    return spanString;
  }

  /// Returns the source line of text represented by [span] with the span
  /// highlighted in a human-readable format.
  ///
  /// Example, for the following code:
  ///
  ///     var foo = 1, bar = 2;
  ///
  /// A span of the `foo` variable/initializer would be printed as such:
  ///
  ///     var foo = 1, bar = 2;
  ///         ^^^^^^^
  ///
  static String highlightedSpanText(SourceSpan span) {
    // Use the built-in highlighting in `message`.
    var message = span.message('');

    // Strip out the first line, which consists of redundant line information
    // that will be provided by `clickableReference`.
    var firstNewlineIndex = message.indexOf('\n');
    if (firstNewlineIndex != -1) {
      message = message.substring(firstNewlineIndex + 1);
    }

    return message;
  }

  /// Returns a [message] with added source location and text from an optional
  /// [span].
  static String formatMessageWithSpan(String message, SourceSpan span) {
    if (span == null) {
      return message;
    }

    return clickableReference(span) +
        message +
        '\n' +
        highlightedSpanText(span);
  }

  /// Logs an informative message.
  ///
  /// If [asset] is provided, the log entry is associated with that asset.
  /// Otherwise it's associated with the primary input of [transformer]. If
  /// present, [span] indicates the location in the input asset that caused the
  /// error.
  @override
  void info(String message, {AssetId asset, SourceSpan span}) =>
      _logger.info(formatMessageWithSpan(message, span), asset: asset);

  /// Logs a message that won't be displayed unless the user is running in
  /// verbose mode.
  ///
  /// If [asset] is provided, the log entry is associated with that asset.
  /// Otherwise it's associated with the primary input of [transformer]. If
  /// present, [span] indicates the location in the input asset that caused the
  /// error.
  @override
  void fine(String message, {AssetId asset, SourceSpan span}) =>
      _logger.fine(formatMessageWithSpan(message, span), asset: asset);

  /// Logs a warning message.
  ///
  /// If [asset] is provided, the log entry is associated with that asset.
  /// Otherwise it's associated with the primary input of [transformer]. If
  /// present, [span] indicates the location in the input asset that caused the
  /// error.
  @override
  void warning(String message, {AssetId asset, SourceSpan span}) =>
      _logger.warning(formatMessageWithSpan(message, span), asset: asset);

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
      _logger.error(formatMessageWithSpan(message, span), asset: asset);
}
