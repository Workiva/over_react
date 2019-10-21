import 'package:over_react/over_react.dart';

// ignore_for_file: uri_has_not_been_generated
import 'private_factory_public_component.example.over_react.g.dart' as $;
export 'private_factory_public_component.example.over_react.g.dart';

@Factory()
UiFactory<FormActionInputPropsMixin> _FormActionInput = $.$FormActionInput;

UiFactory<FormActionInputPropsMixin> FormSubmitInput = ([Map backingMap]) =>
    _FormActionInput(backingMap);

UiFactory<FormActionInputPropsMixin> FormResetInput = ([Map backingMap]) =>
    _FormActionInput(backingMap);

@Props()
mixin FormActionInputPropsMixin on UiProps {
  String prop1;
}

@Component2()
class FormActionInputComponent extends UiComponent2<FormActionInputPropsMixin> {
  @override
  render() {
    return Dom.div()(props.children);
  }
}
