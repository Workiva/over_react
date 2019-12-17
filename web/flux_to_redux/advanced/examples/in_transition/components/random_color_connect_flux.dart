import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/util/hoc.dart';

import '../../../stores.dart';
import '../../../components/color_block.dart';


part 'random_color_connect_flux.over_react.g.dart';

UiFactory<RandomColorConnectFluxProps> ConnectedRandomColorConnectFlux = composeHocs([
  connectFlux<InTransitionTopLevelStore, RandomColorActions, RandomColorConnectFluxProps>(
    context: inTransitionTopLevelStoreContext,
    mapStateToProps: (state) => (RandomColorConnectFlux()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor
    ),
    mapActionsToProps: (actions) => (RandomColorConnectFlux()
      ..changeMainBackgroundColor = () { actions.changeMainBackgroundColor(); }
      ..changeBlockOneBackgroundColor = () { actions.changeBlockOneBackgroundColor(); }
    ),
  ),
  connectFlux<InTransitionLowLevelStore, RandomColorActions, RandomColorConnectFluxProps>(
    context: inTransitionLowLevelStoreContext,
    mapStateToProps: (state) => (RandomColorConnectFlux()..blockTwoBackgroundColor = state.backgroundColor),
    mapActionsToProps: (actions) => RandomColorConnectFlux()..changeBlockTwoBackgroundColor = () => actions.changeBlockTwoBackgroundColor(),
  ),
  connectFlux<InTransitionSecondStore, RandomColorActions, RandomColorConnectFluxProps>(
    context: inTransitionSecondStoreContext,
    mapStateToProps: (state) => (RandomColorConnectFlux()..blockThreeBackgroundColor = state.backgroundColor),
    mapActionsToProps: (actions) => RandomColorConnectFlux()..changeBlockThreeBackgroundColor = () => actions.changeBlockThreeBackgroundColor(),
  ),
])(RandomColorConnectFlux);

@Factory()
UiFactory<RandomColorConnectFluxProps> RandomColorConnectFlux = _$RandomColorConnectFlux;

@Props()
class _$RandomColorConnectFluxProps extends UiProps with ConnectPropsMixin {
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
class RandomColorConnectFluxComponent extends UiComponent2<RandomColorConnectFluxProps> {
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
                (Dom.div()..key='c1')('This module uses a ConnectedFlux pattern to change its background color.'),
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
