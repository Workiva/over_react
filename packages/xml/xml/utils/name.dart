part of xml;

// separator between prefix and local name
final _SEPARATOR = ':';

// xml namespace declarations
final _XML = 'xml';
final _XML_DATA = new _NamespaceData(_XML, true);
final _XML_URI = 'http://www.w3.org/XML/1998/namespace';
final _XMLNS = 'xmlns';

/// XML entity name.
abstract class XmlName extends Object with XmlVisitable, XmlWritable, XmlOwned {

  /// Return the namespace prefix, or `null`.
  String get prefix;

  /// Return the local name, excluding the namespace prefix.
  String get local;

  /// Return the fully qualified name, including the namespace prefix.
  String get qualified;

  /// Return the namespace URI, or `null`.
  String get namespaceUri;

  /// Creates a qualified [XmlName] from a `local` name and an optional `prefix`.
  factory XmlName(String local, [String prefix]) {
    return prefix == null || prefix.isEmpty
        ? new _XmlSimpleName(local)
        : new _XmlPrefixName(prefix, local, '$prefix$_SEPARATOR$local');
  }

  /// Create a [XmlName] by parsing the provided `qualified` name.
  factory XmlName.fromString(String qualified) {
    var index = qualified.indexOf(_SEPARATOR);
    if (index > 0) {
      var prefix = qualified.substring(0, index);
      var local = qualified.substring(index + 1, qualified.length);
      return new _XmlPrefixName(prefix, local, qualified);
    } else {
      return new _XmlSimpleName(qualified);
    }
  }

  XmlName._();

  @override
  /*E*/ accept/*<E>*/(XmlVisitor/*<E>*/ visitor) => visitor.visitName(this);

  @override
  bool operator ==(other) => other is XmlName &&
      other.local == local &&
      other.namespaceUri == namespaceUri;

  @override
  int get hashCode => qualified.hashCode;

}

/// An XML entity name without a prefix.
class _XmlSimpleName extends XmlName {

  @override
  String get prefix => null;

  @override
  final String local;

  @override
  String get qualified => local;

  @override
  String get namespaceUri {
    for (var node = parent; node != null; node = node.parent) {
      for (var attribute in node.attributes) {
        if (attribute.name.prefix == null && attribute.name.local == _XMLNS) {
          return attribute.value;
        }
      }
    }
    return null;
  }

  _XmlSimpleName(this.local) : super._();

}

/// An XML entity name with a prefix.
class _XmlPrefixName extends XmlName {

  @override
  final String prefix;

  @override
  final String local;

  @override
  final String qualified;

  @override
  String get namespaceUri {
    for (var node = parent; node != null; node = node.parent) {
      for (var attribute in node.attributes) {
        if (attribute.name.prefix == _XMLNS && attribute.name.local == prefix) {
          return attribute.value;
        }
      }
    }
    return null;
  }

  _XmlPrefixName(this.prefix, this.local, this.qualified) : super._();

}
