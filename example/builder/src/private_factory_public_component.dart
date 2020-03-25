// ignore_for_file: prefer_function_declarations_over_variables
import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
part 'private_factory_public_component.over_react.g.dart';

UiFactory<FormActionInputProps> _FormActionInput =
    _$_FormActionInput; // ignore: undefined_identifier

UiFactory<FormActionInputProps> FormSubmitInput = ([backingMap]) =>
    _FormActionInput(backingMap);

UiFactory<FormActionInputProps> FormResetInput = ([backingMap]) =>
    _FormActionInput(backingMap);

mixin FormActionInputProps on UiProps {
  String prop1;
}

@Component2()
class FormActionInputComponent extends UiComponent2<FormActionInputProps> {
  @override
  render() {
    return Dom.div()(props.children);
  }
}
