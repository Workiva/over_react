import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:over_react/src/util/hoc.dart';

import '../store.dart';
import '../../../components/little_block.dart';

part 'connect_flux_big_block.over_react.g.dart';

// When refactoring from a Flux component to a connectFlux component (with multiple stores):
// [1] Add props for the state values that are needed, and remove the store prop.
// [2] Add props for the actions that are needed.
// [3] Refactor calls to the `store` prop to the new props added in [1] and [2].
// [4] Make a `composeHocs` call, passing in a `List`.
// [5] Make a `connectFlux` call for each store the component needs access to, with each call being an element in the `List`.
// [6] Tie `connectFlux` to the correct context by using the `context` parameter.
// [7] Use `mapStateToProps` and `mapActionsToProps` to point props to the correct state values.

/*[4]*/UiFactory<ConnectFluxBigBlockProps> ConnectedConnectFluxBigBlock = composeHocs([
  /*[5]*/connectFlux<RandomColorStore, RandomColorActions, ConnectFluxBigBlockProps>(
    /*[6]*/context: randomColorStoreContext,
    /*[7]*/mapStateToProps: (state) => (ConnectFluxBigBlock()
      ..backgroundColor = state.mainBackgroundColor
      ..blockOneBackgroundColor = state.blockOneBackgroundColor
    ),
    /*[7]*/mapActionsToProps: (actions) => (ConnectFluxBigBlock()
      ..changeMainBackgroundColor = actions.changeMainBackgroundColor
      ..changeBlockOneBackgroundColor = actions.changeBlockOneBackgroundColor
    ),
  ),
  /*[5]*/connectFlux<LowLevelStore, RandomColorActions, ConnectFluxBigBlockProps>(
    /*[6]*/context: lowLevelStoreContext,
    /*[7]*/mapStateToProps: (state) =>
        (ConnectFluxBigBlock()..blockTwoBackgroundColor = state.backgroundColor),
    /*[7]*/mapActionsToProps: (actions) =>
        (ConnectFluxBigBlock()..changeBlockTwoBackgroundColor = actions.changeBlockTwoBackgroundColor),
  ),
  /*[5]*/connectFlux<AnotherColorStore, RandomColorActions, ConnectFluxBigBlockProps>(
    /*[6]*/context: anotherColorStoreContext,
    /*[7]*/mapStateToProps: (state) =>
        (ConnectFluxBigBlock()..blockThreeBackgroundColor = state.backgroundColor),
    /*[7]*/mapActionsToProps: (actions) =>
        (ConnectFluxBigBlock()..changeBlockThreeBackgroundColor = actions.changeBlockThreeBackgroundColor),
  ),
])(ConnectFluxBigBlock);

@Factory()
UiFactory<ConnectFluxBigBlockProps> ConnectFluxBigBlock = _$ConnectFluxBigBlock;

@Props()
class _$ConnectFluxBigBlockProps extends UiProps with ConnectPropsMixin {
  /*[1]*/String backgroundColor;

  /*[1]*/String blockTwoBackgroundColor;

  /*[1]*/String blockThreeBackgroundColor;

  /*[1]*/String blockOneBackgroundColor;

  /*[2]*/void Function() changeMainBackgroundColor;

  /*[2]*/void Function() changeBlockOneBackgroundColor;

  /*[2]*/void Function() changeBlockTwoBackgroundColor;

  /*[2]*/void Function() changeBlockThreeBackgroundColor;
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
              /*[3]*/props.changeMainBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Main Background Color'),
          (Dom.button()
            ..onClick = (_) {
              /*[3]*/props.changeBlockOneBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 1 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              /*[3]*/props.changeBlockTwoBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 2 Background Color'),
          (Dom.button()
            ..onClick = (_) {
              /*[3]*/props.changeBlockThreeBackgroundColor();
            }
            ..style = {'padding': '10px', 'margin': '10px'}
          )('Change Block 3 Background Color'),
        ),
        (Dom.div()..style = {'display': 'flex', 'flexDirection': 'column'})(
          (LittleBlock()
            ..blockTitle = 'Block 1'
            /*[3]*/..backgroundColor = this.props.blockOneBackgroundColor
            /*[3]*/..colorString = this.props.blockOneBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 2'
            /*[3]*/..backgroundColor = this.props.blockTwoBackgroundColor
            /*[3]*/..colorString = this.props.blockTwoBackgroundColor
          )(),
          (LittleBlock()
            ..blockTitle = 'Block 3'
            /*[3]*/..backgroundColor = this.props.blockThreeBackgroundColor
            /*[3]*/..colorString = this.props.blockThreeBackgroundColor
          )(),
        ),
      ),
    ));
  }
}
