import 'package:over_react/over_react.dart';

part 'dom_prop_types.over_react.g.dart';

UiFactory<HammerTimeProps> HammerTime =
    // ignore: undefined_identifier
    _$HammerTime;

mixin HammerTimeProps on UiProps {
  String somethingThatCanBeTouched;
}

mixin HammerTimeState on UiState {}

class HammerTimeComponent extends UiStatefulComponent2<HammerTimeProps, HammerTimeState> {
  final mcHammer = 'cant touch this';

  @override
  get defaultProps {
    return newProps()
      ..somethingThatCanBeTouched = mcHammer;
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
