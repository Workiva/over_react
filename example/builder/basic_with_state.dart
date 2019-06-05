import 'dart:developer';

import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/over_react_redux/over_react_redux.dart';
import 'props_mixin.dart' as pm;
import 'state_mixin.dart';
import '../store.dart';
import 'package:redux/redux.dart';

part 'basic_with_state.over_react.g.dart';

UiFactory<BasicProps> ConnectedBasic = connect<AppState, BasicProps>
  (mapStateToProps: (state, _) => Basic()..basicProp = state.basicProp)
  (Basic);



@Factory()
UiFactory<BasicProps> Basic = _$Basic;

@Props()
class _$BasicProps extends UiProps with ConnectPropsMixin {
  String basicProp;
}

@Component2()
class BasicComponent extends UiComponent2<BasicProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProp';

  @override
  render() {
    return Dom.div()(
        Dom.div()('default prop testing: ${props.basicProp}'),
        (Dom.button()..onClick = (_){ props.dispatch('Idonothing');})('Click Me')
    );
  }
}
