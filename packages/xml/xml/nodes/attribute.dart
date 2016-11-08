part of xml;

/// XML attribute node.
class XmlAttribute extends XmlNode implements XmlNamed {

  @override
  final XmlName name;

  /// Return the value of the attribute.
  final String value;

  /// Create an attribute with `name` and `value`.
  XmlAttribute(this.name, this.value) {
    assert(this.name._parent == null);
    this.name._parent = this;
  }

  @override
  XmlNodeType get nodeType => XmlNodeType.ATTRIBUTE;

  @override
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor) => visitor.visitAttribute(this);

}
