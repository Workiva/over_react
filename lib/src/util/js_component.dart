import 'package:react/react_client/component_factory.dart';

import '../component_declaration/component_declaration.dart';

/// Creates a Dart component factory that wraps a ReactJS [factoryProxy].
///
/// See the [complete guide to wrapping JS components](https://github.com/Workiva/over_react/blob/master/doc/wrapping_js_components.md) for more information.
///
/// Example:
/// ```dart
/// UiFactory<ButtonProps> Button = uiJsComponent(
///   ReactJsComponentFactoryProxy(MaterialUI.Button),
///   _$ButtonConfig, // ignore: undefined_identifier
/// );
///
/// @Props(keyNamespace: '')
/// mixin ButtonProps on UiProps {}
/// ```
UiFactory<TProps> uiJsComponent<TProps extends UiProps>(
  ReactJsComponentFactoryProxy factoryProxy,
  dynamic _config,
) {
  ArgumentError.checkNotNull(_config, '_config');

  if (_config is! UiFactoryConfig<TProps>) {
    throw ArgumentError(
        '_config should be a UiFactory<TProps>. Make sure you are '
        r'using either the generated factory config (i.e. _$FooConfig) or manually '
        'declaring your config correctly.');
  }

  // ignore: invalid_use_of_protected_member
  final propsFactory = _config.propsFactory;
  ArgumentError.checkNotNull(propsFactory, '_config.propsFactory');
  propsFactory!;

  TProps _uiFactory([Map? backingMap]) {
    TProps builder;
    if (backingMap == null) {
      builder = propsFactory.jsMap(JsBackedMap());
    } else if (backingMap is JsBackedMap) {
      builder = propsFactory.jsMap(backingMap);
    } else {
      builder = propsFactory.map(backingMap);
    }
    return builder..componentFactory = factoryProxy;
  }

  return _uiFactory;
}
