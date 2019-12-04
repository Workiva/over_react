import 'package:over_react/over_react.dart';
import 'props_mixin.dart' as pm;
import 'state_mixin.dart';

// ignore_for_file: uri_has_not_been_generated
import 'basic_with_state.example.over_react.g.dart' as $;
export 'basic_with_state.example.over_react.g.dart';

UiFactory<BasicProps> Basic = $.$Basic;

class BasicProps = UiProps with pm.ExamplePropsMixinClass, BasicPropsMixin;
class BasicState = UiState with ExampleStateMixinClass, BasicStateMixin;

mixin BasicPropsMixin on UiProps, pm.ExamplePropsMixinClass {
  String basicProp;
  String basic1;
  String basic2;
  String basic3;
  String basic4;
  String basic5;
}

mixin BasicStateMixin on UiState, ExampleStateMixinClass {
  String basicState;
}

class BasicComponent extends UiStatefulComponent2<BasicProps, BasicState> {
  @override
  get defaultProps => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps'
      ..propMixin1 = '<props mixin>';

  @override
  get initialState => newState()..basicState = '<basic state>'
      ..stateMixin1 = '<state mixin>';

  @override
  render() {
    return Dom.div()(
        Dom.div()('props for mixin in basic.dart: ${props.propMixin1}'),
        Dom.div()('default prop testing: ${props.basicProp}'),
        Dom.div()('default state testing:  ${state.basicState}'),
        Dom.div()('state mixin in basic.dart: ${state.stateMixin1}'),
    );
  }
}
