library document_event_helper;

import 'dart:html' as html;

/// Utility class that helps with dependency injection when mocking document events.
abstract class DocumentEventHelper {
  static html.HtmlDocument _document = html.document;
  /// Singleton that can be used to listen to events like you would with `document`.
  ///
  /// Can be mutated when testing
  static html.HtmlDocument get document => _document;
  static set document(html.HtmlDocument value) {
    // TODO add `.fromEnvironment` check for warning when not testing.
    _document = value;
  }
}
