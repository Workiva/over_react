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

import 'package:over_react/over_react.dart';
import 'package:react/react.dart' as react;

import '../component_declaration/function_component.dart';

/// A HOC that creates a "lazy" component that lets you defer loading a component’s code until it is rendered for the first time.
///
/// Returns a `UiFactory` you can use just render in your tree. While the code for the lazy component is still loading,
/// attempting to render it will suspend. Use <Suspense> to display a loading indicator while it’s loading.
/// [load] is a function that should return a `Future<UiFactory<TProps>>` that resolves to the component to be rendered.
/// [_config] should be a `UiFactoryConfig<TProps>` or `null` and is only `dynamic` to avoid an unnecessary cast in the boilerplate.
///
/// React will not call [load] until the first time the component is rendered.
/// After React first calls [load], it will wait for it to resolve, and then render the resolved value.
/// Both the returned Future and the Future's resolved value will be cached, so React will not call [load] more than once.
/// If the Future rejects, React will throw the rejection reason for the nearest Error Boundary to handle.
///
/// Example:
/// ```dart
/// import 'package:over_react/over_react.dart';
///
/// part 'main.over_react.g.dart';
///
/// mixin ALazyComponentPropsMixin on UiProps {}
///
/// UiFactory<ALazyComponentPropsMixin> ALazyComponent = lazy(
///   () async {
///     final componentModule = await loadComponent();
///     return uiForwardRef(
///       (props, ref) {
///         return (componentModule.AnotherComponent()
///           ..ref = ref
///           ..addProps(props)
///         )(props.children);
///       },
///       _$ALazyComponentConfig,
///     );
///   },
///   _$ALazyComponentConfig
/// );
/// ```
///
/// > __NOTE:__ A lazy component MUST be wrapped with a `Suspense` component to provide a fallback ui while it loads.
///
/// ```dart
/// (Suspense()
///   ..fallback = Dom.p()('Loading...')
/// )(
///    ALazyComponent()(),
/// );
/// ```
/// See: <https://react.dev/reference/react/lazy>.
UiFactory<TProps> lazy<TProps extends UiProps>(
    Future<UiFactory<TProps>> Function() load, /* UiFactoryConfig<TProps> */ dynamic _config) {
      _config ??= UiFactoryConfig();
  if (_config is! UiFactoryConfig<TProps>) {
    throw ArgumentError('_config is required when using a custom props class and should be a UiFactoryConfig<TProps>. Make sure you are '
        r'using either the generated factory config (i.e. _$FooConfig) or manually declaring your config correctly.');
  }
  // ignore: invalid_use_of_protected_member
  var propsFactory = _config.propsFactory;

  final lazyFactoryProxy = react.lazy(() async {
    final factory = await load();
    // By using a wrapper uiForwardRef ensures that we have a matching factory proxy type given to react-dart's lazy,
    // a `ReactDartWrappedComponentFactoryProxy`. This is necessary to have consistent prop conversions since we don't
    // have access to the original factory proxy outside of this async block.
    final wrapper = uiForwardRef<TProps>(
      (props, ref) {
        final builder = factory()
          ..addProps(props)
          ..ref = ref;
        return props.children == null || (props.children != null && props.children?.isEmpty != false)
            ? builder()
            : builder(props.children);
      },
      UiFactoryConfig(
        propsFactory: propsFactory,
        displayName: _config.displayName != null ? 'lazy(${_config.displayName})' : 'lazy(anonymous)'
      ),
    );
    return wrapper().componentFactory!;
  });

  if (propsFactory == null) {
    if (TProps != UiProps && TProps != GenericUiProps) {
      throw ArgumentError(
          'config.propsFactory must be provided when using custom props classes');
    }
    propsFactory = PropsFactory.fromUiFactory(
            ([backingMap]) => GenericUiProps(lazyFactoryProxy, backingMap))
        as PropsFactory<TProps>;
  }
    // Work around propsFactory not getting promoted to non-nullable in _uiFactory: https://github.com/dart-lang/language/issues/1536
  final nonNullablePropsFactory = propsFactory;

  TProps _uiFactory([Map? props]) {
    TProps builder;
    if (props == null) {
      // propsFactory should get promoted to non-nullable here, but it does not some reason propsF
      builder = nonNullablePropsFactory.jsMap(JsBackedMap());
    } else if (props is JsBackedMap) {
      builder = nonNullablePropsFactory.jsMap(props);
    } else {
      builder = nonNullablePropsFactory.map(props);
    }

    return builder..componentFactory = lazyFactoryProxy;
  }

  return _uiFactory;
}
