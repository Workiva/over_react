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

library memo_test;

import 'package:over_react/src/util/memo.dart';
import 'package:over_react_test/over_react_test.dart';
import 'package:test/test.dart';
import 'package:over_react/over_react.dart';
import 'fixtures/basic_ui_component.dart';

part 'memo_test.over_react.g.dart';

int renderCount = 0;
mixin FunctionCustomPropsProps on UiProps {
  int testProp;
}

UiFactory<FunctionCustomPropsProps> FunctionCustomProps = uiFunction(
  (props) {
    renderCount++;
    return Dom.div()(Dom.div()('prop id: ${props.id}'),
        Dom.div()('test Prop: ${props.testProp}'));
  },
  $FunctionCustomPropsConfig, // ignore: undefined_identifier
);

main() {
  group('memo -', () {
    test('errors when wrapping a UiComponent', () {
      expect(() => memo<BasicUiComponentProps>(BasicUiComponent),
          throwsArgumentError);
    });

    test('errors when wrapping a UiComponent2', () {
      expect(() => memo<BasicUiComponent2Props>(BasicUiComponent2),
          throwsArgumentError);
    });

    test('wraps a function component', () {
      UiFactory<UiProps> FunctionTest = uiFunction(
        (props) {
          return Dom.div()('prop id: ${props.id}');
        },
        UiFactoryConfig(),
      );

      UiFactory<UiProps> FunctionMemo = memo<UiProps>(FunctionTest);
      mount(FunctionMemo()());

      expect(isValidElementOfType(FunctionMemo()(), FunctionTest), isTrue);
    });

    test('wraps a function component with custom props', () {
      UiFactory<FunctionCustomPropsProps> FunctionCustomPropsMemo =
          memo<FunctionCustomPropsProps>(FunctionCustomProps);
      mount(FunctionCustomPropsMemo()());

      expect(
          isValidElementOfType(
              FunctionCustomPropsMemo()(), FunctionCustomProps),
          isTrue);
    });

    test('memoizes based on props', () {
      renderCount = 0;
      UiFactory<FunctionCustomPropsProps> FunctionCustomPropsMemo =
          memo<FunctionCustomPropsProps>(FunctionCustomProps);
      final testJacket = mount((FunctionCustomPropsMemo()..testProp = 1)());
      testJacket.rerender((FunctionCustomPropsMemo()..testProp = 1)());
      testJacket.rerender((FunctionCustomPropsMemo()..testProp = 1)());

      expect(renderCount, equals(1));
    });

    test('memoizes based on areEqual parameter', () {
      renderCount = 0;
      UiFactory<FunctionCustomPropsProps> FunctionCustomPropsMemo =
          memo<FunctionCustomPropsProps>(FunctionCustomProps,
              areEqual: ((prevProps, nextProps) {
        return prevProps.testProp == nextProps.testProp - 1;
      }));
      final testJacket = mount((FunctionCustomPropsMemo()..testProp = 1)());
      testJacket.rerender((FunctionCustomPropsMemo()..testProp = 2)());
      testJacket.rerender((FunctionCustomPropsMemo()..testProp = 4)());

      expect(renderCount, equals(2));
    });
  });
}

@Factory()
UiFactory<BasicUiComponent2Props> BasicUiComponent2 = _$BasicUiComponent2;

@Props()
class _$BasicUiComponent2Props extends UiProps {
  String childId;
}

@Component2()
class BasicUiComponent2Component extends UiComponent2<BasicUiComponent2Props> {
  @override
  render() => 'basic component';
}
