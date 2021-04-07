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

import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'use_context_example.over_react.g.dart';

final TestNewContext = createContext<Map>({'renderCount': 0});

mixin UseContextExampleProps on UiProps {}

UiFactory<UseContextExampleProps> UseContextExample = uiFunction(
  (props) {
    final context = useContext(TestNewContext);
    return Dom.div()(
      Dom.div()('useContext counter value is ${context['renderCount']}'),
    );
  },
  _$UseContextExampleConfig, // ignore: undefined_identifier
);

mixin NewContextProviderProps on UiProps {}

UiFactory<NewContextProviderProps> NewContextProvider = uiFunction(
  (props) {
    final renderCount = useState(0);

    _onButtonClick(event) {
      renderCount.setWithUpdater((oldValue) => oldValue + 1);
    }

    final provideMap = {'renderCount': renderCount.value};

    return (Dom.div()..style = {'marginTop': 20})(
      (Dom.button()
        ..className = 'btn btn-primary'
        ..onClick = _onButtonClick
      )('Redraw'),
      Dom.br()(),
      'TestContext.Provider props.value: $provideMap',
      Dom.br()(),
      Dom.br()(),
      (TestNewContext.Provider()..value = provideMap)(props.children),
    );
  },
  _$NewContextProviderConfig, // ignore: undefined_identifier
);
