part of xml;

/// XML element node.
class XmlElement extends XmlParent implements XmlNamed {

  @override
  final XmlName name;

  @override
  final List<XmlAttribute> attributes;

  /// Create an [XmlElement] with the given `name`, `attributes`, and `children`.
  XmlElement(XmlName name, Iterable<XmlAttribute> attributes,
      Iterable<XmlNode> children)
      : name = name,
        attributes = attributes.toList(growable: false),
        super(children) {
    assert(this.name._parent == null);
    this.name._parent = this;
    for (var attribute in this.attributes) {
      assert(attribute._parent == null);
      attribute._parent = this;
    }
  }

  /// Return the attribute value with the given `name`.
  String getAttribute(name, {String namespace}) {
    var attribute = getAttributeNode(name, namespace: namespace);
    return attribute != null ? attribute.value : null;
  }

  /// Return the attribute node with the given `name`.
  XmlAttribute getAttributeNode(String name, {String namespace}) {
    return attributes.firstWhere(_createMatcher(name, namespace),
        orElse: () => null);
  }

  @override
  XmlNodeType get nodeType => XmlNodeType.ELEMENT;

  @override
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor) => visitor.visitElement(this);

}
