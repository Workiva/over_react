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

import 'package:over_react/over_react.dart';

part 'unstable.over_react.dart';

mixin UnstableTestProps on UnstableUiProps {
  bool legitProp;
}

UnstableUiFactory<UnstableTestProps> UnstableTest = uiFunction(
  (props) {
    return Dom.div()(
        Dom.div()('legit prop: ${props.legitProp}'),
        Dom.div()('fake prop: ${props["fakeProp"]}'), // ignore: deprecated_member_use_from_same_package
    );
  },
  UiFactoryConfig(
        propsFactory: PropsFactory(
          map: (map) => _$$UnstableTestProps(map),
          jsMap: (map) => _$$UnstableTestProps$JsMap(map),
        ),
        displayName: 'UnstableTest'), // ignore: undefined_identifier
);