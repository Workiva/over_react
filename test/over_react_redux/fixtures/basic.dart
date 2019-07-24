import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';


part 'basic.over_react.g.dart';

@Factory()
UiFactory<BasicProps> Basic = _$Basic;

@Props()
class _$BasicProps extends UiProps with ConnectPropsMixin {
  String propFromState;
  String propFromOwnProps;
  String propFromDispatch;
  dynamic anything;
}

@Component2()
class BasicComponent extends UiComponent2<BasicProps> {
  @override
  Map getDefaultProps() => newProps()..id = 'basic component'
      ..propFromState = 'default propFromState';

  @override
  render() {
    return Dom.div()(
        Dom.div()('default prop testing: ${props.propFromState}'),
        (Dom.button()..onClick = (_){ props.dispatch('Idonothing');})('Click Me')
    );
  }
}
