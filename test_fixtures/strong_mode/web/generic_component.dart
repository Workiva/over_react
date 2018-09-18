import 'package:over_react/over_react.dart';

@Factory()
UiFactory<GenericStatefulProps> GenericStateful;

@Props()
class GenericStatefulProps extends UiProps {}

@State()
class GenericStatefulState extends UiState {}

@Component()
class GenericStatefulComponent<T extends GenericStatefulProps, S extends GenericStatefulState> extends UiStatefulComponent<T, S> {
  @override
  render() { }
}
