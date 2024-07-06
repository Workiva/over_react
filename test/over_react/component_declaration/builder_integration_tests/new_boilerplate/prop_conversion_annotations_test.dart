// @dart=2.14
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

import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client/react_interop.dart' show JsRef;
import 'package:test/test.dart';

part 'prop_conversion_annotations_test.over_react.g.dart';

void main() {
  group('(New boilerplate) prop conversion annotations:', () {
    test('@ConvertProp works as expected', () {
      final fooPropKey = Test().getPropKey((p) => p.foo);

      expect((Test()..foo = 100), equals({fooPropKey: r'$100'}),
          reason: 'setter should convert value');

      expect(Test({fooPropKey: r'$200'}).foo, 200,
          reason: 'getter should convert value');
    });

    test('@ConvertProp on a late prop works as expected', () {
      final latePropKey = Test().getPropKey((p) => p.lateProp);

      expect((Test()..lateProp = 100), equals({latePropKey: r'$100'}),
          reason: 'setter should convert value');

      expect(Test({latePropKey: r'$200'}).lateProp, 200,
          reason: 'getter should convert value');
    });

    test('@convertJsMapProp works as expected', () {
      final map = {'abc': true};
      final mapPropKey = Test().getPropKey((p) => p.mapProp);

      final setterResult = (Test()..mapProp = map)[mapPropKey];
      expect(setterResult, isA<JsMap>(), reason: 'setter should convert value');
      expect(unjsifyMapProp(setterResult as JsMap), map);

      expect(Test({mapPropKey: jsifyMapProp(map)}).mapProp, map,
          reason: 'getter should convert value');
    });

    test('@convertJsRefProp works as expected', () {
      final ref = createRef();
      final refPropKey = Test().getPropKey((p) => p.refProp);

      final setterResult = (Test()..refProp = ref)[refPropKey];
      expect(setterResult, isA<JsRef>(), reason: 'setter should convert value');
      expect(unjsifyRefProp(setterResult), ref);

      expect(Test({refPropKey: jsifyRefProp(ref)}).refProp, ref,
          reason: 'getter should convert value');
    });
  });
}

UiFactory<TestProps> Test = uiFunction(
  (_) {},
  _$TestConfig, // ignore: undefined_identifier
);

String? nullableMakeMoney(int? i) => i == null ? null : makeMoney(i);
int? nullableGetNumber(String? i) => i == null ? null : getNumber(i);

String makeMoney(int i) => '\$$i';
int getNumber(String i) => int.parse(i.replaceFirst('\$', ''));

mixin TestProps on UiProps {
  @ConvertProp<String?, int?>(nullableMakeMoney, nullableGetNumber)
  int? foo;

  @ConvertProp<String, int>(makeMoney, getNumber)
  late int lateProp;

  @convertJsMapProp
  Map? mapProp;

  @convertJsRefProp
  dynamic refProp;
}
