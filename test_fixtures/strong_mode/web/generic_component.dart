import 'package:over_react/over_react.dart';

@Factory()
UiFactory<GenericStatelessProps> GenericStateless;

@Props()
class GenericStatelessProps extends UiProps {}

@Component()
class GenericStatelessComponent<T extends GenericStatelessProps> extends UiComponent<T> {
  @override
  render() { }
}
