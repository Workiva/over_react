import 'package:over_react/over_react.dart';

part 'pseudo_static_lifecycle.over_react.g.dart';

UiFactory<HammerTimeProps> HammerTime =
    // ignore: undefined_identifier
    castUiFactory(_$HammerTime);

mixin HammerTimeProps on UiProps {
  String somethingThatCanBeTouched;
}

mixin HammerTimeState on UiState {}

class HammerTimeComponent extends UiStatefulComponent2<HammerTimeProps, HammerTimeState> {
  final mcHammer = 'cant touch this';

  @override
  get defaultProps {
    return newProps() // This newProps() call should not lint
      ..addProps(super.defaultProps) // This super.defaultProps access should not lint
      ..somethingThatCanBeTouched = mcHammer; // This mcHammer access SHOULD lint
  }

  @override
  getDerivedStateFromProps(Map nextProps, Map prevState) {
    final tNextProps = typedPropsFactory(nextProps);
    final tNextPropsJs = typedPropsFactoryJs(nextProps);
    final tPrevState = typedStateFactory(prevState);
    final tPrevStateJs = typedStateFactoryJs(prevState);

    if (props.somethingThatCanBeTouched == mcHammer) {
      return newState();
    }

    return null;
  }

  @override
  render() {}
}
