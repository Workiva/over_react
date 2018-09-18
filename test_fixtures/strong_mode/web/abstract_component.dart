import 'package:over_react/over_react.dart';

@AbstractProps()
abstract class AbstractStatelessProps extends UiProps {}

@AbstractComponent()
abstract class AbstractStatelessComponent<T extends AbstractStatelessProps> extends UiComponent<T> {
  @override
  render() { }
}
