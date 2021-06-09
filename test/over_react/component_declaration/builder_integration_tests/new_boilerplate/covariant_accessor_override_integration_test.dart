// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
// Copyright 2016 Workiva Inc.
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
import 'package:test/test.dart';

part 'covariant_accessor_override_integration_test.over_react.g.dart';

main() {
  group('(New boilerplate) covariant acessor integration:', () {
    test('override works without compile-time or runtime errors', () {
      final test = Test();

      expect(() => test.foo = 'bar', returnsNormally);

      String value;
      expect(() => value = test.foo, returnsNormally);

      expect(value, 'bar');
    });
  });
}

UiFactory<TestProps> Test = _$Test; // ignore: undefined_identifier, invalid_assignment

mixin BasePropsMixin on UiProps {
  Object foo;
}

mixin OverridePropsMixin on UiProps, BasePropsMixin {
  @override
  covariant String foo;
}

class TestProps = UiProps with BasePropsMixin, OverridePropsMixin;
