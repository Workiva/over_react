part of over_react.web.demo_components;

/// A class of possible HTML `type` attribute values to be placed on a [Dom.button].
class ButtonType extends DebugFriendlyConstant {
  /// The DOM `<button>` `type` attribute value associated with this constant.
  final String typeName;

  const ButtonType._(String name, this.typeName) : super(name);

  /// [typeName] value: 'button'
  static const ButtonType BUTTON = const ButtonType._('BUTTON', 'button');

  /// [typeName] value: 'submit'
  static const ButtonType SUBMIT = const ButtonType._('SUBMIT', 'submit');

  /// [typeName] value: 'reset'
  static const ButtonType RESET  = const ButtonType._('RESET', 'reset');

  @override
  String get debugDescription => 'typeName: $typeName';
}
