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
library builder_utils.test.unit.node_with_meta_test;

import 'package:analyzer/analyzer.dart';
import 'package:test/test.dart';

import 'package:builder_utils/builder_utils.dart';

import '../test_utils.dart';

void main() {
  group('NodeWithMeta', () {
    test('instantiates and provides access to an annotation and node', () {
      var member = parseAndGetSingleMember('@TestAnnotation("hello")\nvar a;');
      var nodeWithMeta =
          new NodeWithMeta<TopLevelVariableDeclaration, TestAnnotation>(member);

      expect(nodeWithMeta.node, same(member));
      expect(nodeWithMeta.metaNode, isNotNull);
      expect(nodeWithMeta.metaNode.name.name, 'TestAnnotation');
      expect(nodeWithMeta.meta, isNotNull);
      expect(nodeWithMeta.meta.positional, 'hello');
    });

    test('partially instantiates an "incomplete" annotation', () {
      var member = parseAndGetSingleMember(
          '@TestAnnotation(someIdentifier, named: "hello")\nvar a;');
      var nodeWithMeta =
          new NodeWithMeta<TopLevelVariableDeclaration, TestAnnotation>(member);

      expect(nodeWithMeta.node, same(member));
      expect(nodeWithMeta.metaNode, isNotNull);
      expect(nodeWithMeta.metaNode.name.name, 'TestAnnotation');

      expect(nodeWithMeta.isIncomplete, isTrue);
      expect(nodeWithMeta.unsupportedArguments, hasLength(1));
      expect(() => nodeWithMeta.meta, throwsStateError);

      expect(nodeWithMeta.potentiallyIncompleteMeta, isNotNull,
          reason:
              'should still have attempted to instantiate the incomplete annotation');
      expect(nodeWithMeta.potentiallyIncompleteMeta.named, equals('hello'),
          reason: 'should still have passed the supported argument');
      expect(nodeWithMeta.potentiallyIncompleteMeta.positional, isNull,
          reason: 'should have used null for unsupported argument');
    });

    test('gracefully handles a node without an annotation', () {
      var member = parseAndGetSingleMember('var a;');
      var nodeWithMeta =
          new NodeWithMeta<TopLevelVariableDeclaration, TestAnnotation>(member);

      expect(nodeWithMeta.node, same(member));
      expect(nodeWithMeta.metaNode, isNull);
      expect(nodeWithMeta.meta, isNull);
    });
  });
}
