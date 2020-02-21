import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'non_component_two_counter.over_react.g.dart';
// ignore_for_file: deprecated_member_use_from_same_package
@Factory()
UiFactory<NonComponentTwoCounterProps> NonComponentTwoCounter = _$NonComponentTwoCounter;

@Props()
class _$NonComponentTwoCounterProps extends UiProps with ConnectPropsMixin {}

@Component()
class NonComponentTwoCounterComponent extends UiComponent<NonComponentTwoCounterProps> {
  @override
  render() {
    return Dom.div()();
  }
}
