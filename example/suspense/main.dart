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

import 'package:js/js.dart';
import 'package:over_react/js_component.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react_client/component_factory.dart';
import 'package:react/react_client/react_interop.dart' hide lazy;
import 'package:react/react_dom.dart' as react_dom;
import 'counter_component.dart' deferred as lazy_component;
import 'third_party_file.dart';

part 'main.over_react.g.dart';

@Props(keyNamespace: '')
mixin TestJsProps on UiProps {
  @Accessor(key: 'buttonProps')
  JsMap? _$raw$buttonProps;

  Map? get buttonProps => unjsifyMapProp(_$raw$buttonProps);
  set buttonProps(Map? value) => _$raw$buttonProps = jsifyMapProp(value);

  @Accessor(key: 'listOfProps')
  List<dynamic>? _$raw$listOfProps;

  List<Map?>? get listOfProps => unjsifyMapListProp(_$raw$listOfProps);
  set listOfProps(List<Map?>? value) => _$raw$listOfProps = jsifyMapListProp(value);

  @Accessor(key: 'inputRef')
  dynamic _$raw$inputRef;

  dynamic get inputRef => unjsifyRefProp(_$raw$inputRef);
  set inputRef(dynamic value) => _$raw$inputRef = jsifyRefProp(value);

  @Accessor(key: 'messageContext')
  ReactContext? _$raw$messageContext;

  Context<String?>? get messageContext => unjsifyContextProp(_$raw$messageContext);
  set messageContext(Context<String?>? value) => _$raw$messageContext = jsifyContextProp(value);

  dynamic /*ElementType*/ component;
  dynamic /*ElementType*/ inputComponent;
  dynamic /*ElementType*/ buttonComponent;
}

@JS('TestJsComponent')
external ReactClass get _TestJs;

UiFactory<TestJsProps> TestJs = uiJsComponent(
  ReactJsComponentFactoryProxy(_TestJs),
  _$TestJsConfig, // ignore: undefined_identifier
);

UiFactory<TestJsProps> LazyTestJs = lazy(() async => TestJs,
_$TestJsConfig, // ignore: undefined_identifier
);

UiFactory<CounterPropsMixin> LazyCounter = lazy(() async {
  await Future.delayed(Duration(seconds: 5));
  await lazy_component.loadLibrary();
  return lazy_component.Counter;
},
UiFactoryConfig(
  propsFactory: PropsFactory.fromUiFactory(CounterPropsMapView)
  )
);

void main() {
  react_dom.render(
      StrictMode()(
        (Suspense()
          ..fallback = (Dom.div()..id = 'suspense')(
            'I am a fallback UI that will show while we load the lazy component! The load time is artificially inflated to last an additional 5 seconds just to prove it\'s working!',
          )
        )(
          (LazyTestJs())(
            (Dom.div()..id = 'Heyyy!')(),
          ),
        ),
      ),
      querySelector('#content'));
}
