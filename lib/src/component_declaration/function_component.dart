// Copyright 2016 Workiva Inc.
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

// ignore_for_file: prefer_generic_function_type_aliases
library over_react.component_declaration.function_component;

import 'dart:developer';

import 'package:js/js_util.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/src/util/prop_errors.dart';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/js_backed_map.dart';
import 'package:react/react_client/react_interop.dart';

export 'component_type_checking.dart' show isComponentOfType, isValidElementOfType;




UiFactory<T> uiFunctionComponent<T extends UiProps>(
    dynamic Function(T props) functionComponent,
    // FIXME allow passing in displayName for generic function components
    FunctionComponentConfig<T> config,
    {
      PropsFactory<T> propsFactory,
      String displayName,
      void Function(UiFunctionComponentStatics<T>) initStatics,
    }) {
  if (config != null) {
    if (propsFactory != null) throw ArgumentError('propsFactory cannot be used along with config');
    propsFactory = config.propsFactory;
    displayName ??= config.componentName;
  }

  // Get the display name from the inner function if possible so it doesn't become `_uiFunctionComponentWrapper`
  // FIXME make this work in DDC and make more robust
  displayName ??= getFunctionName(functionComponent);

  dynamic _uiFunctionComponentWrapper(Map props) {
    return functionComponent(propsFactory.jsMap(props as JsBackedMap));
  }

  /// FIXME DartFunctionComponent should be JsBackedMap?
  final factory = react.registerFunctionComponent(_uiFunctionComponentWrapper,
      displayName: displayName);

  if (propsFactory == null) {
    // todo allow passing in of custom uiFactory/typedPropsFactory
    // TODO make it easier to pass in parts of generatedInfo
    if (T != UiProps && T != GenericUiProps) {
      throw ArgumentError('config.propsFactory must be provided when using custom props classes');
    }
    propsFactory = PropsFactory.fromUiFactory(([backingMap]) => GenericUiProps(factory, backingMap)) as PropsFactory<T>;
  }

  if (initStatics != null) {
    final statics = UiFunctionComponentStatics<T>._(
        newProps: () => propsFactory.jsMap(JsBackedMap()),
        keyFor: (accessProps) => getPropKey(accessProps, propsFactory.map)
    );
    initStatics(statics);

    if (statics.defaultProps != null) {
      // fixme need to move to react-dart
      (factory.reactFunction as ReactClass).defaultProps = JsBackedMap.from(statics.defaultProps).jsObject;
    }
    // fixme need to implement in react-dart
//    if (statics.propTypes != null) {}
  }

  T _uiFactory([Map backingMap]) {
    T builder;
    if (backingMap == null) {
      builder = propsFactory.jsMap(JsBackedMap());
    } else if (backingMap is JsBackedMap) {
      builder = propsFactory.jsMap(backingMap);
    } else {
      builder = propsFactory.map(backingMap);
    }

    return builder..componentFactory = factory;
  }
  return _uiFactory;
}

String getFunctionName(Function f) {
  if (f == null) throw ArgumentError.notNull('f');

  // DDC
  // todo

  // Dart2js
  final constructor = getProperty(f, 'constructor');
  if (constructor != null) {
    return getProperty(constructor, 'name');
  }

  return null;
}

class UiFunctionComponentStatics<T> {
  Map defaultProps;
  Map<String, react.PropValidator<T>> propTypes;

  final String Function(void Function(T) accessProps) keyFor;
  final T Function() newProps;

  UiFunctionComponentStatics._({this.keyFor, this.newProps});
//
//  T newProps() => this._newProps();
//
//  String keyFor(void Function(T) accessProps) => this._keyFor(accessProps);

}

class GenericUiProps extends UiProps {
  @override
  final Map props;

  GenericUiProps(ReactComponentFactoryProxy componentFactory, [Map props]) :
        this.props = props ?? JsBackedMap() {
    this.componentFactory = componentFactory;
  }

  @override
  String get propKeyNamespace => '';

  @override
  bool get $isClassGenerated => true;
}

typedef FunctionFactoryFactory<T extends UiProps> = UiFactory<T> Function(ReactDartFunctionComponentFactoryProxy);


@protected
class FunctionComponentConfig<T extends UiProps> {
  @protected
  final PropsFactory<T> propsFactory;
  final String componentName;

  @protected
  FunctionComponentConfig({this.propsFactory, this.componentName});
}

class PropsFactory<T extends UiProps> {
  final T Function(Map props) map;
  final T Function(JsBackedMap props) jsMap;

  PropsFactory({
    @required this.map,
    @required this.jsMap,
  });

  PropsFactory.fromUiFactory(UiFactory<T> factory) : this.map = factory, this.jsMap = factory;
}
