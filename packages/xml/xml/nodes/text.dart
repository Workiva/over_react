part of xml;

/// XML text node.
class XmlText extends XmlData {

  /// Create a text node with `text`.
  XmlText(String text) : super(text);

  @override
  XmlNodeType get nodeType => XmlNodeType.TEXT;

  @override
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor) => visitor.visitText(this);

}
