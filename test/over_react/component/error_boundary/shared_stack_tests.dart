// Copyright 2022 Workiva Inc.
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

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart' hide ErrorBoundary;
import 'package:react_testing_library/react_testing_library.dart' as rtl;
import 'package:over_react/components.dart';
import 'package:test/test.dart';

part 'shared_stack_tests.over_react.g.dart';

@isTestGroup
void sharedErrorBoundaryStackTests() {
  group(
      'includes the Dart component displayName in error boundary errors for', () {
    void expectRenderErrorWithComponentName(ReactElement element,
        {@required String expectedComponentName}) {
      final capturedInfos = <ReactErrorInfo>[];
      rtl.render(
          (ErrorBoundary()
            ..onComponentDidCatch = (error, info) {
              capturedInfos.add(info);
            })(element));

      expect(capturedInfos, hasLength(1),
          reason: 'test setup check; should have captured a single component error');
      expect(capturedInfos[0].componentStack,
          contains('at $expectedComponentName'));
    }


    test('Component components', () {
      expectRenderErrorWithComponentName(
        ThrowingComponent()(),
        expectedComponentName: 'ThrowingComponent',
      );
    });

    test('Component2 components', () {
      expectRenderErrorWithComponentName(
        ThrowingComponent2()(),
        expectedComponentName: 'ThrowingComponent2',
      );
    });

    test('function components', () {
      expectRenderErrorWithComponentName(
        ThrowingFunctionComponent()(),
        expectedComponentName: 'ThrowingFunctionComponent',
      );
    });

    test('forwardRef function components', () {
      expectRenderErrorWithComponentName(
        ThrowingForwardRefComponent()(),
        expectedComponentName: 'ThrowingForwardRefComponent',
      );
    });
  });
}

@Factory()
UiFactory<ThrowingComponentProps> ThrowingComponent = _$ThrowingComponent; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$ThrowingComponentProps extends UiProps {}

@Component()
class ThrowingComponentComponent extends UiComponent<ThrowingComponentProps> {
  @override
  render() {
    throw Exception();
  }
}

mixin ThrowingComponent2Props on UiProps {}

UiFactory<ThrowingComponent2Props> ThrowingComponent2 = castUiFactory(_$ThrowingComponent2); // ignore: undefined_identifier

class ThrowingComponent2Component extends UiComponent2<ThrowingComponent2Props> {
  @override
  render() {
    throw Exception();
  }
}

mixin ThrowingFunctionComponentProps on UiProps {}

UiFactory<ThrowingFunctionComponentProps> ThrowingFunctionComponent = uiFunction((_) {
  throw Exception();
},
  _$ThrowingFunctionComponentConfig, // ignore: undefined_identifier

);

mixin ThrowingForwardRefComponentProps on UiProps {}

UiFactory<ThrowingForwardRefComponentProps> ThrowingForwardRefComponent = uiForwardRef((_, __) {
  throw Exception();
},
  _$ThrowingForwardRefComponentConfig, // ignore: undefined_identifier

);