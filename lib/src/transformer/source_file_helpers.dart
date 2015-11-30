library web_skin_dart.transformer.source_file_helpers;

import 'dart:convert';

import 'package:analyzer/analyzer.dart';
import 'package:source_span/source_span.dart';

class Replacement {
  final SourceSpan span;
  final String newText;

  Replacement(this.span, this.newText);

  @override
  String toString() => 'Replacement (span: $span, newText: $newText)';
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

  void remove(SourceSpan span, {bool preserveNewlines: false}) {
    String replacement;
    if (preserveNewlines) {
      replacement = '\n' * '\n'.allMatches(span.text).length;
    } else {
      replacement = '';
    }

    _replacements.add(
        new Replacement(span, replacement)
    );
  }

  void processReplacements({onUnmodified(String string), onRemoval(String string), onAddition(String string)}) {
    _replacements.sort((r1, r2) => r1.span.compareTo(r2.span));
    
    var lastEdge = 0;
    for (Replacement replacement in _replacements) {
      if (replacement.span.start.offset < lastEdge) {
        throw 'Overlapping replacement $replacement in replacements $_replacements.';
      }

      if (onUnmodified != null) {
        onUnmodified(sourceFile.getText(lastEdge, replacement.span.start.offset));
      }
      if (onRemoval != null) {
        onRemoval(replacement.span.text);
      }
      if (onAddition != null) {
        onAddition(replacement.newText);
      }

      lastEdge = replacement.span.end.offset;
    }

    if (onUnmodified != null) {
      onUnmodified(sourceFile.getText(lastEdge));
    }
  }

  String getTransformedText() {
    StringBuffer transformedSource = new StringBuffer();

    processReplacements(
        onUnmodified: (source) => transformedSource.write(source),
        onAddition: (source) => transformedSource.write(source)
    );

    return transformedSource.toString();
  }

  String getHtmlDiff() {
    StringBuffer diff = new StringBuffer();

    void writeDiff(String source, String className) {
      if (source.isEmpty) {
        return;
      }

      diff.write('<span class="$className">');
      diff.write(const HtmlEscape().convert(source));
      diff.write('</span>');
    }
    
    processReplacements(
        onUnmodified: (source) => writeDiff(source, 'diff-unmodified'),
        onRemoval: (source) => writeDiff(source, 'diff-removal'),
        onAddition: (source) => writeDiff(source, 'diff-addition')
    );

    return '''
        <!DOCTYPE html>
        <html>
        <head>
          <title>web_skin_dart Transformer Diff - ${const HtmlEscape().convert(sourceFile.url.path)}</title>
          <style>
            .diff-unmodified {
                color: #444;
            }
            .diff-removal {
                color: #a00;
                background-color: #fee;
                text-decoration: line-through;
            }
            .diff-addition {
                color: #0a0;
                background-color: #efe;
            }
          </style>
        </head>
        <body>
          <code>
            <pre>$diff</pre>
          </code>
        </body>
        </html>
    ''';
  }
}

SourceSpan getSpan(SourceFile sourceFile, AstNode node, {bool skipCommentAndMetadata: true}) {
  if (skipCommentAndMetadata && node is AnnotatedNode) {
    return sourceFile.span(node.firstTokenAfterCommentAndMetadata.offset, node.end);
  }

  return sourceFile.span(node.offset, node.end);
}
