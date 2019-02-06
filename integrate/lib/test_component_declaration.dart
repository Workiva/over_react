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

part 'test_component_declaration.over_react.g.dart';

@Factory()
UiFactory<FooProps> Foo = _$Foo;

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

