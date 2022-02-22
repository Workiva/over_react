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
// ignore_for_file: deprecated_member_use_from_same_package
library element_type_test;

import 'package:test/test.dart';
import 'package:over_react/over_react.dart';
// import 'package:over_react/src/component/dom_components.dart';

part 'element_type_test.over_react.g.dart'; // ignore: uri_has_not_been_generated

void main() {
  group('UiFactory.elementType', () {
    group('returns the expected value when used on a', () {
      test('Dom component', () {
        const factory = Dom.div;
        expect(factory.elementType, same(factory().componentFactory.type));
        expect(factory.elementType, 'div');
      });

      test('custom composite component', () {
        final factory = CustomTest;
        expect(factory.elementType, same(factory().componentFactory.type));
      });

      test('custom function component', () {
        final factory = CustomFnTest;
        expect(factory.elementType, same(factory().componentFactory.type));
      });
    });
  });
}

UiFactory<CustomTestProps> CustomTest =
    // ignore: undefined_identifier
    castUiFactory(_$CustomTest);

mixin CustomTestProps on UiProps {}

class CustomTestComponent extends UiComponent2<CustomTestProps> {
  @override
  render() {
    return null;
  }
}

final CustomFnTest = uiFunction<CustomFnTestProps>(
  (props) {
    return null;
  },
  _$CustomFnTestConfig, // ignore: undefined_identifier
);

mixin CustomFnTestProps on UiProps {}

