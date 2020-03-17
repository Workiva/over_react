import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component_that_renders_nothing.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FlawedWithNoChildProps> FlawedWithNoChild = _$FlawedWithNoChild;

mixin FlawedWithNoChildProps on UiProps {}

class FlawedWithNoChildComponent extends UiComponent2<FlawedWithNoChildProps> {
  @override
  void componentDidMount() {
    throw FlawedWithNoChildComponentException();
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
