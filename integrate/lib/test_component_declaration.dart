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

library over_react.integrate.test_component_declaration;

import 'package:over_react/over_react.dart';

// ignore: uri_does_not_exist, uri_has_not_been_generated
part 'test_component_declaration.overReact.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FooProps> Foo = $Foo;

@Props()
class _$FooProps extends UiProps {}

@State()
class _$FooState extends UiState {}

@Component()
class FooComponent extends UiStatefulComponent<FooProps, FooState> {
  @override
  render() {
    return Dom.div()(
      'Child 1',
      'Child 2'
    );
  }
}

// AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FooState extends _$FooState with _$FooStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = $metaForFooState;
}

// AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FooProps extends _$FooProps with _$FooPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForFooProps;
}
