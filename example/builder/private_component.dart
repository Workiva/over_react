import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'private_component.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<_CustomColorInputProps> _CustomColorInput = _$_CustomColorInput;

@Props()
class _$_CustomColorInputProps extends UiProps {
  bool prop1;
}

@State()
class _$_CustomColorInputState extends UiState {
  bool state1;
}

@Component()
class CustomColorInputComponent extends UiStatefulComponent<_CustomColorInputProps, _CustomColorInputState> {
  render() {
    return Dom.div()();
  }

}

// AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class _CustomColorInputProps extends _$_CustomColorInputProps with _$_CustomColorInputPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaFor_CustomColorInputProps;
}

// AF-#### This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class _CustomColorInputState extends _$_CustomColorInputState with _$_CustomColorInputStateAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const StateMeta meta = _$metaFor_CustomColorInputState;
}
