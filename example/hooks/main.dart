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

import 'package:react/react_dom.dart' as react_dom;

import 'use_callback_example.dart';
import 'use_context_example.dart';
import 'use_debug_value_example.dart';
import 'use_imperative_handle_example.dart';
import 'use_layout_effect_example.dart';
import 'use_memo_example.dart';
import 'use_reducer_example.dart';
import 'use_ref_example.dart';
import 'use_state_example.dart';

void main() {
  render() {
    react_dom.render(
        Fragment()(
          Dom.h1()('Function Component Examples'),
          Dom.h2()('useState & useEffect Hook Example'),
          UseStateExample()(),
          Dom.h2()('useReducer Hook Example'),
          (UseReducerExample()..initialCount = 10)(),
          Dom.h2()('useCallback Hook Example'),
          UseCallbackExample()(),
          Dom.h2()('useContext Hook Example'),
          UseContextExample()(),
          Dom.h2()('useRef Hook Example'),
          UseRefExample()(),
          Dom.h2()('useMemo Hook Example'),
          UseMemoExample()(),
          Dom.h2()('UseLayoutEffect Hook Example'),
          UseLayoutEffectExample()(),
          Dom.h2()('UseImperativeHandle Hook Example'),
          UseImperativeHandleExample()(),
          Dom.h2()('UseDebugValue Hook Example'),
          UseDebugValueExample()(),
        ),
        querySelector('#content'));
  }

  render();
}
