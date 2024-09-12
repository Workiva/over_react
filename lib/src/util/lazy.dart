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

library over_react.lazy;

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:react/react.dart' as react;

UiFactory<TProps> lazy<TProps extends UiProps>(Future<UiFactory<TProps>> Function() loadComponent,/* UiFactoryConfig<TProps> */ dynamic _config, {bool useJsFactoryProxy = false}) {
  ArgumentError.checkNotNull(_config, '_config');

  if (_config is! UiFactoryConfig<TProps>) {
    throw ArgumentError(
        '_config should be a UiFactoryConfig<TProps>. Make sure you are '
        r'using either the generated factory config (i.e. _$FooConfig) or manually '
        'declaring your config correctly.');
  }
   // ignore: invalid_use_of_protected_member
  final propsFactory = _config.propsFactory;
  ArgumentError.checkNotNull(propsFactory, '_config.propsFactory');
  propsFactory!;


  final lazyFactoryProxy = react.lazy(() async {
    final factory = await loadComponent();
              // final wrapper = uiForwardRef<TProps>(
              //   (props, ref) {
              //     final builder = factory()
              //       ..addProps(props)
              //       ..ref = ref;
              //     return props.children == null || (props.children != null && props.children?.isEmpty != false) ? builder() : builder(props.children);
              //   },
              //   UiFactoryConfig(
              //     propsFactory: PropsFactory.fromUiFactory(factory),
              //     displayName: 'Lazy${_config.displayName}',
              //   ),
              // );
              // return wrapper().componentFactory!;
    return factory().componentFactory!;
  }, useJsFactoryProxy: useJsFactoryProxy);

  TProps _uiFactory([Map? props]) {
    TProps builder;
    if (props == null) {
      builder = propsFactory.jsMap(JsBackedMap());
    } else if (props is JsBackedMap) {
      builder = propsFactory.jsMap(props);
    } else {
      builder = propsFactory.map(props);
    }

    return builder..componentFactory = lazyFactoryProxy;
  }

  return _uiFactory;
}
