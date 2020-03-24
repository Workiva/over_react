import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'redux_big_block.over_react.g.dart';

// When refactoring from a Flux component to a Redux component:
// [1] Add props for the state values that are needed, and remove the store prop.
// [2] Add props for the actions that are needed (if you intend to use mapActionsToProps).
// [3] Refactor calls to the `store` prop to the new props added in [1] and [2].
// [4] Wrap the existing factory in a `connect` call.
// [5] Use `mapStateToProps` and `mapDispatchToProps` to point props to the correct state values.
// [6] Set the `pure` constructor on `connect` to be `false`.

// [4]
UiFactory<ReduxBigBlockProps> ConnectedReduxBigBlock = connect<FluxStore, ReduxBigBlockProps>(
  // [5]
  mapStateToProps: (state) => (ReduxBigBlock()..backgroundColor = state.backgroundColor),
  mapDispatchToProps: (dispatch) =>
      (ReduxBigBlock()..changeBackgroundColor = () => dispatch(UpdateBackgroundColorAction())),
  // [6]
  pure: false,
)(ReduxBigBlock);

UiFactory<ReduxBigBlockProps> ReduxBigBlock = _$ReduxBigBlock;

mixin ReduxBigBlockPropsMixin on UiProps {
  String backgroundColor; // [1]

  void Function() changeBackgroundColor; // [2]
}

class ReduxBigBlockProps = UiProps with ReduxBigBlockPropsMixin, ConnectPropsMixin;

class ReduxBigBlockComponent extends UiComponent2<ReduxBigBlockProps> {
  @override
  render() {
    return (Dom.div()..style = {
      'padding': '50px',
      'backgroundColor': props.backgroundColor, // [3]
      'color': 'white',
    })(
      'This module uses a redux pattern to change its background color.',
      (Dom.button()
        ..onClick = (_) {
          props.changeBackgroundColor(); // [3]s
        }
        ..style = {'padding': '10px', 'margin': '10px'}
      )('Change Background Color'),
    );
  }
}
