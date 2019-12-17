import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../../../stores.dart';
import '../../../components/color_block.dart';

part 'random_color_redux.over_react.g.dart';

UiFactory<RandomColorReduxProps> ConnectedRandomColorRedux = composeHocs([
  connect<InTransitionTopLevelStore, RandomColorReduxProps>(
    context: inTransitionTopLevelStoreContext,
    mapStateToProps: (state) => (RandomColorRedux()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor
    ),
    mapDispatchToProps: (dispatch) => (RandomColorRedux()
      ..changeMainBackgroundColor = () { dispatch(UpdateBackgroundColorAction()); }
      ..changeBlockOneBackgroundColor = () { dispatch(UpdateBlockOneBackgroundColorAction()); }
      ..changeBlockTwoBackgroundColor = () { dispatch(UpdateBlockTwoBackgroundColorAction()); }
      ..changeBlockThreeBackgroundColor = () { dispatch(UpdateBlockThreeBackgroundColorAction()); }
    ),
    pure: false,
  ),
  connect<InTransitionLowLevelStore, RandomColorReduxProps>(
    context: inTransitionLowLevelStoreContext,
    mapStateToProps: (state) => (RandomColorRedux()
      ..blockTwoBackgroundColor = state.backgroundColor
    ),
    mapDispatchToProps: (dispatch) => (RandomColorRedux()
      ..changeBlockTwoBackgroundColor = () { dispatch(UpdateBlockTwoBackgroundColorAction()); }
    ),
    pure: false,
  ),
  connect<InTransitionSecondStore, RandomColorReduxProps>(
    context: inTransitionSecondStoreContext,
    mapStateToProps: (state) => (RandomColorRedux()
      ..blockThreeBackgroundColor = state.backgroundColor
    ),
    mapDispatchToProps: (dispatch) => (RandomColorRedux()
      ..changeBlockThreeBackgroundColor = () { dispatch(UpdateBlockThreeBackgroundColorAction()); }
    ),
    pure: false,
  ),
])(RandomColorRedux);

@Factory()
UiFactory<RandomColorReduxProps> RandomColorRedux = _$RandomColorRedux;

@Props()
class _$RandomColorReduxProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  String blockTwoBackgroundColor;

  String blockThreeBackgroundColor;

  String blockOneBackgroundColor;

  Function changeMainBackgroundColor;

  Function changeBlockOneBackgroundColor;

  Function changeBlockTwoBackgroundColor;

  Function changeBlockThreeBackgroundColor;
}

@Component2()
class RandomColorReduxComponent extends UiComponent2<RandomColorReduxProps> {
  @override
  render() {
    return (
        Fragment()(
            (Dom.div()..style = {
              'padding': '50px',
              'backgroundColor': props.backgroundColor,
              'color': 'white',
              'display': 'flex',
              'alignItems': 'center',
              'justifyContent': 'space-evenly'
            })(
                (Dom.div()..key='c1')('This module uses a Redux pattern to change its background color.'),
                (Dom.div()
                  ..style={'display': 'flex', 'flexDirection': 'column',}
                  ..key='c2'
                )(
                    (Dom.button()
                      ..onClick = (_) {
                        props.changeMainBackgroundColor();
                      }
                      ..style = {
                        'padding': '10px',
                        'margin': '10px'
                      }
                      ..key='btn1'
                    )('Change Main Background Color'),
                    (Dom.button()
                      ..onClick = (_) {
                        props.changeBlockOneBackgroundColor();
                      }
                      ..style = {
                        'padding': '10px',
                        'margin': '10px'
                      }
                      ..key='btn2'
                    )('Change Block 1 Background Color'),
                    (Dom.button()
                      ..onClick = (_) {
                        props.changeBlockTwoBackgroundColor();
                      }
                      ..style = {
                        'padding': '10px',
                        'margin': '10px'
                      }
                      ..key='btn3'
                    )('Change Block 2 Background Color'),
                    (Dom.button()
                      ..onClick = (_) {
                        props.changeBlockThreeBackgroundColor();
                      }
                      ..style = {
                        'padding': '10px',
                        'margin': '10px'
                      }
                      ..key='btn4'
                    )('Change Block 3 Background Color')
                ),
                (Dom.div()
                  ..style={'display': 'flex', 'flexDirection': 'column'}
                  ..key='c3'
                )(
                  (ColorBlock()
                    ..blockTitle = 'Block 1'
                    ..backgroundColor = this.props.blockOneBackgroundColor
                    ..colorString = this.props.blockOneBackgroundColor
                    ..key = 'b1'
                  )(),
                  (ColorBlock()
                    ..blockTitle = 'Block 2'
                    ..backgroundColor = this.props.blockTwoBackgroundColor
                    ..colorString = this.props.blockTwoBackgroundColor
                    ..key = 'b2'
                  )(),
                  (ColorBlock()
                    ..blockTitle = 'Block 3'
                    ..backgroundColor = this.props.blockThreeBackgroundColor
                    ..colorString = this.props.blockThreeBackgroundColor
                    ..key = 'b3'
                  )(),
                )
            )
        )
    );
  }
}
