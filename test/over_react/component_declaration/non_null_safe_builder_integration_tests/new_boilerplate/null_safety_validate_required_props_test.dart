// @dart=2.11
// Copyright 2024 Workiva Inc.
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

import 'package:over_react/over_react.dart';
import 'package:react_testing_library/react_testing_library.dart' as rtl;
import 'package:test/test.dart';

import '../../builder_integration_tests/new_boilerplate/null_safety_validate_required_props_test.dart';

part 'null_safety_validate_required_props_test.over_react.g.dart';

void main() {
  group('(New boilerplate) required prop validation: does not throw for non-null safe components',
      () {
    group('on invocation', () {
      test('via call()', () {
        expect(() {
          (Test()..requiredNullable = true)();
        }, returnsNormally);
      });

      test('via build()', () {
        expect(() {
          (Test()..requiredNullable = true).build();
        }, returnsNormally);
      });
    });

    test('on mount', () {
      expect(() {
        rtl.render((Test()..requiredNullable = true)());
      }, returnsNormally);
    });
  });
}

UiFactory<TestProps> Test = castUiFactory(_$Test); // ignore: undefined_identifier

mixin TestPropsMixin on UiProps {}

class TestProps = UiProps with TestPropsMixin, RequiredPropsTestProps;

class TestComponent extends UiComponent2<TestProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {}
}
