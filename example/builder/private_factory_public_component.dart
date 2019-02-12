import 'package:over_react/over_react.dart';

part 'private_factory_public_component.over_react.g.dart';

@Factory()
UiFactory<FormActionInputProps> _FormActionInput =
    _$_FormActionInput;

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
