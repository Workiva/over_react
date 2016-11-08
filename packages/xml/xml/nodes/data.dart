part of xml;

/// Abstract XML data node.
abstract class XmlData extends XmlNode {

  /// Return the textual value of this node.
  @override
  final String text;

  /// Create a data section with `text`.
  XmlData(this.text);

}
