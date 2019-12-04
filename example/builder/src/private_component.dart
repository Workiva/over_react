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

@Component2()
class PrivateComponent extends UiStatefulComponent2<_PrivateProps, _PrivateState> {
  @override
  get defaultProps => newProps()..prop1 = true;

  @override
  get initialState => newState()..state1 = true;

  @override
  render() {
    return Dom.div()('PrivateComponent', {
      'props.prop1': props.prop1,
      'props.state1': state.state1,
    }.toString());
  }
}
