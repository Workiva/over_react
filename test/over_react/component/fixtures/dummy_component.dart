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

import 'package:over_react/over_react.dart';

part 'dummy_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier, invalid_assignment
UiFactory<DummyProps> Dummy = _$Dummy;

@Props()
class _$DummyProps extends UiProps {
  late Function onComponentDidMount;
}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class DummyProps extends _$DummyProps with _$DummyPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value, invalid_assignment
  static const PropsMeta meta = _$metaForDummyProps;
}

@Component2()
class DummyComponent extends UiComponent2<DummyProps> {
  @override
  void componentDidMount() {
    props.onComponentDidMount();
  }

  @override
  render() {
    return (Dom.button()..addTestId('DummyButton'))('oh hai');
  }
}
