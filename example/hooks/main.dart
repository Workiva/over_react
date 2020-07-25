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
import './function_components.dart';

void main() {
  render() {
    react_dom.render(
        Fragment()(
          (Dom.h1())('Function Component Tests'),
          (Dom.h2())('useState & useEffect Hook Test'),
          (UseStateTest())(),
          Dom.h2()('useReducer Hook Test'),
          (UseReducerTest()..initialCount = 10)(),
          Dom.h2()('useCallback Hook Test'),
          UseCallbackTest()(),
          Dom.h2()('useContext Hook Test'),
          UseContextTest()(),
          Dom.h2()('useRef Hook Test'),
          UseRefTest()(),
          Dom.h2()('useMemo Hook Test'),
          UseMemoTest()(),
          Dom.h2()('UseLayoutEffect Hook Test'),
          UseLayoutEffectTest()(),
          Dom.h2()('UseImperativeHandle Hook Test'),
          UseImperativeHandleTest()(),
          Dom.h2()('UseDebugValue Hook Test'),
          UseDebugValueTest()(),
        ),
        querySelector('#content'));
  }

  render();
}
