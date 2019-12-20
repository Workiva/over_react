import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'redux_random_color.over_react.g.dart';

UiFactory<ReduxRandomColorProps> ConnectedReduxRandomColor =
    connect<FluxStore, ReduxRandomColorProps>(
  mapStateToProps: (state) => (ReduxRandomColor()..backgroundColor = state.backgroundColor),
  mapDispatchToProps: (dispatch) =>
      (ReduxRandomColor()..changeBackgroundColor = () => dispatch(UpdateBackgroundColorAction())),
  pure: false,
)(ReduxRandomColor);

@Factory()
UiFactory<ReduxRandomColorProps> ReduxRandomColor = _$ReduxRandomColor;

@Props()
class _$ReduxRandomColorProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  Function changeBackgroundColor;
}

@Component2()
class ReduxRandomColorComponent extends UiComponent2<ReduxRandomColorProps> {
  @override
  render() {
    return ((Dom.div()
      ..style = {'padding': '50px', 'backgroundColor': props.backgroundColor, 'color': 'white'}
    )(
      'This module uses a redux pattern to change its background color.',
      (Dom.button()
        ..onClick = (_) {
          props.changeBackgroundColor();
        }
        ..style = {'padding': '10px', 'margin': '10px'}
      )('Change Background Color'),
    ));
  }
}
