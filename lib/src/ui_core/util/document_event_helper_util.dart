/// Utility class that helps with dependency injection when mocking document events.
library document_event_helper;

import 'dart:html' as html;

class DocumentEventHelper {
  DocumentEventHelper._();
  static html.Document _document = html.document;
  /// Singleton that can be used to listen to events like you would with `document`.
  ///
  /// Can be mutated when testing
  static html.Document get document => _document;
  static set document(html.Document value) {
    // TODO add `.fromEnvironment` check for warning when not testing.
    _document = value;
  }
}
