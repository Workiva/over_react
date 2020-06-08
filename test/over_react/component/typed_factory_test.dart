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

library typed_factory_test;

import 'package:over_react/over_react.dart';
import 'package:test/test.dart';

part 'typed_factory_test.over_react.g.dart';

void main(){
  test('typedPropsFactory falls back to empty backingMap when called with null', () {
    var toCheck = _$TypedFactoryTesterComponent().typedPropsFactory(null);
    toCheck.testProp = true;

    expect(toCheck.testProp, isTrue);
    expect(toCheck, isA<Map>());
  });

  test('typedStateFactory falls back to empty backingMap when called with null', () {
    var toCheck = _$TypedFactoryTesterComponent().typedStateFactory(null);
    toCheck.testState = true;

    expect(toCheck.testState, isTrue);
    expect(toCheck, isA<Map>());
  });
}


@Factory()
UiFactory<TypedFactoryTesterProps> TypedFactoryTester = _$TypedFactoryTester;

@Props()
class _$TypedFactoryTesterProps extends UiProps {
  bool testProp;
}

@State()
class _$TypedFactoryTesterState extends UiState {
  bool testState;
}

@Component2()
class TypedFactoryTesterComponent extends UiStatefulComponent2<TypedFactoryTesterProps, TypedFactoryTesterState> {
  @override
  render() => null;
}
