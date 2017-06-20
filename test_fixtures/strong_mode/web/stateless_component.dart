import 'package:over_react/over_react.dart';

@Factory()
UiFactory<StatelessProps> Stateless;

@Props()
class StatelessProps extends UiProps {}

@Component()
class StatelessComponent extends UiComponent<StatelessProps> {
  @override
  render() { }
}
