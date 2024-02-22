// @dart=2.11
// Copyright 2023 Workiva Inc.
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

part 'partial.over_react.g.dart';

UiFactory<RequiredTestProps> RequiredTest = castUiFactory(_$RequiredTest);

mixin RequiredTestProps on UiProps {
   String testRequiredProp;
}

void partialExample() {
  // An empty props map
  final partialProps = RequiredTest();

  try {
    // Throws: "Expected a value of type 'String', but got one of type 'Null'",
    // because the prop is non-nullable and required, but not present in the map.
    print(partialProps.testRequiredProp);
  } catch (e) {
    print('Threw: $e');
  }

  // APIs for safely accessing required props:

  // 'default'
  print(partialProps.getRequiredProp((p) => p.testRequiredProp, orElse: () => 'default'));
  // null
  print(partialProps.getRequiredPropOrNull((p) => p.testRequiredProp));

  // Bonus added API: UiProps.getPropKey:

  // 'NullabilityPropsMixin.testRequiredProp'
  print(partialProps.getPropKey((p) => p.testRequiredProp));
}
