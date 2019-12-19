import 'dart:html';

import 'package:over_react/over_react.dart';

import 'package:todo_client/src/components/shared/material_ui.dart';

// ignore: uri_has_not_been_generated
part 'create_input.over_react.g.dart';

@Factory()
UiFactory<CreateInputProps> CreateInput =
    // ignore: undefined_identifier
    _$CreateInput;

@Props(keyNamespace: '') // No namespace so prop forwarding works when passing to the JS TextField component.
class _$CreateInputProps extends UiProps {
  void Function(String s) onCreate;
  bool autoFocus;
  String label;
  String placeholder;
}

@Component2()
class CreateInputComponent extends UiComponent2<CreateInputProps> {
  @override
  get defaultProps => (newProps()..autoFocus = false);

  @override
  render() {
    final propsToForward = {...props}..remove('onCreate');

    return Box({...shrinkToFitProps},
      TextField({
        'fullWidth': true,
        'variant': 'outlined',
        ...propsToForward,
        'onKeyDown': (SyntheticKeyboardEvent event) {
          if (props.onKeyDown != null) props.onKeyDown(event);
          InputElement target = event.target;
          final trimmedValue = target.value.trim();
          if (event.keyCode == KeyCode.ENTER && trimmedValue.isNotEmpty) {
            props.onCreate(trimmedValue);
            target.value = '';
          }
        },
      }),
    );
  }
}

// ignore: mixin_of_non_class, undefined_class
class CreateInputProps extends _$CreateInputProps with _$CreateInputPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForCreateInputProps;
}
