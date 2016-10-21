part of xml;

/// XML parser that defines standard actions to the the XML tree.
class XmlParserDefinition extends XmlGrammarDefinition<XmlNode, XmlName> {

  @override
  XmlAttribute createAttribute(XmlName name, String text) => new XmlAttribute(name, text);

  @override
  XmlComment createComment(String text) => new XmlComment(text);

  @override
  XmlCDATA createCDATA(String text) => new XmlCDATA(text);

  @override
  XmlDoctype createDoctype(String text) => new XmlDoctype(text);

  @override
  XmlDocument createDocument(Iterable<XmlNode> children) => new XmlDocument(children);

  @override
  XmlElement createElement(XmlName name, Iterable<XmlNode> attributes, Iterable<XmlNode> children) {
    return new XmlElement(name, attributes, children);
  }

  @override
  XmlProcessing createProcessing(String target, String text) => new XmlProcessing(target, text);

  @override
  XmlName createQualified(String name) => new XmlName.fromString(name);

  @override
  XmlText createText(String text) => new XmlText(text);

}
