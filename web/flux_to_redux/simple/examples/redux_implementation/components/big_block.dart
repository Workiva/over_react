import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'big_block.over_react.g.dart';

UiFactory<BigBlockProps> ConnectedBigBlock = connect<RandomColorState, BigBlockProps>(
  mapStateToProps: (state) => (BigBlock()..backgroundColor = state.backgroundColor),
  mapDispatchToProps: (dispatch) => (BigBlock()..changeBackgroundColor = () => dispatch(UpdateBackgroundColorAction())),
)(BigBlock);

UiFactory<BigBlockProps> BigBlock = _$BigBlock;

mixin BigBlockProps on UiProps {
  String backgroundColor;

  void Function() changeBackgroundColor;
}

class BigBlockComponent extends UiComponent2<BigBlockProps> {
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
