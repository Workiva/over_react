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

library transformer_utils.src.node_with_meta;

import 'package:analyzer/analyzer.dart';
import 'package:barback/barback.dart';

import 'package:transformer_utils/src/analyzer_helpers.dart';

/// Utility class that allows for easy access to an annotated node's
/// instantiated annotation.
class NodeWithMeta<TNode extends AnnotatedNode, TMeta> {
  /// The optionally-annotated node.
  final TNode node;

  /// The optional asset ID associated with this node.
  final AssetId assetId;

  /// The node of the [TMeta] annotation, if it exists.
  final Annotation metaNode;

  /// A reflectively-instantiated version of [metaNode], if it exists.
  TMeta _meta;

  /// The arguments passed to the metadata that are not supported by [getValue],
  /// (or by special handling in subclasses) and therefore not represented in the instantiation of [meta].
  List<Expression> unsupportedArguments;

  /// Construct a [NodeWithMeta] instance from an [AnnotatedNode].
  /// The original node will be available via [node].
  /// The instantiated annotation of type `TMeta` will be available via [meta].
  NodeWithMeta(TNode node, {this.assetId})
      : this.node = node,
        this.metaNode = getMatchingAnnotation(node, TMeta) {
    this.unsupportedArguments = <Expression>[];
    this._meta = instantiateAnnotation(node, TMeta,
        onUnsupportedArgument: this.unsupportedArguments.add);
  }

  /// Whether this node's metadata has arguments that could not be initialized using [getValue]
  /// (or by special handling in subclasses), and therefore cannot represented in the instantiation of [meta].
  bool get isIncomplete => unsupportedArguments.isNotEmpty;

  /// A reflectively-instantiated version of [metaNode], if it exists.
  ///
  /// Throws a [StateError] if this node's metadata is incomplete.
  TMeta get meta {
    if (isIncomplete) {
      throw new StateError(
          'Metadata is incomplete; unsupported arguments $unsupportedArguments. '
          'Use `potentiallyIncompleteMeta` instead.');
    }
    return _meta;
  }

  /// A reflectively-instantiated version of [metaNode], if it exists.
  TMeta get potentiallyIncompleteMeta => _meta;
}
