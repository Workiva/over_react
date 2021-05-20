// @dart=2.9

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

import 'package:over_react/components.dart' as v2;
import 'package:over_react/over_react_flux.dart';
import 'package:react/react_dom.dart' as react_dom;

import './components/big_block.dart';
import './components/redux_big_block.dart';
import './components/connect_flux_big_block.dart';
import 'components/should_not_update.dart';
import './store.dart';

main() {
  react_dom.render(
      v2.ErrorBoundary()(
        // Note the use of the `ReduxMultiProvider` as opposed to a traditional
        // `ReduxProvider`, and that the stores being passed in are the
        // `FluxToReduxAdapterStore`s.
        (ReduxMultiProvider()
          ..storesByContext = {
            randomColorStoreContext: randomColorStoreAdapter,
            lowLevelStoreContext: lowLevelStoreAdapter,
            anotherColorStoreContext: anotherColorStoreAdapter,
          }
        )(
          (BigBlock()
            ..store = randomColorStore
            ..lowLevelStore = lowLevelStore
            ..secondStore = anotherColorStore
            ..actions = randomColorActions
          )(),
          // Note that the components being instantiated are the factories that
          // are returned from the corresponding `composeHocs` calls, and not the
          // original component factories.
          ConnectFluxBigBlock()(),
          ReduxBigBlock()(),
          ShouldNotUpdate()(),
        ),
      ),
      querySelector('#content'));
}
