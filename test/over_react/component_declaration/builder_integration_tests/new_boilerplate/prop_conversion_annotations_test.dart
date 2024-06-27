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

import 'package:over_react/over_react.dart';
import 'package:react_testing_library/react_testing_library.dart' as rtl;
import 'package:test/test.dart';

part 'prop_conversion_annotations_test.over_react.g.dart';

void main() {
  group('(New boilerplate) prop conversion annotations:', () {
    setUp(() {
      setterReturnValue = null;
      gottenProp = null;
    });

    test('@ConvertProp works as expected', () {
      rtl.render((Test()..foo = 100)());

      expect(setterReturnValue, '\$100');
      expect(gottenProp, 100);
    });

    test('@convertJsMapProp works as expected', () {
      final map = {'abc': true};
      rtl.render((Test()..mapProp = map)());

      expect(gottenProp, map);
    });

    test('@convertJsRefProp works as expected', () {
      final ref = createRef();
      rtl.render((Test()..refProp = ref)());

      expect(gottenProp, ref);
    });
  });
}

String? setterReturnValue;
dynamic gottenProp;

UiFactory<TestProps> Test = uiFunction(
  (props) {
    if(props.foo != null) {
      gottenProp = props.foo;
    } else if(props.mapProp != null) {
      gottenProp = props.mapProp;
    } else if(props.refProp != null) {
      gottenProp = props.refProp;
    }
  },
  _$TestConfig, // ignore: undefined_identifier
);

String? makeMoney(int? i) {
  setterReturnValue = i == null ? null : '\$$i';
  return setterReturnValue!;
}
int? getNumber(String? i) => i == null ? null : int.tryParse(i.replaceFirst('\$', ''));

mixin TestProps on UiProps {
  @ConvertProp<String?, int?>(makeMoney, getNumber)
  int? foo;

  @convertJsMapProp
  Map? mapProp;

  @convertJsRefProp
  dynamic refProp;
}
