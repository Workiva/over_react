part of xml;

/// Abstract visitor over [XmlVisitable] nodes.
abstract class XmlVisitor<E> {

  /// Helper to visit an [XmlVisitable] using this visitor by dispatching
  /// through the provided [visitable].
  E visit(XmlVisitable visitable) => visitable.accept(this) as E;

  /// Helper to visit an [Iterable] of [XmlVisitable]s using this visitor
  /// by dispatching through the provided [visitables].
  Iterable<E> visitAll(Iterable<XmlVisitable> visitables) => visitables.map(visit);

  /// Visit an [XmlName].
  E visitName(XmlName name);

  /// Visit an [XmlAttribute] node.
  E visitAttribute(XmlAttribute node);

  /// Visit an [XmlDocument] node.
  E visitDocument(XmlDocument node);

  /// Visit an [XmlDocumentFragment] node.
  E visitDocumentFragment(XmlDocumentFragment node);

  /// Visit an [XmlElement] node.
  E visitElement(XmlElement node);

  /// Visit an [XmlCDATA] node.
  E visitCDATA(XmlCDATA node);

  /// Visit an [XmlComment] node.
  E visitComment(XmlComment node);

  /// Visit an [XmlDoctype] node.
  E visitDoctype(XmlDoctype node);

  /// Visit an [XmlProcessing] node.
  E visitProcessing(XmlProcessing node);

  /// Visit an [XmlText] node.
  E visitText(XmlText node);

}
