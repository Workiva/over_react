// Copyright 2020 Workiva Inc.
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
import 'package:over_react/src/builder/parsing/meta.dart';
import 'package:test/test.dart';

import '../ast_test_util.dart';

void main() {
  group('InstantiatedMeta', () {
    test('instantiates and provides access to an annotation and node', () {
      final member = parseAndGetSingleMember(r'''
        @TestAnnotation("hello")
        var a;
      ''');
      final meta = InstantiatedMeta<TestAnnotation>(member);

      expect(meta.metaNode, isNotNull);
      expect(meta.metaNode.name.name, 'TestAnnotation');
      expect(meta.value, isNotNull);
      expect(meta.value.positional, 'hello');
    });

    test('partially instantiates an "incomplete" annotation', () {
      final member = parseAndGetSingleMember(r'''
        @TestAnnotation(someIdentifier, named: "hello")
        var a;
      ''');
      final meta = InstantiatedMeta<TestAnnotation>(member);

      expect(meta.metaNode, isNotNull);
      expect(meta.metaNode.name.name, 'TestAnnotation');

      expect(meta.isIncomplete, isTrue);
      expect(meta.unsupportedArguments, hasLength(1));
      expect(() => meta.value, throwsStateError);

      expect(meta.potentiallyIncompleteValue, isNotNull,
          reason: 'should still have attempted to instantiate the incomplete annotation');
      expect(meta.potentiallyIncompleteValue.named, equals('hello'),
          reason: 'should still have passed the supported argument');
      expect(meta.potentiallyIncompleteValue.positional, isNull,
          reason: 'should have used null for unsupported argument');
    });

    test('gracefully handles a node without a matching annotation and returns null', () {
      final member = parseAndGetSingleMember(r'''
        var a;
      ''');
      final meta = InstantiatedMeta<TestAnnotation>(member);

      expect(meta, isNull);
    });
  });
}

class TestAnnotation {
  final Object positional;
  final Object named;
  final Object namedConstructorOnly;

  const TestAnnotation(this.positional, {this.named}) : namedConstructorOnly = null;

  const TestAnnotation.namedConstructor({this.namedConstructorOnly})
      : positional = null,
        named = null;
}
