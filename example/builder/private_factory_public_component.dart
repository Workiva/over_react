import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'private_factory_public_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FormActionInputProps> _FormActionInput = _$FormActionInput;


UiFactory<FormActionInputProps> FormSubmitInput = ([Map backingMap]) =>
    _FormActionInput(backingMap);

UiFactory<FormActionInputProps> FormResetInput = ([Map backingMap]) =>
    _FormActionInput(backingMap);

@Props()
class _$FormActionInputProps extends UiProps {
  String prop1;
}

@Component()
class FormActionInputComponent extends UiComponent<FormActionInputProps> {
  @override
  render() {
    return Dom.div()(props.children);
  }
}

// AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FormActionInputProps extends _$FormActionInputProps with _$FormActionInputPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = $metaForFormActionInputProps;
}
