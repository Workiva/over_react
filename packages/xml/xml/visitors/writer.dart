part of xml;

/// A visitor that writes XML nodes exactly as they were parsed.
class XmlWriter extends XmlVisitor {

  final StringBuffer buffer;

  XmlWriter(this.buffer);

  @override
  visitAttribute(XmlAttribute node) {
    visit(node.name);
    buffer.write(XmlGrammarDefinition.EQUALS);
    buffer.write(XmlGrammarDefinition.DOUBLE_QUOTE);
    buffer.write(_encodeXmlAttributeValue(node.value));
    buffer.write(XmlGrammarDefinition.DOUBLE_QUOTE);
  }

  @override
  visitCDATA(XmlCDATA node) {
    buffer.write(XmlGrammarDefinition.OPEN_CDATA);
    buffer.write(node.text);
    buffer.write(XmlGrammarDefinition.CLOSE_CDATA);
  }

  @override
  visitComment(XmlComment node) {
    buffer.write(XmlGrammarDefinition.OPEN_COMMENT);
    buffer.write(node.text);
    buffer.write(XmlGrammarDefinition.CLOSE_COMMENT);
  }

  @override
  visitDoctype(XmlDoctype node) {
    buffer.write(XmlGrammarDefinition.OPEN_DOCTYPE);
    buffer.write(XmlGrammarDefinition.WHITESPACE);
    buffer.write(node.text);
    buffer.write(XmlGrammarDefinition.CLOSE_DOCTYPE);
  }

  @override
  visitDocument(XmlDocument node) {
    writeChildren(node);
  }

  @override
  visitDocumentFragment(XmlDocumentFragment node) {
    buffer.write('#document-fragment');
  }

  @override
  visitElement(XmlElement node) {
    buffer.write(XmlGrammarDefinition.OPEN_ELEMENT);
    visit(node.name);
    writeAttributes(node);
    if (node.children.isEmpty) {
      buffer.write(XmlGrammarDefinition.WHITESPACE);
      buffer.write(XmlGrammarDefinition.CLOSE_END_ELEMENT);
    } else {
      buffer.write(XmlGrammarDefinition.CLOSE_ELEMENT);
      writeChildren(node);
      buffer.write(XmlGrammarDefinition.OPEN_END_ELEMENT);
      visit(node.name);
      buffer.write(XmlGrammarDefinition.CLOSE_ELEMENT);
    }
  }

  @override
  visitName(XmlName name) {
    buffer.write(name.qualified);
  }

  @override
  visitProcessing(XmlProcessing node) {
    buffer.write(XmlGrammarDefinition.OPEN_PROCESSING);
    buffer.write(node.target);
    if (node.text.isNotEmpty) {
      buffer.write(XmlGrammarDefinition.WHITESPACE);
      buffer.write(node.text);
    }
    buffer.write(XmlGrammarDefinition.CLOSE_PROCESSING);
  }

  @override
  visitText(XmlText node) {
    buffer.write(_encodeXmlText(node.text));
  }

  writeAttributes(XmlNode node) {
    for (var attribute in node.attributes) {
      buffer.write(XmlGrammarDefinition.WHITESPACE);
      visit(attribute);
    }
  }

  writeChildren(XmlNode node) {
    for (var child in node.children) {
      visit(child);
    }
  }
}


/// A visitor that writes XML nodes correctly indented and with whitespaces adapted.
class XmlPrettyWriter extends XmlWriter {

  int level = 0;
  final String indent;

  XmlPrettyWriter(buffer, this.level, this.indent) : super(buffer);

  @override
  visitCDATA(XmlCDATA node) {
    newLine();
    super.visitCDATA(node);
  }

  @override
  visitComment(XmlComment node) {
    newLine();
    super.visitComment(node);
  }

  @override
  visitDoctype(XmlDoctype node) {
    newLine();
    super.visitDoctype(node);
  }

  @override
  visitElement(XmlElement node) {
    newLine();
    buffer.write(XmlGrammarDefinition.OPEN_ELEMENT);
    visit(node.name);
    writeAttributes(node);
    if (node.children.isEmpty) {
      buffer.write(XmlGrammarDefinition.WHITESPACE);
      buffer.write(XmlGrammarDefinition.CLOSE_END_ELEMENT);
    } else {
      buffer.write(XmlGrammarDefinition.CLOSE_ELEMENT);
      level++;
      writeChildren(node);
      level--;
      if (!node.children.every((each) => each is XmlText)) {
        newLine();
      }
      buffer.write(XmlGrammarDefinition.OPEN_END_ELEMENT);
      visit(node.name);
      buffer.write(XmlGrammarDefinition.CLOSE_ELEMENT);
    }
  }

  @override
  visitProcessing(XmlProcessing node) {
    newLine();
    super.visitProcessing(node);
  }

  @override
  visitText(XmlText node) {
    // If text is purely whitespace, don't output to the buffer
    // the indentation and newlines will be handled elsewhere.
    if (node.text.trim().isNotEmpty) {
      super.visitText(node);
    }
  }

  void newLine() {
    if (buffer.isNotEmpty) {
      buffer.writeln();
    }
    for (int i = 0; i < level; i++) {
      buffer.write(indent);
    }
  }
}
