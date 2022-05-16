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
import 'package:over_react/src/util/prop_key_util.dart';

part 'prop_key_util_test_dart2.over_react.g.dart';

main() {
  group('getPropKey', () {
    test('returns the expected key', () {
      var testProps = Test()..foo = 'baz';
      var fooPropKey = getPropKey((props) { (props as TestProps).foo; }, Test);   // ignore: avoid_as
      expect(testProps, equals({fooPropKey: 'baz'}));
    });

    test('throws if you don\'t access the prop', () {
      expect(() => getPropKey((props) => false, Test), throwsStateError);
    });

    test('throws if you access the prop multiple times', () {
      expect(() => getPropKey((props) {
        (props as TestProps).foo; // ignore: avoid_as
        (props as TestProps).foo; // ignore: avoid_as
      }, Test), throwsStateError);
    });

    test('throws if you access multiple props', () {
      expect(() => getPropKey((props) {
        (props as TestProps).foo; // ignore: avoid_as
        (props as TestProps).bar; // ignore: avoid_as
      }, Test), throwsStateError);
    });
  });
}

@Factory()
UiFactory<TestProps> Test = _$Test; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$TestProps extends UiProps {
  String foo;

  String bar;
}

@Component2()
class TestComponent extends UiComponent2<TestProps> {
  @override
  render() {}
}

