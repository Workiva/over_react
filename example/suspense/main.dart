// Copyright 2023 Workiva Inc.
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
import 'counter_component.dart' deferred as lazy_component;
import 'lazy.dart';
import 'third_party_file.dart';

final LazyCounter = lazy(() async {
  await lazy_component.loadLibrary();
  await Future.delayed(Duration(seconds: 5));
  return lazy_component.Counter;
},
    UiFactoryConfig(
      propsFactory: PropsFactory.fromUiFactory(CounterPropsMapView),
      displayName: 'This does nothing...',
    ));

void main() {
  react_dom.render(
      StrictMode()(
        (Suspense()
          ..fallback = (Dom.div()..id = 'suspense')(
            'I am a fallback UI that will show while we load the lazy component! The load time is artificially inflated to last an additional 5 seconds just to prove it\'s working!',
          )
        )(
          (LazyCounter()..initialCount = 2)(
            (Dom.div()..id = 'Heyyy!')(),
          ),
        ),
      ),
      querySelector('#content'));
}
