import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'connect_flux_big_block.over_react.g.dart';

UiFactory<ConnectFluxBigBlockProps> ConnectedConnectFluxBigBlock =
    connectFlux<FluxStore, RandomColorActions, ConnectFluxBigBlockProps>(
  mapStateToProps: (state) => (ConnectFluxBigBlock()..backgroundColor = state?.backgroundColor),
  mapActionsToProps: (actions) =>
      (ConnectFluxBigBlock()..changeBackgroundColor = actions.changeBackgroundColor),
)(ConnectFluxBigBlock);

@Factory()
UiFactory<ConnectFluxBigBlockProps> ConnectFluxBigBlock = _$ConnectFluxBigBlock;

@Props()
class _$ConnectFluxBigBlockProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  void Function() changeBackgroundColor;
}

@Component2()
class ConnectFluxBigBlockComponent extends UiComponent2<ConnectFluxBigBlockProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': props?.backgroundColor, 'color': 'white'})(
      'This module uses a connect flux pattern to change its background color.',
      (Dom.button()
        ..onClick = (_) {
          props.changeBackgroundColor();
        }
        ..style = {'padding': '10px', 'margin': '10px'}
      )('Change Background Color'),
    ));
  }
}
