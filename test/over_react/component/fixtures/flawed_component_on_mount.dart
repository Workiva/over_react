import 'package:over_react/over_react.dart';

// ignore: uri_has_not_been_generated
part 'flawed_component_on_mount.over_react.g.dart';

@Factory()
// ignore: undefined_identifier
UiFactory<FlawedOnMountProps> FlawedOnMount = _$FlawedOnMount;

@Props()
class _$FlawedOnMountProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FlawedOnMountProps extends _$FlawedOnMountProps with _$FlawedOnMountPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFlawedOnMountProps;
}

@Component2()
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
