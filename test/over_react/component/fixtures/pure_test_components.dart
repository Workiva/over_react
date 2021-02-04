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
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

part 'pure_test_components.over_react.g.dart';

UiFactory<PureTestWrapperProps> PureTestWrapper = castUiFactory(_$PureTestWrapper); // ignore: undefined_identifier

class PureTestWrapperProps = UiProps with SharedPureTestPropsMixin;

class PureTestWrapperComponent extends UiComponent2<PureTestWrapperProps>
    with RedrawCounterMixin<PureTestWrapperProps> {
  final pureComponentRef = createRef<PureTestComponent>();

  @override
  get consumedProps => [];

  @override
  get defaultProps => (newProps()
    ..addProps(SharedPureTestPropsMixin.defaultProps)
  );

  @override
  render() {
    return (PureTest()
      ..modifyProps(addUnconsumedProps)
      ..childFuncProp = handleChildFunc
      ..ref = pureComponentRef
    )(
      props.children,
    );
  }

  void handleChildFunc() {}
}

UiFactory<PureTestProps> PureTest = castUiFactory(_$PureTest); // ignore: undefined_identifier

mixin PureTestPropsMixin on UiProps {
  bool childBoolProp;
  void Function() childFuncProp;
}

class PureTestProps = UiProps with SharedPureTestPropsMixin, PureTestPropsMixin;

mixin PureTestState on UiState {
  bool childBoolState;
}

class PureTestComponent extends UiStatefulComponent2<PureTestProps, PureTestState>
    with
        PureComponentMixin,
        RedrawCounterMixin<PureTestProps> {
  @override
  get defaultProps => (newProps()
    ..addProps(SharedPureTestPropsMixin.defaultProps)
    ..childBoolProp = false
  );

  @override
  get initialState => (newState()..childBoolState = false);

  @override
  render() {
    return (Dom.div()..modifyProps(addUnconsumedDomProps))(
      props.children,
    );
  }
}

/// Props shared between [PureTestWrapper] and [PureTest].
mixin SharedPureTestPropsMixin on UiProps {
  static final Map defaultProps = Map.unmodifiable(PureTest()
    ..sharedBoolProp = false
  );

  bool sharedBoolProp;
  ReactElement someVDomEl;
}
