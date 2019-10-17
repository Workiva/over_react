// Copyright 2019 Workiva Inc.
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

part of prop_tyepdef_test_fixtures;

@AbstractProps()
abstract class _$TestAbstractCustomRendererComponentProps extends UiProps {
  CustomRenderFunction customRenderer;
  CustomRenderFunction<TestAbstractCustomRendererComponentProps,
                       TestAbstractCustomRendererComponentState,
                       TestAbstractCustomRendererComponentComponent> parameterizedCustomRenderer;

  String somePropKey;
}

@AbstractState()
abstract class _$TestAbstractCustomRendererComponentState extends UiState {
  String someStateKey;
}

@AbstractComponent()
abstract class TestAbstractCustomRendererComponentComponent<T extends TestAbstractCustomRendererComponentProps,
                                                            S extends TestAbstractCustomRendererComponentState>
    extends UiStatefulComponent<T, S> {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class TestAbstractCustomRendererComponentProps extends _$TestAbstractCustomRendererComponentProps with _$TestAbstractCustomRendererComponentPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestAbstractCustomRendererComponentProps;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
abstract class TestAbstractCustomRendererComponentState extends _$TestAbstractCustomRendererComponentState with _$TestAbstractCustomRendererComponentStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForTestAbstractCustomRendererComponentState;
}
