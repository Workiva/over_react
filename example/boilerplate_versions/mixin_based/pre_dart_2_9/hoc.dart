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

import '../../../builder/main.dart';

part 'hoc.over_react.g.dart';

UiFactory<HocProps> Hoc = connect<ExampleState, HocProps>(
  mapStateToPropsWithOwnProps: (state, props) => Hoc(),
  mapDispatchToPropsWithOwnProps: (state, props) => Hoc(),
)(_$Hoc); // ignore: undefined_identifier, argument_type_not_assignable

mixin HocProps on UiProps {
  String? foo;
}

class HocComponent extends UiComponent2<HocProps> {
  @override
  render() => Dom.div()(props.foo);
}

UiFactory<HocWithTwoFactoriesProps> HocWithTwoFactories =
    _$HocWithTwoFactories; // ignore: undefined_identifier, invalid_assignment

UiFactory<HocWithTwoFactoriesProps> ConnectedHocWithTwoFactories =
    connect<ExampleState, HocWithTwoFactoriesProps>(
  mapStateToPropsWithOwnProps: (state, props) => HocWithTwoFactories(),
  mapDispatchToPropsWithOwnProps: (state, props) => HocWithTwoFactories(),
)(HocWithTwoFactories);

mixin HocWithTwoFactoriesProps on UiProps {
  String? foo;
}

class HocWithTwoFactoriesComponent extends UiComponent2<HocWithTwoFactoriesProps> {
  @override
  render() => Dom.div()(props.foo);
}
