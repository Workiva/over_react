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

part 'null_safety_validate_required_props_test.over_react.g.dart';

void main() {
  // This is just a placeholder test that will be replaced when disableRequiredPropValidation is implemented.
  test('@Props(disableRequiredPropValidation) annotation does not throw', () {
    expect(() {
      rtl.render(ComponentTest()());
    }, returnsNormally);
  });
}

UiFactory<ComponentTestProps> ComponentTest = uiFunction(
  (props) {},
  _$ComponentTestConfig, // ignore: undefined_identifier
);

@Props(disableRequiredPropValidation: {'aProp'})
mixin ComponentTestProps on UiProps {
  @requiredProp
  bool aProp;
}
