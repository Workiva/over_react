import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component_that_renders_a_string.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FlawedWithStringChildProps> FlawedWithStringChild =
    _$FlawedWithStringChild;

@Props()
class _$FlawedWithStringChildProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedWithStringChildProps extends _$FlawedWithStringChildProps
    with _$FlawedWithStringChildPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFlawedWithStringChildProps;
}

@Component()
class FlawedWithStringChildComponent
    extends UiComponent<FlawedWithStringChildProps> {
  @override
  void componentDidMount() {
    throw FlawedWithStringChildComponentException();
  }

  @override
  render() {
    return 'just a string, yo';
  }
}

class FlawedWithStringChildComponentException implements Exception {
  @override
  String toString() =>
      'FlawedWithStringChildComponentException: I was thrown from inside FlawedWithStringChildComponent.componentDidMount!';
}
