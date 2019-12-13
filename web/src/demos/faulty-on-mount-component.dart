import 'package:over_react/over_react.dart';

part 'faulty-on-mount-component.over_react.g.dart';


@Factory()
// ignore: undefined_identifier
UiFactory<FaultyOnMountProps> FaultyOnMount = _$FaultyOnMount;

@Props()
class _$FaultyOnMountProps extends UiProps {}

// AF-3369 This will be removed once the transition to Dart 2 is complete.
// ignore: mixin_of_non_class, undefined_class
class FaultyOnMountProps extends _$FaultyOnMountProps with _$FaultyOnMountPropsAccessorsMixin {
  // ignore: undefined_identifier, undefined_class, const_initialized_with_non_constant_value
  static const PropsMeta meta = _$metaForFaultyOnMountProps;
}

@Component2()
class FaultyOnMountComponent extends UiComponent2<FaultyOnMountProps> {
  @override
  render() {
    throw Shade();
  }
}

class Shade extends Error {
  @override
  toString() => 'lol';
}
