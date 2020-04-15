import 'package:over_react/over_react.dart';
import 'props_mixin.dart' as pm;
import 'state_mixin.dart';

part 'basic_with_state.over_react.g.dart';

UiFactory<BasicProps> Basic = _$Basic; // ignore: undefined_identifier

mixin BasicProps on UiProps {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

mixin BasicState on UiState {
  String basicState;
}

class BasicComponent extends UiStatefulComponent2<BasicProps, BasicState> {
  @override
  get defaultProps => newProps()
    ..id = 'basic component'
    ..basicProp = 'defaultBasicProps';

  @override
  get initialState => newState()..basicState = '<basic state>';

  @override
  render() {
    return Dom.div()(
      Dom.div()('default prop testing: ${props.basicProp}'),
      Dom.div()('default state testing:  ${state.basicState}'),
    );
  }
}
