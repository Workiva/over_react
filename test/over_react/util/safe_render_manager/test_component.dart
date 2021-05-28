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

// ignore_for_file: deprecated_member_use_from_same_package
import 'package:over_react/over_react.dart';

part 'test_component.over_react.g.dart';

@Factory()
UiFactory<TestProps> Test = _$Test; // ignore: undefined_identifier, invalid_assignment

@Props()
class _$TestProps extends UiProps {
  LifecycleCallback? onComponentDidMount;
  LifecycleCallback? onComponentWillUpdate;
  LifecycleCallback? onComponentWillReceiveProps;
  LifecycleCallback? onComponentDidUpdate;
  LifecycleCallback? onComponentWillUnmount;
  LifecycleCallback? onRender;
}

@Component(isWrapper: true)
class TestComponent extends UiComponent<TestProps> {
  @override
  componentDidMount() {
    props.onComponentDidMount?.call();
  }

  @override
  componentDidUpdate(prevProps, prevState) {
    props.onComponentDidUpdate?.call();
  }
  @override
  componentWillUpdate(nextProps, nextState) {
    typedPropsFactory(nextProps).onComponentWillUpdate?.call();
  }
  @override
  componentWillReceiveProps(nextProps) {
    super.componentWillReceiveProps(nextProps);
    typedPropsFactory(nextProps).onComponentWillReceiveProps?.call();
  }
  @override
  componentWillUnmount() {
    super.componentWillUnmount();
    typedPropsFactory(nextProps).onComponentWillUnmount?.call();
  }

  @override
  render() {
    props.onRender?.call();
    return (Dom.div()..addProps(copyUnconsumedProps()))(props.children);
  }
}

// ignore: prefer_generic_function_type_aliases
typedef void LifecycleCallback();
