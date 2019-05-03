// Copyright 2018 Workiva Inc.
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

// ignore: uri_has_not_been_generated
part 'dummy_composite_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<TestCompositeComponentProps> TestCompositeComponent = $TestCompositeComponent;

@Props()
class _$TestCompositeComponentProps extends UiProps {
  Function onComponentDidMount;
  Function onComponentWillUnmount;
  Function onComponentDidUpdate;
}

@Component()
class TestCompositeComponentComponent extends UiComponent<TestCompositeComponentProps> {
  @override
  void componentDidMount() {
    if (props.onComponentDidMount != null) {
      props.onComponentDidMount();
    }
  }

  @override
  void componentDidUpdate(_, __) {
    if (props.onComponentDidUpdate != null) {
      props.onComponentDidUpdate();
    }
  }

  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    if (props.onComponentWillUnmount != null) {
      props.onComponentWillUnmount();
    }
  }

  @override
  render() {
    return Dom.div()('oh hai', props.children);
  }
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class TestCompositeComponentProps extends _$TestCompositeComponentProps with _$TestCompositeComponentPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForTestCompositeComponentProps;
}
