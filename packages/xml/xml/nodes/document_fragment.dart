part of xml;

/// XML document fragment node.
class XmlDocumentFragment extends XmlParent {

  /// Create a document node with `children`.
  XmlDocumentFragment(Iterable<XmlNode> children) : super(children);

  @override
  XmlDocument get document => null;

  @override
  String get text => null;

  @override
  XmlNodeType get nodeType => XmlNodeType.DOCUMENT_FRAGMENT;

  @override
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor) => visitor.visitDocumentFragment(this);

}
