import 'dart:html';

import 'package:meta/meta.dart';
import 'package:over_react/over_react.dart';

import 'package:react_material_ui/react_material_ui.dart';

part 'create_input.over_react.g.dart';

UiFactory<CreateInputProps> CreateInput =
    _$CreateInput; // ignore: undefined_identifier

@Props(keyNamespace: '') // No namespace so prop forwarding works when passing to the JS TextField component.
mixin CreateInputProps on UiProps {
  @requiredProp
  void Function(String s) onCreate;
  bool autoFocus;
  String label;
  String placeholder;
}

class CreateInputComponent extends UiComponent2<CreateInputProps> {
  @visibleForTesting
  final textFieldRef = createRef().jsRef;

  @override
  get defaultProps => (newProps()..autoFocus = false);

  @override
  render() {
    return (Box()
        ..shrinkToFit = true
    )(
      (TextField()
          ..modifyProps(addUnconsumedProps)
          ..fullWidth = true
          ..variant = TextFieldVariant.OUTLINED
          ..inputRef = textFieldRef
          // TODO: How do we get this to play nice with something like forwardRef instead of storing a ref inside the parent component?
          ..onKeyDown = (SyntheticKeyboardEvent event) {
            if (props.onKeyDown != null) props.onKeyDown(event);
            InputElement target = event.target;
            final trimmedValue = target.value.trim();
            if (event.keyCode == KeyCode.ENTER && trimmedValue.isNotEmpty) {
              props.onCreate(trimmedValue);
              target.value = '';
            }
          }
      )()
    );
  }
}
