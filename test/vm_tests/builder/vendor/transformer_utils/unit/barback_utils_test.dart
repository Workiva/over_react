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

// Copied from https://github.com/Workiva/dart_transformer_utils/tree/0.2.23/test/

@TestOn('vm')
library;

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:build/build.dart';
import 'package:over_react/src/builder/vendor/transformer_utils/src/barback_utils.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

const String sourceFileText = '''
var plainVar = "plain";

/// Comment
@Annotation()
var varWithCommentAndMeta = "annotated";
''';

void main() {
  group('assetIdToPackageUri()', () {
    test('returns original path for non-lib file', () {
      var assetId = AssetId('transformer_utils', 'test/test_utils.dart');
      expect(assetIdToPackageUri(assetId), Uri.parse('test/test_utils.dart'));
    });

    test('returns path with "package" scheme for lib file', () {
      var assetId = AssetId('transformer_utils', 'lib/transformer_utils.dart');
      expect(assetIdToPackageUri(assetId),
          Uri.parse('package:over_react/src/builder/vendor/transformer_utils/transformer_utils.dart'));
    });
  });

  group('getSpanForNode()', () {
    test('should get node but skip comment and meta by default', () {
      var sourceFile = SourceFile.fromString(sourceFileText);
      var unit =
          parseString(content: sourceFileText, throwIfDiagnostics: false).unit;
      var annotatedNode = unit.childEntities.last as AstNode;
      var span = getSpanForNode(sourceFile, annotatedNode);
      expect(span.text, 'var varWithCommentAndMeta = "annotated";');
    });

    test('should not skip comment and meta if skip is false', () {
      var sourceFile = SourceFile.fromString(sourceFileText);
      var unit =
          parseString(content: sourceFileText, throwIfDiagnostics: false).unit;
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
      var sourceFile = SourceFile.fromString(sourceFileText);
      var unit =
          parseString(content: sourceFileText, throwIfDiagnostics: false).unit;
      var plainNode = unit.childEntities.first as AstNode;
      var span = getSpanForNode(sourceFile, plainNode);
      expect(span.text, 'var plainVar = "plain";');
    });
  });
}
