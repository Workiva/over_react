// Copyright 2021 Workiva Inc.
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
library cast_ui_factory_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

part 'cast_ui_factory_test.over_react.g.dart';

main() {
  group('castUiFactory', () {
    test('infers the typing of a factory', () {
      UiFactory<BasicProps> testFactory = castUiFactory(_$Basic);

      // This assignment should analyze properly without any static implicit_cast errors
      UiFactory<BasicProps> testAssignment = testFactory; // ignore: unused_local_variable
    });

    test('can use generics to set the type', () {
      final testFactory = castUiFactory<BasicProps>(_$Basic);

      // This assignment should analyze properly without any static implicit_cast errors
      UiFactory<BasicProps> testAssignment = testFactory; // ignore: unused_local_variable
    });

    test('will leave the type a `UiFactory<UiProps` if no type is provided', () {
      final testFactory = castUiFactory(_$Basic);

      // This assignment should analyze properly without any static implicit_cast errors
      UiFactory<UiProps> testAssignment = testFactory; // ignore: unused_local_variable
    });

    test('throws an error if provided something other than a UiFactory', () {
      expect(() => castUiFactory('test'), throwsA(isA<CastError>()));
    });
  });
}

UiFactory<BasicProps> Basic = castUiFactory(_$Basic); // ignore: undefined_identifier

mixin BasicProps on UiProps {}

class BasicComponent extends UiComponent2<BasicProps> {
  @override
  render() => 'test';
}
