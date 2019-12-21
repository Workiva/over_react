import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'redux_big_block.over_react.g.dart';

UiFactory<ReduxBigBlockProps> ConnectedReduxBigBlock = connect<FluxStore, ReduxBigBlockProps>(
  mapStateToProps: (state) => (ReduxBigBlock()..backgroundColor = state.backgroundColor),
  mapDispatchToProps: (dispatch) =>
      (ReduxBigBlock()..changeBackgroundColor = () => dispatch(UpdateBackgroundColorAction())),
  pure: false,
)(ReduxBigBlock);

@Factory()
UiFactory<ReduxBigBlockProps> ReduxBigBlock = _$ReduxBigBlock;

@Props()
class _$ReduxBigBlockProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  Function changeBackgroundColor;
}

@Component2()
class ReduxBigBlockComponent extends UiComponent2<ReduxBigBlockProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': props.backgroundColor, 'color': 'white'})(
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
