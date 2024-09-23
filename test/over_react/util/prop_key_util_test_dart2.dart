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

@TestOn('browser')

import 'package:test/test.dart';
import 'package:over_react/over_react.dart';

part 'prop_key_util_test_dart2.over_react.g.dart';

main() {
  group('getPropKey', () {
    late final String expectedFooPropKey;

    setUpAll(() {
      expectedFooPropKey = (Test()..foo = 'baz').keys.single! as String;
    });

    test('returns the expected key', () {
      final fooPropKey = getPropKey<TestProps>((props) => props.foo, Test);
      expect(fooPropKey, expectedFooPropKey);
    });

    test('throws if you don\'t access the prop', () {
      expect(() => getPropKey<TestProps>((props) {}, Test), throwsStateError);
    });

    test('short-circuits once a prop key is accessed', () {
      var codeAfterAccessWasRun = false;
      getPropKey<TestProps>((props) {
        props.foo;
        codeAfterAccessWasRun = true;
      }, Test);
      expect(codeAfterAccessWasRun, isFalse);
    });

    test('returns the prop key even if the internal exception is caught', () {
      final fooPropKey = getPropKey<TestProps>((props) {
        try {
          props.foo;
        } catch (_) {}
      }, Test);
      expect(fooPropKey, expectedFooPropKey);
    });

    test('throws if the map is accessed more than once (only possible if the internal exception is caught)', () {
      expect(() => getPropKey<TestProps>((props) {
        try {
          props.foo;
        } catch (_) {}
        props.foo;
      }, Test), throwsStateError);
    });
  });
}

@Factory()
UiFactory<TestProps> Test = _$Test; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$TestProps extends UiProps {
  String? foo;

  String? bar;
}

@Component2()
class TestComponent extends UiComponent2<TestProps> {
  @override
  render() {}
}

