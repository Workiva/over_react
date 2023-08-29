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

import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';

// Imports for the DevTools
import 'package:redux_dev_tools/redux_dev_tools.dart';

import '../simple/store.dart' hide store;
export '../simple/store.dart' hide store;

/////////////////////////////// STORE 1 "Counter" ///////////////////////////////

/// A store connected to DevTools.
///
/// Note the use of the special class [DevToolsStore] and the middleware passed
/// into the store.
Store store = DevToolsStore<CounterState>(
  stateReducer,
  initialState: CounterState.defaultState(),
  middleware: [overReactReduxDevToolsMiddleware],
);
