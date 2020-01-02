import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/util/hoc.dart';

import '../store.dart';
import '../../../components/little_block.dart';

part 'connect_flux_big_block.over_react.g.dart';

UiFactory<ConnectFluxBigBlockProps> ConnectedConnectFluxBigBlock = composeHocs([
  connectFlux<RandomColorStore, RandomColorActions, ConnectFluxBigBlockProps>(
    context: randomColorStoreContext,
    mapStateToProps: (state) => (ConnectFluxBigBlock()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor
    ),
    mapActionsToProps: (actions) => (ConnectFluxBigBlock()
      ..changeMainBackgroundColor = actions.changeMainBackgroundColor
      ..changeBlockOneBackgroundColor = actions.changeBlockOneBackgroundColor
    ),
  ),
  connectFlux<LowLevelStore, RandomColorActions, ConnectFluxBigBlockProps>(
    context: lowLevelStoreContext,
    mapStateToProps: (state) =>
        (ConnectFluxBigBlock()..blockTwoBackgroundColor = state.backgroundColor),
    mapActionsToProps: (actions) =>
        (ConnectFluxBigBlock()..changeBlockTwoBackgroundColor = actions.changeBlockTwoBackgroundColor),
  ),
  connectFlux<AnotherColorStore, RandomColorActions, ConnectFluxBigBlockProps>(
    context: anotherColorStoreContext,
    mapStateToProps: (state) =>
        (ConnectFluxBigBlock()..blockThreeBackgroundColor = state.backgroundColor),
    mapActionsToProps: (actions) =>
        (ConnectFluxBigBlock()..changeBlockThreeBackgroundColor = actions.changeBlockThreeBackgroundColor),
  ),
])(ConnectFluxBigBlock);

@Factory()
UiFactory<ConnectFluxBigBlockProps> ConnectFluxBigBlock = _$ConnectFluxBigBlock;

@Props()
class _$ConnectFluxBigBlockProps extends UiProps with ConnectPropsMixin {
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
class ConnectFluxBigBlockComponent extends UiComponent2<ConnectFluxBigBlockProps> {
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
        Dom.div()('This module uses a ConnectedFlux pattern to change its background color.'),
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
