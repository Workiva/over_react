import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component_on_mount.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FlawedOnMountProps> FlawedOnMount = _$FlawedOnMount;

mixin FlawedOnMountProps on UiProps {}

class FlawedOnMountComponent extends UiComponent2<FlawedOnMountProps> {
  @override
  void componentDidMount() {
    throw FlawedOnMountComponentException();
  }

  @override
  render() {
    return (Dom.div()..modifyProps(addUnconsumedDomProps))(props.children);
  }
}

class FlawedOnMountComponentException implements Exception {
  @override
  String toString() =>
      'FlawedOnMountComponentException: I was thrown from inside FlawedOnMountComponent.componentDidMount!';
}
