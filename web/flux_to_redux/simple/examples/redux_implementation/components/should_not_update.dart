import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../store.dart';

part 'should_not_update.over_react.g.dart';

UiFactory<ShouldNotUpdateProps> ConnectedShouldNotUpdate = connect<RandomColorState, ShouldNotUpdateProps>(
  mapStateToProps: (_) => {},
)(ShouldNotUpdate);

UiFactory<ShouldNotUpdateProps> ShouldNotUpdate = _$ShouldNotUpdate;

mixin ShouldNotUpdateProps on UiProps {}

class ShouldNotUpdateComponent extends UiComponent2<ShouldNotUpdateProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': 'gray', 'color': 'white'})(
      'This component should not update when the others do.',
    ));
  }
}
