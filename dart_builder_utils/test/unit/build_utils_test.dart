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

@TestOn('vm')
library builder_utils.test.unit.build_utils_test;

import 'package:analyzer/analyzer.dart';
import 'package:build/build.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

import 'package:builder_utils/src/build_utils.dart';

const String sourceFileText = '''
var plainVar = "plain";

/// Comment
@Annotation()
var varWithCommentAndMeta = "annotated";
''';

void main() {
  group('assetIdToPackageUri()', () {
    test('returns original path for non-lib file', () {
      var assetId = new AssetId('builder_utils', 'test/test_utils.dart');
      expect(assetIdToPackageUri(assetId), Uri.parse('test/test_utils.dart'));
    });

    test('returns path with "package" scheme for lib file', () {
      var assetId =
          new AssetId('builder_utils', 'lib/builder_utils.dart');
      expect(assetIdToPackageUri(assetId),
          Uri.parse('package:builder_utils/builder_utils.dart'));
    });
  });

  group('getSpanForNode()', () {
    test('should get node but skip comment and meta by default', () {
      var sourceFile = new SourceFile.fromString(sourceFileText);
      var unit = parseCompilationUnit(sourceFileText);
      var annotatedNode = unit.childEntities.last as AstNode;
      var span = getSpanForNode(sourceFile, annotatedNode);
      expect(span.text, 'var varWithCommentAndMeta = "annotated";');
    });

    test('should not skip comment and meta if skip is false', () {
      var sourceFile = new SourceFile.fromString(sourceFileText);
      var unit = parseCompilationUnit(sourceFileText);
      var annotatedNode = unit.childEntities.last as AstNode;
      var span = getSpanForNode(sourceFile, annotatedNode,
          skipCommentAndMetadata: false);
      expect(
          span.text,
          [
            '/// Comment',
            '@Annotation()',
            'var varWithCommentAndMeta = "annotated";'
          ].join('\n'));
    });

    test('should return the whole span if the node is not annotated', () {
      var sourceFile = new SourceFile.fromString(sourceFileText);
      var unit = parseCompilationUnit(sourceFileText);
      var plainNode = unit.childEntities.first as AstNode;
      var span = getSpanForNode(sourceFile, plainNode);
      expect(span.text, 'var plainVar = "plain";');
    });
  });

  group('getSpan()', () {
    const String source = '\n'
        '/// Doc comment\n'
        '@Annotation\n'
        'class Node {}\n';

    SourceFile sourceFile;
    AnnotatedNode node;

    setUp(() {
      sourceFile = new SourceFile.fromString(source);
      node = parseCompilationUnit(source).declarations.single;
    });

    test(
        'returns a SourceSpan for a node, skipping its doc comments and meta by default',
        () {
      var span = getSpan(sourceFile, node);
      expect(span.start.offset, equals(source.indexOf('class')));
      expect(span.end.offset, equals(source.indexOf('}') + 1));
    });

    test('returns a SourceSpan for a node, including its doc comments and meta',
        () {
      var span = getSpan(sourceFile, node, skipCommentAndMetadata: false);
      expect(span.start.offset, equals(source.indexOf('///')));
      expect(span.end.offset, equals(source.indexOf('}') + 1));
    });
  });
}
