part of xml;

/// XML document node.
class XmlDocument extends XmlParent {

  /// Create a document node with `children`.
  XmlDocument(Iterable<XmlNode> children) : super(children);

  /// Return the [XmlDoctype] element, or `null` if not defined.
  ///
  /// For example, the following code prints `<!DOCTYPE html>`:
  ///
  ///    var xml = '<!DOCTYPE html>'
  ///              '<html><body></body></html>';
  ///    print(parse(xml).doctypeElement);
  ///
  XmlDoctype get doctypeElement {
    return children.firstWhere((node) => node is XmlDoctype,
        orElse: () => null);
  }

  /// Return the root [XmlElement] of the document, or throw a [StateError] if
  /// the document has no such element.
  ///
  /// For example, the following code prints `<books />`:
  ///
  ///     var xml = '<?xml version="1.0"?>'
  ///               '<books />';
  ///     print(parse(xml).rootElement);
  ///
  XmlElement get rootElement {
    return children.firstWhere((node) => node is XmlElement,
        orElse: () => throw new StateError('Empty XML document'));
  }

  @override
  XmlDocument get document => this;

  @override
  String get text => null;

  @override
  XmlNodeType get nodeType => XmlNodeType.DOCUMENT;

  @override
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor) => visitor.visitDocument(this);

}
