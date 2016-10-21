part of xml;

/// Interface for classes that can be visited using an [XmlVisitor].
abstract class XmlVisitable {

  /// Dispatch the invocation depending on this type to the [visitor].
  ///
  /// Note that the return type of this method is intentionally left unspecified, so
  /// that visitors can (but don't have to) pass return values.
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor);

}
