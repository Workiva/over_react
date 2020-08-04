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

// ignore_for_file: prefer_generic_function_type_aliases
library over_react.component_declaration.function_component;

import 'package:js/js_util.dart';
import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';
import 'package:react/react.dart' as react;

import 'component_type_checking.dart';

export 'component_type_checking.dart'
    show isComponentOfType, isValidElementOfType;

/// Declares a function component and returns a factory that can be used to render it.
///
/// __Example__:
/// ```dart
/// UiFactory<FooProps> Foo = uiFunction(
///   (props) {
///     // Set default props using null-aware operators.
///     final isDisabled = props.isDisabled ?? false;
///     final items = props.items ?? [];
///
///     // Return the rendered component contents here.
///     return Fragment()(
///       Dom.div()(items),
///       (Dom.button()..disabled = isDisabled)('Click me!'),
///     );
///   },
///   // The generated props config will match the factory name.
///   $FooConfig, // ignore: undefined_identifier
/// );
///
/// // Multiple function components can be declared with the same props.
/// UiFactory<FooProps> AnotherFoo = uiFunction(
///   (props) {
///       return (Foo()
///         ..items = props.items
///         ..isDisabled = true
///       )();
///   },
///   $AnotherFooConfig, // ignore: undefined_identifier
/// );
///
/// mixin FooProps on UiProps {
///   bool isDisabled;
///   Iterable<String> items;
/// }
/// ```
///
/// __OR__ Optionally pass in an existing [PropsFactory] in place of a props [config].
///
/// ```dart
/// UiFactory<FooProps> Bar = uiFunction(
///   (props) {
///     return (Dom.button()..disabled = props.isDisabled)('Click me!');
///   },
///   FunctionComponentConfig(
///     propsFactory: PropsFactory.fromUiFactory(Foo),
///     displayName: 'Bar',
///   ),
/// );
/// ```
///
/// __OR__ Don't set `propsFactory` when using `UiProps`, as a generic one will be
/// created for the component in [uiFunction].
///
/// ```dart
/// UiFactory<UiProps> Foo = uiFunction(
///   (props) {
///     return Dom.div()('prop id: ${props.id}');
///   },
///   FunctionComponentConfig(
///     displayName: 'Foo',
///   ),
/// );
/// ```
///
/// Learn more: <https://reactjs.org/docs/components-and-props.html#function-and-class-components>.
// TODO: right now only top level factory declarations will generate props configs.
UiFactory<TProps> uiFunction<TProps extends UiProps>(
  dynamic Function(TProps props) functionComponent,
  FunctionComponentConfig<TProps> config,
) {
  ArgumentError.checkNotNull(config, 'config');

  var propsFactory = config.propsFactory;

  // Get the display name from the inner function if possible so it doesn't become `_uiFunctionWrapper`
  final displayName = config.displayName ?? _getFunctionName(functionComponent);

  dynamic _uiFunctionWrapper(JsBackedMap props) {
    return functionComponent(propsFactory.jsMap(props));
  }

  final factory = react.registerFunctionComponent(
    _uiFunctionWrapper,
    displayName: displayName,
  );

  if (propsFactory == null) {
    if (TProps != UiProps && TProps != _GenericUiProps) {
      throw ArgumentError(
          'config.propsFactory must be provided when using custom props classes');
    }
    propsFactory = PropsFactory.fromUiFactory(
            ([backingMap]) => _GenericUiProps(factory, backingMap))
        as PropsFactory<TProps>;
  }

  TProps _uiFactory([Map backingMap]) {
    TProps builder;
    if (backingMap == null) {
      builder = propsFactory.jsMap(JsBackedMap());
    } else if (backingMap is JsBackedMap) {
      builder = propsFactory.jsMap(backingMap);
    } else {
      builder = propsFactory.map(backingMap);
    }

    return builder..componentFactory = factory;
  }

  registerComponentTypeAlias(factory, _uiFactory);

  return _uiFactory;
}

String _getFunctionName(Function function) {
  return getProperty(function, 'name') ??
      getProperty(function, '\$static_name');
}

class _GenericUiProps extends UiProps {
  @override
  final Map props;

  _GenericUiProps(ReactComponentFactoryProxy componentFactory, [Map props])
      : this.props = props ?? JsBackedMap() {
    this.componentFactory = componentFactory;
  }

  @override
  String get propKeyNamespace => '';

  @override
  bool get $isClassGenerated => true;
}

/// Helper class used to keep track of generated information for [uiFunction].
class FunctionComponentConfig<TProps extends UiProps> {
  @protected
  final PropsFactory<TProps> propsFactory;
  final String displayName;

  FunctionComponentConfig({this.propsFactory, this.displayName});
}

/// Helper class to keep track of props factories used by [uiFunction],
class PropsFactory<TProps extends UiProps> {
  /// Returns a typed props object backed by the specified [Map].
  final TProps Function(Map props) map;

  /// Returns a typed props object backed by the specified [JsBackedMap].
  final TProps Function(JsBackedMap props) jsMap;

  PropsFactory({
    @required this.map,
    @required this.jsMap,
  });

  /// Creates a [PropsFactory] based on [factory].
  PropsFactory.fromUiFactory(UiFactory<TProps> factory)
      : this.map = factory,
        this.jsMap = factory;
}
