import 'package:over_react/over_react.dart';

part 'faulty-on-mount-component.over_react.g.dart';

// ignore: undefined_identifier
UiFactory<FaultyOnMountProps> FaultyOnMount = _$FaultyOnMount;

mixin FaultyOnMountProps on UiProps {}

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
