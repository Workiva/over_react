library web_skin_dart.transformer.source_file_helpers;

import 'package:analyzer/analyzer.dart';
import 'package:source_span/source_span.dart';

class Replacement {
  final SourceSpan span;
  final String newText;

  Replacement(this.span, this.newText);
}

class TransformedSourceFile {
  final List<Replacement> _replacements = [];

  final SourceFile sourceFile;

  TransformedSourceFile(this.sourceFile);

  bool get isModified => _replacements.isNotEmpty;

  void replace(SourceSpan span, String text) {
    _replacements.add(
        new Replacement(span, text)
    );
  }

  void insert(SourceLocation location, String text) {
    _replacements.add(
        new Replacement(location.pointSpan(), text)
    );
  }

  String getTransformedText() {
    _replacements.sort((r1, r2) => r1.span.compareTo(r2.span));

    StringBuffer transformedSource = new StringBuffer();

    var lastEdge = 0;
    for (Replacement replacement in _replacements) {
      transformedSource
        ..write(sourceFile.getText(lastEdge, replacement.span.start.offset))
        ..write(replacement.newText);

      lastEdge = replacement.span.end.offset;
    }

    transformedSource.write(sourceFile.getText(lastEdge));

    return transformedSource.toString();
  }
}

SourceSpan getSpan(SourceFile sourceFile, AstNode node) {
  return sourceFile.span(node.offset, node.end);
}
