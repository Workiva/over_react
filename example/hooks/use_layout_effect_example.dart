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
part 'use_layout_effect_example.over_react.g.dart';

mixin UseLayoutEffectProps on UiProps {}

UiFactory<UseLayoutEffectProps> UseLayoutEffectExample = uiFunction(
  (props) {
    final width = useState(0);
    final height = useState(0);

    final textareaRef = useRef<TextAreaElement>();

    useLayoutEffect(() {
      width.set(textareaRef.current.clientWidth);
      height.set(textareaRef.current.clientHeight);
    });

    return Fragment()(
      Dom.div()('textarea width: ${width.value}'),
      Dom.div()('textarea height: ${height.value}'),
      (Dom.textarea()
        ..ref = textareaRef
        ..onClick = (_) => width.set(0)
      )(),
    );
  },
  $UseLayoutEffectExampleConfig, // ignore: undefined_identifier
);
