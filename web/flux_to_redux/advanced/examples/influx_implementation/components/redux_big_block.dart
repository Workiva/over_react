import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';
import '../../../components/little_block.dart';

part 'redux_big_block.over_react.g.dart';

UiFactory<ReduxBigBlockProps> ConnectedReduxBigBlock = composeHocs([
  connect<RandomColorStore, ReduxBigBlockProps>(
    context: randomColorStoreContext,
    mapStateToProps: (state) => (ReduxBigBlock()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor
    ),
    mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeMainBackgroundColor = () {
        dispatch(UpdateBackgroundColorAction());
      }
      ..changeBlockOneBackgroundColor = () {
        dispatch(UpdateBlockOneBackgroundColorAction());
      }
      ..changeBlockTwoBackgroundColor = () {
        dispatch(UpdateBlockTwoBackgroundColorAction());
      }
      ..changeBlockThreeBackgroundColor = () {
        dispatch(UpdateBlockThreeBackgroundColorAction());
      }
    ),
    pure: false,
  ),
  connect<LowLevelStore, ReduxBigBlockProps>(
    context: lowLevelStoreContext,
    mapStateToProps: (state) => (ReduxBigBlock()..blockTwoBackgroundColor = state.backgroundColor),
    mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeBlockTwoBackgroundColor = () {
        dispatch(UpdateBlockTwoBackgroundColorAction());
      }
    ),
    pure: false,
  ),
  connect<AnotherColorStore, ReduxBigBlockProps>(
    context: anotherColorStoreContext,
    mapStateToProps: (state) => (ReduxBigBlock()..blockThreeBackgroundColor = state.backgroundColor),
    mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeBlockThreeBackgroundColor = () {
        dispatch(UpdateBlockThreeBackgroundColorAction());
      }
    ),
    pure: false,
  ),
])(ReduxBigBlock);

@Factory()
UiFactory<ReduxBigBlockProps> ReduxBigBlock = _$ReduxBigBlock;

@Props()
class _$ReduxBigBlockProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  String blockTwoBackgroundColor;

  String blockThreeBackgroundColor;

  String blockOneBackgroundColor;

  void Function() changeMainBackgroundColor;

  void Function() changeBlockOneBackgroundColor;

  void Function() changeBlockTwoBackgroundColor;

  void Function() changeBlockThreeBackgroundColor;
}

@Component2()
class ReduxBigBlockComponent extends UiComponent2<ReduxBigBlockProps> {
  @override
  render() {
    return (Fragment()(
      (Dom.div()
        ..style = {
          'padding': '50px',
          'backgroundColor': props.backgroundColor,
          'color': 'white',
          'display': 'flex',
          'alignItems': 'center',
          'justifyContent': 'space-evenly'
        }
      )(
        Dom.div()('This module uses a Redux pattern to change its background color.'),
        (Dom.div()
          ..style = {
            'display': 'flex',
            'flexDirection': 'column',
          }
        )(
          (Dom.button()
            ..onClick = (_) {
              props.changeMainBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockOneBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockTwoBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              props.changeBlockThreeBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 3 Background Color'),
        ),
        (Dom.div()..style = {'display': 'flex', 'flexDirection': 'column'})(
          (LittleBlock()
            ..blockTitle = 'Block 1'
            ..backgroundColor = this.props.blockOneBackgroundColor
            ..colorString = this.props.blockOneBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 2'
            ..backgroundColor = this.props.blockTwoBackgroundColor
            ..colorString = this.props.blockTwoBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 3'
            ..backgroundColor = this.props.blockThreeBackgroundColor
            ..colorString = this.props.blockThreeBackgroundColor
          )(),
        ),
      ),
    ));
  }
}
