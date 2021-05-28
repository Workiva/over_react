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

// ignore_for_file: prefer_function_declarations_over_variables
import 'package:over_react/over_react.dart';

part 'private_factory_public_component.over_react.g.dart';

UiFactory<FormActionInputProps> _FormActionInput =
    castUiFactory(_$_FormActionInput); // ignore: undefined_identifier

UiFactory<FormActionInputProps> FormSubmitInput = ([backingMap]) =>
    _FormActionInput(backingMap);

UiFactory<FormActionInputProps> FormResetInput = ([backingMap]) =>
    _FormActionInput(backingMap);

mixin FormActionInputProps on UiProps {
  String? prop1;
}

class FormActionInputComponent extends UiComponent2<FormActionInputProps> {
  @override
  render() {
    return Dom.div()(props.children);
  }
}
