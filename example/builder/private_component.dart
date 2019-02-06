import 'package:over_react/over_react.dart';

part 'private_component.over_react.g.dart';

@Factory()
UiFactory<_PrivateProps> _Private = _$_Private;

@Props()
class _$_PrivateProps extends UiProps {
  bool prop1;
}

@State()
class _$_PrivateState extends UiState {
  bool state1;
}

@Component()
class PrivateComponent extends UiStatefulComponent<_PrivateProps, _PrivateState> {
  @override
  Map getDefaultProps() => newProps()..prop1 = true;

  @override
  Map getInitialState() => newState()..state1 = true;

  @override
  render() {
    return Dom.div()('PrivateComponent', {
      'props.prop1': props.prop1,
      'props.state1': state.state1,
    }.toString());
  }
}
