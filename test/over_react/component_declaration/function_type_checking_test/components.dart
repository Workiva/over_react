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

import '../component2_type_checking_test/type_inheritance/abstract_inheritance/abstract2.dart' show $TestAbstract2ComponentFactory, TestAbstract2Component;

part 'components.over_react.g.dart';

mixin TestAProps on UiProps {}
UiFactory<TestAProps> TestA = uiFunction(
  (props) {},
  _$TestAConfig, // ignore: undefined_identifier
);

mixin TestBProps on UiProps {}
UiFactory<TestBProps> TestB = uiFunction(
  (props) {},
  _$TestBConfig, // ignore: undefined_identifier
);

mixin TestParentProps on UiProps {}
UiFactory<TestParentProps> TestParent = uiFunction(
  (props) {},
  _$TestParentConfig, // ignore: undefined_identifier
);

mixin TestSubtypeProps on UiProps {}
UiFactory<TestSubtypeProps> TestSubtype = uiFunction(
  (props) {},
  _$TestSubtypeConfig, // ignore: undefined_identifier
)..setTypeMeta(subtypeOfFactory: TestParent);

mixin TestSubsubtypeProps on UiProps {}
UiFactory<TestSubsubtypeProps> TestSubsubtype = uiFunction(
  (props) {},
  _$TestSubsubtypeConfig, // ignore: undefined_identifier
)..setTypeMeta(subtypeOfFactory: TestSubtype);


mixin TestExtendtypeProps on UiProps {}
UiFactory<TestExtendtypeProps> TestExtendtype = uiFunction(
  (props) {},
  _$TestExtendtypeConfig, // ignore: undefined_identifier
)..setTypeMeta(subtypeOfRaw: $TestAbstract2ComponentFactory.type);

mixin OneLevelWrapperProps on UiProps {}
UiFactory<OneLevelWrapperProps> OneLevelWrapper = uiFunction(
  (props) {
    return Dom.div()(props.children.single);
  },
  _$OneLevelWrapperConfig, // ignore: undefined_identifier
)..setTypeMeta(isWrapper: true);

mixin TwoLevelWrapperProps on UiProps {}
UiFactory<TwoLevelWrapperProps> TwoLevelWrapper = uiFunction(
  (props) {
    return Dom.div()(props.children.single);
  },
  _$TwoLevelWrapperConfig, // ignore: undefined_identifier
)..setTypeMeta(isWrapper: true);

UiFactory<DoNotReferenceThisFactoryExceptForInASingleTestProps>
    DoNotReferenceThisFactoryExceptForInASingleTest = castUiFactory(
        _$DoNotReferenceThisFactoryExceptForInASingleTest); // ignore: undefined_identifier
mixin DoNotReferenceThisFactoryExceptForInASingleTestProps on UiProps {}
@Component2(subtypeOf: TestAbstract2Component)
class DoNotReferenceThisFactoryExceptForInASingleTestComponentn extends UiComponent2<DoNotReferenceThisFactoryExceptForInASingleTestProps> {
  @override
  render() {}
}

mixin TestUninitializedParentProps on UiProps {}
UiFactory<TestUninitializedParentProps> TestUninitializedParent = uiFunction(
  (props) {
    return Dom.div()(props.children.single);
  },
  _$TestUninitializedParentConfig, // ignore: undefined_identifier
)..setTypeMeta(subtypeOfFactory: DoNotReferenceThisFactoryExceptForInASingleTest);
