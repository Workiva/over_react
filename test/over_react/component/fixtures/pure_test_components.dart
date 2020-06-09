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
import 'package:over_react/components.dart';
import 'package:over_react/src/component/test_fixtures/redraw_counter_component_mixin.dart';

part 'pure_test_components.over_react.g.dart';

UiFactory<PureTestWrapperProps> PureTestWrapper = _$PureTestWrapper; // ignore: undefined_identifier

mixin PureTestWrapperPropsMixin on UiProps {
  UiFactory<SharedPureTestChildPropsMixin> childFactory;
}

class PureTestWrapperProps = UiProps with SharedPureTestPropsMixin, PureTestWrapperPropsMixin;

class PureTestWrapperComponent extends UiComponent2<PureTestWrapperProps>
    with RedrawCounterMixin<PureTestWrapperProps> {
  final pureComponentRef = createRef<PureTestComponentMixin>();

  @override
  get consumedProps => propsMeta.forMixins({
    PureTestWrapperPropsMixin,
  });

  @override
  get defaultProps => (newProps()
    ..addProps(SharedPureTestPropsMixin.defaultProps)
    ..childFactory = PureTest
  );

  @override
  render() {
    return (props.childFactory()
      ..modifyProps(addUnconsumedProps)
      ..childFuncProp = handleChildFunc
      ..ref = pureComponentRef
    )(
      props.children,
    );
  }

  void handleChildFunc() {}
}

UiFactory<PureTestProps> PureTest = _$PureTest; // ignore: undefined_identifier

class PureTestProps = UiProps with SharedPureTestPropsMixin, SharedPureTestChildPropsMixin;

class PureTestState = UiState with SharedPureTestChildStateMixin;

class PureTestComponent extends UiStatefulComponent2<PureTestProps, PureTestState>
    with
        PureUiComponent<PureTestProps>,
        RedrawCounterMixin<PureTestProps>,
        PureTestComponentMixin<PureTestProps, PureTestState> {
  @override
  render() {
    return (Dom.div()..modifyProps(addUnconsumedDomProps))(
      props.children,
    );
  }
}

UiFactory<PureTestWithoutChildrenSupportProps> PureTestWithoutChildrenSupport =
    _$PureTestWithoutChildrenSupport; // ignore: undefined_identifier

class PureTestWithoutChildrenSupportProps = UiProps with SharedPureTestPropsMixin, SharedPureTestChildPropsMixin;

class PureTestWithoutChildrenSupportState = UiState with SharedPureTestChildStateMixin;

class PureTestWithoutChildrenSupportComponent
    extends UiStatefulComponent2<PureTestWithoutChildrenSupportProps, PureTestWithoutChildrenSupportState>
    with
        PureUiComponent<PureTestWithoutChildrenSupportProps>,
        RedrawCounterMixin<PureTestWithoutChildrenSupportProps>,
        PureTestComponentMixin<PureTestWithoutChildrenSupportProps, PureTestWithoutChildrenSupportState> {
  @override
  bool get supportsPropChildren => false;

  @override
  render() {
    return (Dom.hr()..modifyProps(addUnconsumedDomProps))();
  }
}

/// Props shared between [PureTestWrapper], [PureTest] and [PureTestWithoutChildrenSupport].
mixin SharedPureTestPropsMixin on UiProps {
  static final Map defaultProps = Map.unmodifiable(PureTest()
    ..sharedBoolProp = false
  );

  bool sharedBoolProp;
}

/// Props shared between [PureTest] and [PureTestWithoutChildrenSupport].
mixin SharedPureTestChildPropsMixin on UiProps {
  static final Map defaultProps = Map.unmodifiable(PureTest()
    ..addProps(SharedPureTestPropsMixin.defaultProps)
    ..childBoolProp = false
  );

  bool childBoolProp;
  void Function() childFuncProp;
}

/// State shared between [PureTest] and [PureTestWithoutChildrenSupport].
mixin SharedPureTestChildStateMixin on UiState {
  bool childBoolState;
}

/// Behavior shared between [PureTest] and [PureTestWithoutChildrenSupport].
mixin PureTestComponentMixin<T extends SharedPureTestChildPropsMixin, S extends SharedPureTestChildStateMixin>
    on
        UiStatefulComponent2<T, S>,
        PureUiComponent<T>,
        RedrawCounterMixin<T> {
  @override
  get defaultProps => (newProps()
    ..addProps(SharedPureTestChildPropsMixin.defaultProps)
  );

  @override
  get initialState => (newState()..childBoolState = false);
}
