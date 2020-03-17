import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component_that_renders_a_string.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FlawedWithStringChildProps> FlawedWithStringChild = _$FlawedWithStringChild;

mixin FlawedWithStringChildProps on UiProps {}

class FlawedWithStringChildComponent extends UiComponent2<FlawedWithStringChildProps> {
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
