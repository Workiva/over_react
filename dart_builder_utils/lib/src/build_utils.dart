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

library builder_utils.src.build_utils;

import 'package:analyzer/analyzer.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:source_span/source_span.dart';

/// Converts [id] to a "package:" URI.
///
/// This will return a schemeless URI if [id] doesn't represent a library in
/// `lib/`.
Uri assetIdToPackageUri(AssetId id) {
  if (!id.path.startsWith('lib/')) return new Uri(path: id.path);
  return new Uri(
      scheme: 'package',
      path: path.url.join(id.package, id.path.replaceFirst('lib/', '')));
}

/// Returns a [SourceSpan] spanning from the beginning to the end of the given
/// [node]. The preceding comment and metadata will be excluded if
/// [skipCommentAndMetadata] is true.
SourceSpan getSpanForNode(SourceFile sourceFile, AstNode node,
    {bool skipCommentAndMetadata: true}) {
  if (skipCommentAndMetadata && node is AnnotatedNode) {
    return sourceFile.span(
        node.firstTokenAfterCommentAndMetadata.offset, node.end);
  }

  return sourceFile.span(node.offset, node.end);
}

SourceSpan getSpan(SourceFile sourceFile, AstNode node,
    {bool skipCommentAndMetadata: true}) {
  if (skipCommentAndMetadata && node is AnnotatedNode) {
    return sourceFile.span(
        node.firstTokenAfterCommentAndMetadata.offset, node.end);
  }

  return sourceFile.span(node.offset, node.end);
}
