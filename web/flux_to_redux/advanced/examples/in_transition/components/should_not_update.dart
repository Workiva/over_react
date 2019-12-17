import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

import '../../../stores.dart';

part 'should_not_update.over_react.g.dart';

UiFactory<ShouldNotUpdateProps> ConnectedShouldNotUpdate = composeHocs([
  connect<InTransitionTopLevelStore, ShouldNotUpdateProps>(
    context: inTransitionTopLevelStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  ),
  connect<InTransitionLowLevelStore, ShouldNotUpdateProps>(
    context: inTransitionLowLevelStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  ),
  connect<InTransitionSecondStore, ShouldNotUpdateProps>(
    context: inTransitionSecondStoreContext,
    mapStateToProps: (_) => {},
    pure: false,
  )
])(ShouldNotUpdate);

@Factory()
UiFactory<ShouldNotUpdateProps> ShouldNotUpdate = _$ShouldNotUpdate;

@Props()
class _$ShouldNotUpdateProps extends UiProps {}

@Component2()
class ShouldNotUpdateComponent extends UiComponent2<ShouldNotUpdateProps> {
  @override
  render() {
    return ((Dom.div()..style = {'padding': '50px', 'backgroundColor': 'gray', 'color': 'white'})(
      'In a full Redux implementation, this component would not redraw when the'
      'other components update. However, it will in an Influx (Redux & '
      'Flux together) implementation.',
    ));
  }
}
