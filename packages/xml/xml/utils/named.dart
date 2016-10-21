part of xml;

/// A named XML node, such as an [XmlElement] or [XmlAttribute].
abstract class XmlNamed {

  /// Return the name of the node.
  XmlName get name;

}

/// Internal function type to match named elements.
typedef bool _XmlNamedMatcher(XmlNamed named);

/// Internal factory to create element matchers.
_XmlNamedMatcher _createMatcher(String name, String namespace) {
  if (name == null) {
    throw new ArgumentError('Illegal name matcher.');
  } else if (name == '*') {
    if (namespace == null || namespace == '*') {
      return (XmlNamed named) => true;
    } else {
      return (XmlNamed named) => named.name.namespaceUri == namespace;
    }
  } else {
    if (namespace == null) {
      return (XmlNamed named) => named.name.qualified == name;
    } else if (namespace == '*') {
      return (XmlNamed named) => named.name.local == name;
    } else {
      return (XmlNamed named) =>
          named.name.local == name && named.name.namespaceUri == namespace;
    }
  }
}
