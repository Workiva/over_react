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

import 'dart:html';

import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_imperative_handle_example.over_react.g.dart';

mixin FancyInputProps on UiProps {
  String value;
  Function updater;
}

/// The type of ref returned when rendering [UseImperativeHandleExample].
class FancyInputApi {
  final void Function() focus;
  FancyInputApi(this.focus);
}

UiFactory<FancyInputProps> FancyInput = uiForwardRef(
  (props, ref) {
    final inputRef = useRef<InputElement>();

    useImperativeHandle(
      ref,
      () => FancyInputApi(() => inputRef.current.focus()),

      /// Because the return value of [createHandle] never changes, it is not necessary for [ref.current]
      /// to be re-set on each render so this dependency list is empty.
      [],
    );

    return (Dom.input()
      ..ref = inputRef
      ..value = props.value
      ..onChange = (e) => props.updater(e.target.value)
    )();
  },
  $FancyInputConfig, // ignore: undefined_identifier
);

mixin UseImperativeHandleExampleProps on UiProps {}

UiFactory<UseImperativeHandleExampleProps> UseImperativeHandleExample =
    uiFunction(
  (props) {
    final inputValue = useState('');
    final fancyInputRef = useRef<FancyInputApi>();

    return Fragment()(
      (FancyInput()
        ..ref = fancyInputRef
        ..value = inputValue.value
        ..updater = inputValue.set
      )(),
      (Dom.button()
        ..onClick = (_) => fancyInputRef.current.focus()
      )('Focus Input'),
    );
  },
  $UseImperativeHandleExampleConfig, // ignore: undefined_identifier
);
