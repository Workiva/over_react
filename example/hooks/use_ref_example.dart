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
part 'use_ref_example.over_react.g.dart';

mixin UseRefExampleProps on UiProps {}

UiFactory<UseRefExampleProps> UseRefExample = uiFunction(
  (props) {
    final inputValue = useState('');

    final inputRef = useRef<InputElement>();
    final prevInputValueRef = useRef<String>();

    useEffect(() {
      prevInputValueRef.current = inputValue.value;
    });

    return Fragment()(
      Dom.p()(
        'Current Input: ${inputValue.value}, '
        'Previous Input: ${prevInputValueRef.current}',
      ),
      (Dom.input()..ref = inputRef)(),
      (Dom.button()
        ..onClick = (_) => inputValue.set(inputRef.current.value)
      )('Update'),
    );
  },
  $UseRefExampleConfig, // ignore: undefined_identifier
);
