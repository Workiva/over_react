// Copyright 2015 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library transformer_utils.src.transformed_source_file;

import 'dart:convert';

import 'package:analyzer/analyzer.dart';
import 'package:source_span/source_span.dart';

/// A record used internally by [TransformedSourceFile] that represents the
/// replacement of a [SourceSpan] with a string of text.
class _Replacement {
  final SourceSpan span;
  final String newText;

  _Replacement(this.span, this.newText);

  @override
  String toString() => 'Replacement (span: $span, newText: $newText)';
}

/// A utility that allows for modification of a [SourceFile] via a series of
/// replacements, insertions, and removals.
class TransformedSourceFile {
  final List<_Replacement> _replacements = [];

  final SourceFile sourceFile;

  TransformedSourceFile(this.sourceFile);

  bool get isModified => _replacements.isNotEmpty;

  void replace(SourceSpan span, String text) {
    _replacements.add(new _Replacement(span, text));
  }

  void insert(SourceLocation location, String text) {
    _replacements.add(new _Replacement(location.pointSpan(), text));
  }

  void remove(SourceSpan span, {bool preserveNewlines: false}) {
    String replacement;
    if (preserveNewlines) {
      replacement = '\n' * '\n'.allMatches(span.text).length;
    } else {
      replacement = '';
    }

    _replacements.add(new _Replacement(span, replacement));
  }

  void iterateReplacements(
      {onUnmodified(String string),
      onRemoval(String string),
      onAddition(String string)}) {
    _replacements.sort((r1, r2) => r1.span.compareTo(r2.span));

    var lastEdge = 0;
    for (_Replacement replacement in _replacements) {
      if (replacement.span.start.offset < lastEdge) {
        throw 'Overlapping replacement $replacement in replacements $_replacements.';
      }

      var unmodifiedText =
          sourceFile.getText(lastEdge, replacement.span.start.offset);
      var removalText = replacement.span.text;
      var additionText = replacement.newText;

      if (onUnmodified != null && unmodifiedText.isNotEmpty) {
        onUnmodified(unmodifiedText);
      }
      if (onRemoval != null && removalText.isNotEmpty) {
        onRemoval(removalText);
      }
      if (onAddition != null && additionText.isNotEmpty) {
        onAddition(additionText);
      }

      lastEdge = replacement.span.end.offset;
    }

    var unmodifiedText = sourceFile.getText(lastEdge);
    if (onUnmodified != null && unmodifiedText != null) {
      onUnmodified(unmodifiedText);
    }
  }

  String getTransformedText() {
    StringBuffer transformedSource = new StringBuffer();

    iterateReplacements(
        onUnmodified: transformedSource.write,
        onAddition: transformedSource.write);

    return transformedSource.toString();
  }

  String getHtmlDiff() {
    const HtmlEscape elementEscaper = const HtmlEscape(HtmlEscapeMode.ELEMENT);
    const HtmlEscape attrEscaper = const HtmlEscape(HtmlEscapeMode.ATTRIBUTE);

    StringBuffer diff = new StringBuffer();

    void writeDiff(String source, String className) {
      diff.write('<span class="$className">');
      diff.write(elementEscaper.convert(source));
      diff.write('</span>');
    }

    iterateReplacements(
        onUnmodified: (source) => writeDiff(source, 'diff-unmodified'),
        onRemoval: (source) => writeDiff(source, 'diff-removal'),
        onAddition: (source) => writeDiff(source, 'diff-addition'));

    return '''
        <!DOCTYPE html>
        <html>
        <head>
          <title>Transformer Diff - ${attrEscaper.convert(sourceFile.url.path)}</title>
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

SourceSpan getSpan(SourceFile sourceFile, AstNode node,
    {bool skipCommentAndMetadata: true}) {
  if (skipCommentAndMetadata && node is AnnotatedNode) {
    return sourceFile.span(
        node.firstTokenAfterCommentAndMetadata.offset, node.end);
  }

  return sourceFile.span(node.offset, node.end);
}
