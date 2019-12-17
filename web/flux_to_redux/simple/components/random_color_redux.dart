import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import '../stores.dart';

part 'random_color_redux.over_react.g.dart';

UiFactory<RandomColorReduxProps> ConnectedRandomColorRedux = connect<ExampleFluxStore, RandomColorReduxProps>(
  mapStateToProps: (state) => (RandomColorRedux()..backgroundColor = state.backgroundColor),
  mapDispatchToProps: (dispatch) =>
      RandomColorRedux()..changeBackgroundColor = () => dispatch(UpdateBackgroundColorAction()),
  pure: false,
)(RandomColorRedux);

@Factory()
UiFactory<RandomColorReduxProps> RandomColorRedux = _$RandomColorRedux;

@Props()
class _$RandomColorReduxProps extends UiProps with ConnectPropsMixin {
  String backgroundColor;

  Function changeBackgroundColor;
}

@Component2()
class RandomColorReduxComponent extends UiComponent2<RandomColorReduxProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': props.backgroundColor, 'color': 'white'})(
        'This module uses a redux pattern to change its background color.',
        (Dom.button()
          ..onClick = (_) {
            props.changeBackgroundColor();
          }
          ..style = {'padding': '10px', 'margin': '10px'})('Change Background Color')));
  }
}
