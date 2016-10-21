part of xml;

/// XML processing instruction.
class XmlProcessing extends XmlData {

  /// Return the processing target.
  final String target;

  /// Create a processing node with `target` and `text`.
  XmlProcessing(this.target, String text) : super(text);

  @override
  XmlNodeType get nodeType => XmlNodeType.PROCESSING;

  @override
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor) => visitor.visitProcessing(this);

}
