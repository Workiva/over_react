import 'package:over_react/over_react.dart';
import 'package:react/react_client/component_factory.dart';

/// Creates a Dart component factory that wraps a ReactJS [factoryProxy].
///
/// More in-depth documentation for wrapping JS components is coming soon.
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
  final propsFactory = (_config as UiFactoryConfig<TProps>).propsFactory;
  ArgumentError.checkNotNull(_config, '_config');

  TProps _uiFactory([Map backingMap]) {
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
