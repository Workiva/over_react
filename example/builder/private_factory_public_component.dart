import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'private_factory_public_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FormActionInputProps> _FormActionInput =
    // ignore: undefined_identifier
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
