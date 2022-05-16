// Copyright 2021 Workiva Inc.
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
import 'package:over_react/over_react_redux.dart';

part 'two_nine_with_multiple_factories.over_react.g.dart';

UiFactory<CounterProps> Counter = connect<Null, CounterProps>(
    mapStateToProps: (state) => _Counter()
)(_Counter);

UiFactory<CounterProps> _Counter = castUiFactory(_$_Counter);

mixin CounterPropsMixin on UiProps {}

class CounterProps = UiProps with CounterPropsMixin, ConnectPropsMixin;

class CounterComponent extends UiComponent2<CounterProps> {
  @override
  render() => 'test';
}
