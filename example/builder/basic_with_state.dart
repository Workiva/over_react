import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'props_mixin.dart' as pm;
import 'state_mixin.dart';

part 'basic_with_state.over_react.g.dart';

UiFactory<BasicProps> ConnectedBasic = connect<BasicStoreState, BasicProps>
  (mapStateToProps: (state, _) => Basic()..basicProp = state.basicProps)
  (Basic);

@Factory()
UiFactory<BasicProps> Basic = _$Basic;

@Props()
class _$BasicProps extends UiProps with ConnectProps {
  String basicProp;
}

@Component()
class BasicComponent extends UiComponent<BasicProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..basicProp = 'defaultBasicProps';

  @override
  render() {
    return Dom.div()(
        Dom.div()('default prop testing: ${props.basicProp}'),
    );
  }
}


class BasicStoreState {
  String basicProps;
}
