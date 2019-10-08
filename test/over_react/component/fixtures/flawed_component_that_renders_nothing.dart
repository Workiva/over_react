import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component_that_renders_nothing.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FlawedWithNoChildProps> FlawedWithNoChild = _$FlawedWithNoChild;

@Props()
class _$FlawedWithNoChildProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedWithNoChildProps extends _$FlawedWithNoChildProps with _$FlawedWithNoChildPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFlawedWithNoChildProps;
}

@Component()
class FlawedWithNoChildComponent extends UiComponent<FlawedWithNoChildProps> {
  @override
  void componentDidMount() {
    throw new FlawedWithNoChildComponentException();
  }

  @override
  render() {
    return null;
  }
}

class FlawedWithNoChildComponentException implements Exception {
  @override
  String toString() =>
      'FlawedWithNoChildComponentException: I was thrown from inside FlawedWithNoChildComponent.componentDidMount!';
}
