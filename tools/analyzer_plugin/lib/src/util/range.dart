// Copyright 2022 Workiva Inc.
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

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

extension RangeFactoryAddons on RangeFactory {
  /// Returns a source range that covers the given [item] (including a leading or
  /// trailing comma as appropriate).
  ///
  /// Like [nodeInList] but doesn't require a reference to the parent node.
  SourceRange nodeInList2(AstNode item) {
    // Remove the trailing comma.
    var nextToken = item.endToken.next;
    if (nextToken?.type == TokenType.COMMA) {
      return startEnd(item, nextToken!);
    }

    // Remove the leading comma.
    var prevToken = item.beginToken.previous;
    if (prevToken?.type == TokenType.COMMA) {
      return startEnd(prevToken!, item);
    }

    return node(item);
  }
}
