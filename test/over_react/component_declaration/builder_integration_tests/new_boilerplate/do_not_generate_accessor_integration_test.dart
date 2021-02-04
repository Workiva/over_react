// Copyright 2017 Workiva Inc.
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
import 'package:test/test.dart';

import '../../../../test_util/test_util.dart';

part 'do_not_generate_accessor_integration_test.over_react.g.dart';

main() {
  group('(New boilerplate) acessors with doNotGenerate integration', () {
    group('generates prop getters/setters properly', () {
      test('for prop fields listed before the field annotated with doNotGenerate', () {
        expect((DoNotGenerateAccessorTest()..generated1Prop = 'test').values.single, 'test');
      });

      test('for prop fields listed after the field annotated with doNotGenerate', () {
        expect((DoNotGenerateAccessorTest()..generated2Prop = 'test').values.single, 'test');
      });

      test('for prop fields annotated with `doNotGenerate: false`', () {
        expect((DoNotGenerateAccessorTest()..explicitlyGeneratedProp = 'test').values.single, 'test');
      });

      test('except for the field annotated with doNotGenerate', () {
        var instance = DoNotGenerateAccessorTest()..notGeneratedProp = 'test';
        expect(instance.notGeneratedProp, 'test', reason: 'non-generated field should work as expected');
        expect(instance, isEmpty, reason: 'accessor should not be backed by a key-value pair');
      });

      test('omitting the field annotated with doNotGenerate from the list of props', () {
        // ignore: deprecated_member_use_from_same_package, undefined_identifier
        expect(_$metaForDoNotGenerateAccessorTestProps.keys, [
          contains('generated1Prop'),
          contains('generated2Prop'),
          contains('explicitlyGeneratedProp'),
        ], reason: 'should only include generated props');

        // ignore: deprecated_member_use_from_same_package, undefined_identifier
        expect(_$metaForDoNotGenerateAccessorTestProps.props.map((prop) => prop.key).toList(), [
          contains('generated1Prop'),
          contains('generated2Prop'),
          contains('explicitlyGeneratedProp'),
        ], reason: 'should only include generated props');
      });
    });

    group('generates state getters/setters properly', () {
      DoNotGenerateAccessorTestComponent component;

      setUp(() {
        component = renderAndGetComponent(DoNotGenerateAccessorTest()()) as DoNotGenerateAccessorTestComponent;
      });

      test('for state fields listed before the field annotated with doNotGenerate', () {
        expect((component.newState()..generated1State = 'test').values.single, 'test');
      });

      test('for state fields listed after the field annotated with doNotGenerate', () {
        expect((component.newState()..generated2State = 'test').values.single, 'test');
      });

      test('for state fields annotated with `doNotGenerate: false`', () {
        expect((component.newState()..explicitlyGeneratedState = 'test').values.single, 'test');
      });

      test('except for the field annotated with doNotGenerate', () {
        var instance = component.newState()..notGeneratedState = 'test';
        expect(instance.notGeneratedState, 'test', reason: 'non-generated field should work as expected');
        expect(instance, isEmpty, reason: 'accessor should not be backed by a key-value pair');
      });
    });
  });
}

// ignore: undefined_identifier
UiFactory<DoNotGenerateAccessorTestProps> DoNotGenerateAccessorTest = castUiFactory(_$DoNotGenerateAccessorTest);

mixin DoNotGenerateAccessorTestProps on UiProps {
  dynamic generated1Prop;

  @Accessor(doNotGenerate: true)
  dynamic notGeneratedProp;

  dynamic generated2Prop;

  @Accessor(doNotGenerate: false)
  dynamic explicitlyGeneratedProp;
}

mixin DoNotGenerateAccessorTestState on UiState {
  dynamic generated1State;

  @Accessor(doNotGenerate: true)
  dynamic notGeneratedState;

  dynamic generated2State;

  @Accessor(doNotGenerate: false)
  dynamic explicitlyGeneratedState;
}

class DoNotGenerateAccessorTestComponent
    extends UiStatefulComponent2<DoNotGenerateAccessorTestProps, DoNotGenerateAccessorTestState> {
  @override
  render() => (Dom.div()
    ..modifyProps(addUnconsumedProps)
  )('rendered content');
}
