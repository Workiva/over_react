import 'package:over_react/over_react.dart';

@Factory()
UiFactory<StatefulProps> Stateful;

@Props()
class StatefulProps extends UiProps {}

@State()
class StatefulState extends UiState {}

@Component()
class StatefulComponent extends UiStatefulComponent<StatefulProps, StatefulState> {
  @override
  render() { }
}
