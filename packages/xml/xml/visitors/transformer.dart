part of xml;

/// Transformer that creates an identical copy of the visited nodes.
///
/// Subclass can override one or more of the methods to modify the generated copy.
class XmlTransformer extends XmlVisitor<XmlVisitable> {

  @override
  XmlAttribute visitAttribute(XmlAttribute node) {
    return new XmlAttribute(visit(node.name), node.value);
  }

  @override
  XmlCDATA visitCDATA(XmlCDATA node) {
    return new XmlCDATA(node.text);
  }

  @override
  XmlComment visitComment(XmlComment node) {
    return new XmlComment(node.text);
  }

  @override
  XmlDoctype visitDoctype(XmlDoctype node) {
    return new XmlDoctype(node.text);
  }

  @override
  XmlDocument visitDocument(XmlDocument node) {
    return new XmlDocument(visitAll(node.children));
  }

  @override
  XmlDocumentFragment visitDocumentFragment(XmlDocumentFragment node) {
    return new XmlDocumentFragment(visitAll(node.children));
  }

  @override
  XmlElement visitElement(XmlElement node) {
    return new XmlElement(visit(node.name), visitAll(node.attributes), visitAll(node.children));
  }

  @override
  XmlName visitName(XmlName name) {
    return new XmlName.fromString(name.qualified);
  }

  @override
  XmlProcessing visitProcessing(XmlProcessing node) {
    return new XmlProcessing(node.target, node.text);
  }

  @override
  XmlText visitText(XmlText node) {
    return new XmlText(node.text);
  }
}
