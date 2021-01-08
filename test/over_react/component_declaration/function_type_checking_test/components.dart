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

//library test_component2.test_b;

import 'package:over_react/over_react.dart';

import '../component2_type_checking_test/type_inheritance/abstract_inheritance/abstract2.dart' show $TestAbstract2ComponentFactory;

part 'components.over_react.g.dart';

mixin TestAProps on UiProps {}
UiFactory<TestAProps> TestA = uiFunction(
  (props) {}, $TestAConfig,
);

mixin TestBProps on UiProps {}
UiFactory<TestBProps> TestB = uiFunction(
  (props) {}, $TestBConfig,
);

mixin TestParentProps on UiProps {}
UiFactory<TestParentProps> TestParent = uiFunction(
  (props) {},
  $TestParentConfig,
);

mixin TestSubtypeProps on UiProps {}
UiFactory<TestSubtypeProps> TestSubtype = uiFunction(
  (props) {},
  $TestSubtypeConfig,
)..setTypeMeta(subtypeOfFactory: TestParent);

mixin TestSubsubtypeProps on UiProps {}
UiFactory<TestSubsubtypeProps> TestSubsubtype = uiFunction(
  (props) {},
  $TestSubsubtypeConfig,
)..setTypeMeta(subtypeOfFactory: TestSubtype);


mixin TestExtendtypeProps on UiProps {}
UiFactory<TestExtendtypeProps> TestExtendtype = uiFunction(
  (props) {},
  $TestExtendtypeConfig,
)..setTypeMeta(subtypeOfRaw: $TestAbstract2ComponentFactory.type);

mixin OneLevelWrapperProps on UiProps {}
UiFactory<OneLevelWrapperProps> OneLevelWrapper = uiFunction(
  (props) {
    return Dom.div()(props.children.single);
  },
  $OneLevelWrapperConfig,
)..setTypeMeta(isWrapper: true);

mixin TwoLevelWrapperProps on UiProps {}
UiFactory<OneLevelWrapperProps> TwoLevelWrapper = uiFunction(
  (props) {
    return Dom.div()(props.children.single);
  },
  $TwoLevelWrapperConfig,
)..setTypeMeta(isWrapper: true);
