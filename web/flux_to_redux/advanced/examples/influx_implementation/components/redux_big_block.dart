import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';
import '../../../components/little_block.dart';

part 'redux_big_block.over_react.g.dart';

// When refactoring from a Flux component to a Redux component (with multiple stores):
// [1] Add props for the state values that are needed, and remove the store prop.
// [2] Add props for the actions that are needed (if you intend to use mapDispatchToProps).
// [3] Refactor calls to the `store` prop to the new props added in [1] and [2].
// [4] Make a `composeHocs` call, passing in a `List`.
// [5] Make a `connect` call for each store the component needs access to, with each call being an element in the `List`.
// [6] Tie `connect` to the correct context by using the `context` parameter.
// [7] Use `mapStateToProps` and `mapDispatchToProps` to point props to the correct state values.
// [8] Set the `pure` constructor on `connect` to be `false`.

/*[4]*/ UiFactory<ReduxBigBlockProps> ConnectedReduxBigBlock = composeHocs([
  /*[5]*/ connect<RandomColorStore, ReduxBigBlockProps>(
    /*[6]*/ context: randomColorStoreContext,
    /*[7]*/ mapStateToProps: (state) => (ReduxBigBlock()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor),
    /*[7]*/ mapDispatchToProps: (dispatch) => (ReduxBigBlock()
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
      }),
    /*[8]*/ pure: false,
  ),
  /*[5]*/ connect<LowLevelStore, ReduxBigBlockProps>(
    /*[6]*/ context: lowLevelStoreContext,
    /*[7]*/ mapStateToProps: (state) => (ReduxBigBlock()..blockTwoBackgroundColor = state.backgroundColor),
    /*[7]*/ mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeBlockTwoBackgroundColor = () {
        dispatch(UpdateBlockTwoBackgroundColorAction());
      }),
    /*[8]*/ pure: false,
  ),
  /*[5]*/ connect<AnotherColorStore, ReduxBigBlockProps>(
    /*[6]*/ context: anotherColorStoreContext,
    /*[7]*/ mapStateToProps: (state) => (ReduxBigBlock()..blockThreeBackgroundColor = state.backgroundColor),
    /*[7]*/ mapDispatchToProps: (dispatch) => (ReduxBigBlock()
      ..changeBlockThreeBackgroundColor = () {
        dispatch(UpdateBlockThreeBackgroundColorAction());
      }),
    /*[8]*/ pure: false,
  ),
])(ReduxBigBlock);

@Factory()
UiFactory<ReduxBigBlockProps> ReduxBigBlock = _$ReduxBigBlock;

@Props()
class _$ReduxBigBlockProps extends UiProps with ConnectPropsMixin {
  /*[1]*/ String backgroundColor;

  /*[1]*/ String blockTwoBackgroundColor;

  /*[1]*/ String blockThreeBackgroundColor;

  /*[1]*/ String blockOneBackgroundColor;

  /*[2]*/ void Function() changeMainBackgroundColor;

  /*[2]*/ void Function() changeBlockOneBackgroundColor;

  /*[2]*/ void Function() changeBlockTwoBackgroundColor;

  /*[2]*/ void Function() changeBlockThreeBackgroundColor;
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
              /*[3*/ props.changeMainBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              /*[3*/ props.changeBlockOneBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              /*[3*/ props.changeBlockTwoBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              /*[3*/ props.changeBlockThreeBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 3 Background Color'),
        ),
        (Dom.div()..style = {'display': 'flex', 'flexDirection': 'column'})(
          (LittleBlock()
            ..blockTitle = 'Block 1'
            /*[3*/ ..backgroundColor = this.props.blockOneBackgroundColor
            /*[3*/ ..colorString = this.props.blockOneBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 2'
            /*[3*/ ..backgroundColor = this.props.blockTwoBackgroundColor
            /*[3*/ ..colorString = this.props.blockTwoBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 3'
            /*[3*/ ..backgroundColor = this.props.blockThreeBackgroundColor
            /*[3*/ ..colorString = this.props.blockThreeBackgroundColor
          )(),
        ),
      ),
    ));
  }
}
